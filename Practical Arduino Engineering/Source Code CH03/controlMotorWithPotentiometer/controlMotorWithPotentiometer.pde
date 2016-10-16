const int potPin = A0;
const int motorPin = 3;

int potVal = 0;
int mapedPotVal = 0;

void setup()
{
  pinMode(potPin, INPUT);
  pinMode(motorPin, OUTPUT);
    
}

void loop()
{
  potVal = analogRead(potPin);
  
  mapedPotVal = map(potVal, 0, 1023, 0, 255);
  
  analogWrite(motorPin, mapedPotVal);
  
}
