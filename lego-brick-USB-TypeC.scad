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

// derive brick dimensions from library configuration
// pitch (brick_p) = unitGrid[0] * unitMbu  (e.g. 5 * 1.6 = 8.0 mm)
brick_p = unitGrid[0] * unitMbu;

// brick height per layer: 2 * unitMbu = 3.2 mm with default unitMbu=1.6
brick_h = unitMbu * (brickSizeX/2);

// number of layers to shift the USB cutout (kept as a simple integer here)
lebo_blobk_h_usb_c = 3;

union() 
{
    difference() 
    {
    brick();

    translate([brick_p * brickSizeX /2, brick_p*brickSizeY, unitMbu * 2 * lebo_blobk_h_usb_c])
        rotate(a=90, v=[1,0,0])
         usb_c_hole_cut(height=brick_p*brickSizeY);
    }

    translate([brick_p * brickSizeX /2, brick_p*brickSizeY, unitMbu * 2 * lebo_blobk_h_usb_c])
     rotate(a=90, v=[1,0,0])
      usb_c_hole(height=brick_p*brickSizeY);
}