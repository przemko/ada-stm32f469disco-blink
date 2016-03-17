all: flash

flash: main.bin
	st-flash write main.bin 0x8000000

main.bin: main
	arm-eabi-objcopy -O binary main main.bin

main: main.adb
	gprbuild

clean:
	gprclean
	rm -f main.bin *~

