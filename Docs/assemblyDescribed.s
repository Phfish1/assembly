	.file	"test.c"
	.intel_syntax noprefix
	.text
	.globl	calee
	.type	calee, @function
calee:

	; Standard function handling
	; Sets up a new stack frame 
	endbr64					; Protects agains Control Flow Hijacking, when CET is enabled... Otherwise equals to a No Operation (NOP)
	push	rbp				; Saves the RBP of the caller function
	mov	rbp, rsp		; Moves the Bottom Pointer, (RBP) to the top of the caller function's Stack. (RSP)

	; [C1 Comment]:
	; THE CALLE has no "SUB RSP, N". This is because:
	; A function only needs to subtract its Stack Pointer (RSP) IF, it is going to call another function
	; This is because the calee() function in this case, is also going to be using the stack, and needs a reference point
	; to where it can start allocating variables. This is represented as the "MOV RBP, RSP" Instruction
	; If you dont subtract from the RSP, the RBP of the foo function would be the same as the main() function
	; Causing the calee() function to overwrite the Stack Frame of main()
	;
	;	That also means it is not necessary to subtract to SUBtract anything to the RSP if
	; the function is never calling another function. Because the Base pointer is at the end of the function
	; reverted back to the caller's Base Pointer. Resetting the Stack Frame back to the one held by the caller.
	;


	; Stores the arguments passed to the function on the stack
	; "long arg" = -24[rbp]
	mov	QWORD PTR -24[rbp], rdi			; RDI is the Register for the first argument

	; C-Code = "arg -= 1"
	sub	QWORD PTR -24[rbp], 1				; Subtracts 1 to the "arg" variable				

	; Sets up another function local variable, "-8[rbp] == testVar"
	mov	QWORD PTR -8[rbp], 3				; Sets local variable stored on stack equal to: "long 3"

	; Storing a local variable back into the RAX, register which is used as a RETURN value
	mov	rax, QWORD PTR -24[rbp]			; Return value equals to value stored in -24[rbp] / "long arg"

	; [C2 Comment]
	; The "MOV RSP, RBP" or rather the shorthand "leave" is in this case not needed.
	; This is because the Stack Pointer (RSP) is never modified, because it never needs to be. Why is described in [C1 Comment]
	; Although IF this function modified the RSP, (For example if making space for local variables because it calls other functions).
	; The Stack Pointer (RSP) would need to be reverted back to its original value of the caller functions stack frame.
	;		- MOV RSP, RBP		; (RBP) being the Top of the caller functions Stack / Stack Pointer (RSP)
	;

	;
	;	But "POP RBP" Instruction is still needed to revert the BASE POINTER back
	;

	; Removes the stack frame, and returns back to the location of the caler
	; The location of the caller is PUSHED in the stack when CALLING the function,
	; Then when returning the RET instruction POPS the return address from the stack
	pop	rbp				;	Pops the Caller functions Bottom stack Pointer back into RBP. Destroying this functions Stack Frame
	ret						; Pops the return address of the stack, and sets the Instruction Pointer to that value


	.size	calee, .-calee
	.globl	main
	.type	main, @function
main:
	; Sets up the functions stack pointer
	endbr64					; Security check, (CET)
	push rbp				; Stores the caller functions RBP onto the stack
	mov	rbp, rsp		; Prepeares a new Stack Frame

	; [C3 Comment]
	; Prepares / aligns the stack for CALLing
	; As part of the x86-64 System V ABI standard calling convention
	;
	; This defines the local variables the stack will hold
	; The stack is alligned 16 Bytes at a time, meaning if local variables take up more than 16 Bytes in the stack
	; another 16 bytes will be allocated to the stack
	; AKA -> the Stack Pointer (RSP) is Subtracted 32, instead of 16.
	; While it might only need just 24 Bytes of storage, the Stack Pointer should always be aligned by 16!
	; 
	; The Stack Pointer is alligned as much as the local functions variables need. Incrementing always by 16.
	;
	sub	rsp, 16			; Alligns the Stack Pointer 16 Bytes, enough to fit all of function Main's variables


	; Defines local variable to the stack
	mov	QWORD PTR -8[rbp], 1			;	Long = 1

	; Does addition on a local variable
	mov	rax, QWORD PTR -8[rbp]			;	Readies Local variable for addition by moving it into RAX register
	add	rax, 2											;	Adds to RAX, the imidiate value: 2 
	add	QWORD PTR -8[rbp], rax			; Saving the result of the addition PLUS the value already in the local variable back into itself.


	; Calls the function Calee with the local variable as an argument
	mov	rax, QWORD PTR -8[rbp]			; Prepares the local variable to 
	mov	rdi, rax										; Moves local variable stored in RAX, into the first argument (stored in RDI)
	call	calee											; Finally calls the function

	; [C4 Comment]
	; Returns from the main function with an error code of 0
	; The "leave" instruction is a shorthand for 2 other instructions:
	;		- MOV RSP, RBP			; Restoring the Stack Pointer to the value it had before calling, (callers RSP)
	;		- POP RBP						; Restoring the Base Pointer to the balue it had before calling, (callers RBP)
	;
	;	Why the leave instruction is needed is specified in [C2 Comment]. 
	; Basically because the RSP / Stack Pointer is modified by the "SUB RSP, 16" Instruction
	; Which is needed for the calee function to not override the calers local variales. 
	;		- By subtracting the RSP, and MOVing the calee's RBP as RSP.
	;

	mov	eax, 0			; Moves imidiate value of 0 into EAX / Return register
	leave						; Cleans up the Stack Frame, reverting (RSP) and (RBP) back to the callers values
	ret							; Returning, Aka. POPing from the stack into the Instruction register (RIP)



	; [BASICALLY Calling convention]:
	;	
	;	When function is not calling another function
	;		PUSH RBP
	;		MOV RBP, RSP
	;		...
	;		MOV RAX, 0
	;		POP RBP
	;		RET
	;
	;	When function IS calling another function
	;		PUSH RBP	
	;		MOV RBP, RSP
	; 	SUB RSP, N				; "N" = Bytes allocated for local variables, (Increments by 16)
	;		...
	;		MOV RAX, 0
	;		MOV RSP, RBP			; IMPORTANT to update RSP first,
	;		POP RBP						;	Or just use shorthand "LEAVE"
	; 	RET


	
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
