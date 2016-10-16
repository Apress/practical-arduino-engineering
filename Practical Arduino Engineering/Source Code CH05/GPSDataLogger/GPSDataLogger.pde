//Add the SdFat Libraries
#include <SdFat.h>
#include <SdFatUtil.h> 
#include <ctype.h>
#include <NewSoftSerial.h>
#include <TinyGPS.h>

NewSoftSerial nss(2,3);
TinyGPS gps;

void printFloat(double number, int digits); // function prototype for ftoa function

//Create the variables to be used by SdFat Library
Sd2Card card;
SdVolume volume;
SdFile root;
SdFile file;

char name[] = "GPSData.txt";     // holds the name of the new file
char LatData[50];                // data buffer for Latitude
char LongData[50];               // data buffer for longitude

void setup(void)
{  
  Serial.begin(9600);        // Start a serial connection.
  nss.begin(4800);           // Start soft serial communication
  pinMode(10, OUTPUT);       // Pin 10 must be set as an output for the SD communication to
                             // work.
  card.init();               // Initialize the SD card and configure the I/O pins.
  volume.init(card);         // Initialize a volume on the SD card.
  root.openRoot(volume);     // Open the root directory in the volume. 
}

void loop(void)
{  
  
  while (nss.available() > 0)
  {
    int c = nss.read();
    
    // Initialize Longitude and Latitude to floating point numbers
    if(gps.encode(c))     // New valid sentence?
    {
      float latitude, longitude;

      // Get longitude and latitude
      gps.f_get_position(&latitude,&longitude);

      // Print "lat: " to LCD screen
      Serial.print("lat:   ");
      // Prints latitude with 5 decimal places to the Serial Monitor
      Serial.println(latitude,5);
     
      // Print "long: " to the Serial Monitor
      Serial.print("long: ");
      // Prints longitude with 5 decimal places to the Serial Monitor
      Serial.println(longitude,5);
     
     delay(500);

     file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name'
                                              // in 'root' for writing to the end of the file.
     file.print("Latitude: ");
     printFloat(latitude, 6);    
     file.println("");
     file.print("Longitude: ");
     printFloat(longitude, 6);
     file.println("");
     file.close();            // Close the file.
     delay(1000);     // Wait 1 second 
    }
    
  }

}

void printFloat(double number, int digits)
{
  // Handle negative numbers
  if (number < 0.0)
  {
     file.print('-');
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
  file.print(int_part);

  // Print the decimal point, but only if there are digits beyond
  if (digits > 0)
    file.print(".");

  // Extract digits from the remainder one at a time
  while (digits-- > 0)
  {
    remainder *= 10.0;
    int toPrint = int(remainder);
    file.print(toPrint);
    remainder -= toPrint;
  }
}
