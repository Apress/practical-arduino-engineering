//************************************************************************
//					Nokia Shield O-Scope
//************************************************************************
//* Written by Peter Davenport on December 23, 2010.
//* http://peterdavenport.blogspot.com/
//* Uses the Sparkfun Color LCD Shield
//************************************************************************
//    External Component Library's
#include "LCD_driver.h"
//    Included files
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include "WProgram.h"
#include "HardwareSerial.h"
int val1 = 0; // The current value taken on the analog pin
int lastval = 1; // The last value taken on the analog pin
int drawSpeed = 50; // Delay on sample rate.
int osctime = 1; // Variable for timing/X axis position

//************************************************************************
//					Startup code
//************************************************************************
void	setup()
{
	ioinit();           //Initialize I/O
	LCDInit();	    //Initialize the LCD
        LCDContrast(44);    // Sets LCD contrast, adjust this if your contrast is odd looking.
        LCDClear(WHITE);    // Clear LCD to solid white
        LCDPutStr("Ardu-scope", 0, 4, BLACK, WHITE); //Intro and instructions on screen
        LCDPutStr("code by Peter", 16, 4, BLACK, WHITE);
        LCDPutStr("Davenport!", 32, 4, BLACK, WHITE);
        LCDPutStr("The program is", 48, 4, RED, WHITE);
        LCDPutStr("reading analog", 64, 4, RED, WHITE);
        LCDPutStr("pin #2.", 80, 4, RED, WHITE);
        LCDPutStr("Starting in:", 96, 20, GREEN, BROWN); // Startup Timer
        LCDPutStr("5", 112, 58, GREEN, BROWN);
        delay(1000);
        LCDPutStr("4", 112, 58, GREEN, BROWN);
        delay(1000);
        LCDPutStr("3", 112, 58, GREEN, BROWN);
        delay(1000);
        LCDPutStr("2", 112, 58, GREEN, BROWN);
        delay(1000);
        LCDPutStr("1", 112, 58, GREEN, BROWN);
        delay(1000);
        LCDPutStr("0", 112, 58, GREEN, BROWN);
        LCDClear(WHITE);    // Clear LCD to solid White
    //Draw voltage indicator lines
    LCDSetLine(128, 0, 128, 136, BLACK);
    LCDSetLine(44, 0, 44, 136, ORANGE);
    LCDSetLine(2, 0, 2, 136, RED);
    //Write indicator volatges
    LCDPutStr("3.3", 44, 102, ORANGE, WHITE);
    LCDPutStr("5v", 2, 112, RED, WHITE);
    //Write the speed
    if(drawSpeed == 1){
    LCDPutStr("Fast", 2, 4, BLUE, WHITE);
    } else if (drawSpeed == 50) {
    LCDPutStr("Medium", 2, 4, BLUE, WHITE);
    } else {
    LCDPutStr("Slow", 2, 4, BLUE, WHITE);
    }
    //End of startup and begenning the o-scope loop that takes readings, displays them, and checks for button presses.
}
//************************************************************************
//					Loop
//************************************************************************
void	loop()
{
  
  if(osctime <= 130){ // if the X position is still on the screen then...
  
      val1 = analogRead(2);    // read the value from the sensor for line 2
      val1 = 1024 - val1; // Invert it to make it display corectly.
      val1 = val1 / 8; // Divide it by eight to allow it to fit on the screen properly.
      LCDSetLine(lastval, osctime, val1, osctime + 1, BLUE); // Draw it as a linf from last value to current value.
      lastval = val1;//Update last value
      delay(drawSpeed); // wait the prescribed time
      osctime++;//add one to the X position
    
  }else{ // if the X position is not on the screen then...
      osctime = 0;//Clear the timer
      LCDClear(WHITE);    //Clear the LCD
      //Re-draw indicator lines
      LCDSetLine(128, 0, 128, 136, BLACK);
      LCDSetLine(44, 0, 44, 136, ORANGE);
      LCDSetLine(2, 0, 2, 136, RED);
      //Re-write indicator volatges
      LCDPutStr("3.3", 44, 102, ORANGE, WHITE);
      LCDPutStr("5v", 2, 112, RED, WHITE);
      //Re-write the speed
        if(drawSpeed == 1){
          LCDPutStr("Fast  ", 2, 4, BLUE, WHITE);
        } else if (drawSpeed == 50) {
          LCDPutStr("Medium", 2, 4, BLUE, WHITE);
        } else {
          LCDPutStr("Slow  ", 2, 4, BLUE, WHITE);
        }
  }
  //Now it's time to check for button presses
int	s1, s2, s3; // Make intergers for all the swiches
	s1	=	!digitalRead(kSwitch1_PIN); //apply the button values to the intergers
	s2	=	!digitalRead(kSwitch2_PIN);
	s3	=	!digitalRead(kSwitch3_PIN);

if (s1){ // if button 1 is pressed then ....
   drawSpeed = 100; // Set the draw speed to 100
   LCDPutStr("Slow  ", 2, 4, BLUE, WHITE); // write on the screen that the speed is Slow
	}
else if (s2){
   drawSpeed = 50; // Set the draw speed to 50
   LCDPutStr("Medium", 2, 4, BLUE, WHITE); // Write on the screen that the speed is Medium
	}
else if (s3){
     drawSpeed = 1; // Set the draw speed to 1
     LCDPutStr("Fast  ", 2, 4, BLUE, WHITE); // Write on the screen that the speed is Fast
	}
  s1 = 0; // set the button values to 0 
  s2 = 0;
  s3 = 0;
}
