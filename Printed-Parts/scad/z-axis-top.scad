// PRUSA iteration3
// Z axis bottom holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
include <common_dimensions.scad>

z_top_right();
z_top_left();

module z_top_base(){
    hull() {
        translate([-z_motor_ofs-z_beam_motor_ofs-z_beam_width/2,-z_rod_to_rail,0]) cube([z_beam_width,20,5]); // Base
        cylinder(d=z_rod_diam+thinwall*2, h=5); // Z rod hole base
        translate([-z_motor_ofs,0,0]) cylinder(d=22+6, h=7+2); // Z leadscrew hole base
    }

    if (z_top_generate_rod_holder) {
        translate([0,0,5]) cylinder(d1=z_rod_diam+z_top_wall_width*2, d2=z_rod_diam+4, h=5);
    }

    translate([-z_motor_ofs-z_beam_motor_ofs-z_beam_width/2,-z_rod_to_rail,0]) cube([z_top_wall_width,20,z_top_height]); // Motor-side wall
    ////translate([-z_top_width/2-z_motor_ofs+z_top_width-z_top_wall_width,-z_rod_to_rail,0]) cube([z_top_wall_width,z_top_wall_width+43,z_top_height]); // Rod-side wall
    translate([-z_motor_ofs-z_beam_motor_ofs-z_beam_width/2,-z_rod_to_rail,0]) cube([z_beam_width+z_top_wall_width,z_top_wall_width,z_top_height]); // Base
    translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_rod_to_rail-z_beam_width,0]) cube([z_top_wall_width,z_beam_width,z_top_height]); // Beam wraparound wall
    
    // Rail guide (front)
    translate([-z_railguide_width/2-z_motor_ofs-z_beam_motor_ofs,-z_railguide_depth-z_rod_to_rail,0]) cube([z_railguide_width, z_railguide_depth, z_top_height]);
    
    // Rail guide (side wraparound)
    //translate([-z_railguide_depth-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_railguide_width/2-z_rod_to_rail-z_beam_width/2,0]) cube([z_railguide_depth, z_railguide_width, z_top_height]);
        
    // Dummy beam
    //%translate([-z_motor_ofs-z_beam_motor_ofs-z_beam_width/2,-z_rod_to_rail-z_beam_width,0]) cube([z_beam_width,z_beam_width,z_top_height]);
    

}

module z_top_fancy(){
    hull() {
        translate([-z_motor_ofs-z_top_width*2/2,-50,0]) cube([z_top_width*2.25, 100, z_top_height/2]);
        translate([-z_motor_ofs-z_beam_motor_ofs,0,z_top_height*0.75]) rotate([90,0,0]) cylinder(d=z_top_height/2, h=100, center=true);
    }
    
    /*
    // corner cutouts
    translate([0.5,-2.5,0]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,30,51]);
    translate([0.5,40-0.5+5,0]) rotate([0,0,-45+90]) translate([-15,0,-1]) cube([30,30,51]);
    //translate([-4,40+5,5]) rotate([0,0,-35-0]) translate([0,0,0.1]) cube([30,30,51]);
    //translate([-4+11,40+5+5,0]) rotate([0,0,-45-0]) translate([0,0,-1]) cube([30,30,51]);
    translate([8,0,12+20+6]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([20,-2,12+8]) rotate([45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([25,20,12+30]) rotate([-45,0,0]) rotate([0,-90,0]) translate([0,-5,0]) cube([30,50,30]);
    translate([50-2.5,-5+2.5+67,0]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
    translate([50-2.5,-5+2.5,0]) rotate([0,0,-45-90]) translate([-15,0,-1]) cube([30,30,51]);
    //translate([50-1.5,10-1.5,0]) rotate([0,0,-45]) translate([-15,0,-1]) cube([30,30,51]);
    //translate([0,0,5]) rotate([45+180,0,0]) rotate([0,0,-45+90]) translate([0,0,-15]) cube([30,30,30]);
    // Stiffner cut out
    translate([30,0,5.5]) rotate([0,-45,0]) translate([0,-5,0]) cube([30,60,30]);
    */
}

module z_top_holes(){

    // Hole for Z rod
    if (z_top_generate_rod_holder) {
        // Z rod holder
        translate([0,0,5]) rotate([0,0,0]) poly_cylinder(h = 50, r=z_rod_diam_tight/2);
        translate([0,1,0.6]) rotate([0,0,180]) cube([z_motor_ofs,2,100]); // it's bit up because it helps with printing
        
        // Z rod holding screw
        poly_cylinder(r=1.3, h=100);
        translate([0,0,2.5]) cylinder(d=6.3, h=5, $fn=6);
    } else {
        // Hole all the way through.
        poly_cylinder(h = 50, r=z_rod_diam_tight/2, center=true);
        translate([0,1,0.6]) rotate([0,0,180]) cube([z_motor_ofs,2,100]); // it's bit up because it helps with printing
    }
    
    // Hole for Z leadscrew bearing
    translate([-z_motor_ofs,0,-1]) cylinder(r=15/2, h=100);
    translate([-z_motor_ofs,0,2+0.001]) cylinder(r=22/2, h=8);

    // Front mounting screw holes
    translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_top_wall_width+0.001,6+ 0+5]) rotate([90,0,0])  cylinder(h = 2, r=3.5, $fn=30);
    translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_top_wall_width+0.001,6+ 0+5]) rotate([0,-90,90]) cylinder(h = 50, r=1.7, $fn=6);

    // Wraparound mounting screw holes
    translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2+z_top_wall_width+0.001,-z_rod_to_rail-z_beam_width/2,6+ 0+5]) rotate([0,-90,0]) cylinder(h = 2, r=3.5, $fn=30);
    translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2+z_top_wall_width+0.001,-z_rod_to_rail-z_beam_width/2,6+ 0+5]) rotate([0,-90,0]) cylinder(h = 20, r=1.7, $fn=6);
    //translate([-z_railguide_depth-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_railguide_width/2-z_rod_to_rail-z_beam_width/2+z_railguide_width/2,6+ 0+5]) rotate([-90,0,-90]) cylinder(h = 50, r=1.5, $fn=30);

    // Rail guide nut cutouts
    translate([-z_motor_ofs-z_beam_motor_ofs,-z_railguide_depth-z_rod_to_rail,6+ 0+5]) rotate([-90,0,0]) cylinder(h = z_railguide_depth, d1=z_railguide_keepout+2, d2=z_railguide_keepout, $fn=12);
    translate([-z_railguide_depth-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_railguide_width/2-z_rod_to_rail-z_beam_width/2+z_railguide_width/2,6+ 0+5]) rotate([-90,0,-90]) cylinder(h = z_railguide_depth, d1=z_railguide_keepout+2, d2=z_railguide_keepout, $fn=12);

    
}

module z_top_right(){
    intersection() {
        difference(){
            z_top_base();
            z_top_holes();
        }
        //z_top_fancy();
    }
}

module z_top_left(){
 translate([z_rod_diam+z_top_wall_width*3,0,0]) mirror([1,0,0]) 
    z_top_right();
}

module stepper_motor_holes() {
    poly_cylinder( r=12.5, h=100);
    translate([+15.5,+15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([+15.5,-15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([-15.5,+15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([-15.5,-15.5,0]) poly_cylinder( r=3.0/2, h=100 );
}

