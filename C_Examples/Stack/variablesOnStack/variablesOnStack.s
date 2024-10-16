	.file	"ileegal.c"
	.intel_syntax noprefix
	.text
	.globl	leafFunction
	.type	leafFunction, @function
leafFunction:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	pop	rbp
	ret
	.size	leafFunction, .-leafFunction
	.globl	main
	.type	main, @function
main:
	endbr64												; Standard security

	; Sets up the stack
	push	rbp											; Saves Base Pointer of Caller function
	mov	rbp, rsp									; Creates a new Base Pointer based on the Caller's Stack Pointer

	; Allocates enough space on the stack for both initialized and uninitialized variables  
	sub	rsp, 80										; 16 * 5 


	mov	DWORD PTR -72[rbp], 0
	cmp	DWORD PTR -72[rbp], 0

	je	.L4
	mov	DWORD PTR -68[rbp], 100
	mov	QWORD PTR -64[rbp], 3
	mov	QWORD PTR -56[rbp], 40
	mov	QWORD PTR -48[rbp], 50
	mov	QWORD PTR -40[rbp], 60
	mov	QWORD PTR -32[rbp], 70
	mov	QWORD PTR -24[rbp], 80
	mov	QWORD PTR -16[rbp], 90
	mov	QWORD PTR -8[rbp], 120
.L4:
	mov	eax, 0
	call	leafFunction
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
