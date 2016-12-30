.EQU	PORT13,	0x05	
.EQU	DDR13,	0x04	
.EQU	P13,	5		
.EQU	_ms_stack,	__stack
.EQU	UDR0,	0xC6	
.EQU	UBRR0H,	0xC5	
.EQU	UBRR0L,	0xC4	
.EQU	UCSR0C,	0xC2	
.EQU	UCSR0B,	0xC1	
.EQU	UCSR0A,	0xC0	
.EQU	TXEN0,	3		
.EQU	RXEN0,	4		
.EQU	UDRE0,	5		
.EQU	TXC0,	6		
.EQU	RXC0,	7		
.EQU	BAUD_9600, 103	
	.global _global_0
	.data
	.size _global_0, 2
_global_0:
	.word falseHigh
	.text
	.global _global_1
	.data
	.size _global_1, 2
_global_1:
	.word falseHigh
	.text
	.global _global_2
	.data
	.size _global_2, 2
_global_2:
	.word falseHigh
	.text
	.global _global_3
	.data
	.size _global_3, 2
_global_3:
	.word falseHigh
	.text
	.global _global_4
	.data
	.size _global_4, 2
_global_4:
	.word falseHigh
	.text
	.global _global_5
	.data
	.size _global_5, 2
_global_5:
	.word falseHigh
	.text
	.global _global_6
	.data
	.size _global_6, 2
_global_6:
	.word falseHigh
	.text
	.global _global_7
	.data
	.size _global_7, 2
_global_7:
	.word falseHigh
	.text
	.global _global_8
	.data
	.size _global_8, 2
_global_8:
	.word falseHigh
	.text
	.global _global_9
	.data
	.size _global_9, 2
_global_9:
	.word falseHigh
	.text
	.global _global_10
	.data
	.size _global_10, 2
_global_10:
	.word falseHigh
	.text
.text
.global main
main:

.EQU	MLX1,	0	; Hardware Multiplier
.EQU	MLX2,	1	; Hardware Multiplier
.EQU	TCSl,	2	; Tail Call Special/Save
.EQU	TCSh,	3	; Tail Call Special/Save
.EQU falseReg,	4
.EQU zeroReg,	5
.EQU c_sreg, 	6
			;	7

			;	8
			;	9	
			;	10 	
			;	11	
			;	12	
			;	13	
			;	14	
			;	15	

.EQU	GP1,	16  ; General Purpose 1 		(used by multiplication)
.EQU	GP2,	17  ; General Purpose 2 		(used by multiplication)
.EQU	GP3,	18  ; General Purpose 3 		(used by multiplication)
.EQU	GP4,	19  ; General Purpose 4 		(used by multiplication)
.EQU	GP5,	20  ; General Purpose 5
.EQU	GP6, 	21	; General Purpose 6
			;	22	
.EQU	PCR,	23	; proc call register


.EQU	CCPl,	24
.EQU	CCPh,	25
.EQU	HFPl,	26
.EQU	HFPh,	27
.EQU	CRSl,	28
.EQU	CRSh,	29
.EQU	AFPl,	30
.EQU	AFPh,	31

.EQU	SREG,	0x3F

.EQU	falseHigh,	254
.EQU	trueHigh,	255

;; 16-bit counting registers, of which XYZ are
;; are memory address registers.
.EQU	WL,	0x18
.EQU	WH,	0x19
.EQU	XL,	0x1A
.EQU	XH,	0x1B
.EQU	YL,	0x1C
.EQU	YH,	0x1D
.EQU 	ZL,	0x1E
.EQU	ZH,	0x1F

.EQU	SPl,	0x3D
.EQU	SPh,	0x3E

LDI GP1, falseHigh
MOV falseReg, GP1
CLR zeroReg

CLI
IN c_sreg, SREG

LDI		CRSl,	0
LDI		CRSh,	0
LDI 	HFPl,	lo8(_end)
LDI		HFPh,	hi8(_end)
LDI		CCPl,	0
LDI		CCPh,	0
LDI		AFPl,	lo8(_ms_stack)
LDI		AFPh,	hi8(_ms_stack)

OUT SPl, AFPl
OUT SPh, AFPh

