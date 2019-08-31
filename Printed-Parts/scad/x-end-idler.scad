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
        translate(v=[0,-22,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 80, r=1.8, $fn=30);
        translate(v=[-t8nut_id/2,-22,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 3, r=3.1, $fn=30);
        translate(v=[-t8nut_id/2-x_end_base_depth-1.5+2.5,-22,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 80, d=6.4, $fn=6);
    }
}


module waste_pocket(){

    extra_ofs = 1.1; // Offset to account for x_end changes
    
    // waste pocket
    translate([-x_to_z_offset,-1+extra_ofs,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=5, r=5.5, $fn=30);     
    translate([-x_to_z_offset,-1+extra_ofs,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=5, r=5.5, $fn=30);    
    translate([-x_to_z_offset,-5.9+extra_ofs,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=3, r1=5.5, r2=4.3, $fn=30);     
    translate([-x_to_z_offset,-5.9+extra_ofs,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=3, r=5.5, r2=4.3, $fn=30);      

    //M3 thread (tight fit)
    translate([-x_to_z_offset,8.5+extra_ofs,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=12, r=1.3, $fn=30); 
    translate([-x_to_z_offset,8.5+extra_ofs,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=12, r=1.3, $fn=30); 

    //M3 heads
    translate([-x_to_z_offset,11.5+extra_ofs,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=4, d=6.5, $fn=30); 
    translate([-x_to_z_offset,11.5+extra_ofs,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=4, d=6.5, $fn=30); 

    //M3 nut traps
    //translate([-x_to_z_offset-2.9,0.5+extra_ofs,52-3-1.6]) cube([55.8,3.1,200]);
    //translate([-x_to_z_offset-2.9,0.5+extra_ofs,-10+1.5+1.6]) cube([5.8,3.1,16]);
}


module x_end_idler_base(){
    union(){
        difference(){
            x_end_base();
            //x_end_idler_holes();
        }
        translate([-x_to_z_offset,8.5,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
        translate([-x_to_z_offset,8.5,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
        translate(v=[-t8nut_id/2-x_end_base_depth,-22+3.5,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 0.5, d1=10, d2=7, $fn=6);
    }
}


module x_end_idler(){
    mirror([0,1,0]) 
    difference(){
        x_end_idler_base();
        x_end_idler_holes();
        waste_pocket();
        // Re-cutout the Z bearing hold in case the "waste pocket" base was too big
        translate(v=[0,0,-1]) poly_cylinder(h = x_end_base_height+2, r=(z_bearing_diam/2)+0.1);
    }
    
}

//difference(){
x_end_idler();
//translate([-15,-50,0])   cube([100,100,100]);
//}


