################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../src/arraysum.s \
../src/blinky.s \
../src/intsqrt.s \
../src/sseglut.s 

C_SRCS += \
../src/main.c 

OBJS += \
./src/arraysum.o \
./src/blinky.o \
./src/intsqrt.o \
./src/main.o \
./src/sseglut.o 

C_DEPS += \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Assembler'
	@echo $(PWD)
	arm-none-eabi-as -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -I"C:/Users/User/eclipse-workspace2/ELEC1710_ARM_Exercises/inc" -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU GCC Compiler'
	@echo $(PWD)
	arm-none-eabi-gcc -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -DSTM32F1 -DSTM32F103C8Tx -DSTM32 -DDEBUG -I"C:/Users/User/eclipse-workspace2/ELEC1710_ARM_Exercises/inc" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


