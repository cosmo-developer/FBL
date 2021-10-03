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
	push ax
	push word 0x0010
	call initialize_graphics
	pop ax
	start:
	push word 0x0007
	push word 0x0000
	push word [y]
	push word [x]
	call put_pixel
	add word [x],1
	add word [y],1
	pop ax
	pop ax
	pop ax
	pop ax
	jmp start


x:
	dw 0x0000
y:
	dw 0x0000

msg:
	db "Kernel in 16 bit mode started",0xa,0xd,0x0
user_msg:
	db "Press Enter to install!",0x0

spaced_area:
	times 1024-($-$$) db 0
spaced_area2:
	times 1536-($-$$) db 0