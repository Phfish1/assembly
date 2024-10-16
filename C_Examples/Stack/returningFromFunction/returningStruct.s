	.file	"returningStruct.c"
	.intel_syntax noprefix
	.text
	.globl	structFunction
	.type	structFunction, @function
structFunction:
	endbr64
	push	rbp
	mov	rbp, rsp


	; Store first value (HIGH bytes) in a local variable
	mov	eax, 2863311530
	mov	QWORD PTR -16[rbp], rax

	; Store second value (LOW bytes) in local variable
	movabs	rax, 72057594037927935
	mov	QWORD PTR -8[rbp], rax

	;
	;	Lets say we theoreticly did a multiplication of 2 longs,
	; > NOTE that in this case we are just storing 2 longs in a struct
	;
	; Ready values for being returned
	;	In this case can uses both RAX and RDX as return values
	; This makes it possible to store 128 Bytes, or the result of 2 long/qword value multiplications
	;		MUL does also by default store its values in RDX and RAX, but in reverse order ¨
	;		(this can be changed in the C source code, possibly by storing high bytes in "second" long of the structure)
	;
	mov	rax, QWORD PTR -16[rbp]		; Moves the HIGH bytes of the result into RAX
	mov	rdx, QWORD PTR -8[rbp]		; Moves the LOW bytes of the result into RDX

	pop	rbp
	ret
	.size	structFunction, .-structFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16

	mov	eax, 0
	call	structFunction

	; Stores the returning values in a local variable / struct.
	mov	QWORD PTR -16[rbp], rax
	mov	QWORD PTR -8[rbp], rdx		 

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
