			AREA |.text|, CODE, READONLY, ALIGN=2
			THUMB
			PRESERVE8
			EXTERN currentPt
			EXPORT SysTick_Handler
			EXPORT osSchedulerLaunch
			IMPORT osSchedulerRoundRobin

SysTick_Handler
	;SUSPEND CURRENT THREAD

	;Disable global interrupts
	CPSID	I;

	;Save r4,r5,r6,r7,r8,r9,r10,11
	PUSH  {R4-R11};

	;Load address of currentPt into r0
	LDR R0, =currentPt;

	;Load r1 from address equals r0, i.e. r1 =currentPt
	LDR R1,[R0];

	;Store Cortex-M SP at address equals r1, i.e Save SP into tcb 
	STR SP,[R1];

    ;CHOOSE NEXT THREAD

	PUSH	{R0,LR}
	BL		osSchedulerRoundRobin
	
	POP	    {R0,LR}
	
	LDR		R1,[R0]  ;r1 =currentPt i.e New thread
	LDR 	SP,[R1]  ;SP = currentPt->stackPt

	;Restore r4,r5,r6,r7,r8,r9,r10,11
	POP {R4-R11};

	;Enable global interrupts
	CPSIE	I;

	;Return from exception and restore r0,r1,r2,r3,r12,lr,pc,psr 
	BX	LR;
	



osSchedulerLaunch
	;Load address of currentPt into R0
	 LDR R0,=currentPt;

	;Load r2 from address equals r0,i.e r2 =currentPt
	LDR R2,[r0];

	;Load Cortex-M SP from address equals R2,i.e. SP = currentPt->stackPt
	LDR  SP,[R2];

	;Restore r4,r5,r6,r7,r8,r9,r10,r11
	POP {R4-R11};

	;Restore r12
	POP {R12};

	;Restore r0,r1,r2,r3
	POP	{R0-R3};

	;Skip LR 
	ADD  SP,SP,#4;

	;Create a new start location by popping LR
	POP {LR};

	;Skip PSR by adding 4 to SP
	ADD  SP,SP,#4;

	;Enable global interrupts
	CPSIE	I;

	;Return from exception
	BX	LR;
	
	ALIGN
	END