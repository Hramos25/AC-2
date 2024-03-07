        .data

        .equ putChar, 3
        .equ printInt, 6
        .equ resetC, 12
        .equ readC, 11

        .text

        .globl main

main:   addiu $sp, $sp, -8
        sw $ra, 0($sp)
        sw $s0, 4($sp)

        li $s0, 0
        
while: 
        li $a0, '\r'
        li $v0, putChar
        syscall

        move $a0, $s0
        li $a1, 0x0004000A
        li $v0, printInt
        syscall

while1: 
        move $t3, $v0

        li $a0, 10
        jal delay
    
       bge $t3, $t9, endw

        j while1
        

endw:   addi $s0, $s0, 1
        j while

        lw $s0, 4($sp)
        lw $ra, 0($sp)
        addiu $sp, $sp, 8

        jr $ra




delay:  li $v0, resetC
        syscall

whileD: li $v0, readC
        syscall

        li $t8, 200000
        mul $t8, $t8, $a0

        bge $v0, $t8, endwD

        j whileD

endwD: jr $ra