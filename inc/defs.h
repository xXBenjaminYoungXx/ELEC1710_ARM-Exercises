#define PORTB_CRL *(volatile int *)(0x40010C00)
#define PORTB_CRH *(volatile int *)(0x40010C04)
#define PORTB_ODR *(volatile int *)(0x40010C0C)

#define PORTA_CRL *(volatile int *)(0x40010800)
#define PORTA_CRH *(volatile int *)(0x40010804)
#define PORTA_IDR *(volatile int *)(0x40010808)
#define PORTA_ODR *(volatile int *)(0x4001080C)

#define PORTC_CRL *(volatile int *)(0x40011000)
#define PORTC_CRH *(volatile int *)(0x40011004)
#define PORTC_ODR *(volatile int *)(0x4001100C)

#define RCC_APB2ENR *(volatile int *)(0x40021000+0x18)

#define AFIO_MAPR *(volatile int*)(0x40010000 + 0x04)

#define SCB_CCR *(volatile int*)(0xE000E01C)
