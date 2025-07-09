;mesmo código de Q05
section .data
    msg1 db "digite o primeiro número: ", 0
    msg2 db "digite o segundo número: ", 0
    msg3 db "digite o terceiro número: ", 0

    num1 dd 0
    num2 dd 0
    num3 dd 0
    
    read db "%d",0
    fmt db "Soma dos dois moiores: %d", 0xA, 0

section .text
    global main
    extern printf
    extern scanf

main:    
    push dword num1
    push dword read
    call scanf
    add esp,8


    push dword num2
    push dword read
    call scanf
    add esp,8


    push dword num3
    push dword read
    call scanf
    add esp,8

    mov eax, [num1]
    mov ebx, [num2]
    mov ecx, [num3]

    mov edx, eax
    cmp ebx, edx
    cmovl edx, ebx
    cmp ecx, edx
    cmovl edx, ecx
    
    add eax, [num2]
    add eax, [num3]
    sub eax, edx

    push eax
    push dword fmt
    call printf
    add esp, 8

    xor eax, eax
    ret