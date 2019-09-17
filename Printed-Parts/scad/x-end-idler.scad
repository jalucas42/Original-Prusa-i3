// PRUSA iteration3
// X end idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <x-end.scad>
use <polyholes.scad>

include <common_dimensions.scad>

module x_end_idler_base(){

    x_end_plain();
    
    if (x_end_idler_open_end == false) {
        translate([-x_to_z_offset,8.5,x_end_base_height/2-x_rod_distance/2]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
        translate([-x_to_z_offset,8.5,x_end_base_height/2+x_rod_distance/2]) rotate([90,0,0]) cylinder( h=11, r=6, $fn=30);
        translate(v=[-t8nut_id/2-x_end_base_depth,-22+3.5,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 0.5, d1=10, d2=7, $fn=6);
    }

    // idler bearing holder nubs
    //for (i=[-1,1]) translate(v=[-x_to_z_offset+i*x_end_belt_hole_width/2,-23+3.5,x_end_base_height/2]) rotate(a=[0,i*-90,0]) cylinder(h = 0.50, d1=x_idler_bearing_id+6, d2=x_idler_bearing_id+1, $fn=30);

}

module x_end_idler_holes(){
    //x_end_holes();
    translate([0,0,0]){
        
        rod_to_idler = 22-3.5;
        
        // Idler bearing bolt
        translate(v=[-x_to_z_offset,-rod_to_idler,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 80, r=1.5, $fn=30, center=true);

        // Idler bearing bolt nut trap
        translate(v=[-x_to_z_offset-x_end_base_depth/2-0.001,-rod_to_idler,x_end_base_height/2]) rotate(a=[0,+90,0]) cylinder(h = 2.25, d=6.3, $fn=6);
        
        // Idler bearing bolt head recess
        translate(v=[-x_to_z_offset+x_end_base_depth/2+0.001,-rod_to_idler,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = 2.25, d=6.3, $fn=30);
        
        // Idler bearing
        %translate(v=[-x_to_z_offset,-rod_to_idler,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = x_idler_bearing_width, d=x_idler_bearing_od, $fn=30, center=true);
        // Belt on idler bearing
        %translate(v=[-x_to_z_offset,-rod_to_idler,x_end_base_height/2]) rotate(a=[0,-90,0]) cylinder(h = x_idler_bearing_width-2, d=x_idler_bearing_od+3, $fn=30, center=true);
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

module x_end_idler(){
    mirror([0,0,0]) 
    difference(){
        x_end_idler_base();
        x_end_idler_holes();
        //waste_pocket();
        // Re-cutout the Z bearing hold in case the "waste pocket" base was too big
        //translate(v=[0,0,-1]) poly_cylinder(h = x_end_base_height+2, r=(z_bearing_diam/2)+0.1);
    }
    
}

module x_end_idler_test() {
    intersection() {
        x_end_idler();
        // WHERE DOES 0.4 COME FROM???
        translate([-x_to_z_offset-x_end_base_depth/2+0.4,-x_bearing_diam-2*thinwall-1,0]) cube([x_end_base_depth,x_idler_bearing_od,x_end_base_height/2+x_idler_bearing_id]);
    }
}

//difference(){
//x_end_idler();
x_end_idler();
//translate([-15,-50,0])   cube([100,100,100]);
//}


