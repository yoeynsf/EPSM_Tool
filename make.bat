ca65 -g header.asm  -o output/header.o
ld65 -C nrom_256.cfg --dbgfile output/epsm.dbg output/header.o -o output/EPSM_tool.nes  
pause