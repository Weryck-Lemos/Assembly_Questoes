section .data
    numero dd -1545
    buffer times 13 db 0

section .text
    global _start

_start
    mov eax, [numero]
    mov edi, buffer+12
    mov ecx, 10

    cmp eax,0
    jge positivo

    neg eax
    mov bl, 1  ;Bool True
    jmp converter_digitos

positivo:
    mov bl,0   ;bool False

converter_digitos:

    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    cmp eax, 0
    jnz converter_digitos

    cmp bl, 1
    jne imprimir
    dec edi
    mov byte [edi], '-'

imprimir:
    
    mov byte [buffer+12],10

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 13
    sub edx, ecx
    int 0x80

    mov eax,1
    xor ebx, ebx
    int 0x80