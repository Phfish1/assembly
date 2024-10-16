	.file	"passingArguments.c"
	.intel_syntax noprefix
	.text
	.globl	leafFunction
	.type	leafFunction, @function
leafFunction:
	endbr64
	push	rbp
	mov	rbp, rsp

	mov	QWORD PTR -8[rbp], rdi
	
	mov	eax, 0 		; Return value
	pop	rbp
	ret
	.size	leafFunction, .-leafFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	mov	DWORD PTR -32[rbp], 1
	mov	DWORD PTR -28[rbp], 3
	mov	DWORD PTR -24[rbp], 5
	mov	DWORD PTR -20[rbp], 6

	lea	rax, -32[rbp]
	mov	rdi, rax
	call	leafFunction

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
