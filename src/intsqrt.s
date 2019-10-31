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
	mov r1, r0
	ldr r0, =0x1

while:

	//Store r0 to compare later
	mov r2, r0

	//Itteration
	udiv r3, r1, r0 //  n/xk
	add r0, r0, r3 //   xk + n/xk
	lsr r0, r0, 0x1 //  half

	//See if done
	cmp r0, r2//If X(n+1) <=X(n)+1
	it eq
	beq leave

leave:
  	bx lr	// Branch to the address in lr (link register) to return
