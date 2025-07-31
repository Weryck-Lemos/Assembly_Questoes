section .data

    path: db "hello", 0
    arg1:  db "x",0
    arg2: db "y",0
    argv:  dd path, arg1, arg2, 0

    envp:  dd 0

section .text
global _start

_start:

    mov eax, 11        
    mov ebx, path  
    mov ecx, argv           
    mov edx, envp    
    int 0x80             


    mov eax, 1      
    mov ebx, 1
    int 0x80
