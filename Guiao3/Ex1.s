        .data
        .equ ADDR_BASE_HI, 0xBF88
        .equ TRISE, 0x6100
        .equ LATE, 0x6120
        .equ TRISB, 0x6040
        .equ PORTB, 0x6050


        .text
        .globl main


main:   lui $t0, ADDR_BASE_HI

        lw $t1, TRISB($t0)
        ori $t1, $t1, 0x0002
        sw $t1, TRISB($t0)      # configurar RB0 como input

        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFFFA
        sw $t1, TRISE($t0)      # configurar RE0 como output

while:  lw $t1, PORTB($t0)
        andi $t1, $t1, 0x0002
        lw $t2, LATE($t0)
        andi $t2, $t2, 0xFFFA
        srl $t1, $t1, 1 
        or $t2, $t2, $t1
        sll $t1, $t1, 2
        or $t3, $t2, $t1
        sw $t3, LATE($t0)

        j while

        jr $ra
        