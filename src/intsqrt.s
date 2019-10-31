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
 *		r0 = Value/Result
 *
 *
 */



intsqrt:


	// Remember: MOV the result to r0 before the branch below is executed
  	bx lr	// Branch to the address in lr (link register) to return
