/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_RIT.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    RIT.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "RIT.h"
#include "../led/led.h"

/******************************************************************************
** Function name:		RIT_IRQHandler
**
** Descriptions:		REPETITIVE INTERRUPT TIMER handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/

volatile unsigned int direction;
volatile uint8_t old_value = 0;
volatile uint8_t curr_value = 1;

void RIT_IRQHandler (void)
{			
	static int down=0;	
 	down++;
	
	if(direction == 1) {
		if((LPC_GPIO2->FIOPIN & (1<<11)) == 0) {
			reset_RIT();
			if(down == 1) {
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
			}
		} else {	/* button released */
			down=0;			
			disable_RIT();
			reset_RIT();
			NVIC_EnableIRQ(EINT1_IRQn);							 /* disable Button interrupts			*/
			LPC_PINCON->PINSEL4    |= (1 << 22);     /* External interrupt 0 pin selection EINT1*/
		}
	}
	
	if(direction == 2) {
		if((LPC_GPIO2->FIOPIN & (1<<12)) == 0) {
			reset_RIT();
			if(down == 1) {
				if(old_value != 0) {
					int diff = 0;
					diff = curr_value - old_value;
					curr_value = old_value;
					old_value = diff;
					LED_All_Off();
					LED_Out(curr_value);
				}
			}
		} else {	/* button released */
			down=0;			
			disable_RIT();
			reset_RIT();
			NVIC_EnableIRQ(EINT2_IRQn);							 /* disable Button interrupts			*/
			LPC_PINCON->PINSEL4    |= (1 << 24);     /* External interrupt 0 pin selection EINT1*/
		}
	}
	
	if(direction == 0) {
		if((LPC_GPIO2->FIOPIN & (1<<10)) == 0) {
			reset_RIT();
			if(down == 1) {
				LED_All_Off();
				old_value = 0;
				curr_value = 1;
				LED_Out(curr_value);
			}
		} else {	/* button released */
			down=0;			
			disable_RIT();
			reset_RIT();
			NVIC_EnableIRQ(EINT0_IRQn);							 /* disable Button interrupts			*/
			LPC_PINCON->PINSEL4    |= (1 << 20);     /* External interrupt 0 pin selection EINT1*/
		}
	}
	
  LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
