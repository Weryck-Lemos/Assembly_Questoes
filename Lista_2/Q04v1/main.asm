; main.asm
; Compilar (32-bit):
; nasm -f elf32 main.asm -o main.o
; ld -m elf_i386 main.o -o main -e main
; Executar como root: sudo ./main

SYS_OPEN      equ 5        ; sys_open
SYS_IOCTL     equ 54       ; sys_ioctl
SYS_WRITE     equ 4        ; sys_write
SYS_EXIT      equ 1        ; sys_exit

; IOCTL uinput (<linux/uinput.h>)
UI_SET_EVBIT  equ 0x40045564
UI_SET_RELBIT equ 0x40045566
UI_DEV_CREATE equ 0x5501

; evento tipos/códigos
EV_SYN        equ 0x00
EV_REL        equ 0x02
REL_X         equ 0x00
SYN_REPORT    equ 0x00

section .data
    path_uinput: db "/dev/uinput",0

    ; bloco de 2 eventos: movimento X e sync
events:
    dd 0, 0          ; tv_sec, tv_usec
    dw EV_REL
    dw REL_X
    dd 5             ; mover 5 pixels em X

    dd 0, 0
    dw EV_SYN
    dw SYN_REPORT
    dd 0

events_size equ ($ - events)

section .bss
    fd resd 1

section .text
    global main
main:
    ; abrir /dev/uinput
    mov eax, SYS_OPEN
    mov ebx, path_uinput
    mov ecx, 1       ; O_WRONLY
    mov edx, 0
    int 0x80
    cmp eax,0
    js exit
    mov [fd], eax

    ; habilitar REL
    mov eax, SYS_IOCTL
    mov ebx, [fd]
    mov ecx, UI_SET_EVBIT
    mov edx, EV_REL
    int 0x80

    ; habilitar REL_X
    mov eax, SYS_IOCTL
    mov ebx, [fd]
    mov ecx, UI_SET_RELBIT
    mov edx, REL_X
    int 0x80

    ; criar dispositivo
    mov eax, SYS_IOCTL
    mov ebx, [fd]
    mov ecx, UI_DEV_CREATE
    xor edx, edx
    int 0x80

    ; enviar eventos
    mov eax, SYS_WRITE
    mov ebx, [fd]
    mov ecx, events
    mov edx, events_size
    int 0x80

exit:
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
