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
