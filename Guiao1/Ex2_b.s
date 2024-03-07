    .data
        .equ inkey, 1
        .equ putChar, 3
        .equ print_int, 6

    .text
    .globl main

# Mapa de Registos
# c -> $t0
# cnt -> $t1

main:   li $t1, 0           # cnt = 0

do:     li $v0, inkey
        syscall

        move $a0, $v0
        move $t0, $a0

if:     beq $t0, 0, else

        move $a0, $t0
        li $v0, putChar
        syscall

        j endif

else:   li $a0, '.'
        li $v0, putChar
        syscall

endif:  addi $t1, $t1, 1       # cnt ++

while:  bne $t0, '\n', do

        move $a0, $t1
        li $a1, 10
        li $v0, print_int
        syscall

        li $v0, 0
        jr $ra