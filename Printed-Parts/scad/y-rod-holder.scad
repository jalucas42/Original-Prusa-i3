
use <polyholes.scad>
include <common_dimensions.scad>


rotate([0,-90,0]) 
y_rod(open_end=0);

 translate([25,0,0]) rotate([0,-90,0])
y_rod(open_end=1);

module y_rod_base() {
    // Main base
    hull() {
        translate([0,-50/2,0]) cube([x_beam_width,50,5]);
        translate([0,0,y_rod_to_rail]) rotate([0,90,0]) cylinder( d=y_rod_diam+thinwall, h=x_beam_width );
    }
    
    // Rail guide + support
    if (0) {
        translate([x_beam_width/2-x_railguide_width/2,-12/2,-2.5]) cube([x_railguide_width,12,4]);
        translate([0,-12/2,-3]) cube([(x_beam_width-x_railguide_width)/2,12,1]);
        translate([0,-12/2,-7]) cube([1,12,5]);
    }
    
}

module y_rod_holes(open_end=0) {

    // Rod cutout
    translate([(open_end*-5)+5,0,y_rod_to_rail]) rotate([0,90,0]) cylinder(r=y_rod_diam_tight/2, h=100, $fn=90);
    
    // Tension screw cutout + nut holder
    translate([-1,0,y_rod_to_rail]) rotate([0,90,0]) poly_cylinder(r=1.6, h=100);
    translate([(open_end*-5)+5-2.3,0,y_rod_to_rail]) rotate([0,90,0]) cylinder(d=6.3, h=100, $fn=6);
        
    // Cut off top of rod slot slightly above center point to give some hold
    translate([(open_end*-5)+5,-50/2,y_rod_to_rail+y_rod_diam*0.15]) cube([x_beam_width+2,50,10]);
    
    // Ziptie cutout
    translate([x_beam_width-5-thinwall,0,y_rod_to_rail]) rotate([0,90,0]) rotate_extrude(angle=360) translate([y_rod_diam/2+2,0]) square([2,5]);
    
    // Center marker cutouts
    translate([0,0,-1]) rotate([0,0,0]) cylinder(d=1.5, h=100, $fn=3);
    translate([x_beam_width,0,-1]) rotate([0,0,180]) cylinder(d=1.5, h=100, $fn=3);

    for (i = [0:1]) {
        // Screw hole
        mirror([0,i,0]) translate([x_beam_width/2,17,-1]) rotate([0,0,0]) cylinder(r=1.6, h=100);
        
        //// Screw head cutout
        //mirror([0,i,0]) translate([x_beam_width/2,17,4]) rotate([0,0,0]) poly_cylinder(r=6.5/2, h=100);
        
        // Captive nut hole
        mirror([0,i,0]) translate([x_beam_width/2,17,4]) rotate([0,0,0]) cylinder(r=6.3/2, h=100, $fn=6);
    }
    
}

module y_rod(open_end=0) {
    difference() {
        y_rod_base();
        y_rod_holes(open_end=open_end);
    }
}
