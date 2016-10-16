//Add the SdFat Libraries
#include <SdFat.h>
#include <SdFatUtil.h> 

//Create the variables to be used by SdFat Library
Sd2Card card;
SdVolume volume;
SdFile root;
SdFile file;

char name[] = "Data.txt";     // holds the name of the new file
const int pingPin = 7;

void setup()
{
  Serial.begin(115200);        // Start a serial connection.
  pinMode(10, OUTPUT);       // Pin 10 must be set as an output for the SD communication to work.
  card.init();               // Initialize the SD card and configure the I/O pins.
  volume.init(card);         // Initialize a volume on the SD card.
  root.openRoot(volume);     // Open the root directory in the volume.
}

void loop()
{
  float duration, inches;

  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  // convert the time into a distance
  inches = duration / 74 / 2;
  delay(500);

  if (inches >= 5)
  {
    Serial.println("Door Open!!"); 
    delay(500);
    file.open(root, name, O_CREAT | O_APPEND | O_WRITE);    // Open or create the file 'name' in 'root' for writing to the end of the file.
    file.println("Door Open!!");
    file.close();
  }
  else
  {
    Serial.println("Nothing to Report"); 
  }

  delay(1000);
}

