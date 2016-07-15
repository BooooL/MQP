#include "Wire.h"
#define MT9V034_ADDR = 0x58;
#define MT9V034_CHIP_VERSION 0x00

void getVersion();
int count = 0;
void setup() { 
  Wire.begin();
  pinMode(21, INPUT);
  pinMode(20, OUTPUT);
  digitalWrite(20,HIGH);
 //Initialize serial and wait for port to open:
  Serial.begin(9600); 
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }
  // prints title with ending line break 
  Serial.println("MT9V034 I2C Test Code"); 
  delay(1000);
} 

void loop() 
{
  if(count<1){
    getVersion();
    count++;
  }
  // read the state of the switch into a local variable:
  if(digitalRead(21)==HIGH){
         getVersion();
      }
}

void getVersion()
{
  byte upper;
  byte lower;
  
  // Read from CHIP_VERSION REGISTER
  // 1. begin by reading the upper 8 bits of the version
  Serial.println("Writing 0x0198 to camera address 0x07");
  Wire.beginTransmission(0x58); // call to camera @ addr 0xB8
  Wire.write(0x07); // chip control register
  Wire.write(0x01); // parallel output, simultaneous mode
  Wire.write(0x98); // master & snapshot mode enabled
  Wire.endTransmission();
  Serial.println("address written");
  Serial.println("Verifying write");
  Wire.beginTransmission(0x58); // call to camera @ addr 0xB8
  Wire.write(0x07); // move register pointer back
  Wire.endTransmission();
  Wire.requestFrom(0x58,2); // Request the transmitted two bytes from the two registers
  if(Wire.available()<=2) {  // 
    upper = Wire.read(); // Reads the data from the register  
    lower = Wire.read();
  }
  
  Serial.print("upper= ");
  Serial.print(upper,HEX);
  Serial.print(" lower= ");
  Serial.println(lower,HEX);
}
