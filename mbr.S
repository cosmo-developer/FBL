[org 0x7c00]
[bits 16]
xor ax,ax
mov ds,ax
cld
jmp start_16
%include 'asmlib/video.S'
%include 'asmlib/diskio.S'
mov bp,sp
start_16:
	call clear_screen
    push word msg
	call println
	
	push word 0x0000
	call reset_disk_system
	
	push word 0x7e00
	push word 0x0000
	push word 0x0000;first hard drive
	push word 0x0002; cylinder 0 sector 2
	push word 0x0001; number of sector to read
	call read_from_disk
	
	push word 0x7e00
	push word 0x0000
	push word 0x0000;first hard drive
	push word 0x0001; cylinder 0 sector 1
	push word 0x0001; number of sector to write
	call write_in_disk
	
	
msg:
	db "Booting...",0xa,0xd,0x0

times 510-($-$$) db 0
dw 0xaa55