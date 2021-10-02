[org 0x7e00]
[bits 16]
jmp start_kernel
xor ax,ax
mov ds,ax
cld
%include 'asmlib/video.S'
%include 'asmlib/diskio.S'

start_kernel:
	push word msg
	call println
	
msg:
	db "Kernel in 16 bit mode started",0xa,0xd,0x0
times 510-($-$$) db 0