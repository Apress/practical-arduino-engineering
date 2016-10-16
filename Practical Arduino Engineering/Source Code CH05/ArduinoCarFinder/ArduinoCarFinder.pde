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

// set up buttons
int button1 = 5;
int button2 = 6;

float latVal = 0;
float longVal= 0;

int buttonVal1 = 0;
int buttonVal2 = 0;

int buttonCount = 0;
int numCount = 0;

void gpsData(TinyGPS &gps);

void setup()
{
  nss.begin(4800);

  pinMode(button1, INPUT);
  pinMode(button2, INPUT);

  digitalWrite(button1, HIGH);
  digitalWrite(button2, HIGH);

  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();
  lcd.home();
  lcd.print("Arduino");
  lcd.setCursor(0,1);
  lcd.print("Car Finder");
  delay(3000); 
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
  //longVal = 0.00000;
  //latVal = 0.00000;

  // Get longitude and latitude
  gps.f_get_position(&latitude,&longitude);

  buttonVal1 = digitalRead(button1);
  buttonVal2 = digitalRead(button2);

  if (buttonVal2 == LOW)
  {
    buttonCount++;
  }

  if(buttonVal1 == LOW)
  {
    switch (buttonCount)
    {
    case 1:
      if (numCount <= 0)
      {
        gps.f_get_position(&latitude,&longitude);
        latVal = latitude;
        longVal = longitude;
        delay(250);
        numCount++; 
      }
      else if (numCount > 0)
      {
        lcd.home();
        lcd.print("car is here:     ");
        delay(2000);
        lcd.clear();
        lcd.home();
        lcd.print("Lat:   ");
        lcd.print(latVal,5);
        lcd.setCursor(0,1);
        lcd.print("Long: ");
        lcd.print(longVal,5);
        delay(5000); 
        lcd.clear();

      }
      break;
    case 2:
      lcd.clear();
      lcd.home();
      lcd.print("Reset Car loc");
      lcd.setCursor(0,1);
      lcd.print("keep holding");
      delay(5000);
      lcd.clear();
      break;
    default:
      buttonCount = 0;
      numCount = 0;
      break;

    }    

  }

  if(buttonVal1 == HIGH)
  {
    lcd.home();
    lcd.print("You are here:   ");
    delay(2000);
    lcd.clear(); 
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
    delay(5000);
    lcd.clear();
    if (longitude <= longVal + 0.00010 && longitude >= longVal - 0.00010 && latitude <= latVal + 0.00010 && latitude >= latVal - 0.00010)
    {
      lcd.clear();
      lcd.home();
      lcd.print("You should see  ");
      lcd.setCursor(0,1);
      lcd.print("your car");
      delay(2000);
      lcd.clear();

    }
    else
    {
      lcd.clear();
      lcd.home();
      lcd.print("Keep Looking    ");
      delay(1000);
      lcd.clear();
    }
   
  }

}

