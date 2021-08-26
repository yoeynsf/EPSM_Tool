.segment "BANK0"


mainprep:
    LDA #$38
    STA pointer_Ypos
    LDA #$30
    STA pointer_Xpos

    LDX #0
    LDA #$B4
    STA (EPSM_ADDR0_buf, X)
    LDA #%11000000
    STA (EPSM_DATA0_buf, X)


main:						; Game logic goes here
	LDA #$00
	TAX
	TAY
    JSR spriteprep

    JSR edit_mode_check
    JSR move_pointer 
    JSR edit_mode

    JSR load_algorithm_sprite

    JSR play_note

    LDA #<pointer_sprite
    STA pointer 
    LDA #>pointer_sprite
    STA pointer + 1
    LDA pointer_Xpos
    STA TempX
    LDA pointer_Ypos
    STA TempY
    JSR LoadSprites

    JSR ClearSprites
	LDA framecounter
	waitVBlank:
	CMP framecounter	
	BEQ waitVBlank
	
	JMP main
;----------------------------------------------------------------------
