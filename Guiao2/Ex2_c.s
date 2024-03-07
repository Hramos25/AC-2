        .data

        .equ inkey, 1
        .equ resetC, 12
        .equ readC, 11
        .equ printInt, 6
        .equ putChar, 3 

        .text
        .globl main

# Mapa de Registos
# cnt1 -> $t0 
# cnt5 -> $t1 
# cnt10 -> $t2

main:   addiu $sp, $sp, -16
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        li $s0, 0
        li $s1, 0
        li $s2, 0

while:  li  $a0, 100
        jal delay

        addi $s2, $s2, 1    # cnt10 += 1

        rem $t3, $s2, 2     # cnt10 % 2
        rem $t4, $s2, 10    # cnt10 % 10

if:     bne $t3, 0, elseif

        addi $s1, $s1, 1    # cnt5 += 1
elseif:
if2:    bne $t4, 0, endif

        addi $s0, $s0, 1    # cnt1 += 1

endif:  move $a0, $s0
        li $a1, 5
        sll $a1, $a1, 16
        ori $a1, $a1, 10
        li $v0, printInt
        syscall

        li $a0, '\t'
        li $v0, putChar
        syscall

        move $a0, $s1
        li $a1, 5
        sll $a1, $a1, 16
        ori $a1, $a1, 10
        li $v0, printInt
        syscall

        li $a0, '\t'
        li $v0, putChar
        syscall

        move $a0, $s2
        li $a1, 5
        sll $a1, $a1, 16
        ori $a1, $a1, 10
        li $v0, printInt
        syscall

        li $a0, '\r'
        li $v0, putChar
        syscall

endw:   jr $ra



delay:  li $v0, resetC
        syscall

whileD: li $v0, readC
        syscall

        li $t8, 200000
        mul $t8, $t8, $a0

        bge $v0, $t8, endwD

        j whileD

endwD: jr $ra
