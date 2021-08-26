.proc write_nametable
    LDY pointer_position

    LDA pointer_Y_coord
    CMP #$0A 
    JEQ AM_toggle

    CPY #$37                ; Y still contains pointer_position
    JEQ loop_toggle

    CPY #$3B 
    JEQ note_tiles
    
    LDA max_values, Y
    CMP #$FF                ; data port?
    JEQ data_port_write                     

    AND #$F0
    JEQ single_tile 

    JMP double_tile
done:
    RTS 
.endproc


.proc double_tile
    LDA PPUSTATUS 

    LDY pointer_position
    
    LDA nametable_address_high, Y  
    STA PPUADDR 
    LDA nametable_address_low, Y 
    STA PPUADDR

    LDA sector_1_table, Y
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    STA PPUDATA
    LDA sector_1_table, Y 
    AND #$0F
    STA PPUDATA
    JMP write_nametable::done
.endproc

.proc single_tile
    LDA PPUSTATUS
 
    CPY #$30
    BNE :+
    JMP write
:
    CPY #$31
    BNE :+
    LDY #$30
    JMP write
:
    CPY #$38
    BNE :+
    JMP write
:
    CPY #$34
    BNE :+
    LDY #$38
    JMP write
:
    CPY #$39
    BNE :+
    LDY #$38
    JMP write
:
write:
    LDA nametable_address_high, Y  
    STA PPUADDR 
    LDA nametable_address_low, Y 
    STA PPUADDR

    LDA sector_1_table, Y 
    STA PPUDATA

    JMP write_nametable::done
.endproc

.proc data_port_write       ; write data port buffers to nametable
    LDA PPUSTATUS

    LDY pointer_position
    LDA nametable_address_high, Y 
    STA PPUADDR
    LDA nametable_address_low, Y
    STA PPUADDR

    LDY pointer_X_coord
    BEQ :+
    TYA
    ASL 
    TAY 
:  
    LDA EPSM_ADDR0_buf + 1, Y 
    LSR 
    LSR 
    LSR
    LSR 
    STA PPUDATA
    LDA EPSM_ADDR0_buf + 1, Y 
    AND #$0F
    STA PPUDATA 
    LDA EPSM_ADDR0_buf, Y 
    LSR 
    LSR 
    LSR
    LSR 
    STA PPUDATA
    LDA EPSM_ADDR0_buf, Y 
    AND #$0F
    STA PPUDATA



    JMP write_nametable::done
.endproc

.proc loop_toggle
    LDA PPUSTATUS
    LDA nametable_address_high, Y  
    STA PPUADDR 
    LDA nametable_address_low, Y 
    STA PPUADDR

    LDX #$60
    LDA sector_1_table, Y 
    BEQ :+
    LDX #$70
:
    STX PPUDATA
    JMP write_nametable::done
.endproc

.proc note_tiles
    LDA PPUSTATUS
    LDY pointer_position
    
    LDA nametable_address_high, Y 
    STA PPUADDR 
    LDA nametable_address_low, Y 
    STA PPUADDR
    
    LDA sector_1_table, Y
    TAY 
    LDA note_tile_data, Y 
    STA PPUDATA
    LDA octave_tile_data, Y 
    STA PPUDATA

    JMP write_nametable::done
.endproc

.proc AM_toggle
    LDA PPUSTATUS
    LDA nametable_address_high, Y  
    STA PPUADDR 
    LDA nametable_address_low, Y 
    STA PPUADDR

    LDY pointer_X_coord
    LDX #$60
    LDA sector_1_table + $28, Y 
    BEQ :+
    LDX #$70
:
    STX PPUDATA
    JMP write_nametable::done
.endproc
