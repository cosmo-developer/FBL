%ifndef util_s
%define util_s
%include 'asmlib/math.S'
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
;Currently fault to be fixed
itoa:
	push bp
	mov bp,sp
	sub sp,4
	push si
	push di
	push bx
	mov di,itoa_buffer
	mov word [bp-2],0;itoa_buffer counter
	mov word [bp-4],0;number of digit
	
	;start
	push word [bp+4]
	call count_digit
	mov [bp-4],ax
	sub word [bp-4],1;lower than 1
	pop bx
	itoa_while_loop1_start:
		push word [bp-4]
		push word [bp+4]
		call get_digit_at
		mov si,ax
		mov ah,digit_ascii_table[si]
		mov byte [di],ah
		add di,1
		sub word [bp-4],1
		pop bx
		pop bx
		mov ax,[bp-4]
		cmp ax,0
		jg itoa_while_loop1_end
		jmp itoa_while_loop1_start
	itoa_while_loop1_end:
	add di,1
	mov byte [di],0x0
	mov ax,itoa_buffer
	;end
	
	pop bx
	pop di
	pop si
	add sp,4
	pop bp
	ret


;@param #1 number
;@param #2 index of digit base is 0
get_digit_at:
	push bp
	mov bp,sp
	sub sp,2
	push bx
	
	push word [bp+6]
	push word 10
	call pow16
	mov bx,[bp+4]
	mov [bp-2],ax
	div16 bx,[bp-2]
	mod16 ax,10
	pop bx
	pop bx
	
	pop bx
	add sp,2
	pop bp
	ret

digit_ascii_table:
	db 48,49,50,51,52,53,54,55,56,57
itoa_buffer:
	times 6 db 0

%endif