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
include <./lib-keyboard/panel.scad>;
use <./lib-keyboard/usb_c_cutout.scad>;

// Box size in X-direction specified as multiple of an 1x1 brick.
boxSizeX = 1; // [1:32] 
// Box size in Y-direction specified as multiple of an 1x1 brick.
boxSizeY = 4; // [1:32] 
// Total box height specified as number of layers. Each layer has the height of one plate.
boxLayers = 3; // [1:24]


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
    panel();

    translate([-2, (brick_p*boxSizeY) /2, 6])
    rotate(a=90, v=[0,1,0])
     rotate(a=90, v=[0,0,1])
      usb_c_cutout();
    }

    // translate([-2, (brick_p*boxSizeY) /2, 5])
    // rotate(a=90, v=[0,1,0])
    //  rotate(a=90, v=[0,0,1])
    //   usb_c_cutout();
}