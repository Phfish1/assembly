section .data                   ; section ".data" where variables are stored / data is defined
    my_string db "hello world",10    ; db= "Define Bytes" " "hello word",10 " "10" being "new_line"
                                ; "text" is a label for the MEMMORY ADDRESS where "hello word",10 is stored
                                ; Aka where the bytes "hello wordl,10" are defined in memory
section .text
    global _start

_start:                         ; "_start" 
                                ; "mov rax, 1" moves the VALUE 1 into the register "rax" 
    mov rax, 1                  ; 1 = Linux Syscall, "sys_write" into "syscall ID"
    mov rdi, 1                  ; 1 = Standard_output "std_out" into "ARG1" / filedescriptor
    mov rsi, my_string          ; Memmory address of "text" into "ARG2" / buffer
    mov rdx, 12                 ; "Length of string in memmory address": "text", into "ARG3" / count
    syscall                     ; call the kernel, (it reads the "rax" register, then the arguments if needed)

    mov rax, 60                 ; 60 = "sys_exit"
    mov rdi, 0                  ; 0 = "errorcode: no_error" (can be anything you want, but 0 is no_error)
    syscall                     ; Call the kernel 



