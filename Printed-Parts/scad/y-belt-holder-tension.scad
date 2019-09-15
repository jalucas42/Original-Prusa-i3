
use <polyholes.scad>
include <common_dimensions.scad>

y_beltholder();
//beltholder();

module y_beltholder_base() {
    translate([-5,-y_beltholder_base_width/2,-y_beltholder_height/2-2]) cube([y_beltholder_base_depth,y_beltholder_base_width,y_beltholder_base_height]);
    %translate([-0,-6,0]) beltholder();
    
}

module y_beltholder_holes() {
    
    // Main beltholder slot
    translate([-3.001-5,-y_beltholder_base_width/2-1,-y_beltholder_height/2-0.5/2]) cube([y_beltholder_depth+5,y_beltholder_base_width+2,y_beltholder_height+0.5]);
    
    rotate([0,0,90]) for (i=[-1,1]) {
        // M3 slot
        hull() {
            translate([i*y_beltholder_base_width/2-0.001-i* 7,-2-3+0.002,0]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
            translate([i*y_beltholder_base_width/2-0.001-i*18,-2-3+0.002,0]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
        }
        
        // M3 nut trap slot
        hull() {
            translate([i*y_beltholder_base_width/2-0.001-i* 7,-2-3-3.0+0.001,0]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
            translate([i*y_beltholder_base_width/2-0.001-i*18,-2-3-3.0+0.001,0]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
        }

        // M3 nut cutout to allow removing beltholder pieces without completely removing screw.
        translate([i*y_beltholder_base_width/2-0.001-i*18,0,0]) rotate([90,0,0]) cylinder(d=6.4, h=100, $fn=6, center=true);
    }

    // Center marker cutouts
    for (i=[-1,1]) translate([0,i*y_beltholder_base_width/2,0]) rotate([0,0,i*30]) cylinder(d=1.5, h=100, center=true, $fn=3);



    for (i=[-1,0,1]) {
        // M3 plate mounting holes
        translate([0,i*15,0]) rotate([0,0,30]) cylinder(d=3.4, h=100, center=true, $fn=6);
        translate([0,i*15,y_beltholder_height/2+9-3]) rotate([180,0,30]) cylinder(d=6.4, h=y_beltholder_base_height/2, center=false, $fn=6);
        
    }

}

module y_beltholder() {
    difference() {
        y_beltholder_base();
        y_beltholder_holes();
    }
}

module beltholder() {
    rotate([0,0,90]) translate([-y_beltholder_width,-3,-y_beltholder_height/2]) 
    {
        
        difference() {
            translate([0, -2, 0]) cube([y_beltholder_width, 6+2, y_beltholder_height]);

            translate([-1, 0, y_beltholder_height/2-2.1/2]) cube([10, 7.001, 2.1]); // Belt slot
            
            hull() {
                translate([-1+ 7, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=2.1, h=7.001, $fn=30); // Belt slot
                translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=9, h=7.001, $fn=30); // Belt slot
            }

            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); // Belt slot
        }

        difference() {
            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=6, h=6-3, $fn=30); // Belt slot
            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); // Belt slot
            
        }
    }
}