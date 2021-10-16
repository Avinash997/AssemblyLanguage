// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

@SCREEN
D = A
@addr
M = D

@8191
D = A

@size
M = D

@sizenow
M = 0


(LOOP)

@KBD
D = M

@WHITE
D; JEQ

@BLACK
D; JNE


@LOOP
0;JMP


(WHITE)
@sizenow
D = M

@addr
A = M + D
M = 0

@sizenow
M = M + 1
D = M

@size
D = M - D

@WHITE
D; JGE

@sizenow
M = 0

@LOOP
0; JMP


(BLACK)
@sizenow
D = M

@addr
A = M + D
M = -1

@sizenow
M = M + 1
D = M

@size
D = M - D

@BLACK
D; JGE

@sizenow
M = 0

@LOOP
0; JMP