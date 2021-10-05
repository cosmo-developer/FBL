%ifndef timing_s
%define timing_s
;@param #1 High part of microseconds
;@param #2 Low part of microseconds
delay_t:
	push bp
	mov bp,sp
	push cx
	push dx
	push ax
	mov cx,[bp+4];High part
	mov dx,[bp+4];Low part
	mov ah,0x86
	int 0x15
	pop ax
	pop dx
	pop cx
	pop bp
	ret

%endif