/**
* MachineBlocks
*/

// Imports
include <./lib-keyboard/brick.scad>;
include <./kbl2scad/plates_lib.scad>

/* [Size] */
// Brick size in X-direction specified as multiple of an 1x1 brick.
brickSizeX = 4; // [1:32]  
// Brick size in Y-direction specified as multiple of an 1x1 brick.
brickSizeY = 2; // [1:32]  
// Height of brick specified as number of layers. Each layer has the height of one plate.
baseLayers = 1; // [1:24]

lego_P = 8.0;

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
}

 translate([0, -5,-5])
  my_key_hss() ;




//brick();