#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"

uint8_t old_value = 0;
uint8_t curr_value = 1;

void EINT0_IRQHandler (void)	  
{
	LED_All_Off();
	old_value = 0;
	curr_value = 1;
	LED_Out(curr_value);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	int tmp = 0;
	if(curr_value < 233) {
		if(old_value != 0) {
			tmp = curr_value;
			curr_value += old_value;
		} else {
			tmp = 1;
		}
		old_value = tmp;
		LED_All_Off();
		LED_Out(curr_value);
	}
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	if(old_value != 0) {
		int diff = 0;
		diff = curr_value - old_value;
		curr_value = old_value;
		old_value = diff;
		LED_All_Off();
		LED_Out(curr_value);
	}
	
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}


