#include <ColorLCDShield.h>

LCDShield lcd;

const int fields = 4; // how many fields are there? right now 4
int motorPins[] = {4,5,7,6}; // Motor Pins
int index = 0; // the current field being received
int values[fields]; // array holding values for all the fields

void setup()
{
  Serial.begin(9600); // Initialize serial port to send and receive at 9600 baud

  lcd.init(1);
  lcd.contrast(40);
  lcd.clear(WHITE);
  
  for (int i; i <= 3; i++)        // set LED pinMode to output
  {
    pinMode(motorPins[i], OUTPUT);
    digitalWrite(motorPins[i], LOW); 
  }
  
  Serial.println("The Format is: MotoADir,MotoASpe,MotorBDir,MotoBSpe\n");
  
}

void loop()
{

  
if( Serial.available())
  {
    char ch = Serial.read();
  if(ch >= '0' && ch <= '9') // If the value is a number 0 to 9
    {
      // add to the value array
      values[index] = (values[index] * 10) + (ch - '0');
    }
  else if (ch == ',') // if it is a comma
    {
      if(index < fields -1) // If index is less than 4 - 1...
      index++; // increment index
    }
  else
    {
      if (values[0] == 0 && values[1] == 0 && values[2] == 0 && values[3] == 0)
      {
        lcd.clear(WHITE);
        lcd.setStr("Motors have ", 1, 10, BLACK, WHITE);
        lcd.setStr("Stopped", 20, 10, BLACK, WHITE);
      }
      else if (values[0] == 0 && values[2] == 0)
      {
        lcd.clear(WHITE);
        lcd.setStr("Reverse", 50, 40, BLACK, WHITE);
      }
      else if (values[0] == 1 && values[2] == 1)
      {
        lcd.clear(WHITE);
        lcd.setStr("Forward", 50, 40, BLACK, WHITE);
      }
      else if (values[0] == 0 && values[2] == 1)
      {
        lcd.clear(WHITE);
        lcd.setStr("Left", 50, 50, BLACK, WHITE);
      }
      else if (values[0] == 1 && values[2] == 0)
      {
        lcd.clear(WHITE);
        lcd.setStr("Right", 50, 50, BLACK, WHITE);
      }
              
      for(int i=0; i <= index; i++)
        {
         
           if (i == 0)
           {
             Serial.println("Motor A");
             Serial.println(values[i]); 
           }
           else if (i == 1)
           {
             Serial.println(values[i]);
           }
           if (i == 2)
           {
             Serial.println("Motor B");
             Serial.println(values[i]); 
           }
           else if (i == 3)
           {
             Serial.println(values[i]);
           }
            
           if (i == 0 || i == 2)  // If the index is equal to 0 or 2
           {
              digitalWrite(motorPins[i], values[i]); // Write to the digital pin 1 or 0 
                                                     // depending what is sent to the arduino.
           }
           
           
           if (i == 1 || i == 3) // If the index is equale to 1 or 3 
           {
              analogWrite(motorPins[i], values[i]);  // Write to the PWM pins a number between 
                                                     // 0 and 255 or what the person has enter 
                                                     // in the serial monitor. 
           }
     
      values[i] = 0; // set values equal to 0
    }
    
      index = 0; 
    }
}
}
