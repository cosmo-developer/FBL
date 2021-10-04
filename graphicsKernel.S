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
%include 'asmlib/video.S'

graphics_Kernel:
	push si
	
	push word 0x0010
	call initialize_graphics
	push word 12;color
	push word 25;height
	push word 95;width
	push word 7
	push word 95
	call fill_box
	pop si
	pop si
	pop si
	pop si
	
	push word 0x010F
	push word 0x0000
	call set_cursor_pos
	
	mov ah,0x0e
	
	mov al,'I'
	mov bh,0x00
	mov bl,0xBC
	int 0x10
	mov al,'n'
	mov bh,0x00
	int 0x10
	mov al,'s'
	mov bh,0x00
	int 0x10
	mov al,'a'
	mov bh,0x00
	int 0x10
	mov al,'l'
	mov bh,0x00
	int 0x10
	mov al,'l'
	mov bh,0x00
	int 0x10
	
	pop si
	hlt


times 2048-($-$$) db 0