
use <polyholes.scad>
use <printable_bearing.scad>
include <common_dimensions.scad>

module y_bearing_holder_base() {
    translate([-y_bearing_holder_width/2,-y_bearing_holder_depth/2,0]) hull() {
        translate([0,0,0]) cube([y_bearing_holder_width,y_bearing_holder_depth, 5]);
        translate([y_bearing_holder_width/2,0,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od+thinwall+2, h=y_bearing_holder_depth);
    }
}

module y_bearing_holder_holes() {

    // Cut off top of rod slot slightly above center point to give some hold
    translate([-y_bearing_holder_width/2,-y_bearing_holder_depth/2-1,y_bearing_holder_height]) cube([y_bearing_holder_width,y_bearing_holder_depth+2,20]);

    // Bearing cutout
    translate([0,-1-y_bearing_holder_depth/2,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od, h=y_bearing_holder_depth+2);

    // Cutout screw holes
    translate([+20,+10,-1]) rotate([0,0,0]) poly_cylinder(r=1.6, h=50);
    translate([+20,-10,-1]) rotate([0,0,0]) poly_cylinder(r=1.6, h=50);
    translate([-20,  0,-1]) rotate([0,0,0]) poly_cylinder(r=1.6, h=50);

    // Cutout screw heads
    translate([+20,+10,3]) rotate([0,0,0]) poly_cylinder(r=6.4/2, h=50);
    translate([+20,-10,3]) rotate([0,0,0]) poly_cylinder(r=6.4/2, h=50);
    translate([-20,  0,3]) rotate([0,0,0]) poly_cylinder(r=6.4/2, h=50);
 
    // Center marker cutouts
    translate([0,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.5, h=100, $fn=3);
    translate([0,+y_bearing_holder_depth/2,-1]) rotate([0,0,30]) cylinder(d=1.5, h=100, $fn=3);

    translate([+20,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.0, h=100, $fn=3);
    translate([+20,+y_bearing_holder_depth/2,-1]) rotate([0,0,30]) cylinder(d=1.0, h=100, $fn=3);
    translate([-20,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.0, h=100, $fn=3);
    translate([-20,+y_bearing_holder_depth/2,-1]) rotate([0,0,30]) cylinder(d=1.0, h=100, $fn=3);

    // Ziptie cutout
    translate([0,4/2,y_bearing_holder_rod_ofs]) rotate([90,0,0]) rotate_extrude(angle=360) translate([y_bearing_od/2+2,0]) square([3,4]);

}

module y_bearing_holder() {
    difference() {
        y_bearing_holder_base();
        y_bearing_holder_holes();
    }
}

//my_linear_bearing_cutout( length=27, od=bearing_size );
y_bearing_holder();
%translate([0,0,y_bearing_holder_rod_ofs]) rotate([90,0,0]) cylinder(d=y_rod_diam, h=100, center=true);