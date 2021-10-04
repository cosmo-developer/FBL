;@param #1 disk number 0x00 for first floppy and 0x80 for first hard drive
reset_disk_system:
	push bp
	mov bp,sp
	
	push dx
	push si
	
	push word reset_disk_msg
	call println
	pop si
	
	mov ah,0x00
	mov dx,[bp+4]
	int 0x13
	jc report_error
	
	push word reset_succes
	call println
	pop si
	
	pop si
	pop dx
	pop bp
	ret

report_error:
	clc
	push word disk_io_failure_msg
	call println
	jmp $
;@param #1 number of sector to read
;@param #2 cylinder(high) sector(low)  Only for little endian
;@param #3 head(high) drive(low) little endian
;@param #4 base_address of data buffer
;@param #5 off_set of data buffer

read_from_disk:
	push bp
	mov bp,sp
	push cx
	push dx
	push es
	
	mov ax,[bp+4];number of sector 
	mov ah,0x02;targeting disk read function of int 13
	mov cx,[bp+6];cylinder number and sector
	mov dx,[bp+8]; head and drive
	mov es,[bp+10]; data buffer base_address
	mov bx,[bp+12]; off_set of data buffer
	int 0x13
	jc report_error
	pop es
	pop dx
	pop cx
	pop bp
	ret

;@param #1 number of sector to write
;@param #2 cylinder(high) sector(low)  Only for little endian
;@param #3 head(high) drive(low) little endian
;@param #4 base_address of data buffer
;@param #5 off_set of data buffer
write_in_disk:
	push bp
	mov bp,sp
	push cx
	push dx
	push es
	
	mov ax,[bp+4]
	mov ah,0x03
	mov cx,[bp+6]
	mov dx,[bp+8]
	mov es,[bp+10]
	mov bx,[bp+12]
	int 0x13
	jc report_error
	
	pop es
	pop dx
	pop cx
	pop bp
	ret
reset_disk_msg:
	db "Resetting floppy disk 0....",0xa,0xd,0x0
reset_succes:
	db "Disk reseted!",0xa,0xd,0x0
reset_failed:
	db "Disk Reset Failed!....",0xa,0xd,0x0
disk_io_failure_msg:
	db "Disk I/O Operation failed!",0xa,0xd,0x0