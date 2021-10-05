%ifndef mouse_s
%define mouse_s

init_mouse_driver:
	push bp
	mov bp,sp
	mov ax,0x0000
	int 0x33
	mov ax,0x0000
	int 0x33
	cmp ax,0x0000
	je init_mouse_driver_if1
	jmp init_mouse_driver_end
	init_mouse_driver_if1:
		call show_mouse_error_1msg
		jmp init_mouse_driver_end
	init_mouse_driver_else1:
		call show_mouse_success_msg
	init_mouse_driver_end:
	pop bp
	ret
;@param get mouse X
update_mouse_coord:
	push bp
	mov bp,sp
	
	push bx
	push cx
	push dx
	
	mov ax,0x0003
	int 0x33
	mov [mouse_x_coord],cx
	mov [mouse_y_coord],dx
	
	pop dx
	pop cx
	pop bx
	
	pop bp
	ret
	
show_mouse_error_1msg:
	push bp
	mov bp,sp
	push si
	push word mouse_error_1msg
	call println
	pop si
	pop si
	pop bp
	ret

show_mouse_success_msg:
	push bp
	mov bp,sp
	push si
	push word mouse_success_msg
	call println
	pop si
	pop si
	pop bp
	ret

mouse_device_struct:
	mouse_error_1msg:
		db "Mouse Hardware/Driver Not Installed!",0x0a,0x0d,0x0
	mouse_success_msg:
		db "Mouse Driver Installed",0x0a,0x0d,0x0
	number_of_buttons:
		db 0x0
	button_status:
		dw 0x0000
	mouse_x_coord:
		dw 0x0000
	mouse_y_coord:
		dw 0x0000
end_mouse_struct:
MOUSE_DEVICE_STRUCT_SIZE equ end_mouse_struct-mouse_device_struct-1

%endif