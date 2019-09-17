
use <x-end.scad>
use <x-end-idler.scad>
use <x-end-motor.scad>
use <x-carriage.scad>
use <z-axis-bottom.scad>
use <z-axis-top.scad>

include <common_dimensions.scad>

%translate([-z_beam_width/2+z_motor_ofs+z_beam_motor_ofs,-z_rod_to_rail-z_beam_width,]) cube([z_beam_width,z_beam_width,110-z_top_height]);

xz_right();
translate([150,0,0]) xz_left();
translate([60,-x_to_z_offset,15+0+x_end_base_height/2]) rotate([180,0,0]) x_carriage();

module xz_left() {
    mirror([0,0,1]) z_bottom_right();
    translate([0,0,15]) rotate([0,0,90]) mirror([0,0,0]) x_end_motor();
    translate([0,0,110]) mirror([0,0,1]) z_top_right();
    %translate([0,0,-10]) cylinder(d=10, h=300);
    %translate([-z_motor_ofs,0,-10]) cylinder(d=8, h=300);

}

module xz_right() {
    mirror([1,0,0]) mirror([0,0,1]) z_bottom_right();
    translate([0,0,15]) rotate([0,0,90]) mirror([0,0,0]) x_end_idler();
    translate([0,0,110]) mirror([0,0,1]) mirror([1,0,0]) z_top_right();
    %translate([0,0,-10]) cylinder(d=10, h=300);
    %translate([z_motor_ofs,0,-10]) cylinder(d=8, h=300);

}