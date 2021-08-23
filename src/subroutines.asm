.proc edit_mode_check
    LDA held_buttons
    AND #KEY_A
    BNE :+
    LDA joystatus
    AND #KEY_A
    BEQ remove_sprite
    LDA Flags
    EOR #EDIT_FLAG
    STA Flags
:
insert_sprite:    
    LDA #<edit_sprite
    STA pointer
    LDA #>edit_sprite
    STA pointer + 1

    LDA pointer_Xpos
    CLC 
    ADC #8
    STA TempX
    LDA pointer_Ypos
    STA TempY
    JSR LoadSprites
    JMP :+
remove_sprite:
    LDA Flags       ; clear edit flag
    AND #%11111011
    STA Flags
:
    RTS
.endproc


.proc move_pointer
    LDA Flags
    AND #EDIT_FLAG
    JNE nothing

Right:

    LDA held_buttons
    AND #KEY_R
    BNE no_right
    LDA joystatus
    AND #KEY_R
    BEQ no_right
    LDA pointer_X_coord
    CMP #3
    BEQ no_right
    INC pointer_X_coord
    LDY pointer_position
    LDA sector_1_positions, Y
    STA temp 
    INC pointer_position
    LDY pointer_position

    LDA sector_1_positions, Y    ; grab new position for the sprite cursor
    CMP temp 
    BNE :+
    INY
    STY pointer_position
    INC pointer_X_coord
:
    LDY pointer_position
    LDA cursor_position_X, Y    ; grab new position for the sprite cursor
    STA pointer_Xpos
    LDA cursor_position_Y, Y
    STA pointer_Ypos
no_right:
Left:
    LDA held_buttons
    AND #KEY_L
    BNE no_left
    LDA joystatus
    AND #KEY_L
    BEQ no_left 
    LDA pointer_X_coord
    CMP #0
    BEQ no_left
    DEC pointer_X_coord
    DEC pointer_position
    LDY pointer_position

    LDA sector_1_positions, Y    ; grab new position for the sprite cursor
    STA temp 
    DEY
    BMI :+
    LDA sector_1_positions, Y
    CMP temp
    BNE :+
    STY pointer_position
    DEC pointer_X_coord
:
    LDY pointer_position
    LDA cursor_position_X, Y    ; grab new position for the sprite cursor
    STA pointer_Xpos
    LDA cursor_position_Y, Y
    STA pointer_Ypos
no_left:
Down:
    LDA held_buttons
    AND #KEY_D
    BNE no_down
    LDA joystatus
    AND #KEY_D
    BEQ no_down
    LDA pointer_Y_coord
    CMP #13
    BEQ no_down
    INC pointer_Y_coord
    LDA pointer_position
    CLC
    ADC #4
    STA pointer_position
    LDY pointer_position

    LDA sector_1_positions, Y    ; grab new position for the sprite cursor
    STA temp
    LDA pointer_position
    CLC 
    ADC #4
    TAY
    LDA sector_1_positions, Y
    CMP temp 
    BNE :+
    STY pointer_position
    INC pointer_Y_coord
:
    LDY pointer_position
    LDA cursor_position_X, Y
    STA pointer_Xpos
    LDA cursor_position_Y, Y
    STA pointer_Ypos
no_down:
Up:
    LDA held_buttons
    AND #KEY_U
    BNE no_up
    LDA joystatus
    AND #KEY_U
    BEQ no_up
    LDA pointer_Y_coord
    CMP #0
    BEQ no_up
    DEC pointer_Y_coord
    LDA pointer_position
    TAY 
    LDA sector_1_positions, Y
    STA temp
    TYA 
    SEC
    SBC #4
    STA pointer_position
    LDY pointer_position

    LDA sector_1_positions, Y    ; grab new position for the sprite cursor\
    CMP temp 
    BNE :+
    LDA pointer_position
    SEC
    SBC #4
    TAY
    LDA sector_1_positions, Y
    STY pointer_position
    DEC pointer_Y_coord
:
    LDY pointer_position
    LDA cursor_position_X, Y    ; grab new position for the sprite cursor
    STA pointer_Xpos
    LDA cursor_position_Y, Y
    STA pointer_Ypos
no_up:
nothing:
    RTS
.endproc



LoadPalettes:
	LDA #$3F
	STA PPUADDR 
	LDA #$00
	STA PPUADDR
	LDX #$00
:
	LDA bgpalettes, X
	STA PPUDATA
	INX
	CPX #$10
	BNE :-
	LDX #$00
:
	LDA sprpalettes, X
	STA PPUDATA
	INX
	CPX #$10
	BNE :-
	RTS	

spriteprep:
	LDA OAMposAtFrame
    CLC 
    ADC #32
    STA currentOAMpos
    STA OAMposAtFrame
	RTS

LoadSprites:
    LDY #$00
    LDX currentOAMpos;We're about to render a sprite so get the next free one.
:
	LDA (pointer), Y         ;Y position
    BMI donesprite
    CLC
    ADC TempY
    SEC
    SBC #1                  ; compensate for the +1 scanline delay
    STA $0200, X
    INY
    INX
    LDA (pointer), Y        ;Tile Number
    STA $0200, X
    INY
    INX
    LDA (pointer), Y        ;Attributes
    STA $0200, X
    INY
    INX
    LDA (pointer), Y        ;X position
    CLC
    ADC TempX
    STA $0200, X
    INY
    INX
    JMP :-
    donesprite:
    STX currentOAMpos
	RTS

 ClearSprites:
    LDX currentOAMpos
    LDA #$FF
    Clear:
    STA $0200, X
    INX
    INX
    INX
    INX
    CPX OAMposAtFrame
    BNE Clear
    RTS

LoadNametable:
	LDY #0
	LDX #4
:
	LDA (pointer), Y 
	STA PPUDATA
	INY
	BNE :-	
	INC pointer + 1
	DEX
	BNE :- 
	RTS
