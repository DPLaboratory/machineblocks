// Ergo plate in Lego
// Imports
include <./lib-keyboard/brick-plate.scad>;
include <./kbl2scad/plates_lib.scad>

/* [Size] */

// Box size in X-direction specified as multiple of an 1x1 brick.
boxSizeX = 24; // [1:32] 
// Box size in Y-direction specified as multiple of an 1x1 brick.
boxSizeY = 15; // [1:32] 
// Total box height specified as number of layers. Each layer has the height of one plate.
boxLayers = 1; // [1:24]

hss = false; // Add holes for hss screws

// Pit wall thickness
basePitWallThickness = [5, 5, 5, 5];

stl_file = "./STL/Plate/switch_plate_right.stl";   // Nome del file STL

border = 14;        // spessore del bordo in mm
border_height = 5;   // quanto sporge il bordo in Z

module plate() {
    rotate([0,180, 0]) import(stl_file, convexity = 5, center = true);
}

// contorno
module contorno() {
    offset(delta = -10)
    {
    offset(delta = 10) 
        projection(cut = false)  
         plate();
    }
}

module lego_plate()
{
    difference()
    {
        intersection() {
            translate([-lego_P*(boxSizeX/2)-0.2, 
                -lego_P*(boxSizeY/2)-0.2, 0])
                    brick_plate();  
                        
            linear_extrude(height = border_height)
                offset(delta = border) 
                    contorno();    
        }

        linear_extrude(height = border_height)
            contorno();   
    }  
}  

lego_plate();
  
translate([0,0,4])
    plate();

// Aumenta i bordi
//minkowski() {
//    plate();
//    cube([2*border, 2*border, 0.01], center = true); // ingrandisce solo XY
//}


// Profilo modo 2
//module plate_border() {
//    // projection(cut = true) plate();
//    linear_extrude(height = border_height)
//        difference() {
//            offset(delta = border) projection(cut = true) plate(); // profilo allargato
//            projection(cut = true) plate();                        // scava il vuoto centrale
//        }
//}
//
//translate([0, 0, size_z/2 - border_height]) plate_border();



