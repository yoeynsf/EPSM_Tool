.proc write_registers ; make sure that we're only reading from #$32 and #$38
    LDY pointer_position
   
    LDA pointer_Y_coord
    CMP #$0A 
    BNE :+
    JMP AM_Decay
:
    CMP #$02 
    BNE :+
    JMP AM_Decay
:
    CMP #$09
    BNE :+
    JMP SSG_EG_write
:

    CPY #$32
    BNE :+
    JMP LFO_write
:
    CPY #$36
    BNE :+
    JMP LFO_write
:
    CPY #$3A
    BNE :+
    JMP LFO_write
:

    CPY #$30
    BNE :+
    JMP algorithm_feed
:
    CPY #$31
    BNE :+
    LDY #$30
    JMP algorithm_feed
:

    CPY #$38
    BNE :+
    JMP algorithm_feed
:
    CPY #$34
    BNE :+
    LDY #$38
    JMP algorithm_feed
:
    CPY #$39
    BNE :+
    LDY #$38
    JMP algorithm_feed
:


    CPY #$3B            ; note change
    BNE :+
    JMP freq_write
:

    LDA pointer_Y_coord
    CMP #1
    BNE :+
    JMP attack_keyscale
:
    CMP #6
    BNE :+
    JMP attack_keyscale
:
    CMP #$04
    BNE :+
    JMP sustain_release
:
    CMP #$05
    BNE :+
    JMP sustain_release
:
    CMP #$07
    BNE :+
    JMP detune_freq
:
    CMP #$08
    BNE :+
    JMP detune_freq
:

write:
    LDX #0
    LDA all_sector_registers, Y 
    CMP #$FF 
    BEQ skip
    STA (EPSM_ADDR0_buf, X)
    LDA sector_1_table, Y 
    STA (EPSM_DATA0_buf, X) 
skip:
    RTS 
.endproc

.proc freq_write 
    LDX #0
    LDA #$A4                    ; high byte 
    STA (EPSM_ADDR0_buf, X)
    LDA sector_1_table, Y
    ASL                         ; X2 because we're indexing into a table of words
    TAY 
    LDA pitch_table_1, Y
    STA (EPSM_DATA0_buf, X)
    LDA #$A0                    ; low byte
    STA (EPSM_ADDR0_buf, X)
    INY 
    LDA pitch_table_1, Y
    STA (EPSM_DATA0_buf, X)

    LDA #$A4
    STA (EPSM_ADDR0_buf, X)
    DEY 
    LDA pitch_table_2, Y
    STA (EPSM_DATA0_buf, X)
    LDA #$A0                    ; low byte
    STA (EPSM_ADDR0_buf, X)
    INY 
    LDA pitch_table_2, Y
    STA (EPSM_DATA0_buf, X)

    JMP write_registers::skip 
.endproc

.proc attack_keyscale
    LDX #0 

    LDY pointer_position
    LDA all_sector_registers, Y 
    STA (EPSM_ADDR0_buf, X)
    
    LDY pointer_X_coord
    LDA sector_1_table + $04, Y
    STA temp 
    LDA sector_1_table + $18, Y
    ASL                                 ; kk00 aaaa (k = key scale, a= attack) 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    ORA temp 
    STA (EPSM_DATA0_buf, X)    
    JMP write_registers::skip 
.endproc

.proc algorithm_feed
    LDX #0 
    LDY pointer_position

    LDA all_sector_registers, Y 
    STA (EPSM_ADDR0_buf, X)

    LDA sector_1_table + $30
    STA temp 
    LDA sector_1_table + $38
    ASL                                 ; 00ff faaa (f = feedback, a = algorithm)
    ASL 
    ASL 
    ORA temp 
    STA (EPSM_DATA0_buf, X)

    JMP write_registers::skip 
.endproc

.proc sustain_release
    LDX #0 

    LDY pointer_position
    LDA all_sector_registers, Y 
    STA (EPSM_ADDR0_buf, X)
    
    LDY pointer_X_coord
    LDA sector_1_table + $10, Y
    STA temp 
    LDA sector_1_table + $14, Y
    ASL                                 ; kk00 aaaa (k = key scale, a= attack) 
    ASL 
    ASL 
    ASL 
    ORA temp 
    STA (EPSM_DATA0_buf, X)    
    JMP write_registers::skip
.endproc

.proc LFO_write
    LDX #0
    LDA #$22
    STA (EPSM_ADDR0_buf, X)
    LDA sector_1_table + $32
    ORA #%00001000              ; LFO enable bit
    STA (EPSM_DATA0_buf, X)

    LDA #$B4
    STA (EPSM_ADDR0_buf, X)
    LDA #%11000000              ; L/R channel set
    STA temp 
    LDA sector_1_table + $36    ; PMS
    ORA temp
    STA temp 
    LDA sector_1_table + $3A    ; AMS 
    ASL 
    ASL 
    ASL 
    ASL 
    ORA temp 
    STA (EPSM_DATA0_buf, X)
    JMP write_registers::skip
.endproc

.proc detune_freq
    LDX #$00
    LDY pointer_position
    LDA all_sector_registers, Y
    STA (EPSM_ADDR0_buf, X)

    LDY pointer_X_coord
    LDA sector_1_table + $1C, Y
    STA temp 
    LDA sector_1_table + $20, Y
    ASL 
    ASL 
    ASL 
    ASL 
    ORA temp
    STA (EPSM_DATA0_buf, X)
    JMP write_registers::skip
.endproc

.proc AM_Decay
    LDX #$00
    LDY pointer_position
    LDA all_sector_registers, Y
    STA (EPSM_ADDR0_buf, X)

    LDY pointer_X_coord
    LDA sector_1_table + $08, Y         ; decay
    STA temp 
    LDA sector_1_table + $28, Y         ; AM bit
    CLC
    ROR
    ROR 
    ORA temp 
    STA (EPSM_DATA0_buf, X)
    JMP write_registers::skip
.endproc

.proc SSG_EG_write
    LDX #$00 
    LDY pointer_position
    LDA all_sector_registers, Y 
    STA (EPSM_ADDR0_buf, X)

    LDY pointer_X_coord
    LDA sector_1_table + $24, Y
    BEQ :+
    SEC 
    SBC #1
    ORA #%00001000                  ; "enable" bit
:
    STA (EPSM_DATA0_buf, X)

    JMP write_registers::skip 
.endproc