section .data
    txt      db "Digite um numero: ", 0
    tam      equ $ - txt
    newline  db 10

section .bss
    entrada  resb 12 
    buffer   resb 11      
    num1     resd 1
    num2     resd 1
    num3     resd 1

section .text
    global main

main:

    call print_prompt
    mov eax, 3 
    mov ebx, 0 
    mov ecx, entrada
    mov edx, 12
    int 0x80
    call atoi  
    mov [num1], eax

    call print_prompt
    mov eax, 3
    mov ebx, 0
    mov ecx, entrada
    mov edx, 12
    int 0x80
    call atoi
    mov [num2], eax

    call print_prompt
    mov eax, 3
    mov ebx, 0
    mov ecx, entrada
    mov edx, 12
    int 0x80
    call atoi
    mov [num3], eax


    mov eax, [num1]
    mov ebx, [num2]
    mov ecx, [num3]

    mov edx, eax
    cmp ebx, edx
    cmovl edx, ebx
    cmp ecx, edx
    cmovl edx, ecx

    mov esi, eax
    add esi, ebx
    add esi, ecx
    sub esi, edx

    mov eax, esi
    mov ecx, 10
    mov edi, buffer + 11  
    call converter_digits

    xor eax, eax
    ret


print_prompt:
    mov eax, 4   
    mov ebx, 1   
    mov ecx, txt
    mov edx, tam
    int 0x80
    ret


atoi:
    xor eax, eax 
    xor ebx, ebx         
.next_char:
    movzx edx, byte [entrada + ebx]
    cmp dl, 10          
    je .done
    cmp dl, 0 
    je .done
    sub dl, '0'
    imul eax, eax, 10
    add eax, edx
    inc ebx
    jmp .next_char
.done:
    ret


converter_digits:
    cmp eax, 0
    jne .conv
    dec edi
    mov byte [edi], '0'
    jmp .print_digits

.conv:
    xor edx, edx
.loop:
    div ecx          
    add dl, '0'
    dec edi
    mov [edi], dl
    xor edx, edx
    cmp eax, 0
    jne .loop

.print_digits:
    mov eax, 4  
    mov ebx, 1     
    mov ecx, edi
    lea edx, [buffer + 11]
    sub edx, ecx
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret
