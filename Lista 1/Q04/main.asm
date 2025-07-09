section .data
    num1 dd 10
    num2 dd 20
    num3 dd 15

    fmt db "Soma dos dois moiores: %d", 0xA, 0

section .text
    global main
    extern printf

main:
    mov eax, [num1]
    mov ebx, [num2]
    mov ecx, [num3]

;encontrar o menor
    mov edx, eax
    cmp ebx, edx
    cmovl edx, ebx
    cmp ecx, edx
    cmovl edx, ecx

    add eax, [num2]
    add eax, [num3]
    sub eax, edx

    push eax
    push fmt
    call printf
    add esp, 8

    xor eax, eax
    ret