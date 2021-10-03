take_input:
	push bp
	mov sp,bp
	push ax
	mov ah,0x0
	int 0x16
	int 0x10
	pop ax
	pop bp
	ret

take_input_while_not_enter:
	push bp
	mov bp,sp
	push ax
	push si
	push di
	push dx
	
	
	mov si,[bp+4]
	mov di,si
	keyboard_input_loop_start:
		mov ah,0x00
		int 0x16
		cmp ah,0x1c
		je keyboard_input_loop_end
		cmp ah,0x0e
		je back_space_handle
		mov ah,0x0e
		int 0x10
		mov byte [si],al
		add si,1
		jmp keyboard_input_loop_start
	
	back_space_handle:
		cmp di,si
		je keyboard_input_loop_start
		sub si,1
		mov ah,0x0e
		int 0x10
		mov dl,al
		mov al,' '
		int 0x10
		mov al,dl
		int 0x10
		jmp keyboard_input_loop_start
	
	keyboard_input_loop_end:
		mov ah,0x0e
		mov al,0x0a
		int 0x10
		mov al,0x0d
		int 0x10
		mov byte [si],0x0
		
	pop dx
	pop di
	pop si
	pop ax
	pop bp
	ret