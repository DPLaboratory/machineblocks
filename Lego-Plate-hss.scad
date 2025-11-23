/**
* MachineBlocks
*/

// Imports
include <./lib-keyboard/brick.scad>;
include <./kbl2scad/plates_lib.scad>

/* [Size] */
// Brick size in X-direction specified as multiple of an 1x1 brick.
brickSizeX = 8; // [1:32]  
// Brick size in Y-direction specified as multiple of an 1x1 brick.
brickSizeY = 8; // [1:32]  
// Height of brick specified as number of layers. Each layer has the height of one plate.
baseLayers = 3; // [1:24]

lego_P = 8.0;
lego_h = 9.6 / 3;

union()
{
  difference()
  {
      translate([-lego_P*(brickSizeX/2)-0.2, 
                -lego_P*(brickSizeY/2)-0.2, 0])
          brick();
      
      translate([0, -5,-5])
      {
        linear_extrude(height = 20)
          my_key_holes(true);
      }

    translate([0, 0, (lego_h * baseLayers) + 1.7/2])
      cube([lego_P*(brickSizeX-2), lego_P*(brickSizeY- 2), 1.7], center=true);
  }

  translate([0, -5, (lego_h * baseLayers) - 8])
    my_key_hss() ;
}