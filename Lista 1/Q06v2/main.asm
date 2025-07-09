section .data
    
    num1 dd 0
    num2 dd 0
    num3 dd 0
    fmt db "Soma dos dois moiores: %d", 0xA, 0

section .text
    global main
    extern printf
    extern atoi

main:
    mov ebx, [esp+8] ;argv

    push dword [ebx+4]
    call atoi
    add esp,4
    mov [num1], eax

    push dword [ebx+8]
    call atoi
    add esp,4
    mov [num2], eax

    push dword [ebx+12]
    call atoi
    add esp,4
    mov [num3], eax

    
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