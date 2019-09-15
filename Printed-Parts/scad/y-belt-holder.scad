
use <polyholes.scad>
include <common_dimensions.scad>

y_beltholder();
//y_beltholder_half();
//scale ([2,2,2]) knurl_test();


module y_beltholder() {
    translate([0,0,-3]) {
        translate([0,-22,0]) y_beltholder_half();
        mirror([0,1,0]) translate([0,-22,0]) y_beltholder_half();
    }
}


module y_beltholder_half() {
    
    difference() {
        union() {
            // Screw plate base
            translate([0,0,-2]) cube([y_plate_to_belt+1+4+thinwall,22+0.001,2+6]);
            // Main base
            translate([0,-9,-2]) cube([thinwall,22+9+0.001,2+6]);
        }
        // Bottom cutout for pulling belt tight
        translate([y_plate_to_belt+1+4+thinwall,22+0.001,0]) cylinder(d=12, h=7);
        
        // Belt slot
        translate([y_plate_to_belt,0,0]) cube([2.1,10,6+1]);
        
        // Belt loop hole
        translate([y_plate_to_belt+2.1/2,7,0]) hull() {
            translate([0,0,0]) rotate([0,0,45]) cylinder(d=2.1, h=50, $fn=30);
            translate([0,10,0]) cylinder(d=8.5, h=50, $fn=16);
        }

        // Center notch (centered on screw holes and belt)
        translate([0,-9,3]) rotate([0,90,0]) cylinder(r=1.0, h=100, center=true, $fn=4);
        
        // M3 screw hole
        translate([0,-4,3]) rotate([0,90,0]) poly_cylinder(r=1.6, h=100, center=true);
        
    }
    
    // Center post in belt loop
    translate([y_plate_to_belt+2.1/2,7,0]) hull() {
        translate([0,10,0]) cylinder(d=5, h=6, $fn=16);
        translate([0,3,0]) cylinder(d=1, h=6);
    }
}

/*
module knurl_test() {
    //rotate([45,35.26,45]) cube([2,2,2], center=true);
    
    translate([-2,-1,-2]) cube([11,11,2.001]);
    difference() {
        union() {
            for (y=[0:4]) for (x=[0:4]) {
                translate([x*2*cos(180/4)*1.414,(y*2+0)*cos(180/4)*1.414,0]) rotate([0,0,0]) cylinder(d1=2, d2=0.001, h=2.0/2, $fn=4);
                translate([(x*2-1)*cos(180/4)*1.414,(y*2+1)*cos(180/4)*1.414,0]) rotate([0,0,0]) cylinder(d1=2, d2=0.001, h=2.0/2, $fn=4);
            }
        }
        translate([-50,-50,0.6]) cube([100,100,100]);
    }
}
*/