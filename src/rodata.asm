.segment "RODATA"

PaletteData:
	.byte $0F,$11,$21,$30	
	.byte $0F,$1A,$2A,$3A	
	.byte $0F,$15,$25,$35	
	.byte $0F,$0F,$0F,$0F

	.byte $0F,$0F,$15,$30	
	.byte $0F,$0F,$0F,$0F	
	.byte $0F,$0F,$0F,$0F	
	.byte $0F,$0F,$0F,$0F	

pointer_sprite:
	.byte $00, $00, $00, $00
	.byte $80 

edit_sprite:
	.byte $00, $01, %00100000, $00
	.byte $00, $01, %00100000, $08
	.byte $80

sprite_algorithm_1:
	.byte $00, $10, $00, $00
	.byte $00, $11, $00, $08
	.byte $00, $12, $00, $10
	.byte $00, $13, $00, $18
	.byte $00, $14, $00, $20
	.byte $08, $20, $00, $00
	.byte $08, $21, $00, $08
	.byte $08, $22, $00, $10
	.byte $08, $23, $00, $18
	.byte $08, $24, $00, $20
	.byte $80	
nametable:
	.incbin "gfx/editor.nam"

.segment "VECTORS"
	.word NMI
	.word Reset
	.word IRQ


