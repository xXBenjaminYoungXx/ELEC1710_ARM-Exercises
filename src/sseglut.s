/*
 * sseglut.s
 *
 *  Created on: 21 Oct 2019
 *      Author: Benjamin Young
 *		Studen Number: C3330653
 *		Email: BenjaminYoung7198@gmail.com
 *		IL Session: Tuesday 1:00pm
 */

  .syntax unified
  .cpu cortex-m3
  .thumb
  .global sseglut

//----------------------------
//GPIO(A/B) adress allocation|
//----------------------------

.equ GPIOA_IDR, 0x40010808 //Declare GPIOA_IDR (General Purpose I/O Port A _ Input) as Input address
.equ GPIOB_ODR, 0x40010C0C //Declare GPIOB_ODR (General Purpose I/O Port B _ Output) as Output address
//Note: A0 is used as bit input from debounced button

//----------------------
//Main Instruction Body|
//----------------------

//Register Uses:
	//r0 = GPIOA
	//r1 = GPIOB
	//r2 = segData
	//r3 = Tracking/Memory
	//r4 = transfere register 1

//Initialization (Have C as default print)
ldr r0, GPIOA_IDR //r0 holds address of GPIOA
ldr r1, GPIOB_ODR //r1 hold address of GPIOB
ldr r2, =segdata //Store LUT data in r2
ldr r3, 0x00000000 //Start at 0

//Print C, ie store 0x29 in GPIOB
ldr r4, [r2, #12] //Get data from LUT for C **ASK IF I NEED TO DO THIS**
str r4, [r1] //Store r4 data in GPIOA register.

sseglut:

	//Begin by looking for GPIOA_IDR A0 bit to be high
	ldr r4, [r0]

	//Collect bit data using UBFX and store in r4
	ubfx r4, r4, #31, #1//*ASK FOR HELP**\\

	//Compare
	cmp r4, #1

	//If Not eq Return ProjectC
	bne ssegult

	b stage2

stage2:

	//At this stage we need to print the next number
	//To do so a group of conditional branches will be used
	//each branch will depend on r3
	/*R3 value:     Current print:      What to print:
	*	0			c					3
	*	1			3					3
	*	2			3					3
	*	3			3					0
	*	4			0					6
	*	5			6					5
	*	6			5					3
	*	7			3					c
	*/
	cmp r3, #3 //If r3 is less than 3, print 3
	bcc print3

	cmp r3, #3 //If r3 is 3
	beq print0

	cmp r3, #4 //If r3 is 4
	beq print6

	cmp r3, #5 //If r3 is 5
	beq print5

	cmp r3, #6 //If r3 is 6
	beq print3

	cmp r3, #7 //If r3 is 7
	beq printc

printc:
	ldr r4, [r2, #12] //Get data from LUT for C **ASK IF I NEED TO DO THIS**
	str r4, [r1] //Store r4 data in GPIOA register.
	b stage3
print3:
	ldr r4, [r2, #3] //Get data from LUT for 3 **ASK IF I NEED TO DO THIS**
	str r4, [r1] //Store r4 data in GPIOA register.
	b stage3
print0:
	ldr r4, [r2] //Get data from LUT for 0 **ASK IF I NEED TO DO THIS**
	str r4, [r1] //Store r4 data in GPIOA register.
	b stage3
print6:
	ldr r4, [r2, #6] //Get data from LUT for 6 **ASK IF I NEED TO DO THIS**
	str r4, [r1] //Store r4 data in GPIOA register.
	b stage3
print5:
	ldr r4, [r2, #5] //Get data from LUT for 5 **ASK IF I NEED TO DO THIS**
	str r4, [r1] //Store r4 data in GPIOA register.
	b stage3

stage3:
	//This stage is to read r3 and determine the next value, then branch to stage 4
	cmp r3, #7

	//if not 7 r3 = r3+1, if 7 r3 = 0
	//it eq
	ldreq r3, #0

	//it ne
	addne r3, #1

	//Branch to stage 4
	b stage4

stage4:
	//This stage is to hold the program till the clock is off

	//Begin by looking for GPIOA_IDR A0 bit to be low
	ldr r4, [r0]

	//Collect bit data using UBFX and store in r4
	ubfx r4, r4, #31, #1//*ASK FOR HELP**\\

	//Compare
	cmp r4, #1
	it eq //if equ

	beq stage4

	//Otherwise restart program
	b sseglut

//----------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------


.align 4
ssegdata:   // The LUT
    .byte 0x3F  // 0
    .byte 0x06  // 1
    .byte 0x5B  // 2
    .byte 0x4F  // 3
    .byte 0x66  // 4
    .byte 0x6D  // 5
    .byte 0x7D  // 6
    .byte 0x07  // 7
    .byte 0x7F  // 8
    .byte 0x67  // 9
    .byte 0x77  // A
    .byte 0x7C  // B
    .byte 0x29  // C
    .byte 0x5E  // D
    .byte 0x79  // E
    .byte 0x71  // F
