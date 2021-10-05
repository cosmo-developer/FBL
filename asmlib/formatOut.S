%ifndef format_out_s
%define format_out_s
%include 'asmlib/video.S'

count_digit:
	push bp
	mov bp,sp
	push dx
	push cx
	push bx
	
	mov ax,[bp+4];dividend
	mov cx,[bp+8];divisor
	
	start_count_digit:
	cmp ax,0
	je end_count_digit
	
	
	end_count_digit:
	
	pop bx
	pop cx
	pop dx
	pop bp

print_number:
	push bp
	mov bp,sp
	push ax
	
	pop ax
	pop bp
	
%endif