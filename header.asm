.include "longbranch.mac"
.include "src/defines.inc"

.segment "HEADER" ; NROM
	.byte "NES"
	.byte $1A
	.byte $01  ; 2 * 16KB PRG ROM
	.byte $01  ; 1 * 8KB CHR ROM
	.byte %00000010 ; mapper and mirroring (battery present)
	.byte %00000000
	.byte $00
	.byte $00
	.byte $00 
	.byte $00, $00, $00, $00, $00  ; filler bytes

.segment "ZEROPAGE"
pointer:						.res 2
held_buttons:					.res 1
joystatus:						.res 1
framecounter:					.res 1
currentOAMpos:                  .res 1
OAMposAtFrame:                  .res 1
pointer_Xpos:					.res 1
pointer_Ypos:					.res 1
TempY:                          .res 1
TempX:                          .res 1
Flags:							.res 1
shadowPPUMASK:					.res 1
pointer_position:				.res 1
pointer_X_coord:				.res 1
pointer_Y_coord:				.res 1
temp:							.res 1
EPSM_ADDR0_buf:					.res 2
EPSM_DATA0_buf:					.res 2
EPSM_ADDR1_buf:					.res 2
EPSM_DATA1_buf:					.res 2
nametable_pointer:				.res 2
loop_timer:						.res 1

.segment "INTERNALRAM"
bgpalettes:						.res 16
sprpalettes:					.res 16

sector_1_table:					.res 44				
data_ports:						.res 4
sector_2_table:					.res 12





.segment "BANK0"
	.include "src/init.asm"
	.include "src/main.asm"
	.include "src/nmi.asm"
	.include "src/irq.asm"
	.include "src/edit_mode.asm"
	.include "src/subroutines.asm"
	.include "src/nametable.asm"
	.include "src/registerwrite.asm"
	.include "src/play.asm"
	.include "src/sectors.asm"
	.include "src/rodata.asm"

.segment "CHR"
	.incbin "src/gfx/epsm.chr"
