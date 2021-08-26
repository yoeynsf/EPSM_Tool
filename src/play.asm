.proc play_note
    LDA sector_1_table + $37
    BEQ loop_disabled
    JMP loop_enabled

done:
    RTS 
.endproc

.proc loop_enabled
    LDA Flags
    AND #TIMER_FLAG
    BNE done 

    LDA sector_1_table + $33    ; rate
    BEQ stop_loop
    STA temp  
    LDA #$00
    TAY
    LDA loop_timer              ; already 0
calc_timer:
    CLC 
    ADC #$30
    INY
    CPY temp 
    BNE calc_timer
    STA loop_timer
    LDA Flags
    ORA #TIMER_FLAG
    STA Flags

    LDA Flags
    AND #KEY_ON_OFF
    BEQ key_off
key_on:
    LDX #0
    LDA #$28
    STA (EPSM_ADDR0_buf, X)
    LDA #$F0
    STA (EPSM_DATA0_buf, X)
    LDA Flags
    EOR #KEY_ON_OFF
    STA Flags
    JMP done
key_off:
    LDX #0
    LDA #$28
    STA (EPSM_ADDR0_buf, X)
    LDA #$00
    STA (EPSM_DATA0_buf, X)
    LDA Flags
    EOR #KEY_ON_OFF
    STA Flags
    JMP done
stop_loop:
    LDA #$28
    STA (EPSM_ADDR0_buf, X)
    LDA #$00
    STA (EPSM_DATA0_buf, X)
done:
    JMP play_note::done
.endproc 


.proc loop_disabled
    LDA Flags
    AND #LOOP_FLAG
    BEQ :+
    LDA Flags
    AND #%11100111
    STA Flags
    LDA #$28                        ; key off if the loop flag is on
    STA (EPSM_ADDR0_buf, X)
    LDA #$00
    STA (EPSM_DATA0_buf, X)
:


    LDX #0
    LDA held_buttons
    AND #KEY_B
    BNE done

    LDA joystatus
    AND #KEY_B 
    BEQ key_off

key_on:
    LDA #$28
    STA (EPSM_ADDR0_buf, X)
    LDA #$F0
    STA (EPSM_DATA0_buf, X)
    JMP done
key_off:
    LDA #$28
    STA (EPSM_ADDR0_buf, X)
    LDA #$00
    STA (EPSM_DATA0_buf, X)
done:
    JMP play_note::done
.endproc