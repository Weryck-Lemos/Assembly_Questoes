section .data
    numero dd 123456784
    buffer times 11 db 0

section .text
    global _start

_start:
    mov eax, [numero]
    mov edi, buffer+10
    mov ecx, 10

converter_digitos:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl

    cmp eax, 0
    jnz converter_digitos

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80