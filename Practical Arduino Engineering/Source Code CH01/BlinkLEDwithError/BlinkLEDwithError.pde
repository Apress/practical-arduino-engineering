// This code blinks a LED at 100ms

const int LEDdelay = 100;  // delay time

void setup()
{
     pinMode(13, OUTPUT);  // makes pin 13 a output
}

void loop()
{
     digitalWrite(13, HIGH);   // this write a high bit to pin 13
     delay(LEDdelay);          // delay 100ms
     digitalWrite(13, LOW);
     delay(LEDdelay)           // this will throw a syntax error due to a semicolon missing

} 

