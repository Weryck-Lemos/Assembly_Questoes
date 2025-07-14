section .text
    global get_time

get_time:
    push ebx 
    mov eax, 13 
    mov ebx, 0
    int  0x80 
    pop  ebx
    ret 
