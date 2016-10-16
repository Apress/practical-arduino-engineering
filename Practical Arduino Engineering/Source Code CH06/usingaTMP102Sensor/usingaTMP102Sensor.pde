#include <Wire.h>
byte res;
byte msb;
byte lsb;
int val;
float tempC = 0.00;
float tempF = 0.00;

void setup()
{
  Serial.begin(115200);
  Wire.begin();
}

void loop()
{
  res = Wire.requestFrom(72,2); 
  if (res == 2) {
    msb = Wire.receive(); // Read on byte from TMP102
    lsb = Wire.receive(); // read least significant data
    val = ((msb) << 4);   // MSB 
    val |= (lsb >> 4);    // LSB 
    tempC = val*0.0625; // Converted to celsius
    tempF = (tempC * 9 / 5) + 32; // Convert to Fahrenheit
    Serial.print("Temperature: ");
    Serial.print(tempF - 5);
    Serial.println("F");
    delay(1000);   
  }
  
}

