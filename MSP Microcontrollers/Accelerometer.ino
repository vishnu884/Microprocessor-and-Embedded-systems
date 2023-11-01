#define LED GREEN_LED
// Include application, user and local libraries
#include <SPI.h>
#include <LCD_screen.h>
#include <LCD_screen_font.h>
#include <LCD_utilities.h>
#include <Screen_HX8353E.h>
#include <Terminal12e.h>
#include <Terminal6e.h>
#include <Terminal8e.h>
#include <string.h>
#include <stdio.h>
// Define constants for the joystick pins
const int AX = 23;
const int AY = 24;
const int AZ = 25;
// Define screen
Screen_HX8353E myScreen;
/*
* ---------------------------------------------------------------------------------------------------
* DO NOT EDIT CODE ABOVE THIS LINE
* ---------------------------------------------------------------------------------------------------
*/
// YOUR DECLARATIONS AND DEFINITIONS HERE
int x,y,z;
int col=20, row=10;
char a[30];
// Add setup code
void setup()
{
 /*
 * DO NOT EDIT BELOW THIS LINE
 */
 Serial.begin(9600); // for LCD debug output
 // By default MSP432 has analogRead() set to 10 bits. 
 // This Sketch assumes 12 bits. Uncomment to line below to set analogRead()
 // to 12 bit resolution for MSP432.
 analogReadResolution(12);
 // Init screen
 myScreen.begin();
 myScreen.setPenSolid(true);
 
 myScreen.clear(blackColour);
}
// Add loop code
void loop()
{
 // YOUR LOOP CODE HERE (runs continuously after setup function)
 digitalWrite(LED, HIGH);
 x = analogRead(AX);
 y = analogRead(AY);
 z = analogRead(AZ);
 Serial.print(x-1500);
 Serial.print(" ");
 Serial.print(y-1500);
 Serial.print(" ");
 Serial.print(z-2000);
 Serial.println();
 memset(a,'/0',30);
 sprintf(a,"X-Axis: %d",x);
 //myScreen.gText(col,row,a,myColours.white,myColours.black);
 myScreen.gText(col,row,a,whiteColour,blackColour);
 memset(a,'/0',30);
 sprintf(a,"Y-Axis: %d",y);
 //myScreen.gText(col,row+40,a,myColours.white,myColours.black);
  myScreen.gText(col,row+40,a,whiteColour,blackColour);
 memset(a,'/0',30);
 sprintf(a,"Z-Axis: %d",z);
 //myScreen.gText(col,row+80,a,myColours.white,myColours.black);
  myScreen.gText(col,row+80,a,whiteColour,blackColour);
 delay(400);
}
