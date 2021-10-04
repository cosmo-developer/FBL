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
%include 'asmlib/systemService.S'
%include 'asmlib/timing.S'


install_os:
	push bp
	mov bp,sp
	push si
	
	push word os_loader_area
	push word 0x0000; base address
	push word 0x0000;00 head 00 floppy
	push word 0x0006;00 cylinder 06 sector
	push word 0x0001;Number of sector
	call read_from_disk
	pop si
	pop si
	pop si
	pop si
	pop si
	

	push word os_loader_area
	push word 0x0000
	push word 0x0080
	push word 0x0001
	push word 0x0001
	call write_in_disk
	pop si
	pop si
	pop si
	pop si
	pop si
	
	pop si
	pop bp
	ret

start_kernel16:
	call clear_screen
	push word msg
	call println
	push word user_msg
	call println
	push word input_buffer
	call take_input_while_not_enter
	call install_os
	push word reboot_msg
	call println
	push word 0xc6c0
	push word 0x002d
	call  delay_t
	call reboot_device
msg:
	db "Kernel in 16 bit mode started",0xa,0xd,0x0
user_msg:
	db "Press Enter to install!",0x0

input_buffer:
	db 0,0
reboot_msg:
	db "Rebooting device...!",0xa,0xd,0x0
os_loader_area:
	times 512 db 0

spaced_area2:
	times 2048-($-$$) db 0