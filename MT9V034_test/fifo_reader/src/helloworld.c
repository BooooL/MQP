/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xiomodule.h"

#define LED (1<<0)
#define RCK (1<<1)
#define RRST (1<<2)
#define OE (1<<3)

void print(char *str);
void _EXFUN(xil_printf, (const char*, ...));


int main()
{
    init_platform();

    u8 data=0x00,GPI=RRST|OE;

    u32 pixel_count = 0;
    u8 sw,prevState,state=0;
    XIOModule gpi;
    XIOModule gpo;

    // GPI = (D7)|(D6)|(D5)|(D4)|(D3)|(D2)|(D1)|(D0)
    sw = XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
    sw = XIOModule_Start(&gpi);

    // GPO = (FIFO_OE)|(FIFO_RRST)|(FIFO_RCK)|(LED)
    data = XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
    data = XIOModule_Start(&gpo);

    print("\n\rMT9V034 controller and AL422B FIFO reader\n\r");
    while(1)
    {
    	// get switch position
    	sw = XIOModule_DiscreteRead(&gpi,2);
    	if (prevState != sw){
    		if(sw == 1){
    			print("Reading from FIFO...\n\r");
    			GPI |= LED;
    		}else{
    			pixel_count = 0; // ONLY reset pixel count if sw is toggled
    			state = 0;
    			GPI &= ~LED;
    			GPI |= (OE|RRST|RCK);
    			print("\n\rReset for new sequence\n\r");
    		}
    	}

    	// update data read sequence if switch is turned on
    	if(sw == 1){
    		GPI ^= RCK; //toggle the clock signal
            if(state<49)
            	state++;
            else if ((state>=49) && (state<53)){ // 2 clock cycles
    			GPI &= ~OE; //enable FIFO output
    			state++;
    		}
    		else if ((state >= 53) && (state<57)){ // 2 clock cycles
    			GPI &= ~RRST; // point to addr0
    			state++;
    		}
    		// while clocking out pixel data, read gpi
    		else if(pixel_count<360960) // 752*480 = 360960 pixels
    		{
    			GPI |= RRST;

    			if((GPI & RCK)!=0){ // if the clock edge is currently low
    				xil_printf("%d",data);
    			}
    			else{ // if the clock edge is currently HIGH, read the data pins
    				data = XIOModule_DiscreteRead(&gpi, 1);
    				pixel_count++;
    				print("\n\r");
    			}
    		}
    		// after getting all the data, terminate
    		else if (pixel_count==360960)
    		{
    			pixel_count++; // escape these if:else's
    			print("End of read sequence\n\r");
    			GPI &= ~LED;
    		}
    	}

    	// write to the GPI
    	XIOModule_DiscreteWrite(&gpo,1,GPI);
    	prevState = sw; // update prev switch position
    }
    cleanup_platform();
    return 0;
}
