/*
 * Routine for placing switch holes for various types of switches
 */
module switch_hole(center_pt, notched=false, type=1) {
  /*
   * Routine for placing switch holes.
   * Sizes come from Cherry's data sheets (see resources/)
   * TODO: add other types of switches
   * TODO: pull the kerf value from some laser cutter.
   */
   kerf = 0.005;
   // TODO: WTF? Can't assign in if statements? This is a SolidPython candidate
   width = 14.0 - kerf / 2.0;

   translate(center_pt) {
       square([width, width], center=true);
       if(notched) {
	   // TODO: Include
       }
   }
};

/*
 * Taken from Planck case.
 */
module m_switch(w, h) {
  color([.2,.2,.2,.8])
    translate([0, 0, 11.6/2])
      scale([14,14,11.6])
        cube(center=true);
}
module m_cap(w, h, r = 2) {
  color([.9,.9,.9,.8])
      linear_extrude(9,scale=.5/.75) {
        minkowski() {
          scale([w-2*r,h-2*r])
            square(center=true);
          circle(r, $fn=100);
        }
      }
}
module m_key(w, h,c) {
  // z fn
  translate([0, 0, -1.8+5+7.5])
    color(c) m_cap(w, h);
    m_switch(w, h);
}
key_spacing = 19;
module my_key_holes(use_notches=true) {
switch_hole([-28.5,42.75],use_notches);
switch_hole([-9.5,42.75],use_notches);
switch_hole([9.5,42.75],use_notches);
switch_hole([28.5,42.75],use_notches);
switch_hole([-28.5,23.75],use_notches);
switch_hole([-9.5,23.75],use_notches);
switch_hole([9.5,23.75],use_notches);
switch_hole([28.5,14.25],use_notches);
switch_hole([-28.5,4.75],use_notches);
switch_hole([-9.5,4.75],use_notches);
switch_hole([9.5,4.75],use_notches);
switch_hole([-28.5,-14.25],use_notches);
switch_hole([-9.5,-14.25],use_notches);
switch_hole([9.5,-14.25],use_notches);
switch_hole([28.5,-23.75],use_notches);
switch_hole([-19.0,-33.25],use_notches);
switch_hole([9.5,-33.25],use_notches);
}
module my_key_previews(use_notches=true) {
translate([-28.5, 42.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-9.5, 42.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([9.5, 42.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([28.5, 42.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-28.5, 23.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-9.5, 23.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([9.5, 23.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([28.5, 14.25]) m_key(1*18.415+(1-1)*0.6, 2.0*18.415+(2.0-1)*0.6,Grey);
translate([-28.5, 4.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-9.5, 4.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([9.5, 4.75]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-28.5, -14.25]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([-9.5, -14.25]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([9.5, -14.25]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([28.5, -23.75]) m_key(1*18.415+(1-1)*0.6, 2.0*18.415+(2.0-1)*0.6,Grey);
translate([-19.0, -33.25]) m_key(2.0*18.415+(2.0-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
translate([9.5, -33.25]) m_key(1*18.415+(1-1)*0.6, 1*18.415+(1-1)*0.6,Grey);
}
function bbox() = [-2.0, -2.75, 4.0, 5.5];
