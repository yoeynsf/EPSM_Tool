.segment "RODATA"

note_tile_data:
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C, $0D, $0E, $0F, $3B, $0A, $0B
	.byte $0C

octave_tile_data:
	.byte $01, $01, $01, $01, $01, $01, $01
	.byte $02, $02, $02, $02, $02, $02, $02
	.byte $03, $03, $03, $03, $03, $03, $03
	.byte $04, $04, $04, $04, $04, $04, $04
	.byte $05, $05, $05, $05, $05, $05, $05
	.byte $06, $06, $06, $06, $06, $06, $06
	.byte $07

pitch_table_1: ; write first
	.dbyt $0C76, $0E80, $0F2A, $0ECA, $1427, $14BA, $1488	; C-1, D-1, E-1, F-1, G-1, A-1, B-1
	.dbyt $1476, $1680, $172A, $16CA, $1C27, $1CBA, $1C88	; C-2, D-2, E-2, F-2, G-2, A-2, B-2
	.dbyt $1C76, $1E80, $1F2A, $1ECA, $2427, $24BA, $2488	; C-3, D-3, E-3, F-3, G-3, A-3, B-3
	.dbyt $2476, $2680, $272A, $26CA, $2C27, $2CBA, $2C88	; C-4, D-4, E-4, F-4, G-4, A-4, B-4
	.dbyt $2C76, $2E80, $2F2A, $2ECA, $3427, $34BA, $3488	; C-5, D-5, E-5, F-5, G-5, A-5, B-5
	.dbyt $3476, $3680, $372A, $36CA, $3C27, $3CBA, $3C88	; C-6, D-6, E-6, F-6, G-6, A-6, B-6
	.dbyt $3C76												; C-7

pitch_table_2: ; write second
	.dbyt $0D63, $0E0C, $0ECA, $0F32, $1409, $1488, $1516	; C-1, D-1, E-1, F-1, G-1, A-1, B-1
	.dbyt $1563, $160C, $16CA, $1732, $1C09, $1C88, $1D16   ; C-2, D-2, E-2, F-2, G-2, A-2, B-2
	.dbyt $1D63, $1E0C, $1ECA, $1F32, $2409, $2488, $2516 	; C-3, D-3, E-3, F-3, G-3, A-3, B-3
	.dbyt $2563, $260C, $26CA, $2732, $2C09, $2C88, $2D16	; C-4, D-4, E-4, F-4, G-4, A-4, B-4
	.dbyt $2D63, $2E0C, $2ECA, $2F32, $3409, $3488, $3516 	; C-5, D-5, E-5, F-5, G-5, A-5, B-5											
	.dbyt $3563, $360C, $36CA, $3732, $3C09, $3C88, $3D16   ; C-6, D-6, E-6, F-6, G-6, A-6, B-6
	.dbyt $3D63												; C-7

PaletteData:
	.byte $0F,$11,$21,$30	
	.byte $0F,$1A,$2A,$3A	
	.byte $0F,$15,$25,$35	
	.byte $0F,$0F,$0F,$0F

	.byte $0F,$11,$15,$30	
	.byte $0F,$21,$30,$11	
	.byte $0F,$0F,$0F,$0F	
	.byte $0F,$0F,$0F,$0F	

pointer_sprite:
	.byte $00, $00, $00, $00
	.byte $80 

edit_sprite:
	.byte $00, $01, %00100000, $00
	.byte $00, $01, %00100000, $08
	.byte $80

algorithm_table_low:
	.byte <sprite_algorithm_1, <sprite_algorithm_2, <sprite_algorithm_3, <sprite_algorithm_4
	.byte <sprite_algorithm_5, <sprite_algorithm_6, <sprite_algorithm_7, <sprite_algorithm_8

algorithm_table_high:
	.byte >sprite_algorithm_1, >sprite_algorithm_2, >sprite_algorithm_3, >sprite_algorithm_4
	.byte >sprite_algorithm_5, >sprite_algorithm_6, >sprite_algorithm_7, >sprite_algorithm_8

sprite_algorithm_1:
	.byte $00, $10, $01, $00
	.byte $00, $11, $01, $08
	.byte $00, $12, $01, $10
	.byte $00, $13, $01, $18
	.byte $00, $14, $01, $20
	.byte $08, $20, $01, $00
	.byte $08, $21, $01, $08
	.byte $08, $22, $01, $10
	.byte $08, $23, $01, $18
	.byte $08, $24, $01, $20
	.byte $80	

sprite_algorithm_2:
	.byte $00, $30, $01, $00
	.byte $00, $31, $01, $08
	.byte $00, $32, $01, $10
	.byte $00, $33, $01, $18
	.byte $00, $34, $01, $20
	.byte $08, $40, $01, $00
	.byte $08, $41, $01, $08
	.byte $08, $42, $01, $10
	.byte $08, $43, $01, $18
	.byte $08, $44, $01, $20
	.byte $80	

sprite_algorithm_3:
	.byte $00, $50, $01, $00
	.byte $00, $51, $01, $08
	.byte $00, $52, $01, $10
	.byte $00, $53, $01, $18
	.byte $00, $54, $01, $20
	.byte $08, $60, $01, $00
	.byte $08, $61, $01, $08
	.byte $08, $62, $01, $10
	.byte $08, $63, $01, $18
	.byte $08, $64, $01, $20
	.byte $80

sprite_algorithm_4:
	.byte $00, $70, $01, $00
	.byte $00, $71, $01, $08
	.byte $00, $72, $01, $10
	.byte $00, $73, $01, $18
	.byte $00, $74, $01, $20
	.byte $08, $80, $01, $00
	.byte $08, $81, $01, $08
	.byte $08, $82, $01, $10
	.byte $08, $83, $01, $18
	.byte $08, $84, $01, $20
	.byte $80	

sprite_algorithm_5:
	.byte $00, $16, $01, $08
	.byte $00, $17, $01, $10
	.byte $00, $18, $01, $18
	.byte $08, $26, $01, $08
	.byte $08, $27, $01, $10
	.byte $08, $28, $01, $18
	.byte $80

sprite_algorithm_6:
	.byte $00, $36, $01, $08
	.byte $00, $37, $01, $10
	.byte $00, $38, $01, $18
	.byte $08, $46, $01, $08
	.byte $08, $47, $01, $10
	.byte $08, $48, $01, $18
	.byte $10, $49, $01, $14
	.byte $80	

sprite_algorithm_7:
	.byte $00, $56, $01, $08
	.byte $00, $57, $01, $10
	.byte $00, $58, $01, $18
	.byte $08, $67, $01, $10
	.byte $08, $68, $01, $18
	.byte $10, $77, $01, $10
	.byte $10, $78, $01, $18
	.byte $80

sprite_algorithm_8:
	.byte $00, $85, $01, $00
	.byte $00, $86, $01, $08
	.byte $00, $87, $01, $10
	.byte $00, $88, $01, $18
	.byte $08, $95, $01, $00
	.byte $08, $96, $01, $08
	.byte $08, $97, $01, $10
	.byte $08, $98, $01, $18
	.byte $80	

nametable:
	.incbin "gfx/editor.nam"

.segment "VECTORS"
	.word NMI
	.word Reset
	.word IRQ