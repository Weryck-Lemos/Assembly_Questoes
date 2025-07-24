section .data
    fmt_scan db "%lf %lf %lf %lf %lf %lf %lf",0
    fmt_out db "resultado: %lf", 0xA, 0

section .bss
    a resq 1
    b resq 1
    c resq 1
    d resq 1
    e resq 1
    f resq 1
    x resq 1

section .text
    global main
    extern printf
    extern scanf

main:
    lea eax, [x]
    push eax
    lea eax, [f]
    push eax
    lea eax, [e]
    push eax
    lea eax, [d]
    push eax
    lea eax, [c]
    push eax
    lea eax, [b]
    push eax
    lea eax, [a]
    push eax
    push dword fmt_scan
    call scanf
    add esp, 32

;(((((ax + b)* x+c)* x+d)* x+e)* x+f)
    fld qword [a]
    fld qword [x]
    fmul
    fadd qword [b]

    fld qword[x]
    fmul 
    fadd qword[c]

    fld qword [x]
    fmul
    fadd qword [d]

    fld qword [x]
    fmul
    fadd qword [e]

    fld qword [x]
    fmul
    fadd qword[f]

    sub esp, 8
    fstp qword [esp]
    push dword fmt_out
    call printf
    add esp, 12

    xor eax, eax
    ret