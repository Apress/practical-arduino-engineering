// include the library code:
#include <LiquidCrystal.h>
#include <DHT22.h>

int tempPin = 2;

// Create instance
DHT22 myDHT22(tempPin);

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7,8,9,10,11,12);

float tempF = 0.00;
float tempC = 0.00;

void setup()
{
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();
}

void loop()
{ 
 
  delay(2000);
  myDHT22.readData();
  
  lcd.home();
  lcd.print("Temp: ");
  tempC = myDHT22.getTemperatureC();
  tempF = (tempC * 9.0 / 5.0) + 32;
  lcd.print(tempF);
  lcd.print("F ");
  lcd.setCursor(0,1);
  lcd.print("Hum:  ");
  lcd.print(myDHT22.getHumidity());
  lcd.println("%");
      
}