SBI	DDR13,	P13
CBI	PORT13,	P13

RJMP entry_point

proc_call:
	MOV GP1, CRSh
	ANDI GP1, 224
	LDI GP2, 192
	CPSE GP1, GP2
	RJMP error_notproc
	ANDI CRSh, 31
	MOVW CCPl, CRSl
	LD GP1, Y;CRS
	CPSE GP1, PCR
	RJMP error_numargs
	LDD AFPh, Y+1;CRS
	LDD AFPl, Y+2;CRS
	IJMP

before_c_func:
	POP r2
	POP r3
		PUSH CCPl
		PUSH CCPh
		PUSH HFPl
		PUSH HFPh
		PUSH AFPl
		PUSH AFPh
		PUSH r1
		CLR r1
	PUSH r3
	PUSH r2
	OUT SREG, c_sreg
	RET

after_c_func:
	IN c_sreg, SREG
	CLI
	POP r2
	POP r3
		MOVW CRSl, r24
		POP r1
		POP AFPh
		POP AFPl
		POP HFPh
		POP HFPl
		POP CCPh
		POP CCPl
	PUSH r3
	PUSH r2
	RET

inline_cons:
	ST X+, GP1;HFP
	ST X+, GP2
	ST X+, CRSl
	ST X+, CRSh
	MOVW CRSl, HFPl
	SBIW CRSl, 4
	ORI CRSh, 128
	RET

inline_car:
	MOV GP1, CRSh
	ANDI GP1, 224
	LDI GP2, 128
	CPSE GP1, GP2
	RJMP error_notpair
	ANDI CRSh, 31
	LDD GP1, Y+0; (Y=CRS)
	LDD CRSh, Y+1
	MOV CRSl, GP1
	RET

inline_cdr:
	MOV GP1, CRSh
	ANDI GP1, 224
	LDI GP2, 128
	CPSE GP1, GP2
	RJMP error_notpair
	ANDI CRSh, 31
	LDD GP1, Y+2; (Y=CRS)
	LDD CRSh, Y+3
	MOV CRSl, GP1
	RET

inline_set_car:
	MOV GP3, CRSh
	ANDI GP3, 224
	LDI GP4, 128
	CPSE GP3, GP4
	RJMP error_notpair
	ANDI CRSh, 31
	STD Y+0, GP1
	STD Y+1, GP2
	RET

inline_set_cdr:
	MOV GP3, CRSh
	ANDI GP3, 224
	LDI GP4, 128
	CPSE GP3, GP4
	RJMP error_notpair
	ANDI CRSh, 31
	STD Y+2, GP1
	STD Y+3, GP2
	RET

inline_vector_ref:
	MOV GP3, CRSh
	ANDI GP3, 224
	LDI GP4, 160
	CPSE GP3, GP4
	RJMP error_notvect
	ANDI CRSh, 31
	LD GP3, Y+
	LD GP4, Y+
	CP GP1, GP3
	CPC GP2, GP4
	BRLO inline_vector_ref_ok
	RJMP error_bounds
inline_vector_ref_ok:
	LSL GP1
	ROL GP2
	ADD CRSl, GP1
	ADC CRSh, GP2
	LD GP1, Y
	LDD CRSh, Y+1
	MOV CRSl, GP1
	RET

inline_vector_set:
	MOV GP5, CRSh
	ANDI GP5, 224
	LDI GP6, 160
	CPSE GP5, GP6
	RJMP error_notvect
	ANDI CRSh, 31
	LD GP5, Y+
	LD GP6, Y+
	CP GP1, GP5
	CPC GP2, GP6
	BRLO inline_vector_set_ok
	RJMP error_bounds
inline_vector_set_ok:
	LSL GP1
	ROL GP2
	ADD CRSl, GP1
	ADC CRSh, GP2
	ST Y, GP3
	STD Y+1, GP4
	RET

inline_vector_length:
	MOV GP3, CRSh
	ANDI GP3, 224
	LDI GP4, 160
	CPSE GP3, GP4
	RJMP error_notvect
	ANDI CRSh, 31
	LD GP1, Y
	LDD CRSh, Y+1
	MOV CRSl, GP1
	RET

