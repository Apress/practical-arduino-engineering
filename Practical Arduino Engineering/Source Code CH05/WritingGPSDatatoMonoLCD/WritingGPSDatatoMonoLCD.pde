// include the library code:
#include <LiquidCrystal.h>
// includes the NewSoftwareSerial Library
#include <NewSoftSerial.h>
// include TinyGPS library
#include <TinyGPS.h>

// create an instance of the TinyGPS object
TinyGPS gps;

// initializes the soft serial port
NewSoftSerial nss(2,3);

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7,8,9,10,11,12);

void gpsData(TinyGPS &gps);

void setup()
{
  nss.begin(4800);

  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();

}

void loop()
{

  while(nss.available())   // Makes sure data is at the Serial port
  { 
    int c = nss.read();
    if(gps.encode(c))     // New valid sentence?
    {
      gpsData(gps);       // Write data to the LCD
    }
  }

}

void gpsData(TinyGPS &gps)
{
  // Initialize Longitude and Latitude to floating point numbers
  float latitude, longitude;

  // Get longitude and latitude
  gps.f_get_position(&latitude,&longitude);

  // Set cursor to home (0,0)
  lcd.home();
  // Print "lat: " to LCD screen
  lcd.print("lat:   ");
  // Prints latitude with 5 decimal places to LCD screen
  lcd.print(latitude,5);

  // Sets the cursor to the second row
  lcd.setCursor(0,1);
  // Print "long: " to LCD screen
  lcd.print("long: ");
  // Prints longitude with 5 decimal places to LCD screen
  lcd.print(longitude,5);

}

