; bx:ax = 0x00020003
mov bx, 0x0002
mov ax, 0x0003

; dx:cx = 0x00030002
mov dx, 0x0003
mov cx, 0x0002

sub ax, cx
sbb bx, dx

jmp $

times 510-($-$$) db 0
db 0x55, 0xaa
