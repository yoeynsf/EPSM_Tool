.proc edit_mode
    LDA Flags
    AND #EDIT_FLAG
    JEQ nothing

    LDY pointer_position    ; make sure we only write to 2C and $34 because there's duplicate entries
    CPY #$31
    BNE :+
    LDY #$30
    JMP write
:
    CPY #$39
    BNE :+
    LDY #$38
    JMP write
:
    CPY #$34
    BNE :+
    LDY #$38
    JMP write
:
    CPY #$3B
    BNE :+
    JMP note_edit
:
write:

    LDA held_buttons
    AND #KEY_R
    BNE :+
    LDA joystatus
    AND #KEY_R 
    BEQ :+
    LDA pointer_Y_coord
    CMP #$0B
    JEQ data_port_edit

    LDA max_values, Y       ; if it's already the highest value, do nothing (Y already contains index) 
    STA temp 
    LDA sector_1_table, Y
    CMP temp 
    JEQ nothing  
    
    LDA sector_1_table, Y   ; increment by 1
    CLC 
    ADC #1
    STA sector_1_table, Y
: 
    LDA held_buttons
    AND #KEY_L
    BNE :+
    LDA joystatus
    AND #KEY_L 
    BEQ :+
    LDA pointer_Y_coord
    CMP #$0B
    JEQ data_port_edit
    
    LDA sector_1_table, Y
    BEQ :+                  ; if already zero, do nothing
    SEC
    SBC #1
    STA sector_1_table, Y
: 

    LDA held_buttons
    AND #KEY_U
    BNE :+
    LDA joystatus
    AND #KEY_U 
    BEQ :+
    LDA pointer_Y_coord
    CMP #$0B
    JEQ data_port_edit

    LDA max_values, Y 
    AND #$F0
    STA temp 
    BEQ :+
    LDA sector_1_table, Y
    AND #$F0
    CMP temp
    BEQ :+
    LDA sector_1_table, Y
    CLC 
    ADC #$10 
    STA sector_1_table, Y 
:
    LDA held_buttons
    AND #KEY_D
    BNE :+
    LDA joystatus
    AND #KEY_D 
    BEQ :+
    LDA pointer_Y_coord
    CMP #$0B
    JEQ data_port_edit


    LDA sector_1_table, Y
    AND #$F0
    BEQ :+
    LDA sector_1_table, Y 
    SEC 
    SBC #$10 
    STA sector_1_table, Y 
:
nothing:
    RTS 
.endproc

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

    LDA pointer_Xpos    ; if the Y coordinate is on the data ports, then move the sprite over some more and load another one
    CLC 
    ADC #8
    LDX pointer_Y_coord
    CPX #$0B
    BNE :+
    CLC
    ADC #8
    STA temp
    CLC 
    ADC #16
    STA TempX
    LDA pointer_Ypos
    STA TempY
    JSR LoadSprites
    LDA temp
:
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

.proc data_port_edit
    
    LDA joystatus
    AND #KEY_R 
    BEQ left
    LDY pointer_X_coord
    BEQ :+
    TYA 
    ASL 
    TAY 
:    
    LDA EPSM_ADDR0_buf, Y 
    CMP #$FF
    BEQ :+
    CLC 
    ADC #1
    STA EPSM_ADDR0_buf, Y 
:
left:
    LDA joystatus
    AND #KEY_L 
    BEQ up
    LDY pointer_X_coord
    BEQ :+
    TYA 
    ASL 
    TAY 
:    
    LDA EPSM_ADDR0_buf, Y 
    CMP #$18
    BNE :+
    LDA EPSM_ADDR0_buf + 1, Y 
    CMP #$40
    BEQ up
:
    LDA EPSM_ADDR0_buf, Y 
    BEQ up
    SEC 
    SBC #1
    STA EPSM_ADDR0_buf, Y 

up:
    LDA joystatus
    AND #KEY_U 
    BEQ down
    LDY pointer_X_coord
    BEQ :+
    TYA 
    ASL 
    TAY 
:    
    LDA EPSM_ADDR0_buf + 1, Y 
    CMP #$FF
    BEQ :+
    CLC 
    ADC #1
    STA EPSM_ADDR0_buf + 1, Y 
:
down:
    LDA joystatus
    AND #KEY_D 
    BEQ done
    LDY pointer_X_coord
    BEQ :+
    TYA 
    ASL 
    TAY 
:    
    LDA EPSM_ADDR0_buf + 1, Y 
    CMP #$40
    BEQ :+
    SEC 
    SBC #1
    STA EPSM_ADDR0_buf + 1, Y 
:
done:
    LDY pointer_X_coord
    BEQ :+
    TYA 
    ASL 
    TAY 
:    
check_low:                          ; make sure that trying to go low always corrects to $4018
    LDA EPSM_ADDR0_buf, Y 
    CMP #$19
    BCS :+
    LDA EPSM_ADDR0_buf + 1, Y
    CMP #$40
    BNE :+
    LDA #$40 
    STA EPSM_ADDR0_buf + 1, Y
    LDA #$18 
    STA EPSM_ADDR0_buf, Y   
: 


    JMP edit_mode::nothing
.endproc

.proc note_edit
    LDY pointer_position

right:    
    LDA held_buttons
    AND #KEY_R
    BNE skip_right
    LDA joystatus
    AND #KEY_R
    BEQ skip_right

    LDA max_values, Y       ; if it's already the highest value, do nothing (Y already contains index) 
    STA temp 
    LDA sector_1_table, Y
    CMP temp 
    BEQ nothing  
    
    LDA sector_1_table, Y   ; increment by 1
    CLC 
    ADC #1
    STA sector_1_table, Y
skip_right:

left:    
    LDA held_buttons
    AND #KEY_L
    BNE skip_left
    LDA joystatus
    AND #KEY_L
    BEQ skip_left 
    
    LDA sector_1_table, Y   ; decrement by 1
    BEQ skip_left
    SEC
    SBC #1
    STA sector_1_table, Y
skip_left:

up:    
    LDA held_buttons
    AND #KEY_U
    BNE skip_up
    LDA joystatus
    AND #KEY_U
    BEQ skip_up

    LDA sector_1_table, Y
    CMP #$24
    BCS nothing  
    
    LDA sector_1_table, Y   ; increment by 7 because the scale
    CLC 
    ADC #7                  
    STA sector_1_table, Y
skip_up:

down:    
    LDA held_buttons
    AND #KEY_D
    BNE skip_down
    LDA joystatus
    AND #KEY_D
    BEQ skip_down

    LDA sector_1_table, Y
    CMP #$07
    BCC nothing  
    
    LDA sector_1_table, Y   ; increment by 7 because the scale
    SEC
    SBC #7                  
    STA sector_1_table, Y
skip_down:

nothing:
    JMP edit_mode::nothing
.endproc