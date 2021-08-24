# EPSM_Tool - Under Development

A ROM for the NES built for use with the [**Expansion Port Sound Module**](https://github.com/Perkka2/EPSM). Also included is my personal documentation
of the YMF288/YM2608, mainly with the EPSM in mind and it's functionality with the NTSC NES. 

## Usage
The parameters are styled after Bambootracker's patch editor. 

## Main Editor

`A + Up/Down` - Increment/Decrement the high nibble by 1

`A + Left/Right` - Increment/Decrement the low nibble by 1 

If the parameter is only a single nibble, then `A + Up/Down` does't apply. 

## **Data Ports**

`A + Up/Down` - Increment/Decrement the MSB by 1

`A + Left/Right` - Increment/Decrement the LSB by 1 

Used to control where the NES sends data, defaulting to:
```
$C000 - Address where A1 = 0
$E000 - Data where A1 = 0
$C002 - Address where A1 = 1
$E002 - Data where A1 = 1
```
It is also planned for the EPSM to support this kind of addressing as well, requiring extra ICs in the cartridge. Will update as that comes to fruition:
```
$401C - Address where A1 = 0
$401D - Data where A1 = 0
$401E - Address where A1 = 1
$401F - Data where A1 = 1
```

In order to prevent stray writes to the NES's internal registers, the data ports have a lowest value of `$4018`.

## **Play**

 **`Rate`** - Half-seconds in between  `Key On` commands and `Key Off` commands. 
 
 **`Loop`** - Used to keep the patch playing while you edit parameters. Works in conjunction with `Rate`and `Note.` toggles with `A + L/R` 
 
 **`Note`** - Pitch to play patch at. Currently only scales in the key of C Major, no accidentals (C1-B4). A dedicated MIDI cartridge for the tool is planned, allowing for 6-channel playback of patches in real time (not constrained to a scale). 
              
## Special Thanks

 - Perkka, for supplying the EPSM 
 - zeta0134, for putting up with my code and helping out with the pointer system  
 - Lidnariq, for their help with the doc and somehow answering every question of mine
 - Lockster and Bluemarf.m, for being sounding boards for my ideas 
