	.file	"noCallee.c"
	.intel_syntax noprefix
	.text
	.globl	testFunction3
	.type	testFunction3, @function
testFunction3:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -4[rbp], 3
	nop
	pop	rbp
	ret
	.size	testFunction3, .-testFunction3
	.globl	testFunction2
	.type	testFunction2, @function
testFunction2:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 24
	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -24[rbp], esi
	mov	DWORD PTR -4[rbp], 2
	mov	eax, 0
	call	testFunction3
	nop
	leave
	ret
	.size	testFunction2, .-testFunction2
	.globl	testFunction
	.type	testFunction, @function
testFunction:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], 1
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, 3
	mov	edi, eax
	call	testFunction2
	nop
	leave
	ret
	.size	testFunction, .-testFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], 10
	mov	QWORD PTR -8[rbp], 20
	mov	DWORD PTR -16[rbp], 40
	mov	DWORD PTR -12[rbp], 12
	mov	eax, 0
	call	testFunction
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
