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
