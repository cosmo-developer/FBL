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
%include 'asmlib/mouse.S'
%include 'asmlib/util.S'
%include 'asmlib/math.S'


graphics_Kernel:
	push si
	
	push word 0x0010
	call initialize_graphics
	push word testmg
	call println
	mov bl,0x19
	call init_mouse_driver
	pop si
	pop si
	pop si
	
	push word 3
	push word 2547
	call get_digit_at
	push ax
	call itoa
	
	jmp end_section
	
	success_section:
	push word testmg
	call println
	
	pop si
	end_section:
	hlt

testmg:
	db "Hello World!",0x0a,0x0d,0x0
times 2048-($-$$) db 0