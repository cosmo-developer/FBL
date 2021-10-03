;@param #1 com port
;@param #2 baud rate
;@param #3 parity non,odd,non,even
;@param #4 stop_bits
;@param #5 character_size
intialize_serial_com_port:
	push bp
	mov bp,sp
	push ax
	push dx
	
	mov ax,[bp+6];Baud rate
	mov dx,[bp+8];parity
	shl dl,3
	or al,dl
	mov dx,[bp+10];stop_bits
	shl dl,5
	or al,dl
	
	mov dx,[bp+12];character_size
	shl dl,6
	or al,dl
	
	mov ah,0x0
	mov dx,[bp+4]
	int 0x14
	
	pop dx
	pop ax
	pop bp
	ret

;@param #1 com port
;@param #2 character_to_transmit
test_write_com_port:
	push bp
	mov bp,sp
	push si
	push dx
	push ax
	
	mov dx,[bp+4]
	mov ax,[bp+6]
	mov ah,0x01
	int 0x14
	test ah,0x80
	jnz test_write_com_port_serial_write_error_start
	jmp test_write_com_port_end
	test_write_com_port_serial_write_error_start:
		push word serial_error_msg
		call println
		pop si
		jmp test_write_com_port_end	
	test_write_com_port_end:
	pop ax
	pop dx
	pop si
	pop bp
	ret

;@param #1 com port
;@param #2 buffer address
write_on_serial_com_port:
	push bp
	mov bp,sp
	push si
	push dx
	push ax
	
	mov dx,[bp+4]
	mov si,[bp+6]
	
	write_on_serial_com_port_start_sending:
		mov ah,0x01
		mov al,[si]
		cmp byte [si],0x00
		je write_on_serial_com_port_end_sending
		int 0x14
		test ah,0x80
		jnz write_on_serial_com_port_serial_write_error_start
		add si,1
		jmp write_on_serial_com_port_start_sending
	write_on_serial_com_port_end_sending:

	jmp write_on_serial_com_port_end_section
	
	write_on_serial_com_port_serial_write_error_start:
		push word serial_error_msg
		call println
		pop si
		jmp write_on_serial_com_port_end_section
		
	write_on_serial_com_port_end_section:
	pop ax
	pop dx
	pop si
	pop bp
	ret

serial_error_msg:
	db "COM error!",0x0a,0x0d,0x0