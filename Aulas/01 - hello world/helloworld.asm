section .data 
    msg: db 72,'ello World!',10
    msglen: equ $-msg
     
section .text
    GLOBAL _start

; comentarios iniciam com ;
; inicio do codigo

_start:
    ; imprime na tela
    mov eax, 4 ; syscall 'write'
    mov ebx, 1 ; saída para a tela
    mov ecx, msg ; mensagem
    mov edx, msglen ;tamanho da mensagem
    int 80h
    
    ; termina o programa com retorno
    mov eax, 1 ; syscall 'exit'
    mov ebx, 0
    int 80h
    
    
    
    
    
    
    
    
    
    
