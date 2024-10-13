# x86-64 Linux Assembly

In this repo i test assembly.
Main branch is dedicated to compiling C code to assembly, and walking trough its execution.
Finished and partially finished descriptions of assembly files generated from C code lies in the `/Docs` Directory

The `.s` assembly files are compiled using:

```zsh
gcc -S -masm=intel -fno-asynchronous-unwind-tables SOURCE -o OUTPUT
```

A real life example of the Linux **System V** ABI calling conventions are layed out in `/Docs/callingConventions.s`

Bellow is how to set up a Stack Frame:

```asm
    ; Initial setup
    nop
    push rbp
    mov rbp, rsp




    ; Does not TECHNICALLY need to restore Stack Pointer (RSP) Because it was never modified
    mov rsp, rbp            ; But for good practice do it anyway
    pop rbp                 ; Both these lines are equivilent to the LEAVE instruction
    ret
```
