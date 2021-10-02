clear_screen:
	push ax
	mov ah,0x00
	mov al,0x03
	int 0x10
	pop ax
	ret

print_new_line:
	push ax
	mov ah,0x0e
	mov al,0xa
	int 0x10
	mov al,0x0d
	int 0x10
	pop ax
	ret

print_string:
	push ax
	push si
	mov ah,0x0e
	start_print:
		mov al,[si]
		cmp al,0
		je end_print
		int 0x10
		add si,1
		jmp start_print
	end_print:
	pop si
	pop ax
	ret

set_cursor_pos:
	

set_cursor_shape:
	push bp
	mov bp,sp
	push ax
	push cx
	mov ah,0x01
	mov cx,[bp+4]
	int 0x10
	pop cx
	pop ax
	pop bp
	ret
	
println:
	push bp
	mov bp,sp
	push si
	mov si,[bp+4]
	call print_string
	pop si
	pop bp
	ret