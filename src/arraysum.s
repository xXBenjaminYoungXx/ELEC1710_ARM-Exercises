  .syntax unified
  .cpu cortex-m3
  .thumb
  .global bytearraysum
  .global intarraysum

//--------------------------
// bytearraysum: returns the sum of an array of 8-bit integers (signed or unsigned)
//--------------------------
bytearraysum:
	// The array address will be in r0
	// The array size (number of 8-bit bytes) will be in r1

	//--------------------------
	// Write your code here
	//--------------------------

	// In the mov instruction below change rX to the register with the array's sum
	mov r0, r1			// Return value goes in r0, modify "r1" to suit your code
	bx lr				// lr (link register) was set before branching to bytearraysum.
						// This branch instruction causes execution to return

// END OF BYTEARRAYSUM
// -------------------

//--------------------------
// intarraysum: returns the sum of an array of 32-bit integers (signed or unsigned)
//--------------------------
intarraysum:
	// The array address will be in r0
	// The array size (number of 32-bit integers) will be in r1

	//--------------------------
	// Write your code here
	//--------------------------


	// In the mov instruction below change rX to the register with the array's sum
	mov r0, r1			// Return value goes in r0, modify "r1" to suit your code
	bx lr				// lr (link register) was set before branching to bytearraysum.
						// This branch instruction causes execution to return

// END OF INTARRAYSUM
// ------------------
