	.file	"notStoringReturnValue.c"
	.intel_syntax noprefix
	.text
	.globl	memoryFunction
	.type	memoryFunction, @function
memoryFunction:
	; Setup a stack frame with enough memory to host local struct variable
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160


	; Stores Return address of struct in -152[RBP]
	; This is the location which this Callee function will return its struct into
	mov	QWORD PTR -152[rbp], rdi			

	; Threading magic
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	; Moves "Philip\0" into local variable on the stack frame
	movabs	rax, 123598092724304		; "Philip"
	mov	edx, 0											; "\0"
	mov	QWORD PTR -144[rbp], rax		; Stores "Philip" the stack
	mov	QWORD PTR -136[rbp], rdx		; Store "\0" on the stack
	mov	QWORD PTR -128[rbp], 0			; Store padding for the 128-Bytes char on the stack
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
	mov	QWORD PTR -32[rbp], 0 	; 15 * 8(QWORDs) = 120 Bytes
	mov	WORD PTR -24[rbp], 0		; 120 + 2(Word) = 122 Bytes
	mov	BYTE PTR -22[rbp], 0		; 120 + 1(Byte) = 123 Bytes		; Rest of bytes are gone or something idk

	mov	DWORD PTR -20[rbp], 19	; Moves 19, a DWORD(4 Bytes) / Integer into local variable on stack -20[RBP]
	
	;
	; HOLD UP!!! Some documentation in this file is wront, Since memoryFunction does not return anything,
	; The Function does not write to the callers address, but lets imagine it does
	; It would look something like this

			mov	rax, QWORD PTR -168[rbp]	; Store address to write to(callers stack frame addr) into RAX

			; YOU CANNOT Move Memory from Memory, Therefore
			;		You must first move from Memory -> to -> Register,
			; 	Then from Register -> to -> Memory 
			mov	rcx, QWORD PTR -160[rbp]	; move local variables into RCX
			mov	rbx, QWORD PTR -152[rbp]	; AND RBX
			mov	QWORD PTR [rax], rcx			; Store them into the Callers local variable
			mov	QWORD PTR 8[rax], rbx			;	on Main's stack frame.

	; Note that since RBX is used here, it would need to be pushed onto the stack at the begining and popped at the end
	;		This only because RBX belong's to the caller, and must be restored by any callee functions!
	;

	nop ; Maybe required for threading magic idk, Does nothing...

	; Threading magic again
	mov	rax, QWORD PTR -8[rbp]
	xor	rax, QWORD PTR fs:40
	je	.L2
	call	__stack_chk_fail@PLT
.L2:

	; Leaves the function with the address of the CALLER's local variable as the return value
	; RAX equals the CALLERs effective address on its stack frame, which is allocated to the returning struct
	mov	rax, QWORD PTR -152[rbp]		; Main's stack frame address where memoryFunction returns it's struct into

	leave
	ret
	.size	memoryFunction, .-memoryFunction
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp

	;
	; Even though return value is never stored in a local variable accessable to the source code
	; it is still stored on Main's stack, as a "hiden" local variable, only accessible via assembly ( -144[RBP] )!
	;		THIS IS WHY Return values should ALWAYS be accounted for in the source code!!!
	;
	sub	rsp, 144

	; Threading magic
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	;
	; Address -144[RBP] represents memory allocated on the stack for returning struct
	;		Loads effective address as argument to memoryFunction into RDI 
	;	This happens, EVEN though this local variable is NEVER accesible in the source code!!!
	;
	lea	rax, -144[rbp]
	mov	rdi, rax
	mov	eax, 0
	call	memoryFunction

	;
	; Struct which returnMemory modified is now stored on Main's stack frame
	;	But it has no variable anywhere in the C source code where it can be referenced!
	; 

	; DO threading magic
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	xor	rdx, QWORD PTR fs:40
	je	.L5		; Jump to exit function
	call	__stack_chk_fail@PLT
.L5:

	; Exits program to _start
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
