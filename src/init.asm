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

;everything is loaded, now to enable drawing
	
	CLI						; enable interrupts
	
	LDA #%10010000 			; enable NMI, and change background to use 2nd CHR set of tiles ($1000)
	STA PPUCTRL				; enabling sprites and background for left-most 8 pixels
	LDA #%00011110			; enable sprites and backgrounds in general
	STA PPUMASK
	STA shadowPPUMASK

	JMP mainprep