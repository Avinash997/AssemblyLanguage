#include "led.h"



/**@warning : Use default compiler version 5**/

int cnt1,cnt2;

int main(void)
{
	led_init();

	while(1)
	{
		int i;
		led_on();
		
		for( i = 0; i<90000; i++)
		{
		  cnt1 +=1;
		}
		
		led_off();
		
		for( i = 0; i<90000; i++){
		 		cnt2 +=1;
		}

	}
}
