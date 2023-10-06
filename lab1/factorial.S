.arch armv7-a

.data
    .comm input, 4
    .comm result, 4

.section .rodata
.align 2

_str0 :
    .ascii "%d\0"
    .align 2

_str1 :
    .ascii "factorial is: %d\n"
    .align 2

.section .text
.global factorial
factorial :
    @build stack
    str fp, [sp, #-4]!
    mov fp, sp
   
    sub sp, sp, #8
    str r1, [fp, #-8] @get input
    @see it 
    @ ldr r0, _bridge+12
    @ bl printf
    @test_output
    @ ldr r1, _bridge
    @ ldr r1, [r1]
    @ ldr r0, _bridge+12
    @ bl printf

    mov r2, #1 @ for factorial
    mov r3, #1          @ 初始化 r3 为 1（用于循环计数）
    cmp r1, #0          @ 如果 r1 == 0，则返回 1
    beq .L1
    b .L2

.L3 :
    mul r2, r2, r3     @ 计算阶乘：r2 = r2 * r3
    add r3, r3, #1     @ 增加计数器 r3

.L2 :
    cmp r3, r1          @ 比较计数器和输入值
    ble .L3             @ 如果计数器 <= 输入值，继续循环

.L1 :
    mov r0,r2;
    @kill stack
    add sp, fp, #0
    ldr fp, [sp], #4
    bx lr



.global main

main :
    push {fp, lr}
    add fp, sp, #4
    
    @input
    ldr r1, _bridge
    ldr r0, _bridge+8
    bl __isoc99_scanf

    @calculate
    ldr r1, _bridge
    ldr r1, [r1]
    mov r0, r1;
    bl factorial

    @test_output
    mov r1, r0
    ldr r0, _bridge+12
    bl printf

    @return
    mov r0, #0
    pop {fp, pc}


_bridge:
    .word input
    .word result
    .word _str0
    .word _str1
