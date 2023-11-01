#include <SPI.h>
#include <LCD_screen.h>
#include <LCD_screen_font.h>
#include <LCD_utilities.h>
#include <Screen_HX8353E.h>
#include <Terminal12e.h>
#include <Terminal6e.h>
#include <Terminal8e.h>
// Define screen
Screen_HX8353E myScreen;
#define MSP432P4111
#include "msp.h"
#include <energia.h>
#include "SPI.h"
#include <stdint.h>
#include <stdio.h>

#define MAXDOTS 100
int pwm_data[MAXDOTS];
void LCD_plot(void);


//FOR Timer_A0
#define UP 0x0010
#define UPDOWN 0x0030
#define CONT 0x0020
#define HALT 0x0000
//32kHz ACLK (32768)
#define ACLK 0x0100

#define COUNT  32768/20
#define COUNT2 32768/40

void setup() {
  WDT_A->CTL = WDT_A_CTL_PW | WDT_A_CTL_HOLD;   // stop watchdog timer
  myScreen.begin();
  myScreen.setPenSolid(true);
  pinMode(74, INPUT_PULLUP);  ////74 -> P1.4 pushbotton
  pinMode(34, INPUT_PULLUP);////34 -> p2_3

  
  ////**********  please modify the following code  ***********////
  
  ////setting up timer_A0 connected to ACLK in UP mode(counting modes)
  TIMER_A0->CTL = (UPDOWN | ACLK); 

  TIMER_A0->CCR[0] = COUNT;
  ////setting up P2.5 as output mode.
  P2->DIR =  BIT5;
  ////setting up P2.5 connected to timer0.
  P2->SEL0 |= BIT5;
  P2->SEL1 &= ~(BIT5);
  ////setting up timer output mode as toggle(mode 3) (connected to P2.5)
  TIMER_A0->CCTL[2] = TIMER_A_CCTLN_OUTMOD_4;
  ////setting up duty cycle (connected to P2.5)
  TIMER_A0->CCR[2] = COUNT2;
  
  ////**********  please modify the above code  ***********////

  
}



void loop() {
  LCD_plot();
  delay(0.1);
  
}



void LCD_plot(void){
  if(digitalRead(74)==0){
    myScreen.dRectangle(5, 30, 10+100, 50, blackColour);
    while(digitalRead(34)==1){continue;}
    for(int loops=0;loops<MAXDOTS;loops++){
      int buttonState = digitalRead(34);
      // print out the state of the button:
      pwm_data[loops] = buttonState;
      Serial.println(buttonState);  
      delay(10);////10ms 
    }
    for(int i=0;i<MAXDOTS;i++) myScreen.dRectangle(10+(i), 40+ (pwm_data[i]<<5), 1, 1, greenColour);   
  }
}

//void TA0_0_IRQHandler(void){
//}
