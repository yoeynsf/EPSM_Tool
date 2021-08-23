NMI:
    PHA         
    TYA        
    PHA       
    TXA
    PHA         

	LDA #$00            ;Set the OAM address to 0
    STA OAMADDR
	LDA #$02    		;copy sprite data from $0200 into PPU memory
    STA OAMDMA

    LDA #$24            ; Timer A Hi
    STA EPSM_ADDR0
    LDA #$3F
    STA EPSM_DATA0
    
    LDA #$25            ; Timer A Lo
    STA EPSM_ADDR0
    LDA #%00000011
    STA EPSM_DATA0

    LDA #$27            ; Enable Timer and IRQ
    STA EPSM_ADDR0
    LDA #%00001010
    STA EPSM_DATA0
	
	JSR LoadPalettes

	LDA #%10010000 		;Choose nametable 0 as the base nametable address
    STA PPUCTRL

    LDA shadowPPUMASK
    STA PPUMASK

    LDY joystatus       ; save previous frame's inputs
	LDA #$01  			; poll the controller
	STA JOYPAD1
	LDA #$00
	STA JOYPAD1 		; finish poll 
	LDX #$00
Packbytes:	
	LDA JOYPAD1
    LSR
    ROL joystatus
    INX
	CPX #$08			; repeated 8 times, A, B, SEL, STA, U, D, L, R
	BNE Packbytes
    
    TYA 
    AND joystatus       
    STA held_buttons    ; move old inputs to A and find out which ones have been held. will use for menus

    LDA PPUSTATUS  		;the next write to $2005 will be the X scroll
	LDA #$00
    STA PPUSCROLL  		
	STA PPUSCROLL

	INC framecounter  
	PLA
    TAX
    PLA       
    TAY
    PLA        
    RTI