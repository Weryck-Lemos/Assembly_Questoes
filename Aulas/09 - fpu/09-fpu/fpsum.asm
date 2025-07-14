;nasm -f elf64 fpsum.asm -o fpsum.o
;gcc -no-pie fpsum.o -o fpsum -lm
;./fpsum

section .data
    a       dd 1.5
    b       dd 2.0
    c       dd 6.0
    result  dd 0.0          ; 

    format  db "Resultado: %x", 10, 0
    
section .text
    extern printf
    global main

main:
    finit
    fld dword [a]               ; ST(0) = 1.5
    fld dword [b]               ; ST(0) = 2.0, ST(1) = 1.5, 
    fld dword [c]               ; ST(0) = 6.0, ST(1) = 2,0, ST(2) = 1.5 
    ;fadd dword [b]             ; ST(0) += 1.0
    fadd st0, st2
    
    fstp dword [result]         ; salva como double (64 bits)


    % imprime o valor hexadecimal com printf
    mov    rdi, format
    mov    rsi, [result]    
    mov    rax, 0         
    call    printf

    xor     eax, eax
    ret


