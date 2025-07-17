SYS_OPEN    equ 5
SYS_CREAT   equ 8
SYS_UNLINK  equ 10
SYS_READ    equ 3
SYS_WRITE   equ 4
SYS_CLOSE   equ 6
SYS_RENAME  equ 38
SYS_MKDIR   equ 39
SYS_RMDIR   equ 40
SYS_CHMOD   equ 15

O_RDONLY    equ 0
O_WRONLY    equ 1
O_CREAT     equ 64
O_TRUNC     equ 512


section .bss
buffer: resb 4096

section .text
global create_file, remove_file, copy_file, move_file
global create_dir, remove_dir, copy_dir, move_dir, chmod_file

create_file:
    mov eax, SYS_CREAT
    mov ebx, [esp+4]
    mov ecx, [esp+8]
    int 0x80
    ret 8

remove_file:
    remove_file:
    mov eax, SYS_UNLINK
    mov ebx, [esp+4]
    int 0x80
    ret  4   

copy_file:
    push ebx
    push esi
    push edi

    ; open source (O_RDONLY)
    mov   eax, SYS_OPEN
    mov   ebx, [esp+16]        ; after pushes, src is at esp+16
    xor   ecx, ecx
    int   0x80
    mov   esi, eax             ; fd_src

    ; open/create dest (O_WRONLY|O_CREAT|O_TRUNC, 0644)
    mov   eax, SYS_OPEN
    mov   ebx, [esp+20]        ; dst at esp+20
    mov   ecx, O_WRONLY|O_CREAT|O_TRUNC
    mov   edx, 0644
    int   0x80
    mov   edi, eax             ; fd_dst

.loop:
    mov   eax, SYS_READ
    mov   ebx, esi
    mov   ecx, buffer
    mov   edx, 4096
    int   0x80
    test  eax, eax
    jle   .done

    mov   edx, eax
    mov   eax, SYS_WRITE
    mov   ebx, edi
    mov   ecx, buffer
    int   0x80
    jmp   .loop

.done:
    mov   eax, SYS_CLOSE
    mov   ebx, esi
    int   0x80
    mov   eax, SYS_CLOSE
    mov   ebx, edi
    int   0x80

    pop   edi
    pop   esi
    pop   ebx
    ret   8

move_file:
    mov  eax, SYS_RENAME   ; syscall 38
    mov  ebx, [esp+4]      ; old_path
    mov  ecx, [esp+8]      ; new_path
    int  0x80              ; rename(old_path, new_path)
    ret  8                 ; limpa os 2 argumentos (2×4 bytes)


create_dir:
    mov  eax, SYS_MKDIR   ; syscall 39
    mov  ebx, [esp+4]     ; path
    mov  ecx, [esp+8]     ; mode
    int  0x80             ; mkdir(path, mode)
    ret  8                ; limpa 2 argumentos (2×4 bytes)

remove_dir:
    mov  eax, SYS_RMDIR   ; syscall 40
    mov  ebx, [esp+4]     ; path
    int  0x80             ; rmdir(path)
    ret  4                ; limpa 1 argumento (4 bytes)

copy_dir:
    mov  eax, SYS_MKDIR   ; syscall 39 = mkdir
    mov  ebx, [esp+8]     ; segundo argumento: dst_dir
    mov  ecx, 0755        ; modo do diretório
    int  0x80             ; mkdir(dst_dir, 0755)
    ret  8


move_dir:
    jmp move_file


chmod_file:
    mov  eax, SYS_CHMOD   ; syscall 15
    mov  ebx, [esp+4]     ; path
    mov  ecx, [esp+8]     ; mode
    int  0x80             ; chmod(path, mode)
    ret  8                ; limpa 2 argumentos (2×4 bytes)

