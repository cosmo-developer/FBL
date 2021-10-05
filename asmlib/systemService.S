%ifndef system_service_s
%define system_service_s
;reboot system
reboot_device:
    push bp
    mov sp,bp
    int 0x19
    pop bp
    ret
%endif