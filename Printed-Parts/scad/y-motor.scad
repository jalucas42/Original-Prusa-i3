// PRUSA iteration3
// Y motor mount
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <common_dimensions.scad>

y_idler_width = 25;

module y_motor_base(){

    hull() {
        translate([-y_idler_width/2,0,-x_beam_width]) rotate([0,0,0]) cube([y_idler_width,6,x_beam_width]);
        translate([-y_idler_width/2,6,-43/2+y_rail_to_idler]) cube([6,43,43]);
    }
        %translate([0,43/2+6,y_rail_to_idler]) rotate([0,90,0]) cylinder(d=y_idler_bearing_od, h=y_idler_bearing_width, $fn=60, center=true);

    // Rail guide + support
    translate([-y_idler_width/2,-z_railguide_depth,-x_beam_width/2-8.25/2]) cube([y_idler_width,z_railguide_depth,8.25]);    
    /*for (i=[0,1]) mirror([i,0,0]) {
        translate([-y_idler_width/2,-z_railguide_depth,-15-8.25/2]) cube([(y_idler_width-z_railguide_keepout-1)/2,z_railguide_depth,8.25]);
        translate([-y_idler_width/2,-z_railguide_depth-0.5,-30]) cube([(y_idler_width-z_railguide_keepout-1)/2,1,15-8.25/2]);
        translate([-y_idler_width/2,-z_railguide_depth-0.5-4,-30]) cube([(y_idler_width-z_railguide_keepout-1)/2,4,1]);
    }*/

}

module y_motor_holes(){
    translate([-y_idler_width/2-0.001,6+43/2,y_rail_to_idler]) rotate([0,90,0]) {
        for (x=[-1,1]) for (y=[-1,1]) {
            translate([x*31/2,y*31/2,0]) cylinder(d=3.4, h=200, center=false);
            translate([x*31/2,y*31/2,6]) cylinder(d=6.5, h=200, center=false);
        }
        hull() {
            cylinder(d=25, h=200, center=false);
            translate([0,50,0]) cylinder(d=15, h=200, center=false);
        }
        //translate([0,0,15-3]) cylinder(d=28, h=200, center=false);
        //translate([0,0,15+3]) cylinder(d=31, h=200, center=false);
        
    }
    
    // Belt positioning helper.  When viewed from above, will give proper alignment for edge of belt.
    //translate([-3,43/2+6-14,y_rail_to_idler]) cube([25,100,25]);
    //translate([+3,43/2+6-16,y_rail_to_idler]) cube([25,100,25]);

    translate([-3,43/2+6-12.5,y_rail_to_idler]) cube([25,100,25]);
    hull() {
        translate([-3,43/2+6,y_rail_to_idler])  rotate([0,90,0]) cylinder(d2=25, d1=30, h=6, center=false);
        translate([-3,43/2+6,y_rail_to_idler+50])  rotate([0,90,0]) cylinder(d2=25, d1=30, h=6, center=false);
        translate([-3,43/2+6+50,y_rail_to_idler])  rotate([0,90,0]) cylinder(d2=25, d1=30, h=6, center=false);
    }
    
    // Rail guide nut cutouts
    translate([0,0,-x_beam_width/2]) rotate([90,0,0]) cylinder(h = z_railguide_depth+0.001, d2=z_railguide_keepout+2, d1=z_railguide_keepout, $fn=12);    
    translate([0,0,-x_beam_width/2]) rotate([-90,0,0]) cylinder(h = 100, d=3.4, $fn=6);    
    translate([0,3,-x_beam_width/2]) rotate([-90,0,0]) cylinder(h = 100, d=6.4, $fn=12);    
    
    rotate([0,0,0]) cylinder(h = 100, d = 1, $fn = 4, center = true);
}




//#translate([18,40,10]) cube([8, 5, 5]);	

// Final part
module y_motor(){
    difference(){
        y_motor_base();
        y_motor_holes();
    }
}

y_motor();

module nema17_holes() {

}
