section .bss
    time_val resd 1            ; timestamp
    time_str resb 12           ; buffer para a string ASCII
section .text
    global _start

_start:
    xor r10d,r10d

ler_hora:
    ; chamar time 
    mov eax, 13            ; syscall: time
    mov ebx, time_val      ; endereço para armazenar o tempo
    int 0x80

    ; carregar valor de tempo 
    mov eax, [time_val]    ; carrega timestamp em eax
    
    mov dword eax, [time_val]
    cmp eax, r10d
    je ler_hora
    mov r10d, eax
    

    ; converter inteiro para string (base 10) 
    mov edi, time_str      ; ponteiro para buffer
    add edi, 11            ; aponta para o fim
    mov byte [edi], 0xD   ; adiciona newline
    dec edi                ; posiciona antes do newline

convert_loop:
    xor edx, edx
    mov ecx, 10
    div ecx                ; divide eax por 10, resultado em eax, resto em edx
    add dl, '0'
    mov [edi], dl
    dec edi
    test eax, eax
    jnz convert_loop

    inc edi                ; ajusta para apontar para o início da string

    ; imprimir string 
    mov eax, 4             ; syscall: write
    mov ebx, 1             ; stdout
    mov ecx, edi           ; ponteiro para string
    xor edx, edx
    mov edx, time_str
    add edx, 12
    sub edx, edi
;    mov edx, time_str + 12 - edi ; comprimento
    int 0x80

     jmp ler_hora

    ; exit 
    mov eax, 1
    xor ebx, ebx
    int 0x80

