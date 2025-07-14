; maior.asm
; Compilar: nasm -f elf -o maior.o maior.asm
; Linkar: ld -m elf_i386 -o maior maior.o

GLOBAL _start

CR equ 13
LF equ 10

section .data
    num1   dd 15          ; Primeiro número (dd define 4 bytes)
    num2   dd 12          ; Segundo número

    msg    db "Maior: "
    msglen equ $ - msg


section .bss
    num_str: resb 16

section .text
_start:
    ; carregar os dois números
    mov eax, [num1]
    mov ebx, [num2]

    ; comparar
    cmp eax, ebx
    jl b_maior
    call show_result
    jmp fim

    ; ebx é maior
b_maior:
    mov eax, ebx
    call show_result
    jmp fim

show_result:
    ; converter número para string decimal (2 dígitos)
    mov ecx, 10
    xor edx, edx      ; zerar EDX para dividendo alto
    div ecx           ; EDX:EAX / ECX → quociente em EAX, resto em EDX
    add eax, 0x30     ; dezena
    add edx, 0x30     ; unidade

    mov ecx, num_str
    mov [ecx], al
    mov [ecx+1], dl
    mov byte [ecx+2],LF 


    ; escrever "Maior: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, msglen
    int 0x80

    ; escrever número
    mov eax, 4
    mov ebx, 1
    mov ecx, num_str
    mov edx, 3       ; 2 dígitos + newline
    int 0x80
    ret

fim:
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
    

    
    
