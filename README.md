## asm

```
// compile
nasm -f bin -o start.bin start.asm

// run in virtualbox
VBoxManage convertfromraw --format VHD --variant Fixed start.bin start.vhd

// debug in bochs
bochs -qf /dev/null 'ata0-master: type=disk, path="start.vhd", mode=flat, cylinders=1, heads=1, spt=1' 'boot: disk'
```

### bochs 使用

1. 打断点 - `breakpoint`

  `b 0x7c00`

2. 执行到下一个断点处 - `continue`

  `c`

3. 单步调试 - `step`

  `s`

3. 向前执行 N 步 - `step N`

  `s 200`

4. 查看通用寄存器 - `register`

  `r`

5. 查看段寄存器 - `segment register`

  `sreg`

6. 查看物理内存 `xp /nuf addr`

  n = 查看多少个单位

  u = 单位（b - 字节，h - 2字节，w - 4字节， g - 8字节）

  f = 格式 (x - 十六进制，d - 十进制，u - 无符号十进制，o - 八进制，t - 二进制)

  addr = 地址

  `xp /1bx 0x7c0f1`

### 操作符

1. mov

  `mov reg/mem reg/mem/imm`

2. add

  `add reg/mem reg/mem/imm` 进位保存在 eflags（标志寄存器） 的 CF 位上，CF 为 1 则表示发生进位

3. sub

  `sub reg/mem reg/mem/imm` 借位保存在 eflags（标志寄存器） 的 CF 位上，CF 为 1 则表示发生借位

4. loop

  loop 在每次执行完循环体后，自动将 cx 减一，如果值为 0，则循环结束

  ```
  label:
    add dx, ax
    loop label
  ```

5. inc 自增

  `inc reg/mem` 不会影响 CF 标志位

6. dec 自减

  `dec reg/mem` 不会影响 CF 标志位

7. adc 带进位加法（add with carry）

  `adc reg/mem reg/mem/imm`

8. sbb 带借位减法（subtraction with borrow）

  `sbb reg/mem reg/mem/imm`
