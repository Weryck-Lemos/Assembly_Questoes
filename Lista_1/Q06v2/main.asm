section .data
    num1       dd 0
    num2       dd 0
    num3       dd 0
    newline    db  10
    sign       db  '-'

section .bss
    buffer resb 12
    buffer_end equ buffer + 12

section .text
    global  main
    extern  atoi

main:
    mov ebx, [esp + 8]

    push dword [ebx + 4]
    call atoi
    add esp, 4
    mov [num1], eax

    push dword [ebx + 8]
    call atoi
    add esp, 4
    mov [num2], eax

    push dword [ebx + 12]
    call atoi
    add esp, 4
    mov [num3], eax

    mov eax, [num1]
    mov ebx, [num2]
    mov ecx, [num3]
    mov edx, eax
    cmp ebx, edx
    cmovl edx, ebx
    cmp ecx, edx
    cmovl edx, ecx

    mov eax, [num1]
    add eax, [num2]
    add eax, [num3]
    sub eax, edx

    mov     edi, buffer_end
    call    print_int

    xor     eax, eax
    ret


print_int:
    mov ebx, 10
    cmp eax, 0
    jge .PI_POS
    push eax  
    mov eax, 4
    mov ecx, sign
    mov edx, 1
    mov ebx, 1
    int 0x80
    pop  eax 
    neg  eax

.PI_POS:
    xor     edx, edx   
.conv_loop:
    xor     edx, edx
    div     ebx  
    add     dl, '0'
    dec     edi
    mov     [edi], dl
    cmp     eax, 0
    jne     .conv_loop

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, edi
    lea     edx, [buffer_end]
    sub     edx, ecx
    int     0x80

    mov     eax, 4
    mov     ebx, 1
    mov     ecx, newline
    mov     edx, 1
    int     0x80

    ret