inline_gt: ; GP1:GP2 > CRSl:CRSh
	CP CRSl, GP1
	CPC CRSh, GP2
	BRLO inline_gt_ok
	LDI CRSh, falseHigh
	CLR CRSl
	RET
inline_gt_ok:
	LDI CRSh, trueHigh
	CLR CRSl
	RET

inline_div: ; GP1:GP2 / CRSl:CRSh
	MOVW GP3, CRSl
	CLR CRSl
	CLR CRSh
	CP GP3, zeroReg
	CPC GP4, zeroReg
	BRNE inline_div_loop
	RJMP error_divzero
inline_div_loop:
	SUB GP1, GP3
	SBC GP2, GP4
	BRLO inline_div_end
	ADIW CRSl, 1
	RJMP inline_div_loop
inline_div_end:
	RET

error_notproc:
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI YL, lo8(1000)
	RCALL util_pause
RJMP error_notproc

error_numargs:
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_numargs

error_notnum:
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_notnum

error_notpair:
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_notpair

error_notvect:
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_notvect

error_bounds:
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_bounds

error_divzero:
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	RCALL util_flash
	LDI YH, hi8(1000)
	LDI HFPl, lo8(1000)
	RCALL util_pause
RJMP error_divzero

error_custom:
	RCALL util_flash
RJMP error_custom




; INPUT: Y = delay (milliseconds)
util_pause:
	PUSH WH
	PUSH WL

	util_pause_count:       
		LDI WH, hi8(0xFA0)
		LDI WL, lo8(0xFA0)
		util_pause_inner_count:
			SBIW WL, 1
			BRNE util_pause_inner_count
		SBIW YL, 1
		BRNE util_pause_count
	;; NB: In total, this routine takes Y*16002 + 17 operations

	POP WL
	POP WH
RET

; INPUT: Y = delay (microseconds)
util_micropause:
	util_micropause_count:       
		PUSH zeroReg 
		POP zeroReg
		PUSH zeroReg 
		POP zeroReg
		PUSH zeroReg 
		POP zeroReg
		NOP 
		SBIW YL, 1
		BRNE util_micropause_count
RET

util_flash:
	SBI	PORT13,	P13
	LDI YH, hi8(200)
	LDI YL, lo8(200)
	RCALL util_pause
	CBI PORT13, P13
	LDI YH, hi8(200)
	LDI YL, lo8(200)
	RCALL util_pause
RET

entry_point:
	LDI GP1,1
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry1))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry1))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after1
proc_entry1: ; forever
	MOVW AFPl, GP5
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret1))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret1))
	PUSH GP1
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 0
	JMP proc_call
proc_ret1:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_0+1
	LDS CRSl, _global_0
	IN GP3, SPl
	IN GP4, SPh
	ADIW AFPl, 2
	OUT SPl, AFPl
	OUT SPh, AFPh
	SBIW AFPl, 2
	MOVW GP5, AFPl
	MOVW AFPl, GP3
	ADIW AFPl, 2
1:	CP AFPl, GP3
	CPC AFPh, GP4
	BREQ 2f
	LD GP1, Z
	SBIW AFPl, 1
	PUSH GP1
	RJMP 1b
2:	LDI PCR, 1
	JMP proc_call
