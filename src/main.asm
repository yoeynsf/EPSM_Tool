.segment "BANK0"


mainprep:
    LDA #$40
    STA pointer_Ypos
    LDA #$30
    STA pointer_Xpos

main:						; Game logic goes here
	LDA #$00
	TAX
	TAY
    JSR spriteprep

    JSR edit_mode_check
    JSR move_pointer 




    LDA #<pointer_sprite
    STA pointer 
    LDA #>pointer_sprite
    STA pointer + 1
    LDA pointer_Xpos
    STA TempX
    LDA pointer_Ypos
    STA TempY
    JSR LoadSprites

    LDA #$28
    STA TempX
    LDA #$BC
    STA TempY
    LDA #<sprite_algorithm_1
    STA pointer
    LDA #>sprite_algorithm_1
    STA pointer + 1
    JSR LoadSprites

    JSR ClearSprites
	LDA framecounter
	waitVBlank:
	CMP framecounter	
	BEQ waitVBlank
	
	JMP main
;----------------------------------------------------------------------
