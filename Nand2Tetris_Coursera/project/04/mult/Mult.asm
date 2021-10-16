// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R0
D = M
@n1
M = D

@R1
D = M
@n2
M = D

@R2
M = 0

@sum
M = 0


(LOOP)
@n2
M = M-1

@END
D; JLE

@n1
D = M

@sum
M = M + D
D = M

@R2
M = D

@n2
D = M


@LOOP
0;JMP

(END)
@END
0; JMP