    .data

    .equ ADDR_BASE_HI,0xBF88
    .equ TRISB,0x6040 # TRISB address: 0xBF886040
    .equ PORTB,0x6050 # PORTB address: 0xBF886050
    .equ LATB, 0x6060 # LATB address: 0xBF886060
    .equ TRISD,0x60C0 # TRISD address: 0xBF8860C0
    .equ PORTD,0x60D0 # PORTD address: 0xBF8860D0
    .equ LATD, 0x60E0 # LATD address: 0xBF8860E0
    .equ TRISE,0x6100 # TRISE address: 0xBF886100
    .equ PORTE,0x6110 # PORTE address: 0xBF886110
    .equ LATE, 0x6120 # LATE address: 0xBF886120
    
    .text
    .globl main

main: lui $t0,ADDR_BASE_HI # 16 MSbits of port addresses

    lw $t1,TRISE($t0) # Read TRISE register
    ori $t1,$t1,0x0001 # bit0 = 1 (IN)
    andi $t1,$t1,0xFFFD # bit1 = 0 (OUT)
    sw $t1,TRISE($t0) # TRISE configured

loop: lw $t1,PORTE($t0) # Read PORTE register

    andi $t1,$t1,0x0001 # Reset all bits except bit 0
    xori $t1,$t1,0x0001 # Negate bit 0
    sll $t1,$t1,1 #
    lw $t2,LATE($t0) # Read LATE register
    andi $t2,$t2,0xFFFD # Reset bit 1
    or $t2,$t2,$t1 # Merge data
    sw $t2,LATE($t0) # Write LATE register
    
    j loop

    jr $ra