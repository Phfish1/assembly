	.file	"goingBeyondVariableBoundry.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"You won!!!"
	.text
	.globl	debug
	.type	debug, @function
debug:
	endbr64
	push	rbp
	mov	rbp, rsp
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	pop	rbp
	ret
	.size	debug, .-debug
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR 16[rbp], 4457
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
