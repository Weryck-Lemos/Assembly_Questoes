section .text
    global soma_array
    
soma_array:
    mov     rcx, 10        ;elementos
    xor     rbx, rbx       ; índice 

.loop:
    cmp     rbx, rcx
    jge     .end

    mov     eax, [rdi + rbx*4]  
    add     eax, [rsi + rbx*4]  
    mov     [rdx + rbx*4], eax

    inc     rbx
    jmp     .loop

.end:
    ret
