// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
include <common_dimensions.scad>

x_carriage_width = 45; // 2*LM10UU = 58mm
x_carriage_height = x_rod_distance + x_bearing_diam + 2*thinwall;
x_carriage_wall_width = x_bearing_diam/2-3+6;

beltholder_width = 18;
beltholder_height = 2 + 9 + 2;

x_carriage();
//rotate([90,0,0]) beltholder();

module x_carriage_base(){

    // Bearing tubes
    for (i=[-1,1]) translate([0,0,i*x_rod_distance/2]) rotate([0,90,0]) cylinder(d=x_bearing_diam, h=x_carriage_width, center=true, $fn=60);
    
    // Front wall
    translate([-x_carriage_width/2, -x_bearing_diam/2-6, -x_rod_distance/2]) cube([x_carriage_width, x_carriage_wall_width, x_rod_distance]);
    
    // Belt slot block
    //translate([-x_carriage_width/2, -3, 0]) cube([18, 7, x_rod_distance/2]);
}

module x_carriage_holes(){
    
    // PTFE bearing cutouts (1 top center, 2 on bottom)
    for (z=[-1,1]) {
        translate([-12/2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=12, bearing_od=x_bearing_diam);        
        for (i=[0,1]) mirror([i,0,0]) translate([-x_carriage_width/2+2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=12, bearing_od=x_bearing_diam);
    }    

    //%rotate([90,0,0]) cylinder(d=x_idler_bearing_od, h=6, center=true); // Idler bearing (and stepper pinion)
    //%translate([-x_carriage_width/2, -3, x_idler_bearing_od/2]) cube([x_carriage_width, 6, 1]); // Top belt
    //translate([-x_carriage_width/2-1, -3, x_idler_bearing_od/2-1.1]) cube([10, 7.001, 2.1]); // Belt slot
    
    /*hull() {
        translate([-x_carriage_width/2-1+ 7, -3, x_idler_bearing_od/2-1.1+2.1/2+0]) rotate([-90,0,0]) cylinder(d=2.1, h=7.001, $fn=30); // Belt slot
        translate([-x_carriage_width/2-1+13, -3, x_idler_bearing_od/2-1.1+2.1/2+0]) rotate([-90,0,0]) cylinder(d=7, h=7.001, $fn=30); // Belt slot
    }*/
    
    //translate([-x_carriage_width/2-1+13, -x_bearing_diam/2, x_idler_bearing_od/2-1.1+2.1/2+0]) rotate([-90,0,0]) cylinder(d=3.5, h=50, $fn=6, center=true); // M3 hole
    //translate([-x_carriage_width/2-1+13, -3-2.5, x_idler_bearing_od/2-1.1+2.1/2+0]) rotate([-90,0,0]) cylinder(d=6.3, h=50, $fn=6, center=false); // M3 hole
    //translate([-x_carriage_width/2-1+13, -x_bearing_diam/2-0.001, x_idler_bearing_od/2-1.1+2.1/2+0]) rotate([-90,0,0]) cylinder(d=7.0, h=3, $fn=30, center=false); // M3 hole

    // Cutout for bottom belt
    translate([0.001,0,-x_idler_bearing_od/2]) cube([x_carriage_width+0.002, 10, 4], center=true);

    // Slider slot for belt holders
    translate([-x_carriage_width/2-0.001,-2-3,-beltholder_height/2+x_idler_bearing_od/2-0.25]) cube([x_carriage_width+0.002, 2.001, beltholder_height+0.5]);

    for (i=[-1,1]) {
        // M3 slot
        hull() {
            translate([i*x_carriage_width/2-0.001-i*10,-2-3+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
            translate([i*x_carriage_width/2-0.001-i*18,-2-3+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
        }
        
        // M3 nut trap slot
        hull() {
            translate([i*x_carriage_width/2-0.001-i*10,-2-3-3.0+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
            translate([i*x_carriage_width/2-0.001-i*18,-2-3-3.0+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
        }

        // M3 nut cutout to allow removing beltholder pieces without completely removing screw.
        translate([i*x_carriage_width/2-0.001-i*18,0,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=100, $fn=6, center=true);
    }
    
    translate([0,-x_bearing_diam/2-6,0]) for (x=[-1,1]) for (y=[-1,1]) translate([x*31/2,0,y*31/2]) {
        translate([0,8,0]) rotate([90,0,0]) cylinder(d=3.4, h=20, center=false, $fn=30);
        translate([0,3+2,0]) hull() {
            rotate([90,0,0]) cylinder(d=6.4, h=3, center=false, $fn=6);        
            translate([x*20,0,0]) rotate([90,0,0]) cylinder(d=6.4, h=3, center=false, $fn=6);        
        }
    }

    //%translate([0,-3,0]) rotate([-90,0,0]) bolt();
}

module x_carriage(){
    difference(){
        x_carriage_base();
        x_carriage_holes();
    }
    
    %translate([-x_carriage_width/2-1,-3,x_idler_bearing_od/2]) beltholder();
}

module ptfe_bearing_holes(rod_diam=10, tightness=0.0, length=25, ptfe_od=4.0, num_sections=7, bearing_od=19, clearance=1.5) {
    render() {
        $fn = 60;
        rod_diam_tight = rod_diam - tightness;
        translate([0,0,0]) cylinder( d=rod_diam+2, h=length+300, center=true );
        for (i=[0:num_sections-1]) rotate([0,0,i*360/num_sections]) {
            //%translate([rod_diam_tight/2+ptfe_od/2,0,-1]) cylinder( d=ptfe_od, h=length+2 );
            translate([rod_diam_tight/2+ptfe_od/2,0,]) cylinder( d=ptfe_od, h=length );
            intersection() {
                translate([bearing_od/2-3/2,-3/2,]) cube([3,3,length]);
                cylinder(d=bearing_od+clearance, h=length, $fn=60);
            }
        }

        // Cut clearance hole around bearing so it can flex
        translate([0,0,0]) difference() {
            cylinder(d=bearing_od+2*clearance, h=length, $fn=60);
            cylinder(d=bearing_od, h=length, $fn=60);
        }
    }        
}

module nema17_holes() {
    for (x=[-1,1]) for (y=[-1,1]) translate([x*31/2,y*31/2,0]) cylinder(d=3.4, h=20, center=false);
}

//knurled_surface( x_len=10, y_len=10 );
module knurled_surface( x_len=10, y_len=10, cube_side=2 ) {
    knurl_diam = 3;
    //rotate([45,35.26,45]) cube([cube_side,cube_side,cube_side], center=true);
    
    sqrt_2 = sqrt(2);
    cos_180_4 = cos(180/4);

    max_x = ceil(x_len/2);
    max_y = ceil(y_len/2);
    
    //translate([-2,-1,-2]) cube([11,11,2.001]);
    translate([knurl_diam/2,knurl_diam/2,0]) difference() {
        union() {
            for (y=[0:max_x-1]) for (x=[0:max_y-1]) {
                translate([((x+0)*knurl_diam)*cos_180_4*sqrt_2,(y*knurl_diam+0)*cos_180_4*sqrt_2,0]) rotate([0,0,0]) cylinder(d1=knurl_diam, d2=0.001, h=knurl_diam/2, $fn=4);
                translate([((x+0.5)*knurl_diam)*cos_180_4*sqrt_2,((y+0.5)*knurl_diam)*cos_180_4*sqrt_2,0]) rotate([0,0,0]) cylinder(d1=knurl_diam, d2=0.001, h=knurl_diam/2, $fn=4);
            }
        }
        translate([-50,-50,knurl_diam*0.3]) cube([100,100,100]);
    }
}


module beltholder() {
    translate([0,0,-beltholder_height/2]) {
        
        difference() {
            translate([0, -2, 0]) cube([18, 6+2, beltholder_height]);

            translate([-1, 0, beltholder_height/2-2.1/2]) cube([10, 7.001, 2.1]); // Belt slot
            
            hull() {
                translate([-1+ 7, 0, beltholder_height/2]) rotate([-90,0,0]) cylinder(d=2.1, h=7.001, $fn=30); // Belt slot
                translate([-1+13, 0, beltholder_height/2]) rotate([-90,0,0]) cylinder(d=9, h=7.001, $fn=30); // Belt slot
            }

            translate([-1+13, 0, beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); // Belt slot
        }

        difference() {
            translate([-1+13, 0, beltholder_height/2]) rotate([-90,0,0]) cylinder(d=6, h=6-3, $fn=30); // Belt slot
            translate([-1+13, 0, beltholder_height/2]) rotate([-90,0,0]) cylinder(d=3.3, h=100, $fn=30, center=true); // Belt slot
            
        }
    }
}