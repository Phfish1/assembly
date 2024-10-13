	.file	"noCallee.c"
	.intel_syntax noprefix
	.text
	.globl	foo
	.type	foo, @function
foo:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	pop	rbp
	ret
	.size	foo, .-foo
	.globl	testFunction
	.type	testFunction, @function


testFunction:
	endbr64
	push	rbp
	mov	rbp, rsp


	mov	DWORD PTR -20[rbp], edi
	mov	DWORD PTR -4[rbp], 3


	nop
	pop	rbp
	ret
	.size	testFunction, .-testFunction
	.globl	main
	.type	main, @function


main:
	endbr64
	push	rbp
	mov	rbp, rsp


	sub	rsp, 16


	mov	DWORD PTR -8[rbp], 10

	mov	edi, 1
	call	testFunction

	; Places the value 4 onto the stack as a local variable
	mov	DWORD PTR -4[rbp], 4
	
	; Sets up and Calls the testFunction
	; Call, PUSHes the instruction address of the next instruction in line onto the stack.
	mov	eax, DWORD PTR -4[rbp] 		; Places a local variable from the stack into EAX
	mov	edi, eax									; Places the value in EAX into EDI to be used as an argument to the calle function
	call	testFunction						; Does the calling og the testFunction

	; Exits the program
	; The Leave instruction 
	mov	eax, 0		; Moves imidiate value 0, into return register EAX
	leave					; Cleans up the
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
