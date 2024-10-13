	.file	"smalCallee.c"
	.intel_syntax noprefix
	.text
	.globl	bar
	.type	bar, @function
bar:
	endbr64
	push	rbp
	mov	rbp, rsp
	nop
	pop	rbp
	ret
	.size	bar, .-bar
	.globl	foo
	.type	foo, @function
foo:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], 1
	mov	DWORD PTR -16[rbp], 2
	mov	DWORD PTR -12[rbp], 3
	mov	DWORD PTR -8[rbp], 4
	mov	DWORD PTR -4[rbp], 5
	mov	eax, 0
	call	bar
	mov	eax, 0
	leave
	ret
	.size	foo, .-foo
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	pop	rbp
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
