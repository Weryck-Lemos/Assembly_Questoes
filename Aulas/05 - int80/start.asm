; Flags

O_RDONLY   equ 0            ; Apenas leitura                           
O_WRONLY   equ 1            ; Apenas escrita                           
O_RDWR     equ 2            ; Leitura e escrita                        
O_CREAT    equ 0x40         ; Cria o arquivo se não existir            
O_EXCL     equ 0x80         ; Erro se `O_CREAT` + arquivo existir      
O_NOCTTY   equ 0x100        ; Não torna o arquivo terminal de controle 
O_TRUNC    equ 0x200        ; Trunca arquivo para tamanho 0 se existir 
O_APPEND   equ 0x400        ; Escreve sempre ao final do arquivo       
O_NONBLOCK equ 0x800        ; I/O não bloqueante                       


section .data

    filename db "teste.txt", 0
    msg db "Hello World!", 0xA
    msg_len equ $ - msg

section .bss
    buffer resb 128
    time_var resd 1

section .text
    global _start

_start:

    ; open file (cria e habilita a escrita)
    mov eax, 5              ; open
    mov ebx, filename       ; file name
    xor ecx, ecx 
    or ecx, O_CREAT        ; flag O_CREAT
    or ecx, O_WRONLY       ; flag O_WRONLY
    mov edx, 0o644          ; mode: rw-r--r--
    int 0x80

    mov esi, eax            ; file descriptor volta no eax

    ; write to file
    mov eax, 4              ; write
    mov ebx, esi            ; file descriptor
    mov ecx, msg            ; buffer
    mov edx, msg_len        ; length
    int 0x80

    ; close file 
    mov eax, 6              ; close
    mov ebx, esi            ; file descriptor
    int 0x80

    ; open file (somente leitura)
    mov eax, 5
    mov ebx, filename
    mov ecx, O_RDONLY       
    mov edx, 0
    int 0x80

    mov esi, eax            ; file descriptor

    ; read from file
    mov eax, 3              ; syscall: read
    mov ebx, esi            ; file descriptor
    mov ecx, buffer         ; buffer
    mov edx, 128            ; size
    int 0x80

    mov edi, eax            ; number of bytes read

    ; close file
    mov eax, 6
    mov ebx, esi
    int 0x80

    ; write to stdout
    mov eax, 4
    mov ebx, 1              ; stdout
    mov ecx, buffer
    mov edx, edi            ; bytes read
    int 0x80

    ; exit
    mov eax, 1              ; 
    xor ebx, ebx
    int 0x80

