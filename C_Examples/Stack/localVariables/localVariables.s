	.file	"localVariables.c"
	.intel_syntax noprefix
	.text
	.globl	pointerFunction
	.type	pointerFunction, @function
pointerFunction:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -12[rbp], eax
	mov	eax, DWORD PTR -12[rbp]
	pop	rbp
	ret
	.size	pointerFunction, .-pointerFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -32[rbp], 1
	mov	DWORD PTR -28[rbp], 2
	mov	DWORD PTR -24[rbp], 3
	mov	DWORD PTR -20[rbp], 4
	mov	DWORD PTR -16[rbp], 5
	mov	DWORD PTR -12[rbp], 6
	mov	DWORD PTR -8[rbp], 7
	mov	DWORD PTR -4[rbp], 8
	lea	rax, -32[rbp]
	mov	rdi, rax
	call	pointerFunction
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
