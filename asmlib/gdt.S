%ifndef gdt_S
%define gdt_S

gdt_start_ptr:
	null_descriptor:
		dd 0x00
		dd 0x00
	kernel_code_descriptor:
		dw 0xffff ;first 16 bit limit
		dw 0x0000 ; first 16 bit base
		db 0x00   ;8 bit base
		db 10011010b
		db 11001111b
		db 0x00
	kernel_data_descriptor:
		dw 0xffff ;first 16 bit limit
		dw 0x0000 ; first 16 bit base
		db 0x00   ;8 bit base
		db 0b10010010
		db 0b11001111
		db 0x00
gdt_end_ptr:

gdt_descriptor:
	dw gdt_end_ptr-gdt_start_ptr-1;This is the size of gdt
	dd gdt_start_ptr
KERNEL_CODE_SEG equ kernel_code_descriptor-gdt_start_ptr
KERNEL_DATA_SEG equ kernel_data_descriptor-gdt_start_ptr

load_gdtr:
	push bp
	mov bp,sp
	lgdt [gdt_descriptor]
	pop bp
	ret

%endif