        .data
        .equ getChar, 2
        .equ putChar, 3
        .equ print_int, 6

        .text
        .globl main

# Mapa de Registos
# c -> $t0
# cnt -> $t1

main:   li $t1, 0           # cnt = 0

do:     li $v0, getChar     # getChar()
        syscall
        
        move $t0, $v0       # c = getChar

        move $a0, $t0
        li $v0, putChar     # putChar(c)
        syscall     

        addi $t1, $t1, 1    # cnt++

while:   bne $t0, '\n', do   # while(c != '\n')

        move $a0, $t1
        li $a1, 10
        li $v0, print_int   # print_int(cnt, 10)
        syscall         

        li $v0, 0
        jr $ra
