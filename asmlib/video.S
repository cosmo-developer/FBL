%ifndef video_s
%define video_s
;@param #1 pagenumber
;@param #2 row(8 bit high part) column(8 bit low part)
set_cursor_pos:
	push bp
	mov bp,sp
	push ax
	push bx
	push dx

	mov ah,0x02
	mov bx,[bp+4]
	mov bh,bl
	mov dx,[bp+6]
	int 0x10

	pop dx
	pop bx
	pop ax
	pop bp
	ret
;@return 16 bit data 8high bit for row and 8 low bit for column
get_cusor_pos:
	push bp
	mov bp,sp
	push dx
	mov ah,0x04
	int 0x10
	mov ax,dx
	pop dx
	pop bp
	ret

;@return 16 bit data 8high bit for start scan line and 8 low bit for end scan line
get_cusor_shape:
	push bp
	mov bp,sp
	push cx
	mov ah,0x04
	int 0x10
	mov ax,cx
	pop cx
	pop bp
	ret

;@param #1 cursor shape scan lines
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

;@param #1 page number
set_active_page:
	push bp
	mov bp,sp
	push ax
	mov ax,[bp+4]
	mov ah,0x05
	int 0x10
	pop ax
	pop bp
	ret

;@param #1 what to print (a byte)
;@param #2 number of times to print(2 byte)
;@param #3 page number
;not working curently
print_repeat:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx

	mov ax,[bp+4]
	mov cx,[bp+6]
	mov bx,[bp+8]
	mov bh,bl
	mov ah,0x0a
	int 0x10
	pop cx
	pop bx
	pop ax
	pop bp
	ret

%endif