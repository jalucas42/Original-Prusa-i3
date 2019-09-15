// PRUSA iteration3
// X end motor
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
 
use <x-end.scad>
use <x-end-idler.scad>
include <common_dimensions.scad>

module x_end_motor_base(){
    x_end_idler_base();
    translate(v=[-x_end_base_depth/2-x_to_z_offset,(z_bearing_diam/2)+thinwall,0]) cube(size = [17,44,x_end_base_height], center = false);
    
}

module x_end_motor_endstop_base(){
    translate([-x_end_base_depth/2-x_to_z_offset,-x_end_base_width+z_bearing_diam/2+thinwall,x_end_base_height]) {
        difference(){
            // Base block
            cube([x_end_base_depth,18.2,4]);
            // Nice edge
            translate([-1,10,10])rotate([-45,0,0])cube(20,20,20);
            } 
        }
}

module x_end_motor_endstop_holes(){
    translate([-x_end_base_depth/2-x_to_z_offset,-x_end_base_width+z_bearing_diam/2+thinwall,x_end_base_height]){
        translate([17/2,7.5,-3]){
            // Back screw hole for endstop
            translate([-4.75,0,0])cylinder(r=1,h=19,$fn=20);
            // Front screw hole for endstop
            translate([4.75,0,0])cylinder(r=1,h=19,$fn=20);
            }
        }
}

module x_end_motor_holes(){
    x_end_holes();
    
    // Position to place
    translate(v=[-x_to_z_offset-x_end_base_depth/2,32,x_end_base_height/2]) {
        // Belt hole
        //translate(v=[-14,1,0]) cube(size = [10,46,22], center = true);
        // Motor mounting holes
        //translate(v=[20,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
        //translate(v=[1,-15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);
        //translate(v=[20,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
        //translate(v=[1,-15.5,15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);
        //translate(v=[20,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=1.8, $fn=30);
        //translate(v=[1,15.5,-15.5]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 10, r=3.1, $fn=30);
        
        for (x=[-1,1]) for (y=[-1,1]) {
            translate(v=[0,x*15.5,y*15.5]) rotate(a=[0,90,0]) rotate(a=[0,0,-90]) cylinder(h = 100, r=1.8, $fn=30, center=true);
            translate(v=[5,x*15.5,y*15.5]) rotate(a=[0,90,0]) rotate(a=[0,0,-90]) cylinder(h = 100, r=3.1, $fn=30);
        }

        // Cutout for stepper bump around shaft
        translate([0,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 100, d=27, $fn=30);
        
        // Material saving cutout 
        translate(v=[-10,12,10]) cube(size = [60,42,42], center = true);
        //translate([-50,-8.5,-8.5]) cube([100, 100, 100]);

        // Material saving cutout
        translate(v=[-10,40,-30]) rotate(a=[45,0,0])  cube(size = [60,100,42], center = true);
        // Motor shaft cutout
        //#translate(v=[0,0,0]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);
    }
}

// Motor shaft cutout
module x_end_motor_shaft_cutout(){
    union(){
        difference(){
            translate(v=[0,32,30]) rotate(a=[0,-90,0]) rotate(a=[0,0,90]) cylinder(h = 70, r=17, $fn=6);
           
            translate(v=[-10,-17+32,30]) cube(size = [60,2,10], center = true);
            translate(v=[-10,-8+32,-15.5+30]) rotate(a=[60,0,0]) cube(size = [60,2,10], center = true); ///
            translate(v=[-10,8+32,-15.5+30]) rotate(a=[-60,0,0]) cube(size = [60,2,10], center = true);
            
            
        }
        translate(v=[-30,25.2,-11.8 +30]) rotate(a=[0,90,0]) cylinder(h = 30, r=3, $fn=30);
        translate(v=[-30,19.05,30]) rotate(a=[0,90,0]) cylinder(h = 30, r=3.5, $fn=100);
    }
}




// Final part
module x_end_motor(){
    mirror([0,1,0]) 
    difference(){
        union(){
            x_end_motor_base();
            x_end_motor_endstop_base();
        }

        x_end_motor_shaft_cutout();
        //x_end_idler_holes();
        x_end_motor_holes();
        x_end_motor_endstop_holes();    

        // Notch on endstop holder
        translate([-12,-42,65]) rotate([-35,0,0])  rotate([0,0,45]) cube(10,10,10);

        // Waste cutout for pushfit rods
        translate([-x_to_z_offset,x_bearing_diam/2+0.5,x_end_base_height/2]) 
        for (i=[-1,1]) translate([0,0+3,i*x_rod_distance/2]) rotate(a=[90,0,0]) cylinder(d=x_rod_diam_tight+2,h=3, center=false);
        
    }
 
}

x_end_motor();