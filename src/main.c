#include "defs.h"

unsigned int bytearraysum(unsigned char *p, unsigned int length);
unsigned int intarraysum(unsigned int *p, unsigned int length);
unsigned int intsqrt(unsigned int x);
unsigned int intsqrt_c(unsigned int n);
void blinky(void);
void sseglut(void);
void ProjectC(void);

int main(void)
{
	// Enable GPIOA, GPIOB, GPIOC and AFIO clocks
	RCC_APB2ENR |= 0x1D;

	// Disable NJTRST and JTDO functions to enable pins B3 and B4 to be GPIO
	AFIO_MAPR |= (1<<25);

	// PORTA = inputs
	PORTA_CRL = 0x88888888;
	PORTA_CRH = 0x88888888;
	PORTA_ODR = 0x0; //Pulldown

	// PORT B = outputs
	PORTB_CRL = 0x22222222;
	PORTB_CRH = 0x22222222;

	// PORT C = outputs
	PORTC_CRL = 0x22222222;
	PORTC_CRH = 0x22222222;

	// Zero GPIOB pins
	PORTB_ODR = 0x00000000;

	// This should cause usage faults on unaligned LDRs
	SCB_CCR |= 0x04;

	for(;;) {
		
		//Project Part C coded task Benjamin Young
		ProjectC();

		// Uncomment to call label "blinky" in blinky.s
		//blinky();

		// Uncomment to call sseglut in sseglut.s
		// sseglut();

		// Uncomment the section below to run the array sum functions
	/*
		// The byte array that gets summed together
		unsigned char bytearray[] = {2,1,5,8,6,65,235,45,98,5,7};
		// The array of ints for summing together
		int intarray[] = {0x123456, 0x321654, 0x21654987};
		volatile unsigned int total;
		total = bytearraysum(bytearray, sizeof(bytearray));
		total = intarraysum(intarray, sizeof(intarray)/4); // Division by 4 because sizeof() returns a count in bytes
	*/

		// Uncomment the block below to perform the integer square root exercise

	/*
		volatile unsigned int result, argument;
		argument = 2456490969; 			// Result should be 49563 (2456490969 is 49563 squared)
		PORTB_ODR = (1<<8);
		result = intsqrt(argument); 	// Call your integer square root function
		PORTB_ODR = 0;
		PORTB_ODR = (1<<8);
		result = intsqrt_c(argument);	// Call the C integer square root function
		PORTB_ODR = 0;

		// A delay so that integer square root timing can be unambiguously seen on GPIOB8
		volatile unsigned int x;
		for(x = 0; x < 100; x++);
	*/
	}
}


unsigned int intsqrt_c(unsigned int n){
	unsigned int xk=1, xkp1=1;	//x_k and x_k+1

	do {
		xk = xkp1;
		xkp1 = (xk + n/xk) / 2;
	} while(xk - xkp1 > 1);

	return xkp1;
}

