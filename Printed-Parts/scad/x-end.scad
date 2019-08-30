// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <bearing.scad>
use <polyholes.scad>

include <common_dimensions.scad>

module x_end_base(){
    
    // Main block
    translate(v=[-x_end_base_depth-(t8nut_id/2),-x_end_base_width+(z_bearing_diam/2)+thinwall,0]) cube(size = [x_end_base_depth,x_end_base_width,x_end_base_height], center = false);
    //translate(v=[-15,-9.25,x_end_base_height/2]) cube(size = [17,39,x_end_base_height-10], center = true);
    
    // Bearing holder
    {
        //vertical_bearing_base();	
        translate(v=[-2-z_bearing_size/4,0,29]) cube(size = [4+z_bearing_size/2,z_bearing_size,x_end_base_height], center = true);
        cylinder(h = 58, r=z_bearing_size/2, $fn = 90);
    }

    // T8 Nut trap
    {
        // Cylinder
        translate(v=[0,-z_motor_ofs,0]) poly_cylinder(h = 8, r=12.5, $fn=25);
        // Hexagon
        translate(v=[-6,-z_motor_ofs+(17-10.6),10]) rotate([0,0,48.2]) cube(size = [10,5,1], center = true);
    }    
}

module x_end_holes(){
    {
        //vertical_bearing_holes();
        translate(v=[0,0,-1]) poly_cylinder(h = 62, r=(z_bearing_diam/2)+0.1);
        rotate(a=[0,0,-40]) translate(v=[z_bearing_diam/2-2.9,-0.5,0.5]) cube(size = [thinwall*2,1,62]);       
    }

    // Stress relief (for idler bearing tightening)
    translate([0,-(z_bearing_diam/2)-thinwall-0.5-0.25,x_end_base_height/2]) cube(size = [180,1,x_end_base_height/2], center = true);
    
    // Belt hole
    //belt_hole_height = x_end_base_height/2;
    belt_hole_height = x_end_base_height - 4*thinwall - 2*x_rod_diam;
    belt_hole_width = 10;
    translate([-x_to_z_offset,0,x_end_base_height/2]) hull() {
        translate([0,0,belt_hole_height/2-belt_hole_width/2]) rotate([90,60,0]) cylinder(d=belt_hole_width, h=200, $fn=6, center=true);
        translate([0,0,-belt_hole_height/2+belt_hole_width/2]) rotate([90,60,0]) cylinder(d=belt_hole_width, h=200, $fn=6, center=true);
    }

    // Pushfit rods
    translate([-x_to_z_offset,-41.5,6]) rotate(a=[-90,0,0]) pushfit_rod(x_rod_diam,50);
    translate([-x_to_z_offset,-41.5,6+x_rod_distance]) rotate(a=[-90,0,0]) pushfit_rod(x_rod_diam,50);

    // TR Nut trap
    // Hole for the nut
    translate(v=[0,-z_motor_ofs, -1]) poly_cylinder(h = 9.01, r = t8nut_id/2, $fn = 25);

    // Screw holes for TR nut
    translate(v=[0,-z_motor_ofs, 0]) rotate([0, 0, -135]) translate([0, 9.5, -1]) cylinder(h = 10, r = 1.55, $fn=25);
    translate(v=[0,-z_motor_ofs, 0]) rotate([0, 0, -135]) translate([0, -9.5, -1]) cylinder(h = 10, r = 1.55, $fn=25);

    // Nut traps for TR nut screws
    translate(v=[0,-z_motor_ofs, 0]) rotate([0, 0, -135]) translate([0, 9.5, 6]) rotate([0, 0, 0])cylinder(h = 3, r = 3.3, $fn=6);

    translate(v=[0,-z_motor_ofs, 0]) rotate([0, 0, -135]) translate([0, -9.5, 6]) rotate([0, 0, 30])cylinder(h = 3, r = 3.2, $fn=6);
    translate([-5.5,-z_motor_ofs-.2,6]) rotate([0,0,30]) cube([5,5,3]);
    translate([-0,-z_motor_ofs-.2,6]) rotate([0,0,60]) cube([5,10,3]);
}


// Final prototype
module x_end_plain(){
    difference(){
        x_end_base();
        x_end_holes();
    }
}

x_end_plain();


module pushfit_rod(diameter,length){
    poly_cylinder(h = length, r=diameter/2);
    difference(){
        translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
        translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
    }
    //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

