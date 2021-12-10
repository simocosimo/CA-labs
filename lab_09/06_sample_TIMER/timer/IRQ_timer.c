/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"

volatile uint8_t mrlookfor = 0;

/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
extern unsigned char led_value;					/* defined in funct_led								*/
extern unsigned int to_modulate;				/* defined in func_led								*/
extern unsigned int _intensity;
void TIMER0_IRQHandler (void)
{
  LPC_TIM0->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
** Function name:		Timer2_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/

void TIMER2_IRQHandler (void)
{
	if(mrlookfor == 0) {
		LED_Off(to_modulate);
		mrlookfor = 1;
		LPC_TIM2->IR = 1;			/* clear interrupt flag */
	} else if(mrlookfor == 1) {
		LED_On_Intensity(to_modulate, _intensity);
		mrlookfor = 0;
		LPC_TIM2->IR = 2;			/* clear interrupt flag */
	}
 
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
