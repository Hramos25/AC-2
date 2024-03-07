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
        ori $t1, $t1, 0x0001
        sw $t1, TRISB($t0)      # configurar RB0 como input

        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFFFA
        sw $t1, TRISE($t0)      # configurar RE0 como output

while:  lw $t1, PORTB($t0)
        andi $t1, $t1, 0x0001   # Ler valor de RB0
        xori $t1, $t1, 0x0001   # Nega bit 0
        lw $t2, LATE($t0)
        andi $t2, $t2, 0xFFFA
        or $t2, $t2, $t1
        sll $t1, $t1, 2
        or $t2, $t2, $t1
        sw $t2, LATE($t0)       # Escrever valor em RE0

        j while

        jr $ra
        