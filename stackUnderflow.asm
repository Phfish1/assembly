SECTION .data
SECTION .bss
SECTIOn .text
global _start
_start:
  mov rbp, rsp
  mov rax, 1200

  doMore:
    pop rbx
    dec rax
    jnz doMore



  mov rax, 60
  mov rdi, 0
  syscall