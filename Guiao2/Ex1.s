        .data

        .equ putChar, 3
        .equ printInt, 6
        .equ resetC, 12
        .equ readC, 11

        .text

        .globl main

main:   li $t0, 0
while:
        li $a0, '\r'
        li $v0, putChar
        syscall

        move $a0, $t0
        li $a1, 0x0004000A
        li $v0, printInt
        syscall

        li $v0, resetC
        syscall

while1: li $v0, readC
        syscall

        move $t3, $v0

        li $t9, 1000000
    
       bge $t3, $t9, endw

        j while1
        

endw:   addi $t0, $t0, 1
        j while
        jr $ra