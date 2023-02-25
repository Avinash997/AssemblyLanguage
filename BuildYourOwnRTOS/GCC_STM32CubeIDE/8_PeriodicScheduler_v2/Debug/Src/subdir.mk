################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (9-2020-q2-update)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Src/led.c \
../Src/main.c \
../Src/osKernel.c \
../Src/syscalls.c \
../Src/sysmem.c \
../Src/uart.c 

OBJS += \
./Src/led.o \
./Src/main.o \
./Src/osKernel.o \
./Src/syscalls.o \
./Src/sysmem.o \
./Src/uart.o 

C_DEPS += \
./Src/led.d \
./Src/main.d \
./Src/osKernel.d \
./Src/syscalls.d \
./Src/sysmem.d \
./Src/uart.d 


# Each subdirectory must supply rules for building sources it contributes
Src/led.o: ../Src/led.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/led.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/main.o: ../Src/main.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/main.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/osKernel.o: ../Src/osKernel.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/osKernel.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/syscalls.o: ../Src/syscalls.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/syscalls.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/sysmem.o: ../Src/sysmem.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/sysmem.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Src/uart.o: ../Src/uart.c Src/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DSTM32F411xE -c -I../Inc -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Include" -I"C:/Users/Gaming Laptop RTX/Documents/BuildYourOwnRTOS/GCC_STM32CubeIDE/8_PeriodicScheduler_v2/chip_headers/CMSIS/Device/ST/STM32F4xx/Include" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -MMD -MP -MF"Src/uart.d" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

