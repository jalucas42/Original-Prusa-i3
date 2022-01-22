// PRUSA iteration3
// X carriage
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use <ptfe_bearing_holes.scad>
include <common_dimensions.scad>

x_carriage_use_ptfe_bearings = false;
x_carriage_use_bltouch = false; // NOTE: Currently only compatible with PTFE bearings...

// Can use skinnier carriage with builting bearings.  45mm is about right for NEMA17 hole pattern used by some mounts.
x_carriage_width = x_carriage_use_ptfe_bearings ? 45 : 2*x_bearing_length;
x_carriage_height = x_rod_distance + x_bearing_diam + 2*thinwall;
x_carriage_wall_width = x_bearing_diam/2-3+6;
x_bearing_clearance = x_carriage_use_ptfe_bearings ? 0 : 0.2;

x_end_ptfe_bearing_tightness=-0.20; // Negative tightness means larger hole
x_end_ptfe_bearing_ptfe_od = 4.1;
x_end_ptfe_bearing_length = 12;


bltouch_width = 13.3+0.25;
bltouch_depth = 13.5+1.0;
bltouch_height = 40;

beltholder_width = 18;
beltholder_height = 2 + 9 + 2;

test = 0;
if (test) {
    intersection() {
        x_carriage();
        translate([0,-50,0]) cube([100,100,100], center=false);
    }
} else {
    x_carriage();
}


// These planes mark the nozzle tip and where the BL touch should mount.
if (x_carriage_use_bltouch) {
    %translate([0,0,-x_rod_distance/2-x_bearing_diam/2-23]) cube([100,100,0.001], center=true);
    %translate([0,0,-x_rod_distance/2-x_bearing_diam/2-23+bltouch_height+2]) cube([100,100,0.001], center=true);
}

module x_carriage_base(){

    // Bearing tubes
    if (x_carriage_use_ptfe_bearings) {
        for (i=[-1,1]) translate([0,0,i*x_rod_distance/2]) rotate([0,90,0]) cylinder(d=x_bearing_diam, h=x_carriage_width, center=true, $fn=60);
    } else {
        for (i=[-1,1]) translate([0,0,i*x_rod_distance/2]) rotate([0,90,0]) cylinder(d=x_bearing_diam+2*x_bearing_clearance+2*thinwall, h=x_carriage_width, center=true, $fn=60);    }
    
    // Front wall
    translate([-x_carriage_width/2, -x_bearing_diam/2-6, -x_rod_distance/2]) cube([x_carriage_width, x_carriage_wall_width, x_rod_distance]);
    
    // BL Touch mount
    if (x_carriage_use_bltouch) {
        //for (i=[-1]) translate([0,0,i*x_rod_distance/2]) rotate([0,90,0]) cylinder(d=x_bearing_diam, h=x_carriage_width, center=true, $fn=60);
        translate([-13, x_bearing_diam/2, -x_rod_distance/2+x_bearing_diam/2-7]) cube([26, bltouch_depth+thinwall, 7]);
        translate([-x_carriage_width/2, 0, -x_rod_distance/2+x_bearing_diam/2-7]) cube([x_carriage_width, x_bearing_diam/2, 7]);
    }

    //cube([
    
    // Belt slot block
    //translate([-x_carriage_width/2, -3, 0]) cube([18, 7, x_rod_distance/2]);
}

module x_bearing_ziptie_cutout() {
    difference() {
        cylinder(d=x_bearing_diam+3*x_bearing_clearance+2*thinwall+2*2, h=5, $fn=60, center=true);
        cylinder(d=x_bearing_diam+3*x_bearing_clearance+2*thinwall, h=5.002, $fn=60, center=true);
    }
}

module x_carriage_holes(){
    
