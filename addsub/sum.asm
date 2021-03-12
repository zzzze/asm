mov cx, 100
mov ax, 0x0000

; result: ax = 0x13ba
sum:
  add ax, cx
  loop sum

jmp $

times 510-($-$$) db 0
db 0x55, 0xaa
