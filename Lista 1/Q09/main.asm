section .data
    prompt db  "Digite a expressao: "
    prompt_len  equ $-prompt

    res_prefix  db  "Resultado: "
    prefix_len  equ $-res_prefix

    newline db  0xA

section .bss
    input_buf       resb 256
    buffer_conv     resb 12

section .text
    global main
    extern SumSub
    extern s

main:
    mov eax, 4
    mov ebx, 1
    mov  ecx, prompt
    mov edx, prompt_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, input_buf
    mov edx, 255
    int 0x80

    mov ebx, eax
    cmp ebx, 1
    jle skip_term
    dec ebx
    mov byte [input_buf + ebx], 0
skip_term:

    lea eax, [input_buf]
    mov [s], eax

    call SumSub

    mov ecx, 10
    lea edi, [buffer_conv + 12]
    call converter_digitos

    mov eax, 4
    mov ebx, 1
    mov ecx, res_prefix
    mov edx, prefix_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer_conv + 12
    sub edx, edi
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    xor     eax, eax
    ret

converter_digitos:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz converter_digitos
    ret
