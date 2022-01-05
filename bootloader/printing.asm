srt_load_bootloader: db "Bootloader loaded", 0x00
srt_load_kernel_into_memory: db "Kernel loaded into memory", 0x00


;bx : string address
printstr:
  pusha
  mov al, VERBOSE
  cmp al, 0x00
  je printstr_end
  mov ah, 0x0e
  printstr_start:
    mov al, [bx]
    cmp al, 0x00
    je printstr_end_newline
    int 0x10
    add bx, 1
    jmp printstr_start
  printstr_end_newline:
    mov al, 10
    int 0x10
    mov al, 13
    int 0x10
  printstr_end:
    popa
    ret

clear:
  pusha
  mov ah, 0x00
  mov al, 0x03  ; text mode 80x25 16 colours
  int 0x10
  popa
  ret