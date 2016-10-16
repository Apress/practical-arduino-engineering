char ch;

void setup()
{
  Serial.begin(9600); 
  
  Serial.println("Entered Setup Structure"); 
  delay(1000);
  
}
void loop()
{ 
  ch = Serial.read();
  
  if (ch == 'g')
  {
     Serial.println("First If Statement entered"); 
  }
  else if (ch == 's')
  {
     Serial.println("Second If Statement entered"); 
  }
  else
  {
     Serial.println("Else Statement entered"); 
  }
  delay(1000);
  
}
