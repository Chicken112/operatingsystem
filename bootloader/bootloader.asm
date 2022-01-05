[ org 0x7c00 ]
mov [BOOTDRIVE], dl ; Boot drive is stored in dl by bios
KERNEL_OFFSET equ 0x1000
VERBOSE equ 0x01    ; debug strings

mov bp , 0x9000 ; Stack
mov sp , bp

call clear
mov bx, srt_load_bootloader
call printstr


load_kernel:
mov bx, KERNEL_OFFSET
mov dh, 20
mov dl, [BOOTDRIVE]
call readdisk
mov bx, srt_load_kernel_into_memory
call printstr

; mov ah, 0x0e
; mov al, [0x9000]
; int 0x10

call switchto32

jmp $

%include "bootloader/printing.asm"
%include "bootloader/readdisk.asm"
%include "bootloader/gdt.asm"

[bits 32]
after_switch:
    mov ebx, str_load_protectedmode
    mov ax, 2
    mov cl, 0x07
    call printstr32

    call KERNEL_OFFSET
    
    mov ebx, err_kernel_returned
    mov ax, 24
    mov cl, 0x0c
    call printstr32
    jmp $

%include "bootloader/switchto32.asm"
%include "bootloader/printing32.asm"

[bits 16]
BOOTDRIVE: db 0

; padding + magic number
times 510 - ($-$$) db 0
dw 0xaa55