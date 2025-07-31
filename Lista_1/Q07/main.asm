section .data
    mat dd 4,5,-3   ;a:0   b:4   c:8 
        dd 2,1,0    ;d:12  e:16  f:20
        dd 3,-1,1   ;g:24  h:28  i:32
    newline db 0xA

    fmt db "Determinante: %d", 10, 0

section .bss
    buffer resb 12

section .text
    global main

main:

    ;a*e*i
    mov eax, [mat]     ;a
    mov ebx,[mat+16]   ;e
    imul ebx, [mat+32] ;e*i
    imul eax, ebx      ;a * e * i
    mov ecx, eax


    ; - c*e*g
    mov eax, [mat+8]   ;c
    mov ebx, [mat+16]  ;e
    imul ebx, [mat+24] ;e * g
    imul eax, ebx      ;c * e * g
    sub ecx, eax


    ;b*f*g 
    mov eax, [mat+4]
    mov ebx, [mat+20]
    imul ebx, [mat+24]
    imul eax, ebx
    add ecx, eax


    ; - a*f*h
    mov eax, [mat] 
    mov ebx, [mat+20]
    imul ebx, [mat+28]
    imul eax, ebx
    sub ecx, eax


    ;c*d*h 
    mov eax, [mat+8]
    mov ebx, [mat+12]
    imul ebx, [mat+28]
    imul eax, ebx
    add ecx, eax


    ; - b*d*i
    mov eax, [mat+4]
    mov ebx, [mat+12]
    imul ebx, [mat+32]
    imul eax, ebx
    sub ecx, eax


    mov eax, ecx
    mov ecx, 10
    lea   edi, [buffer + 12]
    call converter_digitos

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    xor eax, eax
    ret

converter_digitos:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl

    cmp eax, 0
    jnz converter_digitos

    mov edx, buffer + 12
    sub edx, edi
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80

    ret