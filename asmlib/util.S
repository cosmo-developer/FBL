%ifndef util_s
%define util_s
;@param #1 string buffer address end with 0x0 byte
strlen:
	push bp
	mov bp,sp
	sub sp,2
	mov word [bp-2],0
	strlen_while_1_start:
		cmp byte [bp+4],0x0
		je strlen_while_1_end
		add word [bp-2],1
		jmp strlen_while_1_start
	strlen_while_1_end:
	mov ax,[bp-2]
	add sp,2
	pop bp
	ret

;@param #1 integer number
count_digit:
	push bp
	mov bp,sp
	;counter
	sub sp,2
	mov word [bp-2],0
	
	push dx
	push cx
	
	count_digit_while1_start:
		cmp word [bp+4],0
		je count_digit_while1_end
		mov dx,0; clear dividend flag high
		mov ax,[bp+4]; dividend low
		mov cx,0xA;divisor 
		div cx
		sub word [bp+4],dx
		mov dx,0
		mov ax,[bp+4]
		mov cx,0xA
		div cx
		mov [bp+4],ax
		add word [bp-2],1
		jmp count_digit_while1_start
	count_digit_while1_end:
	mov ax,[bp-2];Result stored inside ax register
	pop cx
	pop dx
	add sp,2
	pop bp
	ret
	


;@param #1 integer number
itoa:
	push bp
	mov bp,sp
	sub sp,4
	mov word [bp-2],0;itoa_buffer counter
	mov word [bp-4],0;number of digit
	push si
	push ax
	;start
	push word [bp+4]
	call count_digit
	mov [bp-4],ax
	pop si
	
	
	
	;end
	pop ax
	pop si
	add sp,4
	pop bp
	ret

digit_ascii_table:
	db 48,49,50,51,52,53,54,55,56,57
itoa_buffer:
	times 6 db 0

%endif