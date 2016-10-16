#include <NewSoftSerial.h>
#include <TinyGPS.h>

NewSoftSerial cell(2,3);  // Soft Serial Pins
TinyGPS gps;

char phoneNumber[] = "xxxxxxxx";  // Replace xxxxxxxx with the recipient's mobile number

void printFloat(double number, int digits); // function prototype for printFloat() function

void setup(void)
{  
  Serial.begin(4800); // GPS
  cell.begin(9600); // Cellular Shield
  delay(35000); // Allow GSM to process 
}

void loop()
{
  while (Serial.available() > 0)
  {
    int c = Serial.read();

    // Initialize Longitude and Latitude to floating point numbers
    if(gps.encode(c))     // New valid sentence?
    {
      float latitude, longitude;

      // Get longitude and latitude
      gps.f_get_position(&latitude,&longitude);

      cell.println("AT+CMGF=1"); // set SMS mode to text

      cell.print("AT+CMGS=");  // now send message...

      cell.print(34,BYTE); // ASCII equivalent of "

      cell.print(phoneNumber);

      cell.println(34,BYTE);  // ASCII equivalent of "

      delay(500);

      
      cell.print("Lat: ");   // our message to send
      printFloat(latitude, 6);
      cell.print(" , ");
      cell.print("Long: ");
      printFloat(longitude, 6);

      cell.println(26,BYTE);  // ASCII equivalent of Ctrl-Z

      delay(60000);     
    }

  }

}

void printFloat(double number, int digits)
{
  // Handle negative numbers
  if (number < 0.0)
  {
     cell.print('-');
     number = -number;
  }

  // Round correctly so that print(1.999, 2) prints as "2.00"
  double rounding = 0.5;
  for (uint8_t i=0; i<digits; ++i)
    rounding /= 10.0;

  number += rounding;

  // Extract the integer part of the number and print it
  unsigned long int_part = (unsigned long)number;
  double remainder = number - (double)int_part;
  cell.print(int_part);

  // Print the decimal point, but only if there are digits beyond
  if (digits > 0)
    cell.print(".");

  // Extract digits from the remainder one at a time
  while (digits-- > 0)
  {
    remainder *= 10.0;
    int toPrint = int(remainder);
    cell.print(toPrint);
    remainder -= toPrint;
  }
}

