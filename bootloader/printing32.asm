str_load_protectedmode: db "Switched to 32 bit protected mode",0x00     ; line 48
err_kernel_returned: db "Kernel returned to bootloader", 0x00

; ax: line index
; ebx: string
; cl: color
printstr32:
    pusha
    push ax
    mov al, VERBOSE
    cmp al, 0x00
    pop ax
    je printstr32_end
    push cx
    ;mov edx, 0xb8000 + 160

    mov edx, 0x00
    mov ecx, 160 ; 160 = char + color
    mul ecx
    mov edx, 0xb8000
    add edx, eax
    
    
    pop cx
    ;mov ah, 0x07  ; color
    mov ah, cl  ; color
    printstr32_start:
        mov al, [ebx] ; load char
        cmp al, 0x00        ; exit?
        je printstr32_end   ; |
        mov [edx], ax
        inc ebx
        add edx, 0x02
        jmp printstr32_start
    printstr32_end:
        popa
        ret