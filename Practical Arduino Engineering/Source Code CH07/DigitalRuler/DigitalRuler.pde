const int pingPin = 9;

void setup() 
{
  Serial.begin(9600);
}

void loop()
{
  float duration, inches;

  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  // convert the time into a distance
  inches = duration / 74 / 2;

  Serial.print(inches);
  Serial.println("in");
 
  delay(1000);
}

