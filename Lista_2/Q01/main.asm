section .data
    fmt     db "%d/%m/%Y %H:%M:%S", 0
    buf     times 20 db 0          

section .bss
    time_val    resd 1   

section .text
    global _start
    extern time, localtime, strftime, sleep

_start:
.loop:
    push dword time_val
    call time
    add  esp, 4

    push dword time_val
    call localtime
    add  esp, 4

    push  eax  
    push  dword fmt
    push  dword 20  
    push  dword buf 
    call  strftime
    add   esp, 16 
        


    mov   ecx, eax  
    mov   byte [buf+ecx], 0x0D
    inc   eax   


    mov   edx, eax  
    mov  ecx, buf  
    mov  ebx, 1    
    mov  eax, 4  
    int  0x80

    ;sleep
    push    dword 1
    call    sleep
    add     esp, 4

    jmp     .loop  