%ifndef math_s
%define math_s
;@param #1 base
;@param #2 exponent
;To be fixed not working currently
pow16:
	push bp
	mov bp,sp
	sub sp,4
	mov word [bp-2],1
	mov ax,[bp+4]
	mov word [bp-4],ax
	pow16_while_loop1_start:
		mov ax,[bp-2];counter
		cmp ax,[bp+6];exponent compared with counter
		je pow16_while_loop1_end;jump on end of this loop if counter reached exponent
		mov ax,[bp+4]
		mul word [bp-4]
		mov word [bp+4],ax
		add word [bp-2],1
	pow16_while_loop1_end:
	mov ax,[bp+4]
	add sp,4
	pop bp
	ret


%endif