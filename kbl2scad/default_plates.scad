/*
 * This file will make a laser cut case for the generated keys in keys.scad.
 * The default is a square, but edit the arrays plate_corners and
 * inside_corners to get a different shape.
 */
 
//use <keys.scad>;
use <test.scad>;
//use <pad4x3.scad>;
//use <numpad.scad>;


/* Set output quality */
$fn = 50;

/* Some values. Don't change key_spacing. Units in mm */
key_spacing = 19.0;
screw_hole = 1.5;
washer_rad = 5.0;

/* Pull the bounding box from the keyfile. */
bounding = bbox();

x1 = key_spacing*(bounding[0]);//+washer_rad;
y1 = key_spacing*(bounding[1]);//+washer_rad;
x2 = key_spacing*(bounding[0]+bounding[2]);
y2 = key_spacing*(bounding[1]+bounding[3]);

/* Screw holes will be placed at these points. */
plate_corners = [
    [x1, y1],
    [x2, y1],
    [x1, y2],
    [x2, y2]];
/* Defines the inside cavity... TODO: I can do better... */
inside_corners = [
    [x1+washer_rad, y1+washer_rad],
    [x2-washer_rad, y1+washer_rad],
    [x1+washer_rad, y2-washer_rad],
    [x2-washer_rad, y2-washer_rad]];

/* Helper routine */
module place_stuff(points) {
    for( pt = points ) {
	translate(pt) child();
    }
}

/*
 * Layer construction:
 */

/* Defines the boundary of the case */
module boundary() {
    difference() {
	hull() {
	    place_stuff(plate_corners) circle(washer_rad);
	}
	place_stuff(plate_corners) circle(screw_hole);
	translate([key_spacing*(-3.0),key_spacing*(0.0)]) circle(screw_hole);
	translate([key_spacing*( 3.0),key_spacing*(0.0)]) circle(screw_hole);
    }
}

/* The top plate with the switch holes. Set flag to true to use notches. */
module plate() {
    difference() {
	boundary();
	my_key_holes(true);
	/* Add other features here */
    }
}

/* This is the spacer that makes the sides of the case. */
module spacer() {
    difference() {
	boundary();
	difference() {
	    hull() {
		place_stuff(inside_corners) circle(washer_rad);
	    }
	    translate([key_spacing*(3.0),key_spacing*(0.0)]) circle(washer_rad);
	    translate([key_spacing*(-3.0),key_spacing*(0.0)]) circle(washer_rad);
	    place_stuff(plate_corners) circle(washer_rad);

	}
    }
}

/* This is the bottom plate. It's trivial. */
module base() {
    boundary();
}

/*
 * Put all of the layers in a grid.
 */
module cuts() {
    plate();
    translate([0,-key_spacing*(bounding[3])-3*washer_rad]) {
	base();
    }
    translate([key_spacing*(bounding[2])+30,0]) {
	spacer();
    }
    translate([key_spacing*(bounding[2])+30, -key_spacing*(bounding[3])-3*washer_rad]) {
	spacer();
    }
}


/*
 * Create a 3D rendering.
 * The layers are mean to be 1.5mm acrylic and 6.4mm MDF. Edit the numbers to fit for what you'll be using.
 */
module preview(explode=1.0) {
    translate([0.0,0.0,-4.0+explode*2]) my_key_previews();

    translate([0,0,-6.4-explode*1]) {
	linear_extrude(6.4) {
	    spacer();
	}
    }
    translate([0,0,-6.4-6.4-explode*2]) {
	linear_extrude(6.4) {
	    spacer();
	}
    }
    translate([0,0,-(6.4+6.4+1.5)-explode*3]) {
	color([0.8,0.8,0.8,0.5])linear_extrude(1.5) {
	   boundary();
	}
    }
    color([0.8,0.8,0.8,0.5]) linear_extrude(1.5) {
	 plate();
    }
}

/*
 * Comment these two lines in and out as you design. Only have cuts uncommented to make the DXF.
 */
// cuts();
//preview(30.0);
//plate();

//boundary();
my_key_holes(true);

