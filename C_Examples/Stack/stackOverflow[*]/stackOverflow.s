	.file	"stackOverflow.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC1:
	.string	"%d\n"		; Our input to printf()
	.align 32					
.LC0:								; This section just describes our array variable
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.quad	9
	.quad	10
	.text
	.globl	recursive
	.type	recursive, @function

recursive:
	; Sets up the stack frame for the function
	endbr64
	push	rbp
	mov	rbp, rsp

	; This describes how many bytes on the stack we dedicate to our Stack Frame.
	sub	rsp, 1552				; 1552 Bytes 


	mov	DWORD PTR -1540[rbp], edi			; This saves our Parameter "count", an INTEGER / DoubleWord to the stack

	; Saves the value of some Segment register FS:40 and places it onto the stack -8[RBP]
	mov	rax, QWORD PTR fs:40					; FS = A segment register, points to something to do with threading
	mov	QWORD PTR -8[rbp], rax				; Saves this value on the stack
	xor	eax, eax											; Clears the EAX Register

	; Prepares addresses for the MOVSQ instruction
	lea	rax, -1536[rbp]								; Moves the address where the array will start at the stack into RAX
	lea	rdx, .LC0[rip]								; Moves Array address into RDX / the address of the label "LC0" into RDX
	
	; Copies a block of memory data from the location .LC0, into the stack
	;	The MOVSQ instruction will move 8 Bytes (Qword) at a time then:
	;		- Incrementing RAX by 8, making space for another Qword on the stack
	;		- Incrementing RDX, moving 8 Bytes down the label
	; A Qword since that is what is defined in the source.c file to be items of the array, ("LONG" / Qword / 8 Bytes)
	;
	mov	ecx, 190											; How many times to do REPeat, Moves the number of items in the array into ECX
	mov	rdi, rax											; Argument-1, DESTINATION Address
	mov	rsi, rdx											; Argument-2, SOURCE Address
	rep movsq										; Repeats 190 times, MOV address of RSI into address of RDI, then increment them both by 8



	; Setups and calls the printf function
	mov	eax, DWORD PTR -1540[rbp]		; Mov our Parameter "count" into EAX
	mov	esi, eax										; Mov Parameter into ESI, Argument-1 / ESI for printf

	lea	rdi, .LC1[rip]							; Loads the address of the string input for printf into argument-2 / RDI
	mov	eax, 0											; Tells the calee / printf that "0" floating point registers are used (System V ABI standard)
																	; Needed because printf also takes in floating point numbers: "printf("%f", 3.14)"
	call	printf@PLT								; Call the printf function

	; Sets up function call recursive with "count+1" 
	; And then... call itself / recursive()
	mov	eax, DWORD PTR -1540[rbp]			; MOV count into EAX
	add	eax, 1												; Add to count 1, into RAX
	mov	edi, eax											; MOV count+1 / RAX into RDI / Argument register
	call	recursive									; Call itself


	; Checks if the stack failed, probably if infinite recursion...
	; And dooes some threading magic maybe
	nop																; Does nothing
	mov	rdx, QWORD PTR -8[rbp]				; Moves the old FS:40 stored in -8[RBP] into RDX
	xor	rdx, QWORD PTR fs:40					; Then XOR the old FS:40 with the current FS:40
je	.L2															; IF the XOR == 0 / IF the new FS:40 == the old FS:40 then JUMP to .L2
	call	__stack_chk_fail@PLT			; ELSE call stack check fail, the stack failed probably XD

.L2:					; If stack did NOT fail, yipiii
	leave				; Clean up the stack frame
	ret					; And leave the function
	
	; Random shit for ld / linker or something no yummy!
	.size	recursive, .-recursive
	.globl	main
	.type	main, @function


main:
	; Sets ut the function
	endbr64
	push	rbp
	mov	rbp, rsp

	; Calls recursive with ar argument of 0
	mov	edi, 0
	call	recursive

	; Exits the program
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
