// header files to use microSD shield
#include <SdFat.h>
#include <SdFatUtil.h> 

//Create the variables to be used by SdFat Library
Sd2Card card;
SdVolume volume;
SdFile root;
SdFile file;

char name[] = "Data.txt";

int PIRpin = 6;
int PIRval = 0;

void setup()
{
  Serial.begin(115200);      // initalize serial communication
  pinMode(PIRpin, INPUT);
  pinMode(10, OUTPUT);       // Pin 10 must be set as an output for the SD communication to work.
  card.init();               // Initialize the SD card and configure the I/O pins.
  volume.init(card);         // Initialize a volume on the SD card.
  root.openRoot(volume);     // Open the root directory in the volume.
  
}

void loop()
{
  PIRval = digitalRead(PIRpin);
  
  if(PIRval == HIGH)
  {
    Serial.println("Motion Detected!!");
    delay(500);
    file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name' 
                                                            // in 'root' for writing to the 
                                                            // end of the file.
    file.println("Motion Detected!!");      
    file.close();                                           // Close the file.  
    delay(500);  
  }
  else
  {
    Serial.println("Nothing to Report");
    delay(500);
  }
  
}
