/**
* MachineBlocks
* https://machineblocks.com/examples/bricks
*
* Brick 4x1x5
* Copyright (c) 2022 - 2025 Jan Philipp Knoeller <pk@pksoftware.de>
*
* Published under license:
* Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International 
* https://creativecommons.org/licenses/by-nc-sa/4.0/
*
*/

// Imports
// Include brick library to import variables (unitMbu, unitGrid, etc.)
include <./lib-keyboard/brick.scad>;
use <./lib-keyboard/usb_c_cutout.scad>;


// Brick size in X-direction specified as multiple of an 1x1 brick.
brickSizeX = 4; // [1:32]  
// Brick size in Y-direction specified as multiple of an 1x1 brick.
brickSizeY = 2; // [1:32]  
// Height of brick specified as number of layers. Each layer has the height of one plate.
baseLayers = 6; // [1:24]

brick();
