// ultrasonic sensor pin
const int pingPin = 9;
const int buzzer = 4; // buzzer pin

void setup() 
{
  Serial.begin(9600);
  pinMode(buzzer, OUTPUT);
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
    
  if (inches >= 4)
  {
     tone(buzzer, 5000, 500);
  }
  else
  {
    digitalWrite(buzzer, LOW);
  }

  Serial.print(inches);
  Serial.println("in");
 
  delay(1000);
}

