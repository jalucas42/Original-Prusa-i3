
use <polyholes.scad>
//use <printable_bearing.scad>
use <ptfe_bearing_holes.scad>
include <common_dimensions.scad>

module y_bearing_holder_base() {
    translate([-y_bearing_holder_width/2,-y_bearing_holder_depth/2,0]) hull() {
        translate([0,0,0]) cube([y_bearing_holder_width,y_bearing_holder_depth, 5]);
        translate([y_bearing_holder_width/2,0,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od, h=y_bearing_holder_depth);
    }
}

module y_bearing_holder_holes() {

    // PTFE bearing holes
    translate([0,y_bearing_holder_depth/2-2,y_bearing_holder_rod_ofs]) rotate([90,0,0]) ptfe_bearing_holes(length=y_bearing_holder_depth-4, bearing_od=y_bearing_od);

    // Bearing cutout
    //translate([0,-1-y_bearing_holder_depth/2,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od, h=y_bearing_holder_depth+2);
    // Ziptie cutout
    //translate([0,4/2,y_bearing_holder_rod_ofs]) rotate([90,0,0]) rotate_extrude(angle=360) translate([y_bearing_od/2+2,0]) square([3,4]);

    // Cutout screw holes + capture nuts
    for (x=[-20,20]) for (y=[-10,0,10]) translate([x,y,0]){
        translate([0,0,-1]) rotate([0,0,30]) cylinder(r=1.6, h=50, $fn=6);
        translate([0,0,+3]) rotate([0,0,30]) cylinder(d=6.3, h=50, $fn=6);
    }
 
    // Center marker cutouts
    translate([0,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.5, h=100, $fn=3);
    translate([0,+y_bearing_holder_depth/2,-1]) rotate([0,0,+30]) cylinder(d=1.5, h=100, $fn=3);

    translate([+20,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.0, h=100, $fn=3);
    translate([+20,+y_bearing_holder_depth/2,-1]) rotate([0,0,+30]) cylinder(d=1.0, h=100, $fn=3);
    translate([-20,-y_bearing_holder_depth/2,-1]) rotate([0,0,-30]) cylinder(d=1.0, h=100, $fn=3);
    translate([-20,+y_bearing_holder_depth/2,-1]) rotate([0,0,+30]) cylinder(d=1.0, h=100, $fn=3);


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

