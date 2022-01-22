
use <x-end.scad>
use <x-end-idler.scad>
use <x-end-motor.scad>
use <x-carriage.scad>
use <z-axis-motor-direct.scad>
use <z-axis-motor-belt.scad>
use <z-axis-bearingholder.scad>
use <z-endstop-holder.scad>

include <common_dimensions.scad>

// Should we render the belt-drive Z axis, or direct-drive?
use_motor_belt = false;

// These control XZ assembly layout.  They have no impact on the actual generated shapes.
tmp_z_spacing = 175;
tmp_x_carriage_height = 25;

%translate([-z_beam_width/2+z_motor_ofs+z_beam_motor_ofs,-z_rod_to_rail-z_beam_width,]) cube([z_beam_width,z_beam_width,110-z_top_height]);

xz_right();
translate([tmp_z_spacing,0,0]) xz_left();
translate([tmp_z_spacing/2,-x_to_z_offset,tmp_x_carriage_height+0+x_end_base_height/2]) rotate([180,180,0]) x_carriage();

module xz_left() {
    translate([0,0,5]) rotate([0,0,180]) z_endstop();
    if (use_motor_belt) {
        mirror([0,0,1]) z_motor_belt_right();
    } else {
        mirror([0,0,1]) z_motor_direct_right();
    }
    translate([0,0,tmp_x_carriage_height+x_end_base_height]) rotate([0,0,90]) mirror([0,0,1]) x_end_motor();
    translate([0,0,110]) mirror([0,0,1]) z_top_right();
    %translate([0,0,-10]) cylinder(d=10, h=300);
    %translate([-z_motor_ofs,0,-10]) cylinder(d=8, h=300);

}

module xz_right() {
    translate([0,0,5]) rotate([0,0,0]) z_endstop();
    if (use_motor_belt) {
        mirror([1,0,0]) mirror([0,0,1]) z_motor_belt_right();
    } else {
        mirror([1,0,0]) mirror([0,0,1]) z_motor_direct_right();
    }
    translate([0,0,tmp_x_carriage_height+x_end_base_height]) rotate([0,0,90]) mirror([0,0,1]) x_end_idler();
    translate([0,0,110]) mirror([0,0,1]) mirror([1,0,0]) z_top_right();
    %translate([0,0,-10]) cylinder(d=10, h=300);
    %translate([z_motor_ofs,0,-10]) cylinder(d=8, h=300);

}