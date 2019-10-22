  .syntax unified
  .cpu cortex-m3
  .thumb
  .global intsqrt

intsqrt:
	// Returns sqrt(n) in register 0
	// The number "n" is found in register 0

	// Remember: MOV the result to r0 before the branch below is executed
  	bx lr	// Branch to the address in lr (link register) to return
