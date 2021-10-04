[org 0x7e00]
[bits 16]
jmp graphics_Kernel
xor ax,ax
mov ds,ax
cld
%include 'asmlib/basicVideoService.S'
%include 'asmlib/diskIO.S'
%include 'asmlib/keyboard.S'
%include 'asmlib/graphics.S'
%include 'asmlib/serialIO.S'

graphics_Kernel:
	push si
	
	push word 0x0010
	call initialize_graphics
	push word 10
	push word 0x00AA
	push word 0x00AC
	push word 0x0001
	push word 0x00FF
	call draw_box
	pop si
	pop si
	pop si
	pop si
	
	pop si
	hlt


times 1536-($-$$) db 0