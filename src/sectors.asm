; $FF = Invalid
sector_1_positions:             ; use as an index into register table
    .byte $00, $01, $02, $03
    .byte $04, $05, $06, $07
    .byte $08, $09, $0A, $0B
    .byte $0C, $0D, $0E, $0F
    .byte $10, $11, $12, $13
    .byte $14, $15, $16, $17
    .byte $18, $19, $1A, $1B
    .byte $1C, $1D, $1E, $1F
    .byte $20, $21, $22, $23
    .byte $24, $25, $26, $27
    .byte $28, $29, $2A, $2B
data_port_positions:  
    .byte $2C, $2D, $2E, $2F
sector_2_positions:
    .byte $30, $30, $31, $32
    .byte $33, $33, $34, $35 
    .byte $33, $33, $36, $37
    .byte $FF, $FF, $FF, $FF

all_sector_registers:       
    .byte $40, $48, $44, $4C      
    .byte $50, $58, $54, $5C
    .byte $60, $68, $64, $6C
    .byte $70, $78, $74, $7C
    .byte $80, $88, $84, $8C
    .byte $80, $88, $84, $8C
    .byte $50, $58, $54, $5C
    .byte $30, $38, $34, $3C
    .byte $30, $38, $34, $3C
    .byte $90, $98, $94, $9C   
    .byte $60, $68, $64, $6C 
    .byte $FF, $FF, $FF, $FF    ; data ports
    .byte $B0, $B0, $22, $FF    ; sector 2
    .byte $B0, $B0, $B4, $FF    ; sector 2
    .byte $B0, $B0, $B4, $FF


cursor_position_X:
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $30, $60, $90, $C0
    .byte $18, $48, $80, $B0    ; data ports
    .byte $40, $40, $80, $C8    ; sector 2
    .byte $40, $40, $80, $C8 
    .byte $40, $40, $80, $C8 

cursor_position_Y:
    .byte $38, $38, $38, $38
    .byte $40, $40, $40, $40
    .byte $48, $48, $48, $48
    .byte $50, $50, $50, $50
    .byte $58, $58, $58, $58
    .byte $60, $60, $60, $60
    .byte $68, $68, $68, $68
    .byte $70, $70, $70, $70
    .byte $78, $78, $78, $78
    .byte $80, $80, $80, $80
    .byte $88, $88, $88, $88
    .byte $A0, $A0, $A0, $A0    ; data ports
    .byte $B0, $B0, $B8, $B8    ; sector 2              
    .byte $D0, $D0, $C0, $C0
    .byte $D0, $D0, $C8, $C8 

max_values:
    .byte $7F, $7F, $7F, $7F
    .byte $1F, $1F, $1F, $1F
    .byte $1F, $1F, $1F, $1F
    .byte $1F, $1F, $1F, $1F
    .byte $0F, $0F, $0F, $0F
    .byte $0F, $0F, $0F, $0F
    .byte $03, $03, $03, $03
    .byte $0F, $0F, $0F, $0F
    .byte $07, $07, $07, $07
    .byte $08, $08, $08, $08
    .byte $01, $01, $01, $01
    .byte $FF, $FF, $FF, $FF    ; data ports
    .byte $07, $07, $07, $08    ; sector 2
    .byte $07, $07, $07, $01
    .byte $07, $07, $03, $2A    

; Note range is C-1 through B-4

nametable_address_low:
    .byte $E7, $ED, $F3, $F9
    .byte $07, $0D, $13, $19
    .byte $27, $2D, $33, $39
    .byte $47, $4D, $53, $59
    .byte $68, $6E, $74, $7A
    .byte $88, $8E, $94, $9A
    .byte $A8, $AE, $B4, $BA
    .byte $C8, $CE, $D4, $DA
    .byte $E8, $EE, $F4, $FA
    .byte $08, $0E, $14, $1A
    .byte $28, $2E, $34, $3A

    .byte $85, $8B, $92, $98    ; data ports
    .byte $CA, $CA, $F2, $FB    ; sector 2
    .byte $4A, $4A, $12, $1B
    .byte $4A, $4A, $32, $3A

nametable_address_high:
    .byte $20, $20, $20, $20
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $21, $21, $21, $21
    .byte $22, $22, $22, $22
    .byte $22, $22, $22, $22

    .byte $22, $22, $22, $22    ; data ports
    .byte $22, $22, $22, $22    ; sector 2
    .byte $23, $23, $23, $23
    .byte $23, $23, $23, $23
