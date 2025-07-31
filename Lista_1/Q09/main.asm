global main
extern printf, scanf

section .data
    fmt_scan  db "%99s",0
    fmt_print db "%d",10,0
    s_ptr     dd 0

section .bss
    txt       resb 100

section .text

main:
    lea    eax, [txt]
    push   eax
    push   fmt_scan
    call   scanf
    add    esp, 8

    lea    eax, [txt]
    mov    [s_ptr], eax

    call   SumSub
    push   eax
    push   fmt_print
    call   printf
    add    esp, 8

    mov    eax, 0
    ret

Fator:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [s_ptr]
    mov al, byte [ebx]
    cmp al, '('
    jne .FDigit

    inc dword [s_ptr]
    call SumSub   
    mov ebx, [s_ptr]
    mov cl, byte [ebx]
    cmp cl, ')'
    jne .FExit
    inc dword [s_ptr]

.FExit:
    pop ebx
    pop ebp
    ret

.FDigit:
    xor eax, eax

.FLoop:
    mov ebx, [s_ptr]
    mov cl, byte [ebx]
    cmp cl, '0'
    jl .FExit
    cmp cl, '9'
    jg .FExit

    ;v = v*10
    mov    edx, eax
    shl    eax, 3
    shl    edx, 1
    add    eax, edx

    ; v += digit
    sub    cl, '0'
    movzx  ecx, cl
    add    eax, ecx

    mov ebx, [s_ptr]
    inc ebx
    mov [s_ptr], ebx
    jmp .FLoop

    ;guarda eax
    jmp    .FExit

MultDiv:
    push   ebp
    mov    ebp, esp
    push   ebx 
    push   edx

    call   Fator
    mov    ebx, eax 

.MDLoop:
    mov    ecx, [s_ptr]
    mov    dl, byte [ecx]
    cmp    dl, '*'
    je     .MDOp
    cmp    dl, '/'
    jne    .MDEnd

.MDOp:
    inc    dword [s_ptr]     ; consome '*' ou '/'

    push   edx       
    call   Fator ; eax = w
    mov    ecx, eax  ; ecx = w
    pop    edx            

    cmp    dl, '*'
    je     .MDMul

    mov    eax, ebx
    cdq
    idiv   ecx
    mov    ebx, eax
    jmp    .MDLoop

.MDMul:
    imul   ebx, ecx  
    jmp    .MDLoop

.MDEnd:
    mov    eax, ebx
    pop    edx
    pop    ebx
    pop    ebp
    ret

SumSub:
    push   ebp
    mov    ebp, esp
    push   ebx 
    push   edx 

    call   MultDiv
    mov    ebx, eax  

.SSLoop:
    mov    ecx, [s_ptr]
    mov    dl, byte [ecx]
    cmp    dl, '+'
    je     .SSOp
    cmp    dl, '-'
    jne    .SSEnd

.SSOp:
    inc    dword [s_ptr]

    push   edx
    call   MultDiv 
    mov    ecx, eax  
    pop    edx

    cmp    dl, '+'
    je     .SSAdd
    sub    ebx, ecx
    jmp    .SSLoop

.SSAdd:
    add    ebx, ecx          ; v += w
    jmp    .SSLoop

.SSEnd:
    mov    eax, ebx 
    pop    edx
    pop    ebx
    pop    ebp
    ret