; inc 不会影响 CF 标志位

mov ax, 0xffff
inc ax

jmp $

times 510-($-$$) db 0
db 0x55, 0xaa
