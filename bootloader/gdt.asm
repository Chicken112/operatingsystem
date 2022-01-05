; global descriptor table
gdt_start:

; null descryptor (8 bytes)
dd 0x0
dd 0x0

gdt_code:
dw 0xffff   ; Limit (bits 0-15)
dw 0x0      ; Base (bits 0-15)
db 0x0      ; Base (bits 16 -23)
db 10011010b; 1 (segment is used) | 00 (highest privilage[ring]) | 1 (code or data?)
            ; [flags] 1 (code?) | 0 (can be executed by lower privilage) | 1 (readable, or only executeable) | 0 (managed by cpu[set dynamically])
db 11001111b; 1 (limit = limit * 0x1000) | 1 (32 bits) | 0 (64 bits) | 0 (avl)
            ; 1111 (last 4 bits of limit)
db 0x0      ; Base (bits 24 - 31)

gdt_data:
dw 0xffff   ; Limit (bits 0-15)
dw 0x0      ; Base (bits 0-15)
db 0x0      ; Base (bits 16 -23)
db 10010010b ; 1st flags , type flags
db 11001111b ; 2nd flags , Limit (bits 16-19)
db 0x0      ; Base (bits 24 -31)

gdt_end:
gdt_descriptor:
dw gdt_end - gdt_start - 1 ; Size of our GDT
dd gdt_start ; Start address of our GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start