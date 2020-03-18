This is a sample project for bare metal programming STM32F103 blue pill board

setup requirements

Linux debian
ARM cross compiler toolchain
	sudo apt-get install gcc-arm-none-eabi binutils-arm-none-eabi
stm32flash to flash the controller, considering the controller has default factory bootloader
	sudo apt-get install stm32flash
stm32f103 microcontroller, with factory bootloader
usb to uart converter
	PL2303HX, CP2102, ftdi etc

I do not recommend baremetal programming,
It is just me exploring brainfuck and masochism.