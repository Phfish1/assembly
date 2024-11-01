	.file	"stringVuln.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"You won!"
	.text
	.globl	exploit
	.type	exploit, @function
exploit:
	endbr32
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 4
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	sub	esp, 12
	lea	edx, .LC0@GOTOFF[eax]
	push	edx
	mov	ebx, eax
	call	puts@PLT
	add	esp, 16
	nop
	mov	ebx, DWORD PTR -4[ebp]
	leave
	ret
	.size	exploit, .-exploit
	.globl	vulnrableFunction
	.type	vulnrableFunction, @function
vulnrableFunction:
	; Setup stack and store caller registers
	endbr32
	push	ebp				;
	mov	ebp, esp		; setup new stack frame
	push	ebx				; Store caller register
	sub	esp, 20			; Make room for local variables

	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_

	;
	; When you access -?[EBP] it refers to local variables
	;	Access +?[EBP] it refers to function parameters
	;

	;
	; Minus 16 is due to:
	;		- 4 For stack alignment (ALL 0 value: 0x00000000)
	;		- 4 For callers EBX (Pushed onto stack in function prolouge)
	;		- 8 For the buffer address :)
	;

	sub	esp, 12					; Modify stack pointer to push into a sa
	lea	edx, -16[ebp]			; Load address of buffer into	
	push	edx
	mov	ebx, eax
	call	gets@PLT
	add	esp, 16

	nop
	mov	ebx, DWORD PTR -4[ebp]
	leave
	ret

	.size	vulnrableFunction, .-vulnrableFunction
	.globl	main
	.type	main, @function
main:
	endbr32
	lea	ecx, 4[esp]
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	ecx

	sub	esp, 4
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_

	sub	esp, 12
	push	1
	call	vulnrableFunction
	add	esp, 16
	mov	eax, 0
	mov	ecx, DWORD PTR -4[ebp]
	leave
	lea	esp, -4[ecx]
	ret


	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
