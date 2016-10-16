int flexPin = A0;
int flexVal = 0;

void setup()
{
  Serial.begin(9600);
  pinMode(flexPin, INPUT); 
}
void loop()
{
  flexVal = analogRead(flexPin);
  flexVal = map(flexVal, 200, 1023, 0, 1023);
  Serial.print("Flex: ");
  Serial.println(flexVal);
  delay(1000);
}
