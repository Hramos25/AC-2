        .data

        .equ printStr, 8
        .equ printInt10, 7
        .equ printInt, 6
        .equ readInt10, 5

str1:   .asciiz "\nIntroduza um inteiro (sinal e módulo): "
str2:   .asciiz "\nValor em base 10 (signed): "
str3:   .asciiz "\nValor em base 2: "
str4:   .asciiz "\nValor em base 16: "
str5:   .asciiz "\nValor em base 10 (unsigned): "
str6:   .asciiz "\nValor em base 10 (unsigned), formatado: "

        .text
        
        .globl main

main:   la $a0, str1
        li $v0, printStr
        syscall

        li $v0, readInt10
        syscall
        move $t0, $v0

        la $a0, str2
        li $v0, printStr
        syscall

        move $a0, $t0
        li $v0, printInt10
        syscall

        la $a0, str3
        li $v0, printStr
        syscall

        move $a0, $t0
        li $a1, 2
        li $v0, printInt
        syscall

        la $a0, str4
        li $v0, printStr
        syscall

        move $a0, $t0
        li $a1, 16
        li $v0, printInt
        syscall

        la $a0, str5
        li $v0, printStr
        syscall

        move $a0, $t0
        li $a1, 10
        li $v0, printInt
        syscall

        la $a0, str6
        li $v0, printStr
        syscall

        li $t1, 10
        ori $t1, $t1, 5
        sll $t2, $t1, 8
        
        move $a0, $t0
        move $a1, $t2
        li $v0, printInt
        syscall

        jr $ra