	.file	"returningMemory.c"
	.intel_syntax noprefix
	.text
	.globl	memoryFuncton
	.type	memoryFuncton, @function
memoryFuncton:
	endbr64
	push	rbp
	mov	rbp, rsp

	; The RBX register belongs to the CALER function, therefore it must be saved
	push	rbx
	sub	rsp, 168		; Does in this case does NOT take advantage of the RED ZONE

	; Stores the return address of 
	mov	QWORD PTR -168[rbp], rdi

	; Does threading magic
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -24[rbp], rax
	xor	eax, eax

	;
	; Creates a new struct as a local variable
	;

	; moves String "Philip\0" into struct
	movabs	rax, 123598092724304
	mov	edx, 0
	mov	QWORD PTR -160[rbp], rax
	mov	QWORD PTR -152[rbp], rdx

	; Fills up the rest of the CHAR descibed as 128 Bytes in the C source code
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

	; Moves into the struct "age" the value 19
	mov	DWORD PTR -32[rbp], 19

	;
	; "Returns" the struct of the function
	; What this effectivly does is modify the space on the stack which the calling function
	;	have already given it. [RBP-168] is where the pointer is stored
	;		The pointer pointing to [MAIN's RBP -144]
	;
	mov	rax, QWORD PTR -168[rbp]	; Store Pointer to return address in RAX

	;
	; Moves local variable structure into addresses given to it by CALLER in RDI
	;		Bascially moves local variable struct, into struct in MAIN, 
	;		which memoruFunction was given a pointer to as argument in RDI
	;
	mov	rcx, QWORD PTR -160[rbp]
	mov	rbx, QWORD PTR -152[rbp]
	mov	QWORD PTR [rax], rcx				; RAX here is used as a BASE
	mov	QWORD PTR 8[rax], rbx				; RAX+8 is equal to the next item on the stack dedicated to the CALER's STRUCT


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

	;
	; returns "age" property of struct
	; RAX+128 being the last index of our CALER's struct
	;		RAX stores pointer to CALER's local variable, RAX+128 is the last address dedicated to that local variable
	;		inside the CALER's stack frame
	; MAIN, passed the address to its local struct via RDI
	;
	mov	edx, DWORD PTR -32[rbp]
	mov	DWORD PTR 128[rax], edx					; Last address of CALER's local struct variable

	; does Threading magic
	mov	rax, QWORD PTR -24[rbp]
	xor	rax, QWORD PTR fs:40
	je	.L3
	call	__stack_chk_fail@PLT
.L3:

	; Returns back pointer the CALLERs local variable on the stack
	; 	IT returns a pointer one of MAIN's local variables, which it defined as an argument in RDI
	mov	rax, QWORD PTR -168[rbp]			; in -168[RBP] is stored a pointer to MAINs stack -144[MAIN's RBP]

	; Undoos it's stack
	add	rsp, 168

	; Restores RBX and RBP to CALER values
	pop	rbx
	pop	rbp
	ret				; Return gracefully
	.size	memoryFuncton, .-memoryFuncton
	.globl	main
	.type	main, @function
main:
	endbr64
	
	; Setup of stack frame
	push	rbp
	mov	rbp, rsp

	; For the local variable. mostly the STRUCT, WHERE the memoryFunction will return to  
	;		Question? Does the RSP get subtracted STIL IF it has no local variables in main
	;							Does the CALER still allocate memory on the stack for the CALEE's return value when it is type memory?
	; 
	sub	rsp, 160		

	; Threading magic
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	; This is the case where we RETURN A MEMORY CLASS value
	;
	; A pointer in this case, is a memory address on the stack frame of the main function which
	;	the callee (memoryFunction) will return it's struct address to.
	;

	;
	; It is of course an error if you return a calee's pointer to a local variable
	; If memoryFunction returned an address to it's local variable... Error
	;

	;
	; A function returning a memory address effectibly means that the function calling 
	; have to define a memory space on the stack, which the function can return into!
	; This memory location is (-8) -> (-144). [RBP -144] is passed into RDI like it is the first argument.
	; 	But this is the value which The callee will "return" to 
	;
	lea	rax, -144[rbp]		; Loads the Effective address of -144[rbp] into RAX
	mov	rdi, rax					; Loads address of main's stack into RAX
	mov	eax, 0
	call	memoryFuncton		; Calls function with address o

	; This is HUGE
	mov	eax, DWORD PTR -16[rbp]		; This refers to the Struct.age we defined
	mov	DWORD PTR -148[rbp], eax	


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
