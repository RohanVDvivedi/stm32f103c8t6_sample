/*
	A simple blink program built for stm32f103 on a blue pill board or alike
*/

#include<regs/rcc.h>
#include<regs/gpio.h>

void delay_for(volatile int clocks)
{
	while(clocks--)
	{
		asm("nop");
	}
}

void main(void)
{
	RCC->RCC_APB2ENR |= (1<<4);

	GPIOC->GPIO_CRH   &= 0xFF0FFFFF;
	GPIOC->GPIO_CRH   |= 0x00200000;

	while(1)
	{
		GPIOC->GPIO_ODR ^= (1 << 13);
		delay_for(300000);
	}
}