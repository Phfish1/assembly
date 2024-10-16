	.file	"redZone.c"
	.intel_syntax noprefix
	.text
	.globl	leafFunction
	.type	leafFunction, @function
leafFunction:
	endbr64
	push	rbp
	mov	rbp, rsp

	;; Subtracting 8 Here Ensures that the Stack Pointer (RSP) is 16 Byte alligned ;;
	sub	rsp, 8 			


	mov	QWORD PTR -128[rbp], 1
	mov	QWORD PTR -120[rbp], 2
	mov	QWORD PTR -112[rbp], 3
	mov	QWORD PTR -104[rbp], 4
	mov	QWORD PTR -96[rbp], 5
	mov	QWORD PTR -88[rbp], 6
	mov	QWORD PTR -80[rbp], 7
	mov	QWORD PTR -72[rbp], 8
	mov	QWORD PTR -64[rbp], 9
	mov	QWORD PTR -56[rbp], 10
	mov	QWORD PTR -48[rbp], 11
	mov	QWORD PTR -40[rbp], 12
	mov	QWORD PTR -32[rbp], 13
	mov	QWORD PTR -24[rbp], 14
	mov	QWORD PTR -16[rbp], 15
	mov	QWORD PTR -8[rbp], 16
	mov	eax, 0
	leave
	ret
	.size	leafFunction, .-leafFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	
	mov	DWORD PTR -4[rbp], 100
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
