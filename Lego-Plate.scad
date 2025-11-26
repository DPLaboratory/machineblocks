/**
* MachineBlocks
*/

// Imports
include <./lib-keyboard/brick-plate.scad>;
include <./kbl2scad/plates_lib.scad>

/* [Size] */

// Box size in X-direction specified as multiple of an 1x1 brick.
boxSizeX = 12; // [1:32] 
// Box size in Y-direction specified as multiple of an 1x1 brick.
boxSizeY = 14; // [1:32] 
// Total box height specified as number of layers. Each layer has the height of one plate.
boxLayers = 1; // [1:24]

hss = false; // Add holes for hss screws

union()
{
    difference()
    {
        translate([-lego_P*(boxSizeX/2)-0.2, 
                -lego_P*(boxSizeY/2)-0.2, 0])
            brick_plate();
        
        translate([0, -5,-5])
        {
        linear_extrude(height = 20)
            my_key_holes(true);
        }
    }

    if (hss)
    {
        translate([0, -5, 0])
        my_key_hss();
    }
}