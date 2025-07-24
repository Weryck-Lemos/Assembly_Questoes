section .data
    mat     dd 4.0,  5.0, -3.0    ; a,  b,  c
            dd 2.0,  1.0,  0.0    ; d,  e,  f
            dd 3.0, -1.0,  1.0    ; g,  h,  i

    fmt db "Determinante: %f", 10, 0

section .bss
    term1 resd 1
    term2 resd 1
    term3 resd 1
    term4 resd 1
    term5 resd 1
    term6 resd 1
    det resd 1

section .text
    global main
    extern printf

main:
    ;a*e*i
    movss xmm0, [mat]     ;xmm0 =a
    movss xmm1, [mat+16]   ; xmm1 =e
    mulss xmm1, xmm0       ; xmm1 =e*a
    movss xmm2, [mat+32]   ; xmm2 =i
    mulss xmm1, xmm2       ; xmm1 =i*(e*a)
    movss [term1], xmm1

    ;c*e*g
    movss xmm0, [mat+8]
    movss xmm1, [mat+16]  
    mulss xmm0, xmm1   
    movss xmm2, [mat+24]  
    mulss xmm0, xmm2  
    movss [term2], xmm0

    ;b*f*g
    movss xmm0, [mat+4] 
    movss xmm1, [mat+20] 
    mulss xmm0, xmm1 
    movss xmm2, [mat+24] 
    mulss xmm0, xmm2 
    movss [term3], xmm0

    ;a*f*h
    movss xmm0, [mat]  
    movss xmm1, [mat+20]  
    mulss xmm0, xmm1  
    movss xmm2, [mat+28]  
    mulss xmm0, xmm2 
    movss [term4], xmm0

    ;c*d*h
    movss xmm0, [mat+8] 
    movss xmm1, [mat+12]  
    mulss xmm0, xmm1   
    movss xmm2, [mat+28] 
    mulss xmm0, xmm2   
    movss [term5], xmm0

    ;b*d*i
    movss xmm0, [mat+4]  
    movss xmm1, [mat+12] 
    mulss xmm0, xmm1    
    movss xmm2, [mat+32]  
    mulss xmm0, xmm2    
    movss [term6], xmm0

    movss xmm0, [term1]
    subss xmm0, [term2]
    addss xmm0, [term3]
    subss xmm0, [term4]
    addss xmm0, [term5]
    subss xmm0, [term6]
    movss [det], xmm0

    movss   xmm0, [det]    
    cvtss2sd xmm0, xmm0       
    sub     esp, 8
    movsd   [esp], xmm0   
    push    dword fmt
    call    printf
    add     esp, 12

    xor     eax, eax
    ret
