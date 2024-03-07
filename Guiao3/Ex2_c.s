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
        lw $t1, PORTB($t0)
        andi $t1, $t1, 0x0008
        sw $t1, PORTB($t0)

        move $t9, $t1
        
        lw $t1, LATE($t0)       # Read LATE register
        andi $t1, $t1, 0xFFE1   # Reset bits 4-1
        sll $t3, $t2, 1         # Shift counter value to "position" 1
        or $t1, $t1, $t3        # Merge counter w/ LATE value
        sw $t1, LATE($t0)       # Update LATE register

        li  $a0, 100
        jal delay

countSum:    
        bne $t9, 0, countMinus


        addi $t2, $t2, 1
        blt $t2, 16, resetS
        li $t2, 0
resetS:  
        j while

countMinus:

        addi $t2, $t2, -1
        bge $t2, 0, resetM
        li $t2, 15

resetM:
        j while


delay:  li $v0, ResetC
        syscall

whileD: li $v0, ReadC
        syscall

        li $t8, 200000
        mul $t8, $t8, $a0

        bge $v0, $t8, endwD

        j whileD

endwD: jr $ra


