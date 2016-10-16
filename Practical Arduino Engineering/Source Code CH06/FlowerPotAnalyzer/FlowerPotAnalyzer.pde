#include <SdFat.h>
#include <SdFatUtil.h>

//Create the variables to be used by SdFat Library
Sd2Card card;
SdVolume volume;
SdFile root;
SdFile file;

char name[] = "weather.txt";     // holds the name of the new file
int photoPin = A0;
int weatherVal = 0;

void setup()
{
   pinMode(photoPin, INPUT);
   pinMode(10, OUTPUT);       // Pin 10 must be set as an output for the SD communication to work.
   card.init();               // Initialize the SD card and configure the I/O pins.
   volume.init(card);         // Initialize a volume on the SD card.
   root.openRoot(volume);     // Open the root directory in the volume.
}

void loop()
{
  weatherVal = analogRead(photoPin);
  
  if (weatherVal >= 800)
  {
   file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name' in 'root' for writing to the end of the file.
   file.println("Dark");    
   file.close();            // Close the file.
   delay(1000);     // Wait 1 second 
  }
  else if (weatherVal >= 300 && weatherVal <= 500)
  {
   file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name' in 'root' for writing to the end of the file.
   file.println("Cloudy");    
   file.close();            // Close the file.
   delay(1000);     // Wait 1 second 
  }
  else if (weatherVal < 300 && weatherVal >= 0)
  {
   file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name' in 'root' for writing to the end of the file.
   file.println("Sunny");    
   file.close();            // Close the file.
   delay(1000);     // Wait 1 second 
  }
}
