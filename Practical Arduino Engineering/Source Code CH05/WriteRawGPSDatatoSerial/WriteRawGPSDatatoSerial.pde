#include <NewSoftSerial.h>

NewSoftSerial serial_gps(2,3);

void setup()
{
  serial_gps.begin(4800);

  Serial.begin(9600); 

  Serial.print("\nRAW GPS DATA\n");
}

void loop()
{
  while (serial_gps.available() > 0)
  {
    int c = serial_gps.read();
    Serial.print(c, BYTE);
  } 
}

