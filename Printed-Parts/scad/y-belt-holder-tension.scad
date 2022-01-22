
use <polyholes.scad>
include <common_dimensions.scad>

// Dimensions of the Y beltholder component (the sliding piece)
y_beltholder_width = 18;
y_beltholder_height = 2 + 9 + 2;
y_beltholder_depth = 6 + 2;

// Dimensions of the Y beltholder base component (that mounts to the plate)
y_beltholder_base_height = y_beltholder_height/2 + y_belt_to_plate;
y_beltholder_base_width = 2*y_beltholder_width + 20;
y_beltholder_base_depth = y_beltholder_depth + 8;

//y_beltholder();
//beltholder();

translate([0,0,y_beltholder_base_width/2]) rotate([90,0,0]) y_beltholder();
for(i=[15,30]) translate([-i,0,5]) rotate([0,90,0]) beltholder();

module y_beltholder_base() {
    translate([-5,-y_beltholder_base_width/2,-y_beltholder_height/2-0.001]) cube([y_beltholder_base_depth,y_beltholder_base_width,y_beltholder_base_height]);
    %translate([-0,-6,0]) beltholder();
    
}

module y_beltholder_holes() {
    
    // Main beltholder slot
    translate([-3.001-5,-y_beltholder_base_width/2-1,-y_beltholder_height/2-0.5/2]) cube([y_beltholder_depth+5,y_beltholder_base_width+2,y_beltholder_height+0.5]);
    
    rotate([0,0,90]) for (i=[-1,1]) {
        // M3 slot
        hull() {
            translate([i*y_beltholder_base_width/2-0.001-i* 7,-2-3+0.002,0]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
            translate([i*y_beltholder_base_width/2-0.001-i*23,-2-3+0.002,0]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
        }
        
        // M3 nut trap slot
        hull() {
            translate([i*y_beltholder_base_width/2-0.001-i* 7,-2-3-3.0+0.001,0]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
            translate([i*y_beltholder_base_width/2-0.001-i*23,-2-3-3.0+0.001,0]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
        }

        // M3 nut cutout to allow removing beltholder pieces without completely removing screw.
        translate([i*y_beltholder_base_width/2-0.001-i*23,0,0]) rotate([90,0,0]) cylinder(d=6.4, h=100, $fn=6, center=true);
    }

    // Center marker cutouts
    for (i=[-1,1]) translate([0,i*y_beltholder_base_width/2,0]) rotate([0,0,i*30]) cylinder(d=1.5, h=100, center=true, $fn=3);



    for (i=[-1,0,1]) {
        // M3 plate mounting holes
        tmp_hole_spacing = 22; // For i3 knockoff plywood...
        //tmp_hole_spacing = 15; // For original aluminum plate...
        translate([0,i*tmp_hole_spacing,0]) rotate([0,0,30]) cylinder(d=3.4, h=100, center=true, $fn=6);
        translate([0,i*tmp_hole_spacing,y_belt_to_plate-thinwall]) rotate([180,0,30]) cylinder(d=6.4, h=100, center=false, $fn=6);
        
    }

}

module y_beltholder() {
    difference() {
        y_beltholder_base();
        y_beltholder_holes();
    }
}

module beltholder() {
    rotate([0,0,90]) 
    translate([-y_beltholder_width,-3,-y_beltholder_height/2]) 
    {
        
        difference() {
            // Main base
            translate([0, -2, 0]) cube([y_beltholder_width, 6+2, y_beltholder_height]);

            // Belt slot
            translate([-1, 0, y_beltholder_height/2-2.1/2]) cube([10, 7.001, 2.1]);
            
            // Teardrop around post
            hull() {
                translate([-1+ 7, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=2.1, h=7.001, $fn=30); // Belt slot
                translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=9, h=7.001, $fn=30); // Belt slot
            }

            // M3 hole thru post
            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); // Belt slot
            
            // Cutout around post to make belt insertion easier.
            translate([-1+13-3, 3, -1]) cube([50, 7.001, y_beltholder_height+2]);            
        }

        // Post for belt to wrap around
        difference() {
            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=6, h=6-3, $fn=30); 
            translate([-1+13, 0, y_beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); 
            
        }
    }
}