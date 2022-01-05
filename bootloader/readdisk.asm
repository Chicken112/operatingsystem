str_err_dikread: db "Error reading disk",0x00
str_err_notenoughspace: db "Not enough sectors read",0x00

; dh : Number of sectors to read
; dl : drive number
; es: offset, bx: offset [es:bx]
readdisk:
    pusha
    push dx
    mov ah, 0x02                ; BIOS read sector function
    mov al, dh                  ; Number of sectors to read
;    mov dl, 0x00                ; Read drive 0 (i.e. first floppy drive)
    mov ch, 0x00                ; Cylinder number
    mov dh, 0x00                ; Head number
    mov cl, 0x02                ; Sector to read from (indexed form 1)
    
    int 0x13                    ; Read

    pop dx
    cmp al, dh
    jne diskerr_space
    jc dikerr_general
    popa
    ret


dikerr_general:
mov ah, 0x0e
mov al, [0x9000]
int 0x10
    mov bx, str_err_dikread
    call printstr
    jmp $

diskerr_space:
    mov bx, str_err_notenoughspace
    call printstr
    jmp $