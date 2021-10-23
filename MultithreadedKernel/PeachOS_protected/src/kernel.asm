[BITS 32]               ; code here is seen as 32 bit code

global _start
;global problem

extern kernel_main

DATA_SEG equ 0x10
CODE_SEG equ 0x08

_start:
    mov ax, DATA_SEG    ; setting data registers
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp        ; setting stack pointer

    ; Enable a A20 line
    in al, 0x92         ; reads in 0x92 processor bus
    or al, 2            
    out 0x92, al        ; writes on 0x92 processor bus

    ;remap the master PIC
    mov al, 0010001b
    out 0x20, al        ; tell master PIC

    mov al, 0x20        ; inteerput 0x20 where master ISR should start
    out 0x21, al

    mov al, 00000001b
    out 0x21, al
    ; end remap of the master PIC

    ; sti                 ; enable the interrypts

    call kernel_main

    jmp $

;problem:           ;to check if idt 0 is loaded or not
    ;mov eax, 0
    ;div eax

    ;int 0

times 512 -($ - $$) db 0