ORG 0x7c00
BITS 16                 ; this is for 16 bits

CODE_SEG equ gdt_code - gdt_start       ; gives 0x8 offset
DATA_SEG equ gdt_data - gdt_start       ; give 0x10 offset


_start:
    jmp short start     ; make a short jump to start label
    nop

times 33 db 0           ; fill 33 bytes to prevent code getting corrupt
                        ; bios parameter block

start:
    jmp 0:step2     ; to make cs point to 0x7c0
    
step2:
    cli                 ; clear interrupts
    mov ax, 0x00
    mov ds, ax          ; to make data reg point to 0x7c0 
    mov es, ax          ; to make extra reg point to 0x7c0
    mov ss, ax          
    mov sp, 0x7c00      ; to make stack pointer point to 0x7c0   
    sti                 ; enables interrupts

; ------------------------------- Global Descripter Table -----------------

load_protected:
    cli
    lgdt[gdt_descriptor]    ; load the descriptor table
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:load32     ;code_seg is replced by 0x8 nd then jump to load32

gdt_start:

gdt_null:               ; null descriptor
    dd 0x0
    dd 0x0

gdt_code:               ; offset 0x8 of code descriptor, CS points
    dw 0xffff           ; segmenet limit of first 0-15 bits
    dw 0                ; base first 0-15 bits
    db 0                ; base 16-23 bits
    db 0x9a             ; access byte
    db 11001111b        ; high 4 bit flags and low 4 bits flags
    db 0                ; base 24-32 bits

gdt_data:               ; offset 0x10 for DS,SS,ES,FS,GS
    dw 0xffff           ; segmenet limit of first 0-15 bits
    dw 0                ; base first 0-15 bits
    db 0                ; base 16-23 bits
    db 0x92             ; access byte
    db 11001111b        ; high 4 bit flags and low 4 bits flags
    db 0                ; base 24-32 bits

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


[BITS 32]               ; code here is seen as 32 bit code
load32:
    mov eax, 1          ; load from sector 1 not0 cuz that is boot sector
    mov ecx, 100        ; number of sectors to load
    mov edi, 0x0100000  ; address where I need to load the sectors
    call ata_lba_read
    jmp CODE_SEG:0x0100000

ata_lba_read:
    mov ebx, eax        ; backup of lba
    ; send the highest 8 bits of thelba to hard disk controller
    shr eax, 24
    or eax, 0xE0        ; selects the master drive       
    mov dx, 0x1F6
    out dx, al
    ; finished sending the hifhest 8 bits of the lba

    ; send the total sectors to read
    mov eax, ecx
    mov dx, 0x1F2
    out dx, al
    ; finished sending the total sectors to read

    ; send more bits of lba
    mov eax, ebx        ; restore the bakup lba
    mov dx, 0x1F3
    out dx, al
    ; finished sending the more bits of lba

    ; send more bits of lba
    mov dx, 0x1F4
    mov eax, ebx        ; restore he bakup lba
    shr eax, 8
    out dx, al
    ; finished sending the more bits of lba

    ; send the upper 16 bits of lba
    mov dx, 0x1F5
    mov eax, ebx        ; restore he bakup lba
    shr eax, 16
    out dx, al    
    ;finished upper 16 bits of lba

    mov dx, 0x1f7
    mov al, 0x20       ; restore he bakup lba
    out dx, al

    ; read all sectors in memory
.next_sector:
    push ecx

    ; checking if we need to read
.try_again:
    mov dx, 0x1f7
    in al, dx
    test al, 8
    jz .try_again

    ; we need to read 256 words at a time
    mov ecx, 256
    mov dx, 0x1F0
    rep insw
    pop ecx
    loop .next_sector
    ; End of sectors reading into memory
    ret


times 510-($ - $$) db 0 ; padding with zeroes to make our file atleat 510 bytes, 2 bytes is for boot signature
dw 0xAA55               ; add boot signature to our file

;-------------------------------------------------------------
; how to run asm file on qemu emulator-----------
; ┌──(root💀kali)-[~/Desktop/PeachOS]
; └─# nasm -f bin ./boot.asm -o ./boot.bin  or make                                                                                                 1 ⨯
                                                                                                                                                 
; ┌──(root💀kali)-[~/Desktop/PeachOS]
; └─# qemu-system-x86_64 -hda ./boot.bin  
; WARNING: Image format was not specified for './boot.bin' and probing guessed raw.
;          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
;          Specify the 'raw' format explicitly to remove the restrictions.
;                                                                                                                                                  
;-------------------------------------------------------------
; need gdb attached, apt install gdb
; gdb 
; add-symbol-file ../build/kernelfull.o 0x100000
; target remote | qemu-system-x86_64 -hda ./os.bin -S -gdb stdio   or   target remote | qemu-system-i386 -hda ./os.bin -S -gdb stdio
; c
; ctrl+c -> shows where program is currently executing
; layout asm
; info register -> to check if we are in protected mode


