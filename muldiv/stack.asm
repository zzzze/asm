mov ax, 0x1234

; 设置 ss 寄存器
mov bx, 0x0000
mov ss, bx

; 设置 sp 寄存器
mov sp, 0x0000

; ax 压入栈
push ax

mov ax, 0x4321

; ax 弹出栈
pop ax

jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
