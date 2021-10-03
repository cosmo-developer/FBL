[org 0x7c00]
[bits 16]
jmp start
%include 'asmlib/basicVideoService.S'
start:
	cli
	call clear_screen
	push word msg
	call println
	push word msg2
	call println
	hlt

msg:
	db "Loading FibreOS-i386....",0xa,0xd,0x0
msg2:
	db "Ready Opening Operating System...",0xa,0xd,0x0

times 510-($-$$) db 0
dw 0xaa55