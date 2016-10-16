#include <ColorLCDShield.h>

LCDShield lcd;

int button[4] = {7,6,5,4};

int buttonState[4] = {0,0,0,0};


void setup()
{

  lcd.init(1); //Initialize the LCD 
  lcd.contrast(40);
  lcd.clear(WHITE);
  for (int i = 0; i <= 3; i++)
  {
    pinMode(button[i], INPUT);
    digitalWrite(button[i], HIGH);
  }
  
}

void loop()
{
  for( int j = 0; j <= 3; j++)
  {
    buttonState[j] = digitalRead(button[j]);
  }
  
  lcd.setRect(9, 9,35 , 36, 0, BLACK);
  lcd.setRect(9, 39,35 , 66, 0, BLACK);
  lcd.setRect(9, 69,35 , 96, 0, BLACK);
  lcd.setRect(9, 99,35 , 126, 0, BLACK);
  
  if(buttonState[0] == 0)
  {
    lcd.setRect(10, 10,35 , 35, 1, YELLOW);
  }
  else
  {
    lcd.setRect(10, 10,35 , 35, 1, WHITE);
  }
  if(buttonState[1] == 0)
  {
    lcd.setRect(10, 40,35 , 65, 1, YELLOW);
  }
  else
  {
    lcd.setRect(10, 40,35 , 65, 1, WHITE);
  }
  if(buttonState[2] == 0)
  {
    lcd.setRect(10, 70,35 , 95, 1, YELLOW);
  }
  else
  {
    lcd.setRect(10, 70,35 , 95, 1, WHITE);
  }
  if(buttonState[3] == 0)
  {
    lcd.setRect(10, 100,35 , 125, 1, YELLOW);
  }
  else
  {
    lcd.setRect(10, 100,35 , 125, 1, WHITE);
  }
  
}
