
use <polyholes.scad>
//use <printable_bearing.scad>
use <ptfe_bearing_holes.scad>
include <common_dimensions.scad>

module ziptie_cutout(inner_diam=10, ziptie_width=5, ziptie_thickness=3, $fn=20, flat=0) {
        // Ziptie cutout
        difference() {
            cylinder(d=inner_diam+2*ziptie_thickness, h=ziptie_width, center=true, $fn=$fn);
            cylinder(d=inner_diam, h=ziptie_width+0.002, center=true, $fn=$fn);
            //translate([(inner_diam+2*ziptie_thickness)/2-flat,-(inner_diam+2*ziptie_thickness)/2,-ziptie_width/2-0.001]) cube([(inner_diam+2*ziptie_thickness),(inner_diam+2*ziptie_thickness),ziptie_width+0.002]);
        }    
}

//ziptie_cutout(inner_diam=y_bearing_od+2*thinwall, $fn=60);

y_bearing_holder_use_ptfe_bearings = false;



module y_bearing_holder_base() {
    translate([-y_bearing_holder_width/2,-y_bearing_holder_depth/2,0]) hull() {
        translate([0,0,0]) cube([y_bearing_holder_width,y_bearing_holder_depth, 5]);
        if (y_bearing_holder_use_ptfe_bearings) {
            translate([y_bearing_holder_width/2,0,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od, h=y_bearing_holder_depth);
        } else {
            translate([y_bearing_holder_width/2,0,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od+2*thinwall, h=y_bearing_holder_depth);
        }
    }
}

module y_bearing_holder_holes() {


    // PTFE bearing holes
    if (y_bearing_holder_use_ptfe_bearings) {
        translate([0,y_bearing_holder_depth/2-2,y_bearing_holder_rod_ofs]) rotate([90,0,0]) ptfe_bearing_holes(length=y_bearing_holder_depth-4, bearing_od=y_bearing_od);
    } else {
        // Bearing cutout
        hull() for(z=[0]) translate([0,0,y_bearing_holder_rod_ofs+z*20]) rotate([90,0,0]) cylinder(d=y_bearing_od+0.25, h=y_bearing_length+0.25+0.002, center=true, $fn=60);
        hull() for(z=[0]) translate([0,0,y_bearing_holder_rod_ofs+z*20]) rotate([90,0,0]) cylinder(d=(y_bearing_od+y_rod_diam)/2, h=y_bearing_holder_depth+0.002, center=true, $fn=60);
        for(y=[-1,1]) translate([0,y*y_bearing_holder_depth/4,y_bearing_holder_rod_ofs]) rotate([90,0,0]) ziptie_cutout(inner_diam=y_bearing_od+2*thinwall, $fn=60);
        translate([-100,-100,y_bearing_holder_rod_ofs+y_bearing_od*0.0]) cube([200,200,200]);
    }

    // Bearing cutout
    //translate([0,-1-y_bearing_holder_depth/2,y_bearing_holder_rod_ofs]) rotate([-90,0,0]) cylinder(d=y_bearing_od, h=y_bearing_holder_depth+2);
    // Ziptie cutout
    //translate([0,4/2,y_bearing_holder_rod_ofs]) rotate([90,0,0]) rotate_extrude(angle=360) translate([y_bearing_od/2+2,0]) square([3,4]);

    // Cutout screw holes + capture nuts
    for (x=[-20,20]) for (y=[-10,0,10]) translate([x,y,0]){
        translate([0,0,-1]) rotate([0,0,30]) cylinder(d=3.5, h=50, $fn=30);
        translate([0,0,+3]) rotate([0,0,30]) cylinder(d=6.5, h=50, $fn=6);
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