proc_after1:
	STS _global_0+1, CRSh
	STS _global_0, CRSl
	LDI GP1, lo8(14)
	LDI GP2, hi8(14)
	ST X+, GP1
	ST X+, GP2
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 41
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 35
	ST X+, CRSl
	ST X+, CRSh
	MOVW CRSl, HFPl
	SUBI CRSl, lo8(30)
	SBCI CRSh, hi8(30)
	ORI CRSh, 160
	STS _global_1+1, CRSh
	STS _global_1, CRSl
	LDI GP1, lo8(14)
	LDI GP2, hi8(14)
	ST X+, GP1
	ST X+, GP2
	LDI CRSh, 0
	LDI CRSl, 1
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 2
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 4
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 8
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 16
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 32
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 64
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 128
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 1
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 2
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 4
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 8
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 16
	ST X+, CRSl
	ST X+, CRSh
	LDI CRSh, 0
	LDI CRSl, 32
	ST X+, CRSl
	ST X+, CRSh
	MOVW CRSl, HFPl
	SUBI CRSl, lo8(30)
	SBCI CRSh, hi8(30)
	ORI CRSh, 160
	STS _global_2+1, CRSh
	STS _global_2, CRSl
	LDI GP1,2
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry2))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry2))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after2
proc_entry2: ; set-ddr
	MOVW AFPl, GP5
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_2+1
	LDS CRSl, _global_2
	POP GP1
	POP GP2
	CALL inline_vector_ref
	PUSH CRSl
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSh
	LDI CRSh, 0
	LDI CRSl, 1
	SBRC CRSh, 7
	JMP error_notnum
	PUSH CRSh
	PUSH CRSl
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_1+1
	LDS CRSl, _global_1
	POP GP1
	POP GP2
	CALL inline_vector_ref
	SBRC CRSh, 7
	JMP error_notnum
	POP GP1
	POP GP2
	ADD CRSl, GP1
	ADC CRSh, GP2
	POP GP4
	POP GP3
	LD GP5, Y
	OR GP5, GP3
	COM GP3
	SBRS GP4, 0
	AND GP5, GP3
	ST Y, GP5
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	ADIW AFPl, 4
	OUT SPl, AFPl
	OUT SPh, AFPh
	POP AFPl
	POP AFPh
	IJMP
proc_after2:
	STS _global_3+1, CRSh
	STS _global_3, CRSl
	LDI GP1,2
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry3))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry3))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after3
proc_entry3: ; set-pin
	MOVW AFPl, GP5
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_2+1
	LDS CRSl, _global_2
	POP GP1
	POP GP2
	CALL inline_vector_ref
	PUSH CRSl
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSh
	LDI CRSh, 0
	LDI CRSl, 2
	SBRC CRSh, 7
	JMP error_notnum
	PUSH CRSh
	PUSH CRSl
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_1+1
	LDS CRSl, _global_1
	POP GP1
	POP GP2
	CALL inline_vector_ref
	SBRC CRSh, 7
	JMP error_notnum
	POP GP1
	POP GP2
	ADD CRSl, GP1
	ADC CRSh, GP2
	POP GP4
	POP GP3
	LD GP5, Y
	OR GP5, GP3
	COM GP3
	SBRS GP4, 0
	AND GP5, GP3
	ST Y, GP5
	LDD CRSh, Z+3
	LDD CRSl, Z+4
	ADIW AFPl, 4
	OUT SPl, AFPl
	OUT SPh, AFPh
	POP AFPl
	POP AFPh
	IJMP
proc_after3:
	STS _global_4+1, CRSh
	STS _global_4, CRSl
	LDI GP1,1
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry4))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry4))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after4
proc_entry4: ; high?
	MOVW AFPl, GP5
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_2+1
	LDS CRSl, _global_2
	POP GP1
	POP GP2
	CALL inline_vector_ref
	PUSH CRSl
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSh
	PUSH CRSl
	LDS CRSh, _global_1+1
	LDS CRSl, _global_1
	POP GP1
	POP GP2
	CALL inline_vector_ref
	POP GP3
	LD GP4, Y
	LDI CRSh, trueHigh
	AND GP4, GP3
	CPSE GP4, GP3
	LDI CRSh, falseHigh
	CLR CRSl
	ADIW AFPl, 2
	OUT SPl, AFPl
	OUT SPh, AFPh
	POP AFPl
	POP AFPh
	IJMP
proc_after4:
	STS _global_5+1, CRSh
	STS _global_5, CRSl
	LDI GP1,1
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry5))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry5))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after5
proc_entry5: ; output
	MOVW AFPl, GP5
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSl
	PUSH CRSh
	LDI CRSh, 255
	LDI CRSl, 0
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_3+1
	LDS CRSl, _global_3
	IN GP3, SPl
	IN GP4, SPh
	ADIW AFPl, 2
	OUT SPl, AFPl
	OUT SPh, AFPh
	SBIW AFPl, 4
	MOVW GP5, AFPl
	MOVW AFPl, GP3
	ADIW AFPl, 4
