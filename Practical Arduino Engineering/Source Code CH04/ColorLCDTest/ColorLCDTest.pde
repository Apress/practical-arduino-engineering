#include <ColorLCDShield.h>

LCDShield lcd;

void setup()
{
  lcd.init(EPSON);
  lcd.contrast(40);
  lcd.clear(WHITE);
 
  lcd.setStr("Epson", 50, 40, BLACK, WHITE); 
}
void loop()
{
}
