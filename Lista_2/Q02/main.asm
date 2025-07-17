section .data
    msgEntrada db "Digite a data: ", 0
    read db "%[^\n]", 0
    msgOk db "Epoch: %ld", 10, 0
    msgErro db "String inválida", 10, 0

section .bss
    entrada resb 64

section .text
    global main
    extern printf, scanf, convert_to_epoch

main:
    push msgEntrada
    call printf
    add esp, 4

    push entrada
    push read
    call scanf
    add esp, 8

    push entrada
    call convert_to_epoch
    add esp, 4

    cmp eax, -1
    je .erro

    
    push eax
    push msgOk
    call printf
    add esp, 8
    jmp .fim

.erro:
    push msgErro
    call printf
    add esp, 4

.fim:
    ret
