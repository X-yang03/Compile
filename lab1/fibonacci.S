.arch armv7-a

.data
    .comm input, 4
    .comm output,4

.section .rodata
.align 2

_str0:
    .ascii "%d\0"
    .align 2

_str1:
    .ascii "%d\n"
    .align 2

.section .text
.global main


main:
    push {fp, lr}
    add fp, sp, #4

    @cin>>n
    ldr r1, _bridge @r1 = &input
    ldr r0, _bridge+8 @_str0
    bl __isoc99_scanf

    ldr r5, _bridge 
    ldr r5, [r5]@r5 = n

    mov r2, #0  @ a = 0
    mov r3, #1  @ b = 1
    mov r4, #1  @ i = 1

    @print a b 
    mov r1,r2
    ldr r0,_bridge+12
    bl printf

    mov r1,r3
    ldr r0,_bridge+12
    bl printf

loop:
    cmp r4,r5
    beq loop_end
    mov r6,r3 @t=b
    add r3,r3,r2 @b=a+b

    @print b
    mov r1,r3
    ldr r0,_bridge+12
    bl printf

    mov r2,r6 @a=t
    add r4,r4,#1 @i=i+1
    b loop

loop_end:
    mov r0, #0
    pop {fp, pc}



_bridge:
    .word input
    .word output
    .word _str0
    .word _str1