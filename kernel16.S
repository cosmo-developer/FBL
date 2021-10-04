;Occupie 3 sector of disk 1536 Bytes
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
%include 'asmlib/serialIO.S'


install_os:
	push bp
	mov bp,sp
	push si
	
	push word os_loader_area
	push word 0x0000; base address
	push word 0x0000;00 head 00 floppy
	push word 0x0005;00 cylinder 05 sector
	push word 0x0001;Number of sector
	call read_from_disk
	
	push word os_loader_area
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
<<<<<<< HEAD
	
	push word 0x0003;character_size
	push word 0x0001;stop_bits
	push word 0x0000;select_parity
	push word 0x0007;select_baud_rate
	push word 0x0000;com port1
	
	call intialize_serial_com_port
	;Sending data to COMPort1
	push word msg;buffer address
	push word 0x0000;com 1 port
	call write_on_serial_com_port
	
=======
>>>>>>> 4526cd4dfaf58cf012f60de57789f123f488b885
	push word msg
	call println
	push word user_msg
	call println
	push word input_buffer
	call take_input_while_not_enter
<<<<<<< HEAD
	call install_os
	hlt
=======


	call install_os
	
x:
	dw 0x00
y:
	dw 0x00

>>>>>>> 4526cd4dfaf58cf012f60de57789f123f488b885
msg:
	db "Kernel in 16 bit mode started",0xa,0xd,0x0
user_msg:
	db "Press Enter to install!",0x0

input_buffer:
	db 0,0

os_loader_area:
	times 512 db 0

spaced_area2:
	times 1536-($-$$) db 0