	.file	"passingStruct.c"
	.intel_syntax noprefix
	.text
	.globl	leafFunction
	.type	leafFunction, @function
leafFunction:
	endbr64
	push	rbp
	mov	rbp, rsp

	;
	; [RBP+144] Is the location of the struct Parameter passed in to leafFunction
	;	Base Pointer + 144, is the location of where the "AGE" value of the Struct is stored on the stack!
	;	Base Pointer + Some Value, describes something already pushed onto the stack
	;

	mov	DWORD PTR 144[rbp], 100
	nop

	pop	rbp
	ret
	.size	leafFunction, .-leafFunction
	.globl	main
	.type	main, @function
main:
	; Initializing stack frame
	endbr64
	push	rbp
	mov	rbp, rsp	
	sub	rsp, 160	; Allocating 160 Bytes for this functions stack frame 

	; This is not treading magic, this is something called !!! Stack Canaries !!!
	; This feature helps detect Stack Smashing, aka a buffer overflow!
	; Stack canarie is stored right at the bottom of the stack, Meaning any malicious code trying
	; to do a buffer overflow, probrally has to write over it to change the return address
	;		Thereby making sure the return address does not get modified by external treat actors!
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax		;
	xor	eax, eax

	; Assigns values to local variables
	; The creation of the structure "human1"

	; Moves string "Philip\0" into Struct
	movabs	rax, 123598092724304	; Moves The name "Philip", into RAX
	mov	edx, 0										; Moves end of string "\0" into EDX
	mov	QWORD PTR -160[rbp], rax		; "Philip"
	mov	QWORD PTR -152[rbp], rdx		; "\0"

	; Sets up Double and Float 
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
	mov	QWORD PTR -40[rbp], 0

	; Assigns Value to Integer "Age"
	mov	DWORD PTR -32[rbp], 19		; "Age" = 19

	; Sets up Double 
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0

	; Sets up Float 
	movss	xmm0, DWORD PTR .LC1[rip]
	movss	DWORD PTR -16[rbp], xmm0
	
	;
	;	Passes structure as a parameter to the leaf function
	; Pushes Structure onto the stack
	;
	push	QWORD PTR -16[rbp]
	push	QWORD PTR -24[rbp]
	push	QWORD PTR -32[rbp]
	push	QWORD PTR -40[rbp]
	push	QWORD PTR -48[rbp]
	push	QWORD PTR -56[rbp]
	push	QWORD PTR -64[rbp]
	push	QWORD PTR -72[rbp]
	push	QWORD PTR -80[rbp]
	push	QWORD PTR -88[rbp]
	push	QWORD PTR -96[rbp]
	push	QWORD PTR -104[rbp]
	push	QWORD PTR -112[rbp]
	push	QWORD PTR -120[rbp]
	push	QWORD PTR -128[rbp]
	push	QWORD PTR -136[rbp]
	push	QWORD PTR -144[rbp]
	push	QWORD PTR -152[rbp]
	push	QWORD PTR -160[rbp]	; 8 Bytes wide Qword, each item on the stack is in this case 8!

	;
	; The stack is Pushed to 19 Times!
	; This to allocate enought space to the structure passed.
	; Effectivly the struct is copied over from where its located... (the stack) over to the stack
	; BUT it does increment the RSP, this is important.
	;		IF you would like to pass / edit the already created STRUCT
	;		Pass in a pointer! 
	;

	call	leafFunction
	add	rsp, 152			; 19 * 8 = 152, Undooes the stack PUSH'ing

	; Health check the stack
	; Checks IF a stack overflow has occured, prevents stack smashing by the use of stack caneries
	mov	eax, 0
	mov	rcx, QWORD PTR -8[rbp]		; Checks if stack caneries is correct
	xor	rcx, QWORD PTR fs:40
	je	.L5												; If no buffer oferflow attack, then leave the function
	call	__stack_chk_fail@PLT			; Call stack check failed, if stack caneries check failed, aka a buffer overflow occured! 
.L5:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1090670464
	.align 4
.LC1:
	.long	1116798976
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
