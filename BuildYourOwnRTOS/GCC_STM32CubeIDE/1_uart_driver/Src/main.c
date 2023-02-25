#include "led.h"
#include "uart.h"




int main(void)
{
	led_init();
	uart_tx_init();

	while(1)
	{
			printf("Hello from STM32F4.........\n\r");
	}
}
