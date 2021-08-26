.segment "STARTUP"

Reset:
	SEI 			; disables interrupts
	CLD 			; disable decimal mode
	
	; disable DMC IRQ
	LDX #$40
	STX $4017
	
	; init stack
	LDX #$FF
	TXS 			
	INX 			
	
	STX PPUCTRL
	STX PPUMASK
	
	STX $4010 		; disable PCM
	
:
	BIT PPUSTATUS
	BPL :-  		;wait vblank
	
	TXA 
	
CLEARMEM:
	STA $0000, X 
	STA $0100, X
	STA $0300, X
	STA $0400, X 
	STA $0500, X
	STA $0600, X
	STA $0700, X
	LDA #$FF
	STA $0200, X
	LDA #$00
	INX           
	BNE CLEARMEM

: 
	BIT PPUSTATUS
	BPL :-  ;wait vblank
	
	LDA #$02 
	STA OAMDMA
	NOP 
	
	LDA #%00000000 ; Increment by 1
	STA PPUCTRL

	LDY #$00			; palette init
	LDX #$10
:
	LDA PaletteData, Y
	STA bgpalettes, Y
	INY
	DEX 
	BNE :-
	LDY #$00
	LDX #$10
:
	LDA PaletteData, X
	STA sprpalettes, Y
	INX
	INY
	CPY #$10
	BNE :-
	
	JSR LoadPalettes 

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR 
	LDA #$00
	STA PPUADDR

	LDA #<nametable
	STA pointer
	LDA #>nametable
	STA pointer + 1
	JSR LoadNametable
	
	LDA #$C0
    STA EPSM_ADDR0_buf + 1
    STA EPSM_ADDR1_buf + 1
    LDA #$02
    STA EPSM_ADDR1_buf 
    LDA #$E0
    STA EPSM_DATA0_buf + 1
    STA EPSM_DATA1_buf + 1
    LDA #$02
    STA EPSM_DATA1_buf 

	LDA #$10
	LDY #0 
	LDX #$10
.proc init_EPSM			; preset the registers we care about to 0
	STA (EPSM_ADDR0_buf), Y
	PHA 
	LDA #$00
	STA (EPSM_DATA0_buf), Y
	PLA 
	INX 
	TXA 
	CPX #$9F
	BNE init_EPSM
	
	LDA #$29 				; enable OPNA mode
	STA (EPSM_ADDR0_buf), Y
	LDA #$80
	STA (EPSM_DATA0_buf), Y
	
	LDA #$B4				; enable L/R stereo for channel 0
	STA (EPSM_ADDR0_buf), Y
	LDA #$C0
	STA (EPSM_DATA0_buf), Y
	
	LDA #$A4				; set pitch to C-5
	STA (EPSM_ADDR0_buf), Y
	LDA pitch_table_1 + $38
	STA (EPSM_DATA0_buf), Y

	LDA #$A0 
	STA (EPSM_ADDR0_buf), Y
	LDA pitch_table_1 + $39
	STA (EPSM_DATA0_buf), Y

	LDA #$A4				
	STA (EPSM_ADDR0_buf), Y
	LDA pitch_table_2 + $38
	STA (EPSM_DATA0_buf), Y

	LDA #$A0 
	STA (EPSM_ADDR0_buf), Y
	LDA pitch_table_2 + $39
	STA (EPSM_DATA0_buf), Y
.endproc

	LDA #NOTE_C5
	STA sector_1_table + $3B

; this is gonna bite me in the butt when i have to write the MIDI implementation

;everything is loaded, now to enable drawing
	
	CLI						; enable interrupts
	
	LDA #%10010000 			; enable NMI, and change background to use 2nd CHR set of tiles ($1000)
	STA PPUCTRL				; enabling sprites and background for left-most 8 pixels
	LDA #%00011110			; enable sprites and backgrounds in general
	STA PPUMASK
	STA shadowPPUMASK

	JMP mainprep