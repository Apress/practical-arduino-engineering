// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7,8,9,10,11,12);

int tiltPin = 4;
int tiltState = 0;

void setup()
{
  pinMode(tiltPin, INPUT);
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();

}
void loop()
{
  tiltState = digitalRead(tiltPin);
  
  if(tiltState == HIGH)
  {
   lcd.home();
   lcd.print("Not Level");
   delay(1000);
   lcd.clear();
  }
  if(tiltState == LOW)
  {
   lcd.setCursor(0,1);
   lcd.print("Level");
   delay(1000);
   lcd.clear();
  }
  
}
