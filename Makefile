CC:=arm-none-eabi-gcc -c
LD:=arm-none-eabi-ld
OC:=arm-none-eabi-objcopy

# specify the instruction set to use and the cpu (can not change this)
ARCH_FLAGS:=-mcpu=cortex-m3 -mthumb
# optimization for code size, use -O(0,1,2,3) for execution performance
OPTIMIZATION:=-Os
# the final compiler flags
CFLAGS:=$(ARCH_FLAGS) ${OPTIMIZATION} -I.# -flto

# add this option to LDFLAGS to build the map file along side the executable elf
MAP:=-Map=main.map
USE_NOHOST:=#--specs=nosys.specs
# introduce the path to the linker script and the name of the linker script
LDSCRIPTS:=-L. -T linker_script.ld
#the final linker flags
LDFLAGS:=$(USE_NOHOST) $(LDSCRIPTS)

# clean project
clean :
	rm -f *.o *.elf *.bin *.d *.map

# generate objects from c sources
%.o : %.c
	${CC} $(CFLAGS) $< -o $@

# generate objects from asm sources
%.o : %.s
	${CC} $(CFLAGS) $< -o $@

# add startup default defines for the project here
# check startup code, this will enable the startup file to zero the bss section, before starting
STARTUP_DEFS:=-D__STARTUP_CLEAR_BSS

# generate explicitly the startup object elf for this controller and project
startup_ARMCM3.o : startup_ARMCM3.s
	${CC} $(CFLAGS) $(STARTUP_DEFS) $< -o $@

# generate final elf by linking all the object files
main.elf : startup_ARMCM3.o main.o
	${LD} $(LDFLAGS) startup_ARMCM3.o main.o -o $@

# convert to hex or binary that can be transfered by the corresponding uploader driver
main.bin : main.elf
	${OC} -O binary main.elf main.bin

all : main.bin

# upload command to upload the code to the microcontroller
upload :
	stm32flash -w main.bin /dev/ttyUSB0