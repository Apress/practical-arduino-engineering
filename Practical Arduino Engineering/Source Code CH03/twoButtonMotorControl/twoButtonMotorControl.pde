const int buttonPin1 = 10; // Sets buttonPin to digital pin 10
const int motorPin1 = 3; // Sets motorPin to digital pin 3
const int buttonPin2 = 9; // Sets buttonPin to digital pin 9
const int motorPin2 = 11; // Sets motorPin to digital pin 11

int buttonVal1 = 0; // Will pass button value here
int buttonVal2 = 0; // Will pass button value here

void setup()
{
  pinMode(buttonPin1, INPUT); // Makes buttonPin an input
  pinMode(motorPin1, OUTPUT); // Makes motorPin an output
  pinMode(buttonPin2, INPUT); // Makes buttonPin an input
  pinMode(motorPin2, OUTPUT); // Makes motorPin an output
  
  digitalWrite(buttonPin1, HIGH); // Activates the Pull up resistor 
                                  // If we did not have this the switch would not work correctly.
  digitalWrite(buttonPin2, HIGH); // Activates the Pull up resistor 
                                  // If we did not have this the switch would not work correctly.
}

void loop()
{
  buttonVal1 = digitalRead(buttonPin1); // What ever is at buttonPin is sent to buttonVal1
  buttonVal2 = digitalRead(buttonPin2); // What ever is at buttonPin is sent to buttonVal2
  
  if (buttonVal1 == 1)
  {
    digitalWrite(motorPin1, HIGH); // Turn motor on if buttonVal equals one
  }
  else
  {
    digitalWrite(motorPin1, LOW); // Turns motor off for all other values.
  } 
  
  if (buttonVal2 == 1)
  {
    digitalWrite(motorPin2, HIGH); // Turns motor off for all other values.
  } 
  else
  {
    digitalWrite(motorPin2, LOW); // Turns motor off for all other values.
  } 
  
}
