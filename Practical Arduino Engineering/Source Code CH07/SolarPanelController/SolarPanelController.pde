#include <Servo.h>

Servo myServo;

int photo1 = A0;  // right photoresistor
int photo2 = A1;  // left photoresistor
int servoPin = 9; // servo pin

int val1 = 0; // value of right photoresistor
int val2 = 0; // value of left photoresistor

void setup()
{
  Serial.begin(9600);
  myServo.attach(servoPin);
  myServo.write(90);
  pinMode(photo1, INPUT);
  pinMode(photo2, INPUT); 
  Serial.println("Solar Controller v1.0");
}

void loop()
{
  delay(500);
  val1 = analogRead(photo1);
  val2 = analogRead(photo2);
  
  Serial.print("Photo1 Value: ");
  Serial.println(val1);
  Serial.print("Photo2 Value: ");
  Serial.println(val2);
  
   if (val1 >= 800 && val2 >= 800)
   {
     myServo.write(90);
     Serial.println("To Dark");
   }
   else if(val1 < val2)
   {
    myServo.write(115); 
    Serial.println("Right Photoresitor has more light"); 
   }
   else if(val2 < val1)
   {
    myServo.write(40); 
    Serial.println("Left Photoresitor has more light"); 
   }
     
}

