  .syntax unified
  .cpu cortex-m3
  .thumb
  .global blinky

// This defines a constant which is the STM32F103's address for the
// port C output data register
.equ	GPIOC_ODR,	0x4001100C

// NB: This function assumes that GPIOC was pre-configured as an output

blinky:
	ldr r0, =0x00002000 // The "2" puts a 1 in bit 13, for output pin PC13
	ldr r1, =0x00000000 // A source of zero to turn off PC13
	ldr r2, =GPIOC_ODR  // Load r3 with the address of port C’s output data register

	str r0, [r2] 	// Store the contents of r0 into the memory address
					// in r2. This turns on PC13, turning OFF the LED.

	ldr r3, =0x00080000 	// Delay loop, counts down from this number
delay1:
	sub r3, r3, #1	   	// Subtract 1 from r3 and store result back in r3
	cmp r3, #0		// Compare r3 to zero. This instruction sets status flags
	it gt			// IT (if-then) block.
	bgt delay1		// If the comparison result was "greater-than"

	str r1, [r2]	// Store the contents of r1 into the memory address
					// in r2. This turns off all of PORTC turning ON the LED.

	ldr r3, =0x00080000 	// Delay loop, counts down from this number
delay2:
	sub r3, r3, #1	// Subtract 1 from r3 and store result back in r3
	cmp r3, #0		// Compare r3 to zero. This sets status flags
	it gt			// IT (if-then) block.
	bgt delay2		// If the comparison result was "greater-than"

	b blinky		// lr was pushed earlier, this causes the function to return to
					// main()
