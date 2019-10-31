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

/*
*	Structure:
*		-sseglut:(Executes once)
*			-Initialise register
*		-Loop:(Repeats Indefinetly)
*			-Reset State register (Make them equal)
*			-Update Output to respective state (Determined by r3)
*			-load Input, Branch off if current state is greater than previous state
*			-Else loop
*		-writenum:(Conditional execution)
*			-Compare current display state to final display state
*			-If current = final, reset display state
*			-Else increment state
*			-Return to loop
*/
//Register Uses:
	//r0 = GPIOA
	//r1 = GPIOB
	//r2 = segData
	//r3 = Tracking/Memory
	//r4 = Transfere register
	//r5 = Previous State
	//r6 = Current State

sseglut:
//--Initialise registers
	ldr r0, =GPIOA_IDR //r0 holds address of GPIOA
	ldr r1, =GPIOB_ODR //r1 hold address of GPIOB
	ldr r2, =ssegdata //Store LUT data in r2
	ldr r3, =0x0 //Display State
	ldr r6, =0x0 //Current State

loop:
//--Reset
	mov r5, r6 //Make Previous state equal to current state.For first loop, initialises r5

//--Update Output/LED Display to respective state (Determined by r3)
	ldrb r4, [r2, r3] //Load data off LUT position r3
	lsl r4, r4, #3 //Shift bits by 3 to accomidate GPIOB pins
	str r4, [r1] //Store data in GPIOB (Output)

//--load Input, Branch off if current state is greater than previous state
	ldrb r6, [r0] //Load GPIOA (Input)
	cmp r6, r5 //If 0,0:Loop | 1,0:writenum | 0,1:Loop | 1,1:Loop
	it ls //If less than or equal too loop as button has not just been pressed
	bls loop //If greater than, ie button has just been pressed, continue to writenum

writenum:
//--Compare current display state to final display state
	cmp r3, #7 //Compare r3 to 7

//--If current = final, reset display state
	it eq //If 7, set to zero, alse add 1
	ldreq r3, =#0 //If it is seven, make zero
	beq loop //If it was made to be zero return to loop

//--Else increment state
	add r3, r3, #1 //If it was not zero Increment r3
	b loop

//----------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------

.align 4
ssegdata:   // The LUT
    .byte 0x39  // C
    .byte 0x4F  // 3
    .byte 0x4F  // 3
    .byte 0x4F  // 3
    .byte 0x3F  // 0
    .byte 0x7D  // 6
    .byte 0x6D  // 5
    .byte 0x4F  // 3
