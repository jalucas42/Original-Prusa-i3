
use <polyholes.scad>
include <common_dimensions.scad>

module y_rod_base() {
    // Main base
    hull() {
        translate([0,-50/2,0]) cube([27,50,5]);
        translate([0,0,y_rod_to_rail]) rotate([0,90,0]) cylinder( d=y_rod_diam+thinwall, h=27 );
    }
    // Rail guide + support
    translate([27/2-8.25/2,-12/2,-2.5]) cube([8.25,12,4]);
    translate([0,-12/2,-3]) cube([(27-8.25)/2,12,1]);
}

module y_rod_holes() {

    // Rod cutout
    translate([5,0,y_rod_to_rail]) rotate([0,90,0]) poly_cylinder(r=y_rod_diam_tight/2, h=100, $fn=90);
    
    // Tension screw cutout + nut holder
    translate([-1,0,y_rod_to_rail]) rotate([0,90,0]) poly_cylinder(r=1.3, h=100);
    translate([5-2.3,0,y_rod_to_rail]) rotate([0,90,0]) cylinder(d=6.3, h=100, $fn=6);
        
    // Cut off top of rod slot slightly above center point to give some hold
    translate([+5,-50/2,y_rod_to_rail+y_rod_diam*0.15]) cube([27+2,50,10]);
    
    // Ziptie cutout
    translate([27-4-thinwall,0,y_rod_to_rail]) rotate([0,90,0]) rotate_extrude(angle=360) translate([y_rod_diam/2+thinwall,0]) square([3,4]);
    
    // Center marker cutouts
    translate([0,0,-1]) rotate([0,0,0]) cylinder(d=1.5, h=100, $fn=3);
    translate([27,0,-1]) rotate([0,0,180]) cylinder(d=1.5, h=100, $fn=3);

    for (i = [0:1]) {
        // Screw hole
        mirror([0,i,0]) translate([27/2,17,-1]) rotate([0,0,0]) poly_cylinder(r=y_rod_screw_diam/2, h=100);
        
        // Screw head cutout
        mirror([0,i,0]) translate([27/2,17,4]) rotate([0,0,0]) poly_cylinder(r=y_rod_screw_diam*1.25, h=100);
    }
    
}

module y_rod() {
    difference() {
        y_rod_base();
        y_rod_holes();
    }
}

rotate([0,0,0]) y_rod();