GXX:=arm-none-eabi-gcc
OCP:=arm-none-eabi-objcopy

GXX_FLAGS:=-mthumb -mcpu=cortex-m3 --specs=nosys.specs

SRCS:=./main.c

clean :
	rm -f *.o *.elf *.bin

compile : 
	${GXX} ${GXX_FLAGS} ${STM_STD_PERIPH_LIB_PATH_INC} ${SRCS} -o main.elf
	${OCP} -O binary main.elf main.bin

upload :
	stm32flash -w main.bin /dev/ttyUSB0