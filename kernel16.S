;Occupie 3 sector of disk 1536 Bytes
[org 0x7e00]
[bits 16]
xor ax,ax
mov ds,ax
cld
jmp start_kernel16
%include 'asmlib/diskIO.S'
%include 'asmlib/gdt.S'

start_kernel16:
	cli
	call load_gdtr
	mov eax,cr0
	or eax,1
	mov cr0,eax
	mov ax,0x10
	mov ds,ax
	mov es,ax
	mov fs,ax
	mov gs,ax
	mov ss,ax
	jmp 0x08:entering_protected_mode

[bits 32]
entering_protected_mode:
	mov ebp,stack_bottom
	mov esp,ebp
	cli
	mov byte [0xb8000],'A'
	mov byte [0xb8001],0xAC
	mov byte [0xb8002],'C'
	mov byte [0xb8003],0xca
	jmp $
	

stack_top:
times 20480 db 0
stack_bottom:

times 65536-($-$$) db 0