        .data
        .equ BASE, 0xBF88    # Endereço base do periférico
        .equ TRISE, 0x6100   # Endereço do registrador TRISE
        .equ TRISB, 0x6040   # Endereço do registrador TRISB
        .equ PORTB, 0x6050   # Endereço do registrador PORTB
        .equ LATE, 0x6120    # Endereço do registrador LATE
        .equ ResetC, 12      # Chamada do sistema para resetar o contador
        .equ ReadC, 11       # Chamada do sistema para ler o contador

        .text
        .globl main

main:   
        lui $t0, BASE         # Carrega o endereço base na parte alta do registrador $t0

        lw $t1, TRISE($t0)   # Carrega o valor do registrador TRISE para $t1
        andi $t1, $t1, 0xFFE1 # Limpa bits específicos em $t1
        sw $t1, TRISE($t0)   # Armazena o valor atualizado de $t1 de volta em TRISE

        li $t2, 15            # Inicializa o contador em 15 (contagem decrescente)

while: 
        lw $t1, LATE($t0)    # Carrega o valor do registrador LATE para $t1
        andi $t1, $t1, 0xFFE1 # Limpa bits específicos em $t1
        sll $t3, $t2, 1      # Desloca $t2 para a esquerda em uma posição (multiplica por 2)
        or $t1, $t1, $t3     # Atualiza os bits de interesse em $t1
        sw $t1, LATE($t0)    # Armazena o valor atualizado de $t1 de volta em LATE

        li $v0, ResetC       # Chamada do sistema para resetar o contador
        syscall

wait:   
        li $v0, ReadC        # Chamada do sistema para ler o contador
        syscall
        blt $v0, 20000000, wait # Aguarda até que o valor do contador seja menor que 20000000

        addi $t2, $t2, -1    # Decrementa o contador
W:      bge $t2, 0, cont     # Verifica se o contador é maior ou igual a zero, se sim, volta para o loop while
        li $t2, 15           # Reinicia o contador para 15 se chegou a zero
cont:
        j while               # Retorna ao início do loop while
        jr $ra