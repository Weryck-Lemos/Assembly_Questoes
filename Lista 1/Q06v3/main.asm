section .data
    filename db  "entrada.txt", 0
    newline db  10
    num1 dd  0
    num2 dd  0
    num3 dd  0

section .bss
    buffer resb 64  
buffer_end equ buffer + 64

section .text
    global  main
    extern  atoi

main:
    mov     eax, 5 
    mov     ebx, filename
    xor     ecx, ecx 
    xor     edx, edx 
    int     0x80
    mov     ebp, eax 

    mov     eax, 3  
    mov     ebx, ebp
    mov     ecx, buffer
    mov     edx, 64
    int     0x80

    mov     eax, 6   
    mov     ebx, ebp
    int     0x80

 
    lea     esi, [buffer]  
    push    esi
    call    atoi
    add     esp, 4
    mov     [num1], eax

.skip1:
    mov     al, [esi]
    cmp     al, 10    
    je      .after1
    inc     esi
    jmp     .skip1
.after1:
    inc     esi 

    push    esi
    call    atoi
    add     esp, 4
    mov     [num2], eax

.skip2:
    mov     al, [esi]
    cmp     al, 10
    je      .after2
    inc     esi
    jmp     .skip2
.after2:
    inc     esi              

    push    esi
    call    atoi
    add     esp, 4
    mov     [num3], eax

    mov     eax, [num1]
    mov     ebx, [num2]
    mov     ecx, [num3]

    mov     edx, eax          
    cmp     ebx, edx
    cmovl   edx, ebx
    cmp     ecx, edx
    cmovl   edx, ecx

    mov     eax, [num1]
    add     eax, [num2]
    add     eax, [num3]
    sub     eax, edx      


    mov     edi, buffer_end   
    call    print_int

    xor     eax, eax   
    ret

print_int:
    mov     ebx, 10
    cmp     eax, 0
    jge     .PIP_POS
    push    eax
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, newline
    mov     edx, 1
    int     0x80
    pop     eax
    neg     eax
.PIP_POS:
    xor     edx, edx
.loop:
    xor     edx, edx
    div     ebx
    add     dl, '0'
    dec     edi
    mov     [edi], dl
    cmp     eax, 0
    jne     .loop

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
