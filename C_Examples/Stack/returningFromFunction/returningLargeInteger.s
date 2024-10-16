	.file	"returningFromFunction.c"
	.intel_syntax noprefix
	.text
	.globl	integerFunction
	.type	integerFunction, @function
integerFunction:
	endbr64
	push	rbp
	mov	rbp, rsp

	movabs	rax, 1152921504606846975		; MOVES 0x0FFFFFFFFFFFFFFF into RAX register
	mov	QWORD PTR -16[rbp], rax					; Move value into a local variable -16[RBP]
	
	; Does multiplication some advanced way
	mov	rdx, QWORD PTR -16[rbp]					; moves value ^, into RDX
	mov	rax, rdx
	sal	rax, 16
	sub	rax, rdx

	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -8[rbp]


	pop	rbp
	ret
	.size	integerFunction, .-integerFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16

	mov	eax, 0
	call	integerFunction

	; Altought our function returns values in both the RAX, and RDX registers, we have not defined more than a single
	; long as to store the return values, in this case we should handle the result as a structure with 2 long's instead!
	mov	QWORD PTR -8[rbp], rax		; Only value in RAX saved, high bits of return values LOST!!!


	mov	eax, 0
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
