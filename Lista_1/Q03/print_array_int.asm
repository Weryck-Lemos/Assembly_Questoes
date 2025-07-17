section .data
    buffer times 11 db 0
    newline db 0xA

section .text
    global print_array

print_array:
    mov esi, [esp+4]
    xor ebx, ebx ; iterador

.loop:
    cmp ebx, 10
    jge .fim

    mov eax, [esi + ebx*4]
    mov ecx, 10
    mov edi, buffer + 10

    push ebx
    call converter_digitos
    pop ebx

    inc ebx
    jmp .loop

.fim:
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
    div ecx    ;eax/10
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

ret