1:	CP AFPl, GP3
	CPC AFPh, GP4
	BREQ 2f
	LD GP1, Z
	SBIW AFPl, 1
	PUSH GP1
	RJMP 1b
2:	LDI PCR, 2
	JMP proc_call
proc_after5:
	STS _global_6+1, CRSh
	STS _global_6, CRSl
	LDI GP1,1
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry6))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry6))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after6
proc_entry6: ; low?
	MOVW AFPl, GP5
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret2))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret2))
	PUSH GP1
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_5+1
	LDS CRSl, _global_5
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 1
	JMP proc_call
proc_ret2:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
	LDI GP1, 1
	EOR CRSh, GP1
	ADIW AFPl, 2
	OUT SPl, AFPl
	OUT SPh, AFPh
	POP AFPl
	POP AFPh
	IJMP
proc_after6:
	STS _global_7+1, CRSh
	STS _global_7, CRSl
	LDI GP1,1
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry7))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry7))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after7
proc_entry7: ; toggle
	MOVW AFPl, GP5
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSl
	PUSH CRSh
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret3))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret3))
	PUSH GP1
	LDD CRSh, Z+1
	LDD CRSl, Z+2
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_7+1
	LDS CRSl, _global_7
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 1
	JMP proc_call
proc_ret3:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_4+1
	LDS CRSl, _global_4
	IN GP3, SPl
	IN GP4, SPh
	ADIW AFPl, 2
	OUT SPl, AFPl
	OUT SPh, AFPh
	SBIW AFPl, 4
	MOVW GP5, AFPl
	MOVW AFPl, GP3
	ADIW AFPl, 4
1:	CP AFPl, GP3
	CPC AFPh, GP4
	BREQ 2f
	LD GP1, Z
	SBIW AFPl, 1
	PUSH GP1
	RJMP 1b
2:	LDI PCR, 2
	JMP proc_call
proc_after7:
	STS _global_8+1, CRSh
	STS _global_8, CRSl
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret4))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret4))
	PUSH GP1
	LDI CRSh, 0
	LDI CRSl, 13
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_6+1
	LDS CRSl, _global_6
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 1
	JMP proc_call
proc_ret4:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
	STS _global_9+1, CRSh
	STS _global_9, CRSl
	LDI GP1,0
	ST X+, GP1;HFP
	LDI GP1, hi8(pm(proc_entry8))
	ST X+, GP1
	LDI GP1, lo8(pm(proc_entry8))
	ST X+, GP1
	ST X+, CCPl
	ST X+, CCPh
	MOVW CRSl, HFPl
	SBIW CRSl, 5
	ORI CRSh, 192
	JMP proc_after8
proc_entry8: ; loop
	MOVW AFPl, GP5
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret5))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret5))
	PUSH GP1
	LDS CRSh, _global_9+1
	LDS CRSl, _global_9
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_8+1
	LDS CRSl, _global_8
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 1
	JMP proc_call
proc_ret5:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
	LDI CRSh, 3
	LDI CRSl, 232
	CALL util_pause
	ADIW AFPl, 0
	OUT SPl, AFPl
	OUT SPh, AFPh
	POP AFPl
	POP AFPh
	IJMP
proc_after8:
	STS _global_10+1, CRSh
	STS _global_10, CRSl
	PUSH AFPh
	PUSH AFPl
	PUSH CCPh
	PUSH CCPl
	LDI GP1, hi8(pm(proc_ret6))
	PUSH GP1
	LDI GP1, lo8(pm(proc_ret6))
	PUSH GP1
	LDS CRSh, _global_10+1
	LDS CRSl, _global_10
	PUSH CRSl
	PUSH CRSh
	LDS CRSh, _global_0+1
	LDS CRSl, _global_0
	IN AFPl, SPl
	IN AFPh, SPh
	MOVW GP5, AFPl
	LDI PCR, 1
	JMP proc_call
proc_ret6:
	POP CCPl
	POP CCPh
	POP AFPl
	POP AFPh
SBI PORT13, P13
JMP _exit
