#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "xiicps.h"
#include "xgpiops.h"

//I2C config params
#define IIC_DEVICE_ID XPAR_XIICPS_0_DEVICE_ID
#define IIC_SCLK_RATE 100000
#define PAGE_SIZE 16
// camera I2C addresses
#define CAM1_ADDR 0x48
#define CAM2_ADDR 0x58
// camera I2C write addresses
#define REG_LOCK 0xFE
#define CAMERA_CTL 0x07
// camera I2C write values
#define MANUAL_TRIG 0x0198
#define LOCKED 0xDEAD
#define UNLOCKED 0xBEEF

typedef u8 AddressType;

typedef enum
{
	WAIT = 0,
	TX_COMMAND = 1,
	RX_DATA = 2
}UART_STATE;

void init_cams();

XGpioPs Gpio;
XIicPs IicInstance;		/* The instance of the IIC device. */

int main()
{
    init_platform();

    char echo[11];
    char status[2];
    char databuf[65][24];
    char databufbuf[3];
    char linefeed[4];

    echo[10] = '\0';
    databufbuf[2] = '\0';

    Xuint32 *baseaddr_p = (Xuint32 *)XPAR_CUSTOM_LOGIC_S00_AXI_BASEADDR;

    u32 data_enable_step;
    u32 write;
	u32 stepbuf;

	char *echotestnl = "G00076801\n";
	char *echotestlf = "G00076801\r";

    UART_STATE STATE = WAIT;

    // setup LED output
    XGpioPs_Config * ConfigPtr = XGpioPs_LookupConfig(XPAR_PS7_GPIO_0_DEVICE_ID);
    XGpioPs_CfgInitialize(&Gpio, ConfigPtr, ConfigPtr->BaseAddr);
    XGpioPs_SetDirectionPin(&Gpio, 7, 1);
    // initialize cameras using I2C
    init_cams();

    while(1)
    {
		switch(STATE)
		{
			case WAIT:
			{
				//blocks until the flag is set (from PL) to initiate data transfer
				while(Xil_In32(baseaddr_p) == 0);
				STATE = TX_COMMAND;
				break;
			}

			case TX_COMMAND:
			{
				printf("G00076801\n");
				STATE = RX_DATA;
				break;
			}

			case RX_DATA:
			{
				int rx_index = 0;	// indexes rows
				int rx_line = 0;	// indexes columns - counts which data line is being received

				// receives echo
				for(rx_index = 0; rx_index < 10; rx_index++)
				{
					echo[rx_index] = inbyte();	// blocking - inbyte is polled
				}

				// makes sure the echo command is successful
				// if not, it repeats the tx_command state

				if(strcmp(echo, echotestnl) != 0 && strcmp(echo, echotestlf) != 0)
				{
					STATE = WAIT;
					break;
				}

				// receives status
				for(rx_index = 0; rx_index < 2; rx_index++)
				{
					status[rx_index] = inbyte();	// blocking - inbyte is polled
				}

				int iteration = 0;

				// receives 24 data blocks
				stepbuf = 0;
				for(rx_line = 0; rx_line < 24; rx_line++)
				{
					iteration = 0;

					for(rx_index = 0; rx_index < 65; rx_index++)
					{
						iteration++;
						databuf[rx_line][rx_index] = inbyte();	// blocking - inbyte is polled
						write = 0;
						databufbuf[1-(iteration%2)] = databuf[rx_line][rx_index];

						if(iteration%2 == 0)
						{
							//'enables' data in memory when the data is not an error code
							if(!(strcmp(databufbuf[0], '0') == 0 && strcmp(databufbuf[1], 'C') <= 0))
								write = 1;
							stepbuf++;
						}

						//sends information to the programmable logic for each data point (2 chars)
						//in the order of {data, enable, step}
						data_enable_step = (databufbuf[1] << 20) | (databufbuf[0] << 12) | (write << 11) | stepbuf;
						*(baseaddr_p+1) = data_enable_step;

					}
				}

				iteration = 0;

				for(rx_index = 0; rx_index < 4; rx_index++)
				{
					linefeed[rx_index] = inbyte();	// blocking - inbyte is polled
				}

				echo[0] = '\0';

				STATE = WAIT;
				break;
			}
		}
    }
    cleanup_platform();
    return 0;
}

void init_cams()
{
    u8 WriteBuffer[sizeof(AddressType) + PAGE_SIZE];

    // number of bytes to be written from write buffer
    u8 ByteCount = 4;
    // set write buffer
    WriteBuffer[0] = (u8) (CAM1_ADDR);
    WriteBuffer[1] = (u8) (CAMERA_CTL);
    WriteBuffer[2] = (u8) (MANUAL_TRIG >> 8);
    WriteBuffer[3] = (u8) (MANUAL_TRIG);

    XIicPs_Config *ConfigPtr;
    int Status;

    // Initialize iicps instance
    ConfigPtr = XIicPs_LookupConfig(IIC_DEVICE_ID);
    Status = XIicPs_CfgInitialize(&IicInstance, ConfigPtr, ConfigPtr->BaseAddress);
    Status = XIicPs_SelfTest(&IicInstance);
    XIicPs_SetSClk(&IicInstance, IIC_SCLK_RATE);

    // Initialize Cam1
    XIicPs_MasterSend(&IicInstance, WriteBuffer, ByteCount,CAM1_ADDR);    while(XIicPs_BusIsBusy(&IicInstance));
    while(XIicPs_BusIsBusy(&IicInstance));

    // Initialize Cam2
    WriteBuffer[0] = (u8) (CAM2_ADDR);
    XIicPs_MasterSend(&IicInstance, WriteBuffer, ByteCount,CAM2_ADDR);
    while(XIicPs_BusIsBusy(&IicInstance));

    // Write LED to indicate finished init sequence
    XGpioPs_WritePin(&Gpio, 7, 0x01);
}