    // PTFE bearing cutouts (1 top center, 2 on bottom)
    if (x_carriage_use_ptfe_bearings) {
        for (z=[-1,1]) {
            //translate([-12/2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=12, bearing_od=x_bearing_diam);        
            for (i=[0,1]) mirror([i,0,0]) translate([-x_carriage_width/2+2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=x_end_ptfe_bearing_length, bearing_od=x_bearing_diam, tightness=x_end_ptfe_bearing_tightness, ptfe_od=x_end_ptfe_bearing_ptfe_od);
        }    
    } else {
       for (z=[-1,1]) {
           // Main bearing cutout
           translate([0,0,z*x_rod_distance/2]) rotate([0,90,0]) cylinder(h=x_carriage_width+10, d=x_bearing_diam+2*x_bearing_clearance, center=true);        
           // wall coutout 
           hull() for (y=[0,1]) translate([0,y*100,z*x_rod_distance/2]) rotate([0,90,0]) cylinder(h=x_carriage_width+10, d=x_bearing_diam-1, center=true, $fn=6);    
           translate([-x_carriage_width/2-0.001,x_bearing_diam/2-thinwall,-x_carriage_height/2]) cube([x_carriage_width+0.002, 100, x_carriage_height]);
           // Ziptie loop 
           // NOTE - have to move the double-bearing zipties to not interfere with mounting holes...
           if (z==1) translate([0,0,z*x_rod_distance/2]) rotate([0,90,0]) x_bearing_ziptie_cutout();        
           if (z==-1) for(x=[-1,1]) for(x1=[-1,1]) translate([x*x_bearing_length/2+x1*x_bearing_length/3,0,z*x_rod_distance/2]) rotate([0,90,0]) x_bearing_ziptie_cutout();        
        }    
    }

    /*for (z=[-1]) {
        //translate([-12/2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=12, bearing_od=x_bearing_diam);        
        translate([-(x_carriage_width/2-4)/2,0,z*x_rod_distance/2]) rotate([0,90,0]) ptfe_bearing_holes(length=x_carriage_width/2-4, bearing_od=x_bearing_diam, tightness=-0.1);
    }*/   

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
    tmp_belt_holder_thickness = 2; // The belt holder "floor"
    tmp_belt_width = 6; // X carriage belt width (gt2 = 6mm)
    translate([-x_carriage_width/2-0.001,-tmp_belt_holder_thickness-tmp_belt_width/2,-beltholder_height/2+x_idler_bearing_od/2-0.25]) cube([x_carriage_width+0.002, tmp_belt_holder_thickness+.001+100, beltholder_height+0.5]);

    for (i=[-1,1]) {
        // NOTE - keeping inner hole based on X_CARRIAGE_WIDTH=45, so that belt length doesn't need to change...
        // M3 slot
        hull() {
            translate([i*x_carriage_width/2-0.001-i*10,-2-3+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
            translate([i*45/2-0.001-i*18,-2-3+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=3.4, h=10, $fn=30);
        }
        
        // M3 nut trap slot
        hull() {
            translate([i*x_carriage_width/2-0.001-i*10,-2-3-3.0+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
            translate([i*45/2-0.001-i*18,-2-3-3.0+0.001,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=10, $fn=6);
        }

        // M3 nut cutout to allow removing beltholder pieces without completely removing screw.
        translate([i*45/2-0.001-i*18,0,x_idler_bearing_od/2]) rotate([90,0,0]) cylinder(d=6.4, h=100, $fn=6, center=true);
    }
    
    // Mounting holes
    translate([0,-x_bearing_diam/2-6,0]) for (x=[-1,1]) for (y=[-1,1]) translate([x*31/2,0,y*31/2]) {
        // M3 hole
        translate([0,8,0]) rotate([90,0,0]) cylinder(d=3.4, h=20, center=false, $fn=30);
        // Nut trap
        translate([0,3+2,0]) hull() {
            rotate([90,0,0]) cylinder(d=6.4, h=3, center=false, $fn=6);        
            translate([x*20,0,0]) rotate([90,0,0]) cylinder(d=6.4, h=3, center=false, $fn=6);        
        }
    }

    // BL Touch mount
    if (x_carriage_use_bltouch) {
        layer_thickness = 0.3;
        // Main BL Touch cutout.  Leave enough for 0.5mm wall support while printing, to be cleaned up later.
        translate([-bltouch_width/2, x_bearing_diam/2+thinwall+0.001, -x_rod_distance/2+x_bearing_diam/2-6-0.5]) cube([bltouch_width, bltouch_depth, 6], center=false);
        // M3 hole.  
        for (x=[-1,1]) translate([x*9, x_bearing_diam/2+thinwall+bltouch_depth/2+0.001, -x_rod_distance/2+x_bearing_diam/2-7+2.5]) cylinder(d=3.2, h=100, $fn=10, center=true);
        // M3 nut capture.
        //for (x=[-1,1]) translate([x*9, x_bearing_diam/2+thinwall+bltouch_depth/2+0.001, -x_rod_distance/2+x_bearing_diam/2-7+2.5]) rotate([180,0,90]) cylinder(d=6.4, h=100, $fn=6, center=false);
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

/*
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
*/

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

module x_carriage_bearing_test() {
    end_spacing=2.0;
    difference() {
        union() {
            translate(v=[-z_rod_to_base/2,0,1.0]) cube(size = [z_rod_to_base,z_bearing_size,2.0], center = true);
            cylinder(h = 12+4, r=x_bearing_diam/2, $fn = 90);
        }
        union() {
            //for (i=[0,1]) 
            for (i=[0])
            translate([0,0,end_spacing+i*(x_end_base_height-z_bearing_length)]) 
            rotate([0,0,-90])
            ptfe_bearing_holes(length=12, bearing_od=z_bearing_diam, tightness=x_end_ptfe_bearing_tightness, ptfe_od=x_end_ptfe_bearing_ptfe_od);
        }
    }
            
}
