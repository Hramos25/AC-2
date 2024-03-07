        .data
        .equ ADDR_BASE_HI, 0xBF88
        .equ TRISE, 0x6100
        .equ LATE, 0x6120
        .equ TRISD, 0x60C0
        .equ PORTD, 0x60D0


        .text
        .globl main


main:   lui $t0, ADDR_BASE_HI

        lw $t1, TRISD($t0)
        ori $t1, $t1, 0x0100
        sw $t1, TRISD($t0)      # configurar RD8 como input

        lw $t1, TRISE($t0)
        andi $t1, $t1, 0xFFFA
        sw $t1, TRISE($t0)      # configurar RE0 como output

while:  lw $t1, PORTD($t0)
        andi $t1, $t1, 0x0100   # Ler valor de RD8
        xori $t1, $t1, 0x0100   # Nega bit 8
        
        srl $t1, $t1, 8         # Como estou a escrever num bit superior, tenho de fazer um deslocamento para um bit inferior
        lw $t2, LATE($t0)
        andi $t3, $t2, 0xFFFA

        or $t3, $t3, $t1

        sll $t1, $t1, 2
        andi $t2, $t2, 0xFFFA
        or $t4, $t2, $t1


        or $t3, $t4, $t3
        sw $t3, LATE($t0)       # Escrever valor em RE0

        j while

        jr $ra
        