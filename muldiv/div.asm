; 被除数 dx:ax - 0x00090006
mov dx, 0x0009
mov ax, 0x0006

; 除数
mov cx, 0x0002

; 初始化 stack
mov bx, 0x0000
mov ss, bx
mov sp, 0x0000

; 高位除法
push ax
mov ax, dx
mov dx, 0x0000
div cx

; 保存高位商到 bx
mov bx, ax

; 低位除法
pop ax
div cx

; 结果：0x48003
; bx => 0x0004
; ax => 0x8003
; dx => 0x0000

jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
