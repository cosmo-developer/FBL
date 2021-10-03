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
draw_box:
    push bp
    mov bp,sp
    
    pop bp
    ret