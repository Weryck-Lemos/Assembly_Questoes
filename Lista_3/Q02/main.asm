section .data
    fmt_in    db  "%f %f %f", 0
    fmt_sqrt  db  "Raiz quadrada do maior: %f", 0xA, 0
    fmt_round db  "Arredondamento do menor: %.0f", 0xA, 0
    fmt_hex   db  "Abs convertido (hex): 0x%X", 0xA, 0

section .bss
    num1 resd 1
    num2 resd 1
    num3 resd 1
    maxf resd 1
    minf resd 1

section .text
    global main
    extern scanf
    extern printf

main:
    push num3
    push num2
    push num1
    push dword fmt_in
    call scanf
    add esp, 16


;maior
    fld dword [num1]          ; st0 = num1
    fld dword [num2]          ; st0 = num2 st1 = num1
    fcom st1
    fstsw ax
    sahf
    fcmovb  st0, st1
    fstp st1      

    fld dword [num3]
    fcom st1
    fstsw ax
    sahf
    fcmovb st0, st1   
    fstp st1
    fstp dword [maxf]

    fld dword [maxf]
    fsqrt
    sub esp, 8
    fstp qword [esp]
    push dword fmt_sqrt
    call printf
    add esp, 12


;menor
    fld dword [num1] 
    fld dword [num2]  
    fcom st1
    fstsw ax
    sahf
    fcmovnb st0, st1 
    fstp st1

    fld dword [num3] 
    fcom st1
    fstsw ax
    sahf
    fcmovnb st0, st1  
    fstp st1           
    fstp    dword [minf] 

    fld dword [minf]
    frndint
    sub esp, 8
    fstp qword [esp]
    push dword fmt_round
    call printf
    add esp, 12

;meio
    fld dword [num1]
    fadd dword [num2]
    fadd dword [num3]
    fsub dword [maxf]
    fsub dword [minf]
    fabs
    sub esp, 4
    fistp dword [esp]
    push dword fmt_hex
    call printf
    add esp, 8

    mov esp, ebp
    pop ebp
    ret
