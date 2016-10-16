const int buttonPin = 10; // Sets buttonPin to digital pin 12
const int motorPin = 3; // Sets motorPin to digital pin 8

int buttonVal = 0; // Will pass button value here

void setup()
{
  pinMode(buttonPin, INPUT); // Makes buttonPin an input
  pinMode(motorPin, OUTPUT); // Makes motorPin an output
  digitalWrite(buttonPin, HIGH); // Activates the Pull up resistor 
                                 // If we did not have this the switch 
                                 // would not work correctly. 
}

void loop()
{
  buttonVal = digitalRead(buttonPin); // What ever is at buttonPin is 
                                      // sent to buttonVal
  
  if (buttonVal == 1)
  {
    digitalWrite(motorPin, HIGH); // Turn motor on if buttonVal equals one
  }
  else
  {
    digitalWrite(motorPin, LOW); // Turns motor off for all other values.
  } 
  
}
