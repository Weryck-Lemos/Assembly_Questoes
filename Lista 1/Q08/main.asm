section .data
    matA dd 1,-2,0    ;a:0   b:4   c:8 
         dd -3,4,5   ;d:12  e:16  f:20
         dd 6,0,-1    ;g:24  h:28  i:32

    matB dd 2,3,-1    ;j:0   k:4   l:8 
         dd 0,-2,4    ;m:12  n:16  o:20
         dd 5,-1,0    ;p:24  q:28  r:32

    fmt db "%d %d %d", 0xA,0
    num1 dd 0
    num2 dd 0
    num3 dd 0

section .text
    global main
    extern printf

main:
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
    xor ecx, ecx


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
    xor ecx, ecx


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
    xor ecx, ecx

    call .printar




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
    xor ecx, ecx
    

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
    xor ecx, ecx


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
    xor ecx, ecx

    call .printar




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
    xor ecx, ecx
    

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
    xor ecx, ecx


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
    xor ecx, ecx
    call .printar


    ret

.printar:
    push dword [num3]
    push dword [num2]
    push dword [num1]
    push fmt
    call printf
    add esp, 16
    ret