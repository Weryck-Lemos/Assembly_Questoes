section .data
    prompt: db "Digite a expressão: ",0
    scan_fmt: db "%255s",0
    fmt_res: db "Resultado: %d",10,0

section .bss
    input_buf: resb 256 

section .text
    global main
    extern printf, scanf, SumSub, s

main:
    push ebp
    mov ebp, esp

    push prompt
    call printf
    add esp, 4

    push input_buf
    push scan_fmt
    call scanf
    add esp, 8

    lea eax, [input_buf]
    mov [s], eax

    call SumSub

    push eax
    push fmt_res
    call printf
    add esp, 8


    mov eax, 0
    pop ebp
    ret
