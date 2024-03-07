        .data
        
        .equ print_str, 8

str:    .asciiz "Ac2 - Aulas praticas\n"

        .text
        .globl main

main:   la $a0, str
        li $v0, print_str   # print_string(str)
        syscall

        li $v0, 0           # return 0
        jr $ra      