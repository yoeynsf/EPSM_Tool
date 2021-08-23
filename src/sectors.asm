; $FF = Invalid
; $FE = Pitch
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
data_port_positions:
    .byte $28, $29, $2A, $2B
sector_2_positions:  
    .byte $2C, $2C, $2D, $2E 
    .byte $31, $31, $2F, $30 
    .byte $31, $31, $32, $33
    .byte $FF, $FF, $FF, $FF

all_sector_registers:             
    .byte $50, $58, $54, $5C
    .byte $60, $68, $64, $6C
    .byte $70, $78, $74, $7C
    .byte $80, $88, $84, $8C
    .byte $80, $88, $84, $8C
    .byte $40, $48, $44, $4C
    .byte $50, $58, $54, $5C
    .byte $30, $38, $34, $3C
    .byte $30, $38, $34, $3C
    .byte $90, $98, $94, $9C   
; no registers for data ports
    .byte $B0, $B0, $22, $FF              
    .byte $B0, $B0, $B4, $FF
    .byte $B0, $B0, $B4, $FE


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
    .byte $18, $48, $80, $B0    ; data ports
    .byte $40, $40, $88, $C8    ; sector 2
    .byte $40, $40, $88, $C8 
    .byte $40, $40, $88, $C8 

cursor_position_Y:
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
