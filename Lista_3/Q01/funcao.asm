section .data
    fmt32 db "%f",0    ;6 casa
    fmt64 db "%.15f",0    ;15 casas

section .text
    extern printf
    global  print_real

print_real:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]    ;valor
    mov ecx, [ebp+12]   ; bits 32 ou 64

    cmp ecx, 32
    je .L32
    cmp ecx, 64
    je .L64

.L32:
    fld dword [eax]
    jmp .armazenar

.L64:
    fld qword [eax]

.armazenar:
    sub     esp, 8
    fstp    qword [esp]
    cmp     ecx, 32
    je      .Lf32_fmt
    push    dword fmt64
    jmp     .Lcall

.Lf32_fmt:
    push    dword fmt32

.Lcall:
    call    printf
    add     esp, 12

    mov esp, ebp
    pop ebp
    ret