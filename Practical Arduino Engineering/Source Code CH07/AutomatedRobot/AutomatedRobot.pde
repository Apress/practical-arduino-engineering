#include <Servo.h> 

Servo myservo;   

const int pingPin = 12;
int motorPins[] = {4,5,7,6}; // Motor Pins
int servoPin = 9;
int pos = 0;  
const int range = 12;

long inoutPing(long);
void moveRight();
void moveLeft();
void turnAround();
void moveForward();


void setup() 
{ 
  Serial.begin(9600);
  myservo.attach(servoPin);  
  for (int i; i <= 3; i++)
  {
    pinMode(motorPins[i], OUTPUT);
    digitalWrite(motorPins[i], LOW); 
  } 
} 


void loop() 
{ 
  long inches;

  moveForward();

  for(pos = 40; pos < 120; pos += 1)   
  {                                   
    myservo.write(pos);              
    if(pos == 90)
    {

      inches = inoutPing();

      if (inches <= range)
      {
        turnAround();
        moveForward();
      }
      else
      {
        moveForward();
      }
      delay(50);
    } 
    delay(15);                       
  }

  inches = inoutPing();

  if (inches <= range)
  {
    moveRight();
    moveForward();
  }
  else
  {
    moveForward();
  }

  delay(50);

  for(pos = 120; pos >= 40; pos-=1)      
  {                                
    myservo.write(pos);              
    if(pos == 90)
    {

      inches = inoutPing();

      if (inches <= range)
      {
        turnAround();
        moveForward();
      }
      else
      {
        moveForward();
      }
      delay(50);
    } 
    delay(15);                        
  } 

  inches = inoutPing();

  if (inches <= range)
  {
    moveLeft();
    moveForward();
  }
  else
  {
    moveForward();
  }

  delay(50);
} 

long inoutPing()
{
  long time, distance;
  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  time = pulseIn(pingPin, HIGH);
  
  distance = time / 74 / 2; 
  
  return distance;
}

void moveRight()
{
  digitalWrite(motorPins[2], LOW);
  analogWrite(motorPins[3], 110);
  delay(350);
}

void moveLeft()
{
  digitalWrite(motorPins[0], LOW);
  analogWrite(motorPins[1], 110);
  delay(350);
}

void turnAround()
{
  digitalWrite(motorPins[0], LOW);
  analogWrite(motorPins[1], 110);
  delay(750);
}

void moveForward()
{
  digitalWrite(motorPins[0], HIGH);
  analogWrite(motorPins[1], 150);
  digitalWrite(motorPins[2], HIGH);
  analogWrite(motorPins[3], 130);
}

