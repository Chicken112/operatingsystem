.PHONY : all
all : build run


.PHONY : run
run : 
	qemu-system-x86_64 -drive format=raw,file="generated/osimage.bin",index=0,if=floppy

.PHONY : build
build : bootloader/bootloader.asm kernel/entry.c
	nasm -f bin bootloader/bootloader.asm -o generated/bootloader.bin
	gcc -ffreestanding -m32 -fno-pie --static -c kernel/entry.c -o generated/entry.o
	nasm -f elf bootloader/kernelentry.asm -o generated/kernelentry.o
	ld -m elf_i386 --entry entry -Ttext 0x1000 -o generated/kernel.bin generated/kernelentry.o generated/entry.o --oformat binary
	cat generated/bootloader.bin generated/kernel.bin > generated/osimage.bin