[org 0x7c00]
[bits 16]
xor ax,ax
mov ds,ax
cld
jmp 0x000:start_16
%include 'asmlib/video.S'
%include 'asmlib/diskio.S'

mov bp,sp
start_16:
    call clear_screen
    push word msg
	call println
	push 0x0607
	call set_cursor_shape
	push word 0x0000
	call reset_disk_system
	push word loading_kernel_16
	call println
	
	push word 0x7e00;offset address
	push word 0x0000;base address
	push word 0x0000;head and drive
	push word 0x0002;cylinder and sector
	push word 0x0001;number of sector on lower byte
	call read_from_disk
	
	push kernel_16_success
	call println
	jmp  0x7e00

msg:
	db "-----------------------Welcome to Fibre-Boot-Manager----------------------------",0xa,0xd,0x0
loading_kernel_16:
	db "Loading kernel from 2nd sector",0xa,0xd,0x0
kernel_16_success:
	db "Kernel 16 loaded successfully",0xa,0xd,0x0
times 510-($-$$) db 0
dw 0xaa55