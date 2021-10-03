[org 0x7e00]
[bits 16]
jmp start_kernel16
xor ax,ax
mov ds,ax
cld
%include 'asmlib/basicVideoService.S'
%include 'asmlib/video.S'
%include 'asmlib/diskIO.S'
%include 'asmlib/keyboard.S'
%include 'asmlib/graphics.S'


install_os:
	push bp
	mov bp,sp
	push si
	
	push word spaced_area
	push word 0x0000; base address
	push word 0x0000;00 head 00 drive
	push word 0x0005;00 cylinder 04 sector
	push word 0x0001;Number of sector
	call read_from_disk
	
	push word spaced_area
	push word 0x0000
	push word 0x0080
	push word 0x0001
	push word 0x0001
	call write_in_disk
	
	pop si
	pop bp
	ret

start_kernel16:
	call clear_screen
	mov ah,0x00
	mov al,0xd
	int 0x10
	push word msg
	call println
	push word user_msg
	call println
	call take_input_while_not_enter

	int 0x10
	push word 0x00f0;color
	push word 0x0000;page
	push word 0x0020;y
	push word 0x0010;x
	set_color:
	call put_pixel
	pop si
	pop si
	pop si


	;call install_os
	

x:
	dw 0x00
y:
	dw 0x00

msg:
	db "Kernel in 16 bit mode started",0xa,0xd,0x0
user_msg:
	db "Press Enter to install!",0x0

spaced_area:
	times 1024-($-$$) db 0
spaced_area2:
	times 1536-($-$$) db 0