#include "kernel.h"
#include <stdint.h>
#include <stddef.h>
#include "idt/idt.h"
#include "io/io.h"
#include "memory/heap/kheap.h"
#include "memory/paging/paging.h"
#include "string/string.h"
#include "disk/disk.h"
#include "fs/pparser.h"

uint16_t* video_mem = 0;
uint16_t terminal_row = 0;
uint16_t terminal_col = 0;

uint16_t terminal_make_char(char c, char color){

    return (color << 8) | c; // return hex of character c with colour color
}

void terminal_putchar(int x, int y, char c, char color)
{
    video_mem[(y * VGA_WIDTH) + x] = terminal_make_char(c,color);
}

void terminal_writechar(char c, char color)
{
    if(c == '\n')
    {
        terminal_row++;
        terminal_col = 0;
        return;
    }
    terminal_putchar(terminal_col, terminal_row, c, color);
    terminal_col++;
    if(terminal_col >= VGA_WIDTH)
    {
        terminal_col=0;
        terminal_row++;
    }
}

void terminal_initialize(){ // remove default text from emulator screen

    video_mem = (uint16_t*)(0xB8000);
    for(int y = 0; y < VGA_HEIGHT; y++)
    {
        for(int x = 0; x < VGA_WIDTH; x++)
        {
            terminal_putchar(x, y, ' ', 0);
        }
    }
}

// size_t strlen(const char* str)
// {
//     size_t len =0;
//     while (str[len])
//     {
//         /* code */
//         len++;
//     }
//     return len;
// }

void print(const char* str){

    size_t len = strlen(str);

    for(int i = 0; i < len; i++){
        terminal_writechar(str[i],15);
    }
}

// extern void problem();

static struct paging_4gb_chunk* kernel_chunk = 0;

void kernel_main(){

    // char* video_mem = (char*)(0xB8000);

    // video_mem[0] = 'A'; // text memory
    // video_mem[1] = 3; // color memeory

    // video_mem[2] = 'A'; // text memory
    // video_mem[3] = 3; // color memeory

    // uint16_t* video_mem = (uint16_t*)(0xB8000);
    terminal_initialize();
    // video_mem[0] = terminal_make_char('B', 15); // 0x0341 -> text memory (41) and color memory (03) endiness included

    // terminal_writechar('A', 15);
    // terminal_writechar('B', 15);

    print("Hello World!\ntesting newline\n");


    kheap_init();       // initialize heap

    disk_search_and_init(); // search and initialize the disks

    idt_init(); // intitliase idt deacriptor table

    kernel_chunk = paging_new_4gb(PAGING_IS_WRITEABLE | PAGING_IS_PRESENT | PAGING_ACCESS_FROM_ALL); // setup paging

    paging_switch(paging_4gb_chunk_get_directory(kernel_chunk));    // swtich to kernel paging chunk

//    char* ptr = kzalloc(4096);
 //   paging_set(paging_4gb_chunk_get_directory(kernel_chunk), (void*)0x1000, (uint32_t)ptr | PAGING_ACCESS_FROM_ALL | PAGING_IS_PRESENT | PAGING_IS_WRITEABLE);

    enable_paging();

    // char* ptr2 = (char*) 0x1000;
    // ptr2[0] = 'A';
    // ptr2[1] = 'B';

    // print(ptr2);

    // print(ptr);

    // char buf[512];

    // disk_read_sector(0, 1, buf);

    enable_interrupts();

    //problem();

    // outb(0x60, 0xff);

    // void* ptr = kmalloc(50);
    // void* ptr2 = kmalloc(5000);
    // void* ptr3 = kmalloc(5600);
    // kfree(ptr);
    // void* ptr4 = kmalloc(50);
    // if(ptr || ptr2 || ptr3 || ptr4){

    // }

    struct path_root* root_path = pathparser_parse("0:/bin/shell.exe", NULL);
    
    if(root_path)
    {

    }
}