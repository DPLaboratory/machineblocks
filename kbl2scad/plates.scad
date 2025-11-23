/*
 * This file will make a laser cut case for the generated keys in keys.scad.
 * The default is a square, but edit the arrays plate_corners and
 * inside_corners to get a different shape.
 */

include <plates_lib.scad>;

//include <./plate/keys.scad>;
/*
 * Comment these two lines in and out as you design. Only have cuts uncommented to make the DXF.
 */

//cuts();

//preview(30.0);

//plate();

//boundary();

//linear_extrude(height = 20)
// my_key_holes(true);

my_key_hss() ;
