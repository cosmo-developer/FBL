[org 0x7c00]
[bits 16]
xor ax,ax
mov ds,ax
cld
jmp start_16

%include 'asmlib/diskio.S'
%include 'asmlib/video.S'

mov bp,sp
start_16:
	call clear_screen
	push word msg
	call println
	push word 0x7e00
	push word 0x0000
	push word 0x0000
	push word 0x0002
	push word 0x0002
	call read_from_disk
	jmp 0x7e00
	
msg:
	db "Booting...",0xa,0xd,0x0
	
input_buffer:
	times 10 db 0


times 510-($-$$) db 0
dw 0xaa55