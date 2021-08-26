KEY_R         = 1 << 0
KEY_L         = 1 << 1 
KEY_D         = 1 << 2
KEY_U         = 1 << 3
KEY_STA       = 1 << 4
KEY_SEL       = 1 << 5
KEY_B         = 1 << 6
KEY_A         = 1 << 7

SPRITEZERO    = 1 << 6

PPUCTRL       = $2000
PPUMASK       = $2001
PPUSTATUS     = $2002
OAMADDR       = $2003
OAMDATA       = $2004
PPUSCROLL     = $2005
PPUADDR       = $2006
PPUDATA       = $2007
OAMDMA        = $4014
JOYPAD1       = $4016
JOYPAD2       = $4017

TIMER_FLAG      = 1 << 0
IRQ_FLAG        = 1 << 1
EDIT_FLAG       = 1 << 2
LOOP_FLAG       = 1 << 3
KEY_ON_OFF      = 1 << 4


DRAW_FLAG       = 1 << 0
COLUMN_FLAG     = 1 << 1
ROW_FLAG        = 1 << 2
DRAW_ATTR_FLAG  = 1 << 3
ATTR_COL_FLAG   = 1 << 4 
ATTR_ROW_FLAG   = 1 << 5

EPSM_ADDR0      = $C000
EPSM_DATA0      = $E000
EPSM_ADDR1      = $C002
EPSM_DATA1      = $E002

NOTE_C1         = $00           ; index into tile and note table
NOTE_D1         = $01
NOTE_E1         = $02
NOTE_F1         = $03
NOTE_G1         = $04
NOTE_A1         = $05
NOTE_B1         = $06

NOTE_C2         = $07
NOTE_D2         = $08
NOTE_E2         = $09
NOTE_F2         = $0A
NOTE_G2         = $0B
NOTE_A2         = $0C
NOTE_B2         = $0D

NOTE_C3         = $0E
NOTE_D3         = $0F
NOTE_E3         = $10
NOTE_F3         = $11
NOTE_G3         = $12
NOTE_A3         = $13
NOTE_B3         = $14

NOTE_C4         = $15
NOTE_D4         = $16
NOTE_E4         = $17
NOTE_F4         = $18
NOTE_G4         = $19
NOTE_A4         = $1A
NOTE_B4         = $1B

NOTE_C5         = $1C
NOTE_D5         = $1D
NOTE_E5         = $1E
NOTE_F5         = $1F
NOTE_G5         = $20
NOTE_A5         = $21
NOTE_B5         = $22

NOTE_C6         = $23
NOTE_D6         = $24
NOTE_E6         = $25
NOTE_F6         = $27
NOTE_G6         = $28
NOTE_A6         = $29
NOTE_B6         = $2A

NOTE_C7         = $2B