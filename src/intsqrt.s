  .syntax unified
  .cpu cortex-m3
  .thumb
  .global intsqrt

/*
 * sseglut.s
 *
 *  Created on: 21 Oct 2019
 *      Author: Benjamin Young
 *		Studen Number: C3330653
 *		Email: BenjaminYoung7198@gmail.com
 *		IL Session: Tuesday 1:00pm
 */

 // Returns sqrt(n) in register 0
// The number "n" is found in register 0

 /*Register Uses:
 *		r0 = current Value/Result
 *		r1 = n (Argument)
 *		r2 = previous value/Result
 		r3 = athrithmic carrier
 *
 */

intsqrt:
	mov r1, r0 //Move argument to r1, as r0 will be used for return
	ldr r0, =0x1 //Initilize r0

	//Itteration
	udiv r3, r1, r0 //  n/xk
	add r0, r0, r3 //   xk + n/xk
	lsr r0, r0, 0x1 //  half
while:

	//Store r0 to compare later
	mov r2, r0

	//Itteration
	udiv r3, r1, r0 //  n/xk
	add r0, r0, r3 //   xk + n/xk
	lsr r0, r0, 0x1 //  half

	//See if done
	cmp r0, r2
	it hi
	bhi final //If it has become bigger, it is flip-floping.
	bne while //If it is less than xn +1, loop
	beq leave //If it has not changed we are done

final:
	//Because it has fliped floped, we need to go to smaller value then leave
	udiv r3, r1, r0 //  n/xk
	add r0, r0, r3 //   xk + n/xk
	lsr r0, r0, 0x1 //  half

leave:
  	bx lr	// Branch to the address in lr (link register) to return
