section .data
    mat dd 2,-3,1   ;a:0   b:4   c:8 
        dd 2,0,-1   ;d:12  e:16  f:20
        dd 1,4,5   ;g:24  h:28  i:32

    fmt db "Determinante: %d", 0xA, 0

section .text
    global main
    extern printf

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


    push ecx
    push fmt
    call printf
    add esp,8

    xor eax, eax
    ret