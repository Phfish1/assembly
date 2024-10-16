	.file	"returningPointer.c"
	.intel_syntax noprefix
	.text
	.globl	pointerFunction
	.type	pointerFunction, @function
pointerFunction:
	; Setup of stack frame
	endbr64
	push	rbp
	mov	rbp, rsp

	; Saves parameter of pointerFunction to stack
	mov	QWORD PTR -24[rbp], rdi

	; Adds 4 to local variable "nextItem" then stores it in local variable
	mov	rax, QWORD PTR -24[rbp]
	add	rax, 4										; Adds 4 because INTEGER == 4Bytes
	mov	QWORD PTR -8[rbp], rax

	; Returns local variable "nextItem"
	mov	rax, QWORD PTR -8[rbp]
	pop	rbp
	ret
	.size	pointerFunction, .-pointerFunction
	.globl	main
	.type	main, @function
main:
	; Setup of stack frame
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48

	; Thread magic
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	; Assign array to stack as a local variable
	mov	DWORD PTR -32[rbp], 1
	mov	DWORD PTR -28[rbp], 2
	mov	DWORD PTR -24[rbp], 3
	mov	DWORD PTR -20[rbp], 4

	; Loads address / pointer into RAX -> RDI for being passed as an argument to pointerFunction
	lea	rax, -32[rbp]
	mov	rdi, rax

	call	pointerFunction
	mov	QWORD PTR -40[rbp], rax		; Moves result into local variable

	; Threading magic
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	xor	rdx, QWORD PTR fs:40
	je	.L5
	call	__stack_chk_fail@PLT
.L5:
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
