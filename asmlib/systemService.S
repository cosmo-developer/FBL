;reboot system
reboot_device:
    push bp
    mov sp,bp
    int 0x19
    pop bp
    ret