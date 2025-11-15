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
use <./lib-keyboard/brick.scad>;
use <./lib-keyboard/usb_c_cutout.scad>;

brick_h = 3.2;
brick_p = 8.0;

lebo_blobk_h_usb_c = 3;

union() 
{
    difference() 
    {
    brick();

    translate([brick_p * 4 /2, brick_p, brick_h * lebo_blobk_h_usb_c])
        rotate(a=90, v=[1,0,0])
         usb_c_hole_cut();
    }

    translate([brick_p * 4 /2, brick_p-0.1, brick_h *lebo_blobk_h_usb_c])
        rotate(a=90, v=[1,0,0])
      usb_c_hole();
}