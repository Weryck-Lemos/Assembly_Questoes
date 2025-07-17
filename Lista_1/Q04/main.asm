section .data
    num1 dd 10
    num2 dd 20
    num3 dd 15
    newline db 10
    buffer times 10 db 0

    fmt db "Soma dos dois moiores: %d", 0xA, 0

section .text
    global main

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

    mov ecx, 10
    mov edi, buffer + 10
    call converter_digitos

    xor eax, eax
    ret

converter_digitos:
    cmp eax, 0
    jne .convert

    dec edi
    mov byte [edi], '0'
    jmp .print

.convert:
    xor edx, edx
.loop_convert:
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    xor edx, edx
    cmp eax, 0
    jnz .loop_convert

.print:
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
