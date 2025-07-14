section .data
    matA dd 1,2,0    ;a:0   b:4   c:8 
         dd 3,4,5   ;d:12  e:16  f:20
         dd 6,0,1    ;g:24  h:28  i:32

    matB dd 2,3,1    ;j:0   k:4   l:8 
         dd 0,2,4    ;m:12  n:16  o:20
         dd 5,1,0    ;p:24  q:28  r:32

    num1 dd 0
    num2 dd 0
    num3 dd 0
    space db ' '
    newline db 0xA

section .bss
    buffer resb 12

section .text
    global main

main:
;linha 1

    ;a*j + b*m  + c*p 
    mov ebx, [matA]
    imul ebx, [matB]
    mov ecx, ebx
    mov eax, [matA+4]
    imul eax, [matB+12]
    add ecx, eax
    mov eax, [matA+8]
    imul eax, [matB+24]
    add ecx, eax
    mov [num1], ecx


    ;a*k + b*n + c*q
    mov ebx, [matA]
    imul ebx, [matB+4]
    mov ecx, ebx
    mov eax, [matA+4]
    imul eax, [matB+16]
    add ecx, eax
    mov eax, [matA+8]
    imul eax, [matB+28]
    add ecx, eax
    mov [num2], ecx



    ;a*l + b*o + c*r
    mov ebx, [matA]
    imul ebx, [matB+8]
    mov ecx, ebx
    mov eax, [matA+4]
    imul eax, [matB+20]
    add ecx, eax
    mov eax, [matA+8]
    imul eax, [matB+32]
    add ecx, eax
    mov [num3], ecx

    call .print_row




;linha 2
    ;d*j + e*m + f*p
    mov ebx, [matA+12]
    imul ebx, [matB]
    mov ecx, ebx
    mov eax, [matA+16]
    imul eax, [matB+12]
    add ecx, eax
    mov eax, [matA+20]
    imul eax, [matB+24]
    add ecx, eax
    mov [num1], ecx
    

    ;d*k + e*n + f*q
    mov ebx, [matA+12]
    imul ebx, [matB+4]
    mov ecx, ebx
    mov eax, [matA+16]
    imul eax, [matB+16]
    add ecx, eax
    mov eax, [matA+20]
    imul eax, [matB+28]
    add ecx, eax
    mov [num2], ecx


    ;d*l + e*o + f*r
    mov ebx, [matA+12]
    imul ebx, [matB+8]
    mov ecx, ebx
    mov eax, [matA+16]
    imul eax, [matB+20]
    add ecx, eax
    mov eax, [matA+20]
    imul eax, [matB+32]
    add ecx, eax
    mov [num3], ecx

    call .print_row




;linha 3
    ;g*j + h*m + i*p
    mov ebx, [matA+24]
    imul ebx, [matB]
    mov ecx, ebx
    mov eax, [matA+28]
    imul eax, [matB+12]
    add ecx, eax
    mov eax, [matA+32]
    imul eax, [matB+24]
    add ecx, eax
    mov [num1], ecx
    

    ;g*k + h*n + i*q
    mov ebx, [matA+24]
    imul ebx, [matB+4]
    mov ecx, ebx
    mov eax, [matA+28]
    imul eax, [matB+16]
    add ecx, eax
    mov eax, [matA+32]
    imul eax, [matB+28]
    add ecx, eax
    mov [num2], ecx


    ;g*l + h*o +i*r
    mov ebx, [matA+24]
    imul ebx, [matB+8]
    mov ecx, ebx
    mov eax, [matA+28]
    imul eax, [matB+20]
    add ecx, eax
    mov eax, [matA+32]
    imul eax, [matB+32]
    add ecx, eax
    mov [num3], ecx

    call .print_row

    ret

.print_row:
    mov eax, [num1]
    call print_int

    mov eax, 4
    mov ebx, 1
    lea ecx, [space]
    mov edx, 1
    int 0x80

    

    mov eax, [num2]
    call print_int

    mov     eax, 4
    mov     ebx, 1
    lea     ecx, [space]
    mov     edx, 1
    int     0x80



    mov     eax, [num3]
    call    print_int

    mov     eax, 4
    mov     ebx, 1
    lea     ecx, [newline]
    mov     edx, 1
    int     0x80

    ret

print_int:
    mov     ecx, 10
    lea     edi, [buffer+12]

.convert_loop:
    xor     edx, edx
    div     ecx
    add     dl, '0'
    dec     edi
    mov     [edi], dl
    test    eax, eax
    jnz     .convert_loop

    mov     edx, buffer+12
    sub     edx, edi
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, edi
    int     0x80

    ret
