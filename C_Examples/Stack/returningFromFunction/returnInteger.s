	.file	"returningFromFunction.c"
	.intel_syntax noprefix
	.text
	.globl	integerFunction
	.type	integerFunction, @function
integerFunction:
	endbr64
	push	rbp
	mov	rbp, rsp

	; Moves 100 into local variable -4[RBP]
	mov	DWORD PTR -4[rbp], 100

	; Passes local variable as a DWORD into EAX,
	; EAX / RAX is used to pass function return values
	mov	eax, DWORD PTR -4[rbp]


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

	mov	eax, 0							; Means nothing
	call	integerFunction

	; Moves value returned from integerFunction into local variable
	mov	DWORD PTR -4[rbp], eax

	; Exits function with argument of 0
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
