;ORG 0x7c00             ; set the origin to this address where bios is located
ORG 0
BITS 16                 ; this is for 16 bits

_start:
    jmp short start     ; make a short jump to start label
    nop

times 33 db 0           ; fill 33 bytes to prevent code getting corrupt
                        ; bios parameter block

start:
    jmp 0x7c0:step2     ; to make cs point to 0x7c0
    
;handle_zero:            ; new interrrupt vector
;    mov ah, 0eh
;    mov al, 'A'
;    mov bx, 0x00
;    int 0x10
;    iret                ; return from intrerupt

;handle_one:            ; new interrrupt vector
;    mov ah, 0eh
;    mov al, 'D'
;    mov bx, 0x00
;    int 0x10
;    iret

step2:
    cli                 ; clear interrupts
    mov ax, 0x7c0
    mov ds, ax          ; to make data reg point to 0x7c0 
    mov es, ax          ; to make extra reg point to 0x7c0
    mov ax, 0x00
    mov ss, ax          
    mov sp, 0x7c00      ; to make stack pointer point to 0x7c0   
    sti                 ; enables interrupts

;---------------------------interrupts code -------------

;    mov word[ss:0x00], handle_zero      ; default is data seg 
;    mov word[ss:0x02], 0x7c0            ; 

;    mov word[ss:0x04], handle_one      ; default is data seg 
;    mov word[ss:0x06], 0x7c0 

    ;int 0               ; calling the interrup 0

    ;mov ax, 0x00        ; exception also call interrupt 0          
    ;div ax

;    int 1                ; calling interrupt 1

; ------------------------------- load from hard disk code -----------------

    mov ah, 2           ; read sector command
    mov al, 1           ; one sector to read
    mov ch, 0           ; cyelinder low 8 bits
    mov cl, 2           ; read sector 2
    mov dh, 0           ; head number
    mov bx, buffer
    int 0x13            ; invoke the read command to read from hdd sector
    jc error


    mov si, buffer
    call print
    jmp $               ; jump to same statement forever

error:
    mov si, error_message
    call print
    jmp $

;    mov si, message     ; address pointed by si
;    call print

print:
    mov bx, 0           ; pae number to set 0
.loop:
    lodsb               ; loads value si is pointing at to al register
    cmp al, 0
    je .done
    call print_char
    jmp .loop
.done:
    ret

print_char:
    mov ah, 0eh         ; function to prints the value to screen when talking to bios, bios sees 0eh and prints al value to screen
    int 0x10            ; interrupts kernel to invoke the bios
    ret

;message: 
;    db ' Hello World! I am Avinash D. Avi', 0

error_message: db 'failed to load the sector',0

times 510-($ - $$) db 0 ; padding with zeroes to make our file atleat 510 bytes, 2 bytes is for boot signature
dw 0xAA55               ; add boot signature to our file

buffer:



;-------------------------------------------------------------
; how to write boot loader in USB stick------------------
; run commands on terminal with usb inserted
;- sudo fdisk -l
; you will find you usb stick of the format 'dev/sdb'
; - sudo dd if=./boot.bin of=/dev/sdb
; now you can boot with USB drive

;-------------------------------------------------------------
; how to run asm file on qemu emulator-----------
; ┌──(root💀kali)-[~/Desktop/PeachOS]
; └─# nasm -f bin ./boot.asm -o ./boot.bin                                                                                                     1 ⨯
                                                                                                                                                 
; ┌──(root💀kali)-[~/Desktop/PeachOS]
; └─# qemu-system-x86_64 -hda ./boot.bin  
; WARNING: Image format was not specified for './boot.bin' and probing guessed raw.
;          Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
;          Specify the 'raw' format explicitly to remove the restrictions.
;                                                                                                                                                  

