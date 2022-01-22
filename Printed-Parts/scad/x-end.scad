// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use <ptfe_bearing_holes.scad>

include <common_dimensions.scad>

x_end_plain();
//x_end_bearing_test();


end_spacing = 4.0;

x_end_endstop_holder_height = 6.0;
x_end_adjustment_offset = 15;
x_end_ptfe_bearing_tightness = -0.20; // Negative tightness means larger hole
x_end_ptfe_bearing_ptfe_od = 4.1;

module x_end_base(){
    
    // Main block
        translate([-x_end_base_depth/2-x_to_z_offset,-x_end_base_width+(z_bearing_size/2),0]) cube(size = [x_end_base_depth,x_end_base_width,x_end_base_height], center = false);

    /*hull() {
        #translate([-x_end_base_depth/2-x_to_z_offset,-x_end_base_width+(z_bearing_size/2),0]) cube(size = [x_end_base_depth,z_bearing_size,x_end_base_height], center = false);
        for (z=[-1,1]) translate([-x_end_base_depth/2-x_to_z_offset+0.001,0,x_end_base_height/2+z*x_rod_distance/2]) rotate([0,-90,0]) cylinder(d=8, h=2.5+thinwall, $fn=10, center=false);
    }*/
    
    // Bearing holder
    {
        translate(v=[-z_rod_to_base/2,0,x_end_base_height/2]) cube(size = [z_rod_to_base,z_bearing_size,x_end_base_height], center = true);
        cylinder(h = x_end_base_height, r=z_bearing_size/2, $fn = 90);
    }

    // X-rod holding screws
    {
        translate([-x_end_base_depth/2-x_to_z_offset-(2.5+thinwall)/2,0,x_end_base_height/2]) cube(size = [(2.5+thinwall),z_bearing_size,x_end_base_height], center = true);
    }

    // Endstop adjustment screw holders.
    // This is a WIP.  Not sure how to support the top one.
    //for(i=[0,1])
    for (i=[1])
    translate([0,0,i*(x_end_base_height-end_spacing)]) {
        hull() {
            cylinder(h=end_spacing, r=z_bearing_size/2, $fn = 90);
            translate([0,x_end_adjustment_offset,0]) cylinder(h=end_spacing, d=12, $fn=32);
            %translate([0,x_end_adjustment_offset,0]) cylinder(h=15, d=3, $fn=8, center=false);
        }
            translate([0,x_end_adjustment_offset,-x_end_endstop_holder_height+end_spacing]) cylinder(h=x_end_endstop_holder_height, d=12, $fn=32);
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
        
        if (x_end_use_ptfe_bearing) {
            for (i=[0,1]) 
            translate([0,0,end_spacing+i*(x_end_base_height-z_bearing_length)]) 
            rotate([0,0,-90])
            ptfe_bearing_holes(length=z_bearing_length-end_spacing*2, bearing_od=z_bearing_diam, tightness=x_end_ptfe_bearing_tightness, ptfe_od=x_end_ptfe_bearing_ptfe_od);
        } else {       
            // Z bearing holder + stress relief cutout
            translate(v=[0,0,-1]) poly_cylinder(h = x_end_base_height+2, r=(z_bearing_diam/2)+0.1);
            rotate(a=[0,0,-40]) translate(v=[z_bearing_diam/2-2.9,-0.5,0.5]) cube(size = [thinwall*2,1,x_end_base_height]);       
        }
    }

    // X-rod holding screws
    {
        //translate([-x_end_base_depth/2-x_to_z_offset-(2.5+thinwall)/2,0,x_end_base_height/2]) cube(size = [(2.5+thinwall),z_bearing_size,x_end_base_height], center = true);
        for (z=[-x_rod_distance/2,x_rod_distance/2]) translate([-x_to_z_offset,0,x_end_base_height/2+z]) {
            translate([0,0,0]) rotate([0,-90,0]) cylinder(d=3.2, h=100, center=false, $fn=10);
            hull() for (y=[0,100]) translate([-x_rod_diam/2-thinwall,y,0]) rotate([0,-90,0]) cylinder(d=6.4, h=2.5, center=false, $fn=6);
        }
    }


    // Endstop adjustment screw holders.
    //for(i=[0,1])
    for (i=[1])
    translate([0,0,i*(x_end_base_height-x_end_endstop_holder_height)]) {
        // M3 hole throughout
        translate([0,x_end_adjustment_offset,0]) cylinder(h=50, d=3.0, $fn=5, center=true);
        // M3 nut capture - tight fit
        translate([0,x_end_adjustment_offset,x_end_endstop_holder_height-3.0]) cylinder(h=50, d=6.3, $fn=6, center=false);
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
        
        rotate([0,0,45]) translate([0,0,0]) {
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

module pushfit_rod(diameter,length){
    poly_cylinder(h = length, r=diameter/2);
    difference(){
        translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
        translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
    }
    //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

module x_end_bearing_test() {
    difference() {
        union() {
            translate(v=[-z_rod_to_base/2,0,1.0]) cube(size = [z_rod_to_base,z_bearing_size,2.0], center = true);
            cylinder(h = x_end_base_height/2, r=z_bearing_size/2, $fn = 90);
        }
        union() {
            //for (i=[0,1]) 
            for (i=[0])
            translate([0,0,end_spacing+i*(x_end_base_height-z_bearing_length)]) 
            rotate([0,0,-90])
            ptfe_bearing_holes(length=z_bearing_length-end_spacing*2, bearing_od=z_bearing_diam, tightness=x_end_ptfe_bearing_tightness);
        }
    }
            
}
