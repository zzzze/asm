NUL equ 0x00
SETCHAR equ 0x07
VIDEOMEM equ 0xb800
STRINGLEN equ 0xffff

section code align=16 vstart=0x7c00
  mov si, SayHello
  xor di, di
  call PringString
  mov si, SayByeBye
  call PringString
  jmp End

PringString:
  .setup:
  mov ax, VIDEOMEM
  mov es, ax
  
  mov bh, SETCHAR
  mov cx, 0xffff

  .printchar:
  mov bl, [ds:si]
  inc si
  mov [es:di], bl
  inc di
  mov [es:di], bh
  inc di
  or bl, NUL
  jz .return
  loop .printchar
  .return:
  ret

SayHello db 'Hi there, I am Coding Master!'
         db NUL
SayByeBye db 'I think you can handle it, bye!'
          db NUL

End: jmp End

times 510-($-$$) db 0
                 db 0x55, 0xaa
