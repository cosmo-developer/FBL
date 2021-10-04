;@param #1 mode
initialize_graphics:
    push bp
    mov bp,sp
    push ax
    mov ax,[bp+4]
    mov ah,0x00
    int 0x10
    pop ax
    pop bp
    ret

;@param #1 x
;@param #2 y
;@param #3 page number
;@param #4 color
put_pixel:
    push bp
    mov bp,sp
    push ax
    push bx
    push cx
    push dx

    mov cx,[bp+4];x coordinate
    mov dx,[bp+6];y coordinate
    mov bx,[bp+8]; page number
    mov bh,bl
    mov ax,[bp+10]
    mov ah,0x0c
    int 0x10

    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret
;@param #1 x
;@param #2 y
;@param #3 width
;@param #4 height
;@param #5 color
draw_box:
    push bp
    mov bp,sp
	sub sp,8
	push ax
	push dx
	mov ax,[bp+4]
	mov  word [bp-2],ax;xcounter
	mov ax,[bp+6]
	mov  word [bp-4],ax;ycounter
	mov ax,[bp+8]
	mov  word [bp-6],ax;width
	mov ax,[bp+10]
	mov  word [bp-8],ax;height
	
	mov ax,[bp+4]
	add word [bp-6],ax
	mov ax,[bp+6]
	add word [bp-8],ax
	
	draw_box_for_loop_start_x:
		mov dx,[bp-2]
		push word [bp+12];Color
		push word 0x0000;Page
		push word [bp-4];Y
		push word [bp-2];X
		call put_pixel
		pop si
		pop si
		pop si
		pop si
		
		push word [bp+12]
		push word 0x0000
		push word [bp-8]
		push word [bp-2]
		call put_pixel
		pop si
		pop si
		pop si
		pop si
		
		add word [bp-2],1
		cmp dx,[bp-6]
		jle draw_box_for_loop_start_x
		
	draw_box_for_loop_start_y:
		mov dx,[bp-4];y counter
		push word [bp+12];Color
		push word 0x0000;Page
		push word [bp-4];Y
		push word [bp-2];X
		call put_pixel
		pop si
		pop si
		pop si
		pop si
		
		push word [bp+12];Color
		push word 0x0000;Page
		push word [bp-4];Y
		push word [bp-8];X+width
		call put_pixel
		pop si
		pop si
		pop si
		pop si
		
		add word [bp-4],1
		cmp dx,[bp-8]
		jle draw_box_for_loop_start_y
	draw_box_end_section:
	
	pop dx
	pop ax
	add sp,8
    pop bp
    ret