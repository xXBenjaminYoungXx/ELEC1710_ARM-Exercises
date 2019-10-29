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

//----------------------
//Main Instruction Body|
//----------------------

//Register Uses:
	//r0 = GPIOA
	//r1 = GPIOB
	//r2 = segData
	//r3 = Tracking/Memory
	//r4 = transfere register 1
	//r5 = StateBef
	//r6 = StateNow

sseglut:
	ldr r0, =GPIOA_IDR //r0 holds address of GPIOA
	ldr r1, =GPIOB_ODR //r1 hold address of GPIOB
	ldr r2, =ssegdata //Store LUT data in r2
	ldr r3, =0x0 //Count Memory
	ldr r5, =0x0 //State of button prior (Before)

	//Set Seg to display C
	ldrb r4, [r2, #7] //get data for c from LUT
	lsl r4, r4, #3 //Shift bits by three as B0-2 are a no-go
	str r4, [r1] //Store that data into GPIOB (Output) regesture

loop:
	ldrb r6, [r0] //Load GPIOA (Input)
	cmp r6, r5 //If 0,0:Loop | 1,0:writenum | 0,1:Loop | 1,1:Loop
	it ls //If input has gone from off to on (Ie greater than) continue else loop
	bls loop //If not greater than I.e 0-->1, loop

writenum:
	ldrb r4, [r2, r3] //Load data off LUT position r3
	lsl r4, r4, #3 //Shift bits by 3
	str r4, [r1] //Store data in GPIOB (Output)
	mov r5, r6 //Make State prev eq to current state

	//Increment Num
	cmp r3, #7 //Compare r3 to 7
	it eq //If 7, set to zero, alse add 1
	ldreq r3, =#0 //If it is seven, make zero
	beq loop //If it was made to be zero return to loop
	add r3, r3, #1 //If it was not zero add one
	b loop //Return to loop

//----------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------


.align 4
ssegdata:   // The LUT
    .byte 0x4F  // 3
    .byte 0x4F  // 3
    .byte 0x4F  // 3
    .byte 0x3F  // 0
    .byte 0x7D  // 6
    .byte 0x6D  // 5
    .byte 0x4F  // 3
    .byte 0x39  // C

/*
To make more efficient:
-I can remove b loop as main.c is a loop
-I can have C not print on start up and only print when button pushed
Would remove 3 lines of code.
*/
