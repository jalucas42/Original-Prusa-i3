// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use <ptfe_bearing_holes.scad>

include <common_dimensions.scad>

module x_end_base(){
    
    // Main block
    translate(v=[-x_end_base_depth/2-x_to_z_offset,-x_end_base_width+(z_bearing_size/2),0]) cube(size = [x_end_base_depth,x_end_base_width,x_end_base_height], center = false);
    //translate(v=[-15,-9.25,x_end_base_height/2]) cube(size = [17,39,x_end_base_height-10], center = true);
    
    // Bearing holder
    {
        //vertical_bearing_base();	
        translate(v=[-z_rod_to_base/2,0,x_end_base_height/2]) cube(size = [z_rod_to_base,z_bearing_size,x_end_base_height], center = true);
        cylinder(h = x_end_base_height, r=z_bearing_size/2, $fn = 90);
    }

    // T8 Nut trap
    hull() {
        // Cylinder
        nut_trap_diam = 25;
        translate(v=[0,-z_motor_ofs,0]) cylinder(h = 8, r=nut_trap_diam/2, $fn=60);
        translate(v=[-z_rod_to_base,-z_motor_ofs,0]) cube([z_rod_to_base,x_end_base_width,8]);
        cylinder(h = 8, r=z_bearing_size/2, $fn = 90);
    }    
}

module x_end_holes(){
    {
        end_spacing = 2.0;
        translate([0,0,end_spacing]) ptfe_bearing_holes(length=z_bearing_length-end_spacing*2, bearing_od=z_bearing_diam);
        translate([0,0,x_end_base_height-z_bearing_length+end_spacing]) ptfe_bearing_holes(length=z_bearing_length-end_spacing*2, bearing_od=z_bearing_diam);
        
        //// Z bearing holder + stress relief cutout
        //translate(v=[0,0,-1]) poly_cylinder(h = x_end_base_height+2, r=(z_bearing_diam/2)+0.1);
        //rotate(a=[0,0,-40]) translate(v=[z_bearing_diam/2-2.9,-0.5,0.5]) cube(size = [thinwall*2,1,x_end_base_height]);       
    }

    // Stress relief (for idler bearing tightening)
    translate([0,-(z_bearing_diam/2)-thinwall-0.5-0.001,x_end_base_height/2]) cube(size = [180,1-0.001,x_end_base_height/2], center = true);
    
    // Belt hole
    translate([-x_to_z_offset,0,x_end_base_height/2]) hull() {
        translate([0,0,+x_end_belt_hole_height/2-x_end_belt_hole_width/2]) rotate([90,60,0]) cylinder(d=x_end_belt_hole_width, h=200, $fn=6, center=true);
        translate([0,0,-x_end_belt_hole_height/2+x_end_belt_hole_width/2]) rotate([90,60,0]) cylinder(d=x_end_belt_hole_width, h=200, $fn=6, center=true);
    }

    translate([-x_to_z_offset,x_bearing_diam/2+thinwall+0.5,x_end_base_height/2]) 
    if (x_end_idler_open_end) {
        for (i=[-1,1]) translate([0,0,i*x_rod_distance/2]) rotate(a=[90,0,0]) pushfit_rod(x_rod_diam_tight,200, center=true);
    } else {
        // FIXME: Handle this case!
        for (i=[-1,1]) translate([0,0,i*x_rod_distance/2]) rotate(a=[90,0,0]) pushfit_rod(x_rod_diam_tight,200, center=true);
    }
        
    
    // TR Nut trap
    translate([0,-z_motor_ofs,0]) {
        // Hole for the nut
        translate(v=[0,0,-1]) poly_cylinder(h = 100, r = t8nut_id/2, $fn = 25, center=true);

        translate([0,0,0]) {
            for (x=[-1,1]) for (y=[-1,1]) {
                translate([x*11.5/2, y*11.5/2,0]) rotate([0,0,x*y*-45]) {
                    cylinder(h = 100, r = 1.4, $fn=6, center=true); // M3 screw hole (tight)
                    translate([0,0,8-3]) cylinder(h = 10, d = 6.3, $fn=6); // M3 nut trap
                }
            }
        }

        // Extra cutout for anti-backlash spring.  Also to remove thinwall around nut traps
        translate([0,0,8-3]) cylinder(d=12.0, h=10);
    }
    
}


// Final prototype
module x_end_plain(){
    //render() 
    difference(){
        x_end_base();
        x_end_holes();
    }
    
    // Draw clearance required for Z leadscrew
    %translate([0,-z_motor_ofs,8]) color("red",0.25) cylinder(d=z_leadscrew_clearance, h=x_end_base_height-8);
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

