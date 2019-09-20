// PRUSA iteration3
// Z axis bottom holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
include <common_dimensions.scad>

rotate([0,0,0]) {
    z_bottom_right();
    z_bottom_left();
}

z_bottom_depth = z_rod_to_rail+43/2;

module z_bottom_base(){
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_width,z_bottom_depth,6]); // Base
    cylinder(d=z_rod_diam+2*thinwall, h=6, $fn=30);
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_wall_width,z_bottom_depth,z_bottom_height]); // Motor-side wall
    translate([-z_bottom_width/2-z_motor_ofs+z_bottom_width-z_bottom_wall_width,-z_rod_to_rail,0]) cube([z_bottom_wall_width,z_bottom_depth,z_bottom_height]); // Rod-side wall
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_width,z_bottom_wall_width,z_bottom_height]); // Base
    
    // Wraparound wall
    translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_rod_to_rail-z_beam_width,0]) cube([z_bottom_wall_width,z_beam_width,z_bottom_height]);
    
    // Rail guide
    translate([-z_railguide_width/2-z_motor_ofs-z_beam_motor_ofs,-z_railguide_depth-z_rod_to_rail,0]) cube([z_railguide_width,z_railguide_depth,z_bottom_height]);
    
    
    %translate([-z_motor_ofs-z_beam_motor_ofs-z_beam_width/2,-z_rod_to_rail-z_beam_width,0]) cube([z_beam_width,z_beam_width,z_bottom_height]);
}

module z_bottom_fancy(){
    hull() {
        translate([-z_motor_ofs-z_bottom_width/2-12,-100,0]) cube([z_bottom_width+20, 200, z_bottom_height/2]);
        translate([-z_motor_ofs-z_beam_motor_ofs,0,z_bottom_height*0.75]) rotate([90,0,0]) cylinder(d=z_bottom_height/2, h=200, center=true);
    }
}

module z_bottom_holes(){

    // Z rod holder
    translate([0,0,5+1]) rotate([0,180,0]) poly_cylinder(h = 50, r=z_rod_diam_tight/2);
    translate([z_rod_diam/2,1,0.6]) rotate([0,0,180]) cube([z_rod_diam+z_motor_ofs,2,7]); // it's bit up because it helps with printing
    
    // Cutout to allow sliding stepper in while z-axis is mounted to rail.
    translate([-8/2-z_motor_ofs,0,-1]) cube([8,100,20]);
    
    translate([-z_motor_ofs-12.5,0,6-2]) cube([25,100,100]);
    
    translate([-z_motor_ofs,0,-1]) stepper_motor_holes();    

    // Frame mounting screw holes
    //translate([-z_motor_ofs-z_beam_motor_ofs,0,10+20+5]) rotate([90,30,0]) cylinder(h = 50, r=1.6, $fn=6);
    //translate([-z_motor_ofs-z_beam_motor_ofs,0,10+ 0+5]) rotate([90,30,0]) cylinder(h = 50, r=1.6, $fn=6);

    // Frame mounting screw head holes (1.5mm recess)
    //translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_bottom_wall_width-1.5,10+20+5]) rotate([-90,0,0]) cylinder(h = 50, r=3.5, $fn=30);
    //translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_bottom_wall_width-1.5,10+ 0+5]) rotate([-90,0,0]) cylinder(h = 50, r=3.5, $fn=30);
    for (h=[15,35]) {
        translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_bottom_wall_width+0.001,h]) rotate([90,0,0])  cylinder(h = 2, r=3.5, $fn=30);
        translate([-z_motor_ofs-z_beam_motor_ofs,-z_rod_to_rail+z_bottom_wall_width+0.001,h]) rotate([0,-90,90]) cylinder(h = 50, r=1.7, $fn=6);
    }

    // Rail guide nut cutouts
    translate([-z_motor_ofs-z_beam_motor_ofs,-3-z_rod_to_rail,10+20+5]) rotate([-90,0,0]) cylinder(h = 3, d1=z_railguide_keepout+2, d2=z_railguide_keepout, $fn=12);
    translate([-z_motor_ofs-z_beam_motor_ofs,-3-z_rod_to_rail,10+ 0+5]) rotate([-90,0,0]) cylinder(h = 3, d1=z_railguide_keepout+2, d2=z_railguide_keepout, $fn=12);

    // Wraparound wall mounting holes
    //for (h=[25,8]) translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2,-z_rod_to_rail-z_beam_width/2,h]) rotate([0,90,0]) cylinder(h=50, d=3.2, center=true, $fn=6);
    // Wraparound mounting screw holes
    for (h=[25,8]) {
        translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2+z_top_wall_width+0.001,-z_rod_to_rail-z_beam_width/2,h]) rotate([0,-90,0]) cylinder(h = 2, r=3.5, $fn=30);
        translate([-z_motor_ofs-z_beam_motor_ofs+z_beam_width/2+z_top_wall_width+0.001,-z_rod_to_rail-z_beam_width/2,h]) rotate([0,-90,0]) cylinder(h = 20, r=1.7, $fn=6);
    }

    // Fancy angled side wall reduction
    translate([-50-z_motor_ofs,-50+26,32]) rotate([-25,0,0]) cube([100, 100, 100]);    
}

module z_bottom_right(){
    intersection() {
        difference(){
            z_bottom_base();
            z_bottom_holes();
        }
        z_bottom_fancy();
    }
    %translate([-43/2-z_motor_ofs,-43/2,7]) color("red",0.25) cube([43,43,50]);

}

module z_bottom_left(){
 translate([z_rod_diam+z_bottom_wall_width*2,0,0]) mirror([1,0,0]) 
    z_bottom_right();
}

module stepper_motor_holes() {
    poly_cylinder( r=12.5, h=100);
    translate([+15.5,+15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([+15.5,-15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([-15.5,+15.5,0]) poly_cylinder( r=3.0/2, h=100 );
    translate([-15.5,-15.5,0]) poly_cylinder( r=3.0/2, h=100 );
}

