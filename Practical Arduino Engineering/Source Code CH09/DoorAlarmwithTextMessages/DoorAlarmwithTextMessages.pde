#include <NewSoftSerial.h>

NewSoftSerial cell(2,3);  // Soft Serial Pins

const int pingPin = 7;

char phoneNumber[] = "xxxxxxxxxx";  // Replace xxxxxxxx with the recipient's mobile number

void setup()
{
  cell.begin(9600);

  delay(35000); // Allow GSM to process
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
  delay(500);

  if (inches >= 5)
  {
    cell.println("AT+CMGF=1"); // set SMS mode to text

    cell.print("AT+CMGS=");  // now send message...

    cell.print(34,BYTE); // ASCII equivalent of "

    cell.print(phoneNumber);

    cell.println(34,BYTE);  // ASCII equivalent of "

    delay(500); 

    cell.print("Door Has Been Opened!!");   // our message to send

    cell.println(26,BYTE);  // ASCII equivalent of Ctrl-Z

    delay(15000);
    
    while (1>0);  // if you remove this you will get a text message every 30 seconds or so.
  }
  else
  {
    // do nothing
  }

  delay(100);
}


