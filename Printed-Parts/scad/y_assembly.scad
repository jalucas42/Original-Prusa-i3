
use <y-rod-holder.scad>
use <y-bearing-holder.scad>
use <y-belt-holder-3030.scad>

include <common_dimensions.scad>

y_assembly_left();
translate([0, -100, 0]) y_assembly_motor();

module y_assembly_left() {
    %translate([0,0,y_rod_to_rail]) rotate([0,90,0]) cylinder(d=y_rod_diam, h=200);
    y_rod();
    translate([200, 0, 0]) rotate([0,0,180]) y_rod();
    translate([100,0,y_rod_to_rail]) rotate([0,180,90]) translate([0,0,-y_bearing_holder_rod_ofs]) y_bearing_holder();

}

module y_assembly_motor() {
    translate([100,0,y_rod_to_rail+y_bearing_holder_rod_ofs]) rotate([0,90,90]) y_beltholder();
}

