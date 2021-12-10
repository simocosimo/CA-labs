/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           funct_led.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        High level led management functions
** Correlated files:    lib_led.c, funct_led.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

#include "../timer/timer.h"
#include "lpc17xx.h"
#include "led.h"

#define LED_NUM     8                   /* Number of user LEDs                */
const unsigned long led_mask[] = { 1UL<<0, 1UL<<1, 1UL<<2, 1UL<< 3, 1UL<< 4, 1UL<< 5, 1UL<< 6, 1UL<< 7 };
// 25% -> 0.3ms - 0x0000222E
// 50% -> 0.7ms - 0x0000445C
// 75% ->   1ms - 0x000061A8
// indexes: 0 -> 25%, 1 -> 50%, 2 -> 75%		with clock configuration at 25Mhz
const unsigned long int_timings[] = { 0x0000222E, 0x0000445C, 0x000061A8 };
unsigned long off_delay = 0x0000222E;

extern unsigned char led_value;
extern unsigned int to_modulate;
extern unsigned int _intensity;

/*----------------------------------------------------------------------------
  Function that turns on requested LED
 *----------------------------------------------------------------------------*/
void LED_On(unsigned int num) {
 
  LPC_GPIO2->FIOPIN |= led_mask[num];
	led_value = LPC_GPIO2->FIOPIN;
}

/*----------------------------------------------------------------------------
  Function that turns on requested LED at requested intensity
 *----------------------------------------------------------------------------*/
void LED_On_Intensity(unsigned int num, unsigned int intensity) {
 
	LED_On(num);
	to_modulate = num;
	_intensity = intensity;
	switch(intensity) {
		case 75:
			init_mul_timer(2, int_timings[2], int_timings[2] + off_delay);
			enable_timer(2);
			break;
		case 50:
			init_mul_timer(2, int_timings[1], int_timings[1] + off_delay);
			enable_timer(2);
			break;
		case 25:
			init_mul_timer(2, int_timings[0], int_timings[0] + off_delay);
			enable_timer(2);
			break;
		default:
			break;
	}
	
}

/*----------------------------------------------------------------------------
  Function that turns off requested LED
 *----------------------------------------------------------------------------*/
void LED_Off(unsigned int num) {

  LPC_GPIO2->FIOPIN &= ~led_mask[num];
	led_value = LPC_GPIO2->FIOPIN;
}

/*----------------------------------------------------------------------------
  Function that outputs value to LEDs
 *----------------------------------------------------------------------------*/
void LED_Out(unsigned int value) {
  int i;
	
  for (i = 0; i < LED_NUM; i++) {
    if (value & (1<<i)) {
      LED_On (i);
    } else {
      LED_Off(i);
    }
  }
	led_value = LPC_GPIO2->FIOPIN;
	
}
