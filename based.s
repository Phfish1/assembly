	.file	"based.c"
	.intel_syntax noprefix
	.text
	.globl	foo
	.type	foo, @function
foo:
	endbr64
	push	rbp
	mov	rbp, rsp

	mov	DWORD PTR -4[rbp], 3

	mov	eax, 0
	pop	rbp
	ret
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp


	sub	rsp, 32

	mov	DWORD PTR -28[rbp], 1
	mov	DWORD PTR -24[rbp], 3
	mov	QWORD PTR -16[rbp], 4
	mov	QWORD PTR -8[rbp], 10
	mov	DWORD PTR -20[rbp], 5

	mov	eax, 0
	call	foo

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
