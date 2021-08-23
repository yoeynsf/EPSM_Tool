# EPSM_Tool - Under Development

A ROM for the NES built for use with the [**Expansion Port Sound Module**](https://github.com/Perkka2/EPSM). Also included is my personal documentation
of the YMF288/YM2608, mainly with the EPSM in mind and it's functionality with the NTSC NES. 

## Usage
The parameters are styled after Bambootracker's patch editor. 

## **Data Ports**

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

## **Play**

 **`Rate`** - Half-seconds in between  `Key On` commands and `Key Off` commands. 
 
 **`Loop`** - Used to keep the patch playing while you edit parameters. Works in conjunction with `Rate`and `Note`
 
 **`Note`** - Pitch to play patch at. Currently only scales in the key of C Major, no accidentals. A dedicated MIDI cartridge with the tool is planned, allowing for 6-channel playback of patches in real time. 
              
 
