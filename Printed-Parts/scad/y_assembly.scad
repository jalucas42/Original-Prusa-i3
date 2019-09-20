
use <y-rod-holder.scad>
use <y-bearing-holder.scad>
use <y-belt-holder-tension.scad>
use <y-idler.scad>
use <y-motor.scad>

include <common_dimensions.scad>

y_assembly_left();
translate([0, -50, 0]) y_assembly_motor();

%translate([0,-100,-x_beam_width]) cube([x_beam_width, 200, x_beam_width]);

module y_assembly_left() {
    %translate([0,0,y_rod_to_rail]) rotate([0,90,0]) cylinder(d=y_rod_diam, h=200);
    translate([-27/2+x_beam_width/2,0,0]) y_rod(open_end=0);
    translate([200, 0, 0]) rotate([0,0,180]) y_rod(open_end=1);
    translate([100,0,y_rod_to_rail]) rotate([0,180,90]) translate([0,0,-y_bearing_holder_rod_ofs]) y_bearing_holder();

}

module y_assembly_motor() {
    translate([100,0,-y_belt_to_plate+y_rail_to_plate]) rotate([0,0,-90]) y_beltholder();
    translate([x_beam_width,0,0]) rotate([0,0,-90]) y_idler();
    translate([x_beam_width,-35,0]) rotate([0,0,-90]) y_motor();
}

