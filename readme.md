# x86-64 Linux Assembly

In this repo i test assembly.
Main branch is dedicated to compiling C code to assembly, and walking trough its execution.
Finished and partially finished descriptions of assembly files generated from C code lies in the `/Docs` Directory

## Things to learn

- How are local variables stored on the stack.

  - A buffer f.eks

- How does stack overflows work

- How does a buffer overflow work, stack smashing

- Stack canaries, what are they and how do they work

  - Ways to bypass stack canaries
    - Incremental solving (Guessing)
    - Stack leaking

- What is stack leaking

- Floating point Registers and arithmetics

  - XMM, SSE, SIMD

- Wierd datatypes
  - \_Float128
  - SCALA vs Vector datatypes

## Info

The `.s` assembly files are compiled using:

```zsh
gcc -S -masm=intel -fno-asynchronous-unwind-tables SOURCE.c -o OUTPUT.s
```

Or optionally to disable Stack Canaries:

```zsh
gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-stack-protector SOUREC.c -o OUTPUT.s
```

A real life example of the Linux **System V** ABI calling conventions are layed out in `/Docs/callingConventions.s`

Bellow is how to set up a Stack Frame:

```asm
  ; Initial setup
    endbr64                 ; Placed by compilers for Control Flow Security
    push rbp                ; Stores Caller's RBP
    mov rbp, rsp            ; Creates new stack frame

  ; Only needed if function calls other functions:
    sub rbp, 64             ; Allocates space on stack for local variables



  ; Does not TECHNICALLY need to restore Stack Pointer (RSP) Because it was never modified
    mov rsp, rbp            ; But for good practice do it anyway
    pop rbp                 ; Both these lines are equivilent to the LEAVE instruction
    ret
```

## Stack smashing

List to great videoes about stack smashing AKA buffer overflows

- Videos

  - [Stack canaries](https://www.youtube.com/watch?v=z6gdQt8mjn4) Low Level Learning
  - [Buffer overflow](https://www.youtube.com/watch?v=qpyRz5lkRjE) Low level Learning
  - [Buffer Overflow](https://www.youtube.com/watch?v=1S0aBV-Waeo) Computerphile
    Note the demonstration in this video is using 32Bit architecture AND the GDB debugger today looks diffrent

- Articles
  - [Stack canaries](https://ctf101.org/binary-exploitation/stack-canaries/) CTF101.org
  - [Stack Smashing Protections](https://heimdalsecurity.com/blog/stack-smashing/) Heimdal

## Concepts

- **PLT** (Procedure Linking Table)

  ```asm
  call printf@PLT
  ```

- **Global Offset Table**

  ```asm
  call __x86.get_pc_thunk.bx
  add ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_

  lea eax, .LC2@GOTOFF[ebx]
  ```

- **Use after Free**

- **Return oriented programming**

- **Static VS dynamic linking of Object files**

- **Dynamic Linker**

- **Stripped vs Unstripped ELF files**

- **ELF (Executable and Linkeble Format)**

## Intresting concepts to dive deeper into

- **Yoda notation**
  - What is it, why is it usefull from a security point of view.

## LORE

I have noticed that some concepts in computer science have lore dating long back

- Canaries

  - A bird which miners use as a "bad gass" detector

- Endian
  - A word from the book about a king and his eggs...
