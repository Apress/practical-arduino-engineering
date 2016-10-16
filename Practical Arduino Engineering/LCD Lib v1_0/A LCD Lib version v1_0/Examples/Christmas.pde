//************************************************************************
//					Nokia Shield
//************************************************************************
//* Derived from code by James P. Lynch and Mark Sproul.	
//*
//*Edit History
//*		<MLS>	= Mark Sproul, msproul -at- jove.rutgers.edu
//*             <PD>   = Peter Davenport, electrifiedpete -at- gmail.com
//************************************************************************
//*	Apr  2,	2010	<MLS> I received my Color LCD Shield sku: LCD-09363 from sparkfun.
//*	Apr  2,	2010	<MLS> The code was written for WinAVR, I modified it to compile under Arduino.
//*     Aug  7, 2010    <PD> Organized code and removed unneccesary elements.
//*     Aug 23, 2010    <PD> Added LCDSetLine, LCDSetRect, and LCDPutStr.
//*     Oct 31, 2010    <PD> Added circle code from Carl Seutter and added contrast code.
//************************************************************************
//    External Component Libs
#include "LCD_driver.h"
//#include "nokia_tester.h"
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

//************************************************************************
//					Main Code
//************************************************************************
void	setup()
{
	ioinit();           //Initialize I/O
	LCDInit();	    //Initialize the LCD
        LCDContrast(44);
        LCDClear(WHITE);    // Clear LCD to a solid color
                LCDPutStr("MERRY CHRISTMASS", 10, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 26, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 42, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 58, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 74, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 90, 10, RED, WHITE);
        LCDPutStr("MERRY CHRISTMASS", 106, 10, RED, WHITE);
        LCDSetRect(55, 116, 75, 130, 1, BROWN);
        LCDDrawCircle (61, 4, 4, RED, FULLCIRCLE);//top
       
}
int num = 1;
int vertBottom = 115;
int horizontalRightBottom = 120;
int horizontalLeftBottom = 10;
int timer = 56;
int timer2 = 11;
int bulbsDown = 4;
int bulbsRight = 61;
int bulbsLeft = 61;

//************************************************************************
//					Loop
//************************************************************************
void	loop()
{
if(timer > 0){
  LCDSetLine(horizontalLeftBottom, vertBottom, horizontalRightBottom, vertBottom, GREEN);
  vertBottom = vertBottom - 1;
  LCDSetLine(horizontalLeftBottom, vertBottom, horizontalRightBottom, vertBottom, GREEN);
  vertBottom = vertBottom - 1;
  horizontalRightBottom = horizontalRightBottom - 1;
  horizontalLeftBottom = horizontalLeftBottom + 1;
  timer--;
}else{
if(timer2 > 0){
  //Left bulbs
    LCDDrawCircle (bulbsRight, bulbsDown, 4, ORANGE, FULLCIRCLE);
    //Right bulbs
    LCDDrawCircle (bulbsLeft, bulbsDown, 4, RED, FULLCIRCLE);
bulbsDown = bulbsDown + 10;
bulbsRight = bulbsRight +5;
bulbsLeft = bulbsLeft -5;
timer2--;
  //Left bulbs
    LCDDrawCircle (bulbsRight, bulbsDown, 4, RED, FULLCIRCLE);
    //Right bulbs
    LCDDrawCircle (bulbsLeft, bulbsDown, 4, ORANGE, FULLCIRCLE);
bulbsDown = bulbsDown + 10;
bulbsRight = bulbsRight +5;
bulbsLeft = bulbsLeft -5;
timer2--;
}
}
}
