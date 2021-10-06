%ifndef math_s
%define math_s
;@param #1 base
;@param #2 exponent
;@return in ax as pow16(base,exponent)
pow16:
	push bp
	mov bp,sp
	
	sub sp,4 ;for two variable counter and result
	push bx
	mov word [bp-2],1 ;initialize counter variable to 1
	mov ax,[bp+4] ;base moved into ax register
	mov [bp-4],ax ;ax moved into local variable result
	
	pow16_while_loop1_start:
		mov ax,[bp-2];mov counter into ax
		cmp ax,[bp+6];compare counter with exponent
		je pow16_while_loop1_end;if counter reaches exponent then jump in end of this while loop
		push word [bp-4] ;Push base on stack as first argument to multiply16
		push word [bp+4] ;Push base on stack as second argument to multiply16
		call multiply16 ;return result*base
		mov word [bp-4],ax;result=multiply16(result,base)
		pop bx
		pop bx
		add word [bp-2],1
		
	pow16_while_loop1_end:
	mov ax,[bp-4];Save result in ax register
	pop bx
	add sp,4
	pop bp
	ret

;@param #1 first number
;@param #2 second number
;@return in ax as product
multiply16:
	push bp
	mov bp,sp
	push bx
	push dx
	
	mov ax,[bp+4]
	mov bx,[bp+6]
	mul bx
	
	pop dx
	pop bx
	pop bp
	ret

%endif