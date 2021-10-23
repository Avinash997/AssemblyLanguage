all:
	nasm -f bin ./boot.asm -o ./boot.bin
	dd if=./message.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin 
# >> : pipe it to file and append it
# boot.bin is out hdd
# bs=512 count=1 : writes one sector after our message