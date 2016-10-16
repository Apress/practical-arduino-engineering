int forcePin = A0;
int forceVal = 0;
int scaleVal = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(forcePin, INPUT);
}
void loop()
{
  forceVal = analogRead(forcePin);
  scaleVal = map(forceVal, 1023, 0, 0, 20);
  Serial.print("Pounds ");
  Serial.println(scaleVal);
  delay(1000);
  
}
