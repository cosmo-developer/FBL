[org 0x7c00]
[bits 16]
xor ax,ax
mov ds,ax
cld
jmp start_16

%include 'asmlib/diskIO.S'
%include 'asmlib/basicVideoService.S'

mov bp,sp
start_16:
	call clear_screen
	push word msg
	call println
	
	
	push word 0x7e00;offset
	push word 0x0000;base address
	push word 0x0000;head 0 floppy 0
	push word 0x0002;cylinder 0 sector 2
	push word 0x0003;number of sector to read
	call read_from_disk
	jmp 0x7e00
	
msg:
	db "Booting...",0xa,0xd,0x0
	
input_buffer:
	times 10 db 0


times 510-($-$$) db 0
dw 0xaa55