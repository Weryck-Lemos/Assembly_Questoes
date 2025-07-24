section .data
    mat dd 4.0, 5.0, -3.0   ;a:0   b:4   c:8 
        dd 2.0, 1.0,  0.0   ;d:12  e:16  f:20
        dd 3.0, -1.0, 1.0   ;g:24  h:28  i:32
    newline db 0xA

    fmt db "Determinante: %f", 0xA, 0

section .bss
    term1   resd 1
    term2   resd 1
    term3   resd 1
    term4   resd 1
    term5   resd 1
    term6   resd 1
    det     resd 1

section .text
    global main
    extern printf

main:
    ;a*e*i
    fld dword [mat]      ;st0 = a
    fld dword [mat+16]   ;st0= e, st1 = a
    fmul                 ;st0 = e*a
    fld dword [mat+32]   ;st0 = i,  st1 = e*a
    fmul                 ;st0 = i*e*a
    fstp dword [term1]   ;term1 = st0


    ; - c*e*g
    fld dword [mat+8]   ;c
    fld dword [mat+16]  ;e
    fmul                ;e *c
    fld dword [mat+24]  ;g
    fmul                ;c * e * g
    fstp dword [term2]


    ;b*f*g 
    fld dword [mat+4]
    fld dword [mat+20]
    fmul
    fld dword [mat+24]
    fmul
    fstp dword [term3]


    ; - a*f*h
    fld dword [mat] 
    fld  dword [mat+20]
    fmul
    fld dword [mat+28]
    fmul
    fstp dword [term4]


    ;c*d*h 
    fld dword [mat+8]
    fld dword [mat+12]
    fmul
    fld dword [mat+28]
    fmul
    fstp dword [term5]


    ; - b*d*i
    fld dword [mat+4]
    fld dword [mat+12]
    fmul
    fld dword [mat+32]
    fmul
    fstp dword [term6]


    fld dword [term1]
    fsub dword [term2]
    fadd dword [term3]
    fsub dword [term4]
    fadd dword [term5]
    fsub dword [term6]
    fstp dword [det]

    fld dword [det]
    sub esp, 8
    fstp qword [esp]
    push dword fmt
    call printf
    add esp, 12

    xor eax, eax
    ret