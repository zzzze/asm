HDDPORT equ 0x1f0
NUL equ 0x00
SETCHAR equ 0x07
VIDEOMEM equ 0xb800

section code align=16 vstart=0x7c00

; 初始化硬盘扇区相关数据
mov si, [READSTART]  ; 低位 8 位
mov cx, [READSTART+0x02]  ; 高位 8 位
mov al, [SECTORNUM]  ; 读取扇区数

push ax  ; ax 入栈，给后面使用

; 初始化目标内存地址
mov ax, [DESTMEM]  ; 低位 8 位
mov dx, [DESTMEM+0x02]  ; 高位 8 位
mov bx, 16
div bx

; 初始化内存读取地址
mov ds, ax
xor di, di
pop ax

call ReadHDD
xor si, si
call PringString
jmp End

ReadHDD:
  push ax
  push bx
  push cx
  push dx

  ; 传递读取扇区数
  mov dx, HDDPORT+2  ; 端口号 0x1f2
  out dx, al

  ; 传递读取扇区起始地址
  mov dx, HDDPORT+3
  mov ax, si
  out dx, al

  mov dx, HDDPORT+4
  mov al, ah
  out dx, al

  mov dx, HDDPORT+5
  mov ax, cx
  out dx, al

  mov dx, HDDPORT+6
  mov al, ah
  mov ah, 0xe0
  or al, ah
  out dx, al

  ; 传递读硬盘信号
  mov dx, HDDPORT+7
  mov al, 0x20
  out dx, al

  ; 判断硬盘是否准备好
  .waits:
  in al, dx
  and al, 0x88
  cmp al, 0x08
  jnz .waits

  mov dx, HDDPORT
  mov cx, 256

  ; 读取硬盘数据，每次 2 字节
  .readword:
  in ax, dx
  mov [ds:di], ax
  add di, 2
  or ah, 0x00
  jnz .readword

  .return:
  pop dx
  pop cx
  pop bx
  pop ax
  ret

PringString:
  .setup:
  push ax
  push bx
  push cx
  push dx

  mov ax, VIDEOMEM
  mov es, ax
  xor di, di
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
  pop dx
  pop cx
  pop bx
  pop ax
  ret


READSTART dd 10  ; 读取的起始扇区号
SECTORNUM db 1  ; 读取扇区数
DESTMEM dd 0x10000  ; 数据保存到内存中的位置


End: jmp End
times 510-($-$$) db 0
db 0x55, 0xaa


times 512*9 db 0  ; 补充 9 个扇区的 0

Data db 'Hi, I come from hard disk drive!'
     db 0x00
times 512*11-($-$$) db 0
