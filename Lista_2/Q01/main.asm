; time_update.asm — exibe data/hora atualizada a cada segundo no mesmo lugar
; Linux x86 32‑bits, ligações dinâmicas com libc

section .data
    fmt     db "%d/%m/%Y %H:%M:%S", 0   ; formato para strftime (sem newline)
    buf     times 20 db 0              ; buffer (>=19 chars + NUL)

section .bss
    time_val    resd 1                 ; time_t

section .text
    global _start
    extern time, localtime, strftime, sleep

_start:
.loop:
    ; — 1) time(&time_val)
    push    dword time_val
    call    time
    add     esp, 4

    ; — 2) localtime(&time_val)
    push    dword time_val
    call    localtime
    add     esp, 4    ; EAX = ponteiro struct tm

    ; — 3) strftime(buf, 20, fmt, tm)
    push    eax        ; struct tm *
    push    dword fmt  ; formato
    push    dword 20   ; tamanho máximo (inclui NUL)
    push    dword buf  ; destino
    call    strftime
    add     esp, 16    ; limpa os argumentos
                      ; → EAX = número de bytes escritos (sem contar o NUL)

    ; — 4) sobrescrever o NUL com CR (‘\r’)
    mov     ecx, eax      ; salva comprimento
    mov     byte [buf+ecx], 0x0D
    inc     eax           ; agora EAX = comprimento + 1 (inclui o CR)

    ; — 5) write(1, buf, eax)
    mov     edx, eax      ; edx = len+1
    mov     ecx, buf      ; ecx = ptr
    mov     ebx, 1        ; stdout
    mov     eax, 4        ; sys_write
    int     0x80

    ; — 6) sleep(1)
    push    dword 1
    call    sleep
    add     esp, 4

    jmp     .loop         ; repete

    ; (não há exit; finalize com Ctrl+C)
