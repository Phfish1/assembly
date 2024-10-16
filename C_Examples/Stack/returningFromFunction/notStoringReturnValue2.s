	.file	"notStoringReturnValue.c"
	.intel_syntax noprefix
	.text
	.globl	memoryFunction
	.type	memoryFunction, @function
memoryFunction:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 168
	mov	QWORD PTR -168[rbp], rdi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax
	xor	eax, eax
	movabs	rax, 123598092724304
	mov	edx, 0
	mov	QWORD PTR -160[rbp], rax
	mov	QWORD PTR -152[rbp], rdx
	mov	QWORD PTR -144[rbp], 0
	mov	QWORD PTR -136[rbp], 0
	mov	QWORD PTR -128[rbp], 0
	mov	QWORD PTR -120[rbp], 0
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -104[rbp], 0
	mov	QWORD PTR -96[rbp], 0
	mov	QWORD PTR -88[rbp], 0
	mov	QWORD PTR -80[rbp], 0
	mov	QWORD PTR -72[rbp], 0
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	mov	QWORD PTR -48[rbp], 0
	mov	WORD PTR -40[rbp], 0
	mov	BYTE PTR -38[rbp], 0
	mov	DWORD PTR -36[rbp], 19


	mov	rax, QWORD PTR -168[rbp]
	
	mov	rcx, QWORD PTR -160[rbp]
	mov	rbx, QWORD PTR -152[rbp]
	mov	QWORD PTR [rax], rcx
	mov	QWORD PTR 8[rax], rbx
	mov	rcx, QWORD PTR -144[rbp]
	mov	rbx, QWORD PTR -136[rbp]
	mov	QWORD PTR 16[rax], rcx
	mov	QWORD PTR 24[rax], rbx
	mov	rcx, QWORD PTR -128[rbp]
	mov	rbx, QWORD PTR -120[rbp]
	mov	QWORD PTR 32[rax], rcx
	mov	QWORD PTR 40[rax], rbx
	mov	rcx, QWORD PTR -112[rbp]
	mov	rbx, QWORD PTR -104[rbp]
	mov	QWORD PTR 48[rax], rcx
	mov	QWORD PTR 56[rax], rbx
	mov	rcx, QWORD PTR -96[rbp]
	mov	rbx, QWORD PTR -88[rbp]
	mov	QWORD PTR 64[rax], rcx
	mov	QWORD PTR 72[rax], rbx
	mov	rcx, QWORD PTR -80[rbp]
	mov	rbx, QWORD PTR -72[rbp]
	mov	QWORD PTR 80[rax], rcx
	mov	QWORD PTR 88[rax], rbx
	mov	rcx, QWORD PTR -64[rbp]
	mov	rbx, QWORD PTR -56[rbp]
	mov	QWORD PTR 96[rax], rcx
	mov	QWORD PTR 104[rax], rbx
	mov	rcx, QWORD PTR -48[rbp]
	mov	rbx, QWORD PTR -40[rbp]
	mov	QWORD PTR 112[rax], rcx
	mov	QWORD PTR 120[rax], rbx
	mov	rax, QWORD PTR -24[rbp]
	xor	rax, QWORD PTR fs:40
	je	.L3
	call	__stack_chk_fail@PLT
.L3:
	mov	rax, QWORD PTR -168[rbp]
	add	rsp, 168
	pop	rbx
	pop	rbp
	ret
	.size	memoryFunction, .-memoryFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -144[rbp]
	mov	rdi, rax
	mov	eax, 0
	call	memoryFunction
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	xor	rdx, QWORD PTR fs:40
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
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
