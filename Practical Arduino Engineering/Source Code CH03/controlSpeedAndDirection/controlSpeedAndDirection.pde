const int switchPin = 10;
const int potPin = A0;
const int motorPin = 3;

int switchVal = 0;
int potVal = 0;
int mapedPotVal = 0;

void setup()
{
  pinMode(switchPin, INPUT);
  pinMode(potPin, INPUT);
  pinMode(motorPin, OUTPUT);
  digitalWrite(switchPin, HIGH);  

}

void loop()
{
  switchVal = digitalRead(switchPin);
  potVal = analogRead(potPin);
  
  mapedPotVal = map(potVal, 0, 1023, 0, 255);
  
  analogWrite(motorPin, mapedPotVal);
  
  if (switchVal == 1)
  {
    digitalWrite(12, HIGH);
  }
  else
  {
    digitalWrite(12, LOW);
  }
  
}
