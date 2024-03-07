        .data
        .equ BASE, 0xBF88
        .equ TRISE, 0x6100
        .equ TRISB, 0x6040
        .equ PORTB, 0x6050
        .equ LATE, 0x6120
        .equ ResetC, 12
        .equ ReadC, 11


        .text
        .globl main

main:   lui $t0, BASE

        lw $t1, TRISE($t0)      # $t0 must be previously initialized
        andi $t1, $t1, 0xFFE1   # Reset bits 4-1
        sw $t1, TRISE($t0)      # Update TRISE register
        
        lw $t1, TRISB($t0)      # Read TRISB register
        ori $t1, $t1, 0x000E    # set bits 3-1
        sw $t1, TRISB($t0)      # Update TRISTB register

        li $t2, 0               # e.g. up counter (initial value is 0)

while:  
        lw $t1, LATE($t0)       # Read LATE register
        andi $t1, $t1, 0xFFE1   # Reset bits 4-1
        sll $t3, $t2, 1         # Shift counter value to "position" 1
        or $t1, $t1, $t3        # Merge counter w/ LATE value
        sw $t1, LATE($t0)       # Update LATE register

        li $v0, ResetC
        syscall

wait:   li $v0, ReadC
        syscall
        blt $v0, 20000000, wait

        addi $t2, $t2, 1
        blt $t2, 16, cont
        li $t2, 0

cont:
        j while
        jr $ra