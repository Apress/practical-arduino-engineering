// include the library code:
#include <LiquidCrystal.h>

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(7,8,9,10,11,12);

int potPin1 = A1;
int potPin2 = A2;
int button1 = 2;


int buttonVal1 = 0;


int menuCount = 0;

void setup() 
{
  
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  lcd.clear();
  
  pinMode(potPin1, INPUT);
  pinMode(potPin2, INPUT);
  pinMode(button1, INPUT);

  
  digitalWrite(button1, HIGH);
  
  lcd.setCursor(0,0);  // Sets the cursor to col 0 and row 0
  lcd.print("Press button    "); // Prints to the LCD
  lcd.setCursor(0,1);  // Sets the cursor to col 0 and row 0
  lcd.print("to view pot val");
}

void loop() 
{
  buttonVal1 = digitalRead(button1);

  
  if (buttonVal1 == LOW)
  {
    menuCount++;
  }
    switch (menuCount)
    {
 
      case 1:
      lcd.setCursor(0,0);  // Sets the cursor to col 0 and row 0
      lcd.print("SensorVal1: "); // Prints Sensor Val: to LCD
      lcd.print(analogRead(potPin1)); // Prints value on Potpin1 to LCD
      lcd.setCursor(0,1);  // Sets the cursor to col 1 and row 0 
      lcd.print("                "); // Prints Sensor Val: to LCD
      delay(250);
      break;
      case 2:
      lcd.setCursor(0,0);  // Sets the cursor to col 0 and row 0
      lcd.print("SensorVal2: "); // Prints Sensor Val: to LCD
      lcd.print(analogRead(potPin2)); // Prints value on Potpin1 to LCD
      lcd.setCursor(0,1);  // Sets the cursor to col 1 and row 0 
      lcd.print("                "); // Prints Sensor Val: to LCD
      delay(250);
      break;
      default:
      menuCount = 0;
      break;
       
    }
    
}

