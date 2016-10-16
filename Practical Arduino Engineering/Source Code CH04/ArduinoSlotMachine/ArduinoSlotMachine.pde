#include <ColorLCDShield.h>

LCDShield lcd;

int Money = 10000;
int button = 3;

void setup()
{
  
  pinMode(button, INPUT);  
  digitalWrite(button, HIGH);  
  
 
  lcd.init(1); //Initialize the LCD
  lcd.contrast(40);
  lcd.clear(WHITE);
  randomSeed(analogRead(0));
  lcd.setStr("Welcome to", 1, 13,BLACK,WHITE);
  lcd.setStr("Ardslots", 20, 13,BLACK,WHITE);
   
}

void loop()
{

char MoneyBuf [15];
char val1 [10];
char val2 [10];
char val3 [10];

int random1 = random (0, 9);
int random2 = random (0, 9);
int random3 = random (0, 9);

sprintf (MoneyBuf, "%5i", Money);
lcd.setStr("$",100,1,BLACK,WHITE);
lcd.setStr(MoneyBuf,100,10,BLACK,WHITE);

 if (!digitalRead(button))
 { 
  
  sprintf (val1, "%i", random1);
  lcd.setStr(val1,64,44,BLACK,WHITE);
  delay(250);
  sprintf (val2, "%i", random2);
  lcd.setStr(val2,64,64,BLACK,WHITE);
  delay(250);
  sprintf (val3, "%i", random3);
  lcd.setStr(val3,64,84,BLACK,WHITE);
  
    if (random1 == random2 == random3)
    {
       Money = 10 + Money;
    }
    else if (random1 == 0 && random2 == 0)
    {
      Money = 1000 + Money;
    }
    else if (random1 == random2)
    {
       Money = 5 + Money;
    }
    else if (random2 == random3)
    {
       Money = 5 + Money;
    }
    else if (random1 == random3)
    {
       Money = 5 + Money;
    }
    else
    {
       Money = Money - 5;
    }
 }
 
  delay(200);
  
}
