// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <x-end.scad>
use <polyholes.scad>

include <common_dimensions.scad>

module x_end_idler_holes(){
    x_end_holes();
    translate([0,3.5,0]){
    translate(v=[0,-22,30.25]) rotate(a=[0,-90,0]) cylinder(h = 80, r=1.8, $fn=30);
    translate(v=[-t8nut_id/2,-22,30.25]) rotate(a=[0,-90,0]) cylinder(h = 3, r=3.1, $fn=30);
    translate(v=[-26,-22,30.25]) rotate(a=[0,-90,0]) cylinder(h = 80, r=3.2, $fn=6);
        
 }
}


module waste_pocket(){

    extra_ofs = 1.1; // Offset to account for x_end changes
    
    // waste pocket
    translate([-x_to_z_offset,-1+extra_ofs,6]) rotate([90,0,0]) cylinder( h=5, r=5.5, $fn=30);     
    translate([-x_to_z_offset,-1+extra_ofs,51]) rotate([90,0,0]) cylinder( h=5, r=5.5, $fn=30);    
    translate([-x_to_z_offset,-5.9+extra_ofs,6]) rotate([90,0,0]) cylinder( h=3, r1=5.5, r2=4.3, $fn=30);     
    translate([-x_to_z_offset,-5.9+extra_ofs,51]) rotate([90,0,0]) cylinder( h=3, r=5.5, r2=4.3, $fn=30);      

    //M3 thread
    translate([-x_to_z_offset,8.5+extra_ofs,6]) rotate([90,0,0]) cylinder( h=12, r=1.4, $fn=30); 
    translate([-x_to_z_offset,8.5+extra_ofs,51]) rotate([90,0,0]) cylinder( h=12, r=1.4, $fn=30); 

    //M3 heads
    translate([-x_to_z_offset,11.5+extra_ofs,6]) rotate([90,0,0]) cylinder( h=4, r=2.9, $fn=30); 
    translate([-x_to_z_offset,11.5+extra_ofs,51]) rotate([90,0,0]) cylinder( h=4, r=2.9, $fn=30); 

    //M3 nut traps
    translate([-x_to_z_offset-2.9,0.5+extra_ofs,52-3-1.6]) cube([5.8,3.1,20]);
    translate([-x_to_z_offset-2.9,0.5+extra_ofs,-10+1.5+1.6]) cube([5.8,3.1,16]);
}


module x_end_idler_base(){
    union(){
        difference(){
            x_end_base();
            x_end_idler_holes();
        }
        translate([-x_to_z_offset,8.5,6]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
        translate([-x_to_z_offset,8.5,51]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
    }
}


module x_end_idler(){
    mirror([0,1,0]) 
    difference(){
        x_end_idler_base();
        waste_pocket();
        // Re-cutout the Z bearing hold in case the "waste pocket" base was too big
        translate(v=[0,0,-1]) poly_cylinder(h = 62, r=(z_bearing_diam/2)+0.1);
    }
    
}

//difference(){
x_end_idler();
//translate([-15,-50,0])   cube([100,100,100]);
//}


