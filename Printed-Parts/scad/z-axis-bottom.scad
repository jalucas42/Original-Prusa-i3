// PRUSA iteration3
// Z axis bottom holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
include <common_dimensions.scad>


module z_bottom_base(){
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_width,z_bottom_wall_width+43,5]); // Base
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_wall_width,z_bottom_wall_width+43,z_bottom_height]); // Motor-side wall
    translate([-z_bottom_width/2-z_motor_ofs+z_bottom_width-z_bottom_wall_width,-z_rod_to_rail,0]) cube([z_bottom_wall_width,z_bottom_wall_width+43,z_bottom_height]); // Rod-side wall
    translate([-z_bottom_width/2-z_motor_ofs,-z_rod_to_rail,0]) cube([z_bottom_width,z_bottom_wall_width,z_bottom_height]); // Base
    
    // Rail guide
    translate([-8.25/2-z_motor_ofs,-3-43/2-z_bottom_wall_width,0]) cube([8.25,3,z_bottom_height]);

}

module z_bottom_fancy(){
    hull() {
        translate([-z_motor_ofs-z_bottom_width/2,-50,0]) cube([z_bottom_width, 100, z_bottom_height/2]);
        translate([-z_motor_ofs,0,z_bottom_height*0.75]) rotate([90,0,0]) cylinder(d=z_bottom_height/2, h=100, center=true);
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

module z_bottom_holes(){

    // Z rod holder
    translate([0,0,5+1]) rotate([0,180,0]) poly_cylinder(h = 50, r=z_rod_diam_tight/2);
    translate([0,1,0.6]) rotate([0,0,180]) cube([15,2,7]); // it's bit up because it helps with printing
    
    // Cutout to allow sliding stepper in while z-axis is mounted to rail.
    translate([-7/2-z_motor_ofs,0,-1]) cube([7,100,20]);
    
    translate([-z_motor_ofs,0,-1]) stepper_motor_holes();    

    // Frame mounting screw holes
    translate([-z_motor_ofs,0,10+20+5]) rotate([90,0,0]) cylinder(h = 50, r=1.5, $fn=30);
    translate([-z_motor_ofs,0,10+ 0+5]) rotate([90,0,0]) cylinder(h = 50, r=1.5, $fn=30);

    // Frame mounting screw head holes
    translate([-z_motor_ofs,-z_rod_to_rail+thinwall,10+20+5]) rotate([-90,0,0]) cylinder(h = 50, r=3.5, $fn=30);
    translate([-z_motor_ofs,-z_rod_to_rail+thinwall,10+ 0+5]) rotate([-90,0,0]) cylinder(h = 50, r=3.5, $fn=30);

    // Rail guide nut cutouts
    translate([-z_motor_ofs,-3-43/2-z_bottom_wall_width,10+20+5]) rotate([-90,0,0]) cylinder(h = 3, d1=13, d2=8.5, $fn=12);
    translate([-z_motor_ofs,-3-43/2-z_bottom_wall_width,10+ 0+5]) rotate([-90,0,0]) cylinder(h = 3, d1=13, d2=8.5, $fn=12);
    
}

module z_bottom_right(){
    intersection() {
        difference(){
            z_bottom_base();
            z_bottom_holes();
        }
        z_bottom_fancy();
    }
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

z_bottom_right();
z_bottom_left();