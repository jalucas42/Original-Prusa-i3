
use <polyholes.scad>

rod_diam = 7.94;
screw_diam = 3.0;

module y_rod_base() {
    // Main base
    translate([0,-50/2,0]) cube([20,50,11+rod_diam*0.6]);
    
    // Rail guide + support
    translate([10-8.25/2,-12/2,-2.5]) cube([8.25,12,4]);
    translate([0,-12/2,-3]) cube([(20-8.25)/2,12,1]);
}

module y_rod_holes() {
    
    // Rod cutout
    translate([4,0,11+rod_diam/2]) rotate([0,90,0]) poly_cylinder(r=rod_diam/2, h=100, $fn=90);
    
    // Ziptie cutout
    translate([12,0,11+rod_diam/2]) rotate([0,90,0]) rotate_extrude(angle=360) translate([rod_diam/2+3,0]) square([3,4]);
    
    for (i = [0:1]) {
        // Top angle cutout
        mirror([0,i,0]) translate([-10,-10,26]) rotate([-30,0,0]) cube([100,100,100]);
        
        // Screw hole
        mirror([0,i,0]) translate([10,17,-1]) rotate([0,0,0]) poly_cylinder(r=screw_diam/2, h=100);
        
        // Screw head cutout
        mirror([0,i,0]) translate([10,17,4]) rotate([0,0,0]) poly_cylinder(r=8/2, h=100);
    }
    
    // Center marker cutouts
    translate([0,0,-1]) rotate([0,0,0]) cylinder(d=1.5, h=100, $fn=3);
    translate([20,0,-1]) rotate([0,0,180]) cylinder(d=1.5, h=100, $fn=3);
}

module y_rod() {
    difference() {
        y_rod_base();
        y_rod_holes();
    }
}

rotate([0,-90,0]) y_rod();