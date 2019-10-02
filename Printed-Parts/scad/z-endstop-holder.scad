// PRUSA Mendel
// 10mm bar Endstop holder
// Used to attach endstops to 10mm rods
// GNU GPL v3
// Peter Ellens
// Based on endstop_holder.scad by
// Josef Pru�a
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <common_dimensions.scad>

z_endstop_height = ceil(6.3+3);
z_endstop_width  = z_rod_diam+2*thinwall;

z_endstop();
%translate([0,0,-1]) cylinder(d=z_rod_diam, h=z_endstop_height+2);

//x_base_screwholder();

module z_endstop_base() {
    hull() {
        cylinder(d=z_endstop_width, h=z_endstop_height);
        translate([0,-z_endstop_width/2,0]) cube([z_rod_diam/2+7,z_endstop_width,z_endstop_height]);
    }
    
    translate([0,thinwall+3.2,0]) rotate([0,0,180]) cube([20+1+5+8+z_endstop_width/2,thinwall+6.4+thinwall,z_endstop_height]);
}

module z_endstop_holes() {
    // rod hole
    translate([0,0,-1]) cylinder(d=z_rod_diam+0.25, h=z_endstop_height+2);
    
    // slide-in slot
    translate([0,0,-1]) hull() {
        cylinder(d=z_rod_diam-1.5, h=z_endstop_height+2);
        translate([z_rod_diam/2+10,0,0]) cylinder(d=z_rod_diam+0.5, h=z_endstop_height+2);
    }
    
    // m3 screw/nut to tighten against rod
    %translate([z_rod_diam/2+3.0/2+1,0,z_endstop_height/2]) rotate([0,90,90]) cylinder(d=3.0/cos(180/6), h=z_endstop_width*2, $fn=6, center=true);
    translate([z_rod_diam/2+3.0/2+1,0,z_endstop_height/2]) rotate([0,90,90]) cylinder(d=3.0/cos(180/6), h=z_endstop_width*2, $fn=6, center=true);
    translate([z_rod_diam/2+3.0/2+1,-(z_endstop_width/2+0.001),z_endstop_height/2]) rotate([-90,-90,0]) cylinder(d=6.3, h=1.2, $fn=6, center=false);
    translate([z_rod_diam/2+3.0/2+1,+(z_endstop_width/2+0.001),z_endstop_height/2]) rotate([+90,+90,0]) cylinder(d=6.3, h=1.2, $fn=6, center=false);

    // mounting holes for switch.  
    // Holes: 3/32 (2.5mm), 3/8 spacing, 3mm from bottom
    // Dimensions: 20.25mm x 10mm x 6.4mm
    %for(i=[-1,1]) translate([i*(3/8*25.4)/2-(10+1+5+z_endstop_width/2),0,3.0]) rotate([0,90,90]) cylinder(d=3/32*25.4/cos(180/6), h=z_endstop_width*2, $fn=6, center=true);

    %translate([-(20+1+5+8)-0.001,-thinwall,-1]) cube([20,6.4,z_endstop_height+2]);
    translate([-(20+1+5+8)-8-0.001,-thinwall,-1]) cube([20+8,6.4,z_endstop_height+2]);

    translate([-(20+1+5+8)-2.5,0,0]) {
        %translate([0,0,z_endstop_height/2]) rotate([0,90,90]) cylinder(d=3.0/cos(180/6), h=z_endstop_width*2, $fn=6, center=true);
        translate([0,0,z_endstop_height/2]) rotate([0,90,90]) cylinder(d=3.0/cos(180/6), h=z_endstop_width*2, $fn=6, center=true);
        translate([0,-(3.2+thinwall+0.001),z_endstop_height/2]) rotate([-90,-90,0]) cylinder(d=6.3, h=1.2, $fn=6, center=false);
        translate([0,+(3.2+thinwall+0.001),z_endstop_height/2]) rotate([+90,+90,0]) cylinder(d=6.3, h=1.2, $fn=6, center=false);
    }
}

module z_endstop() {
    difference() {
        z_endstop_base();
        z_endstop_holes();
    }
}


module x_base_screwholder() {
    difference() {
        hull() {
            cylinder(d=25,h=10);
            translate([0,5,0]) cylinder(d=25,h=10);
            translate([25/2+3,0,0]) cylinder(d=10, h=3);
        }
        translate([0,0,-1]) union() {
            translate([-12.501,0,0]) cube([25,25,10+2]);
            cylinder(d=25.002,h=10+2);
        }

        translate([25/2+3,0,0]) cylinder(d=3.0, h=100, $fn=6, center=true);
        
        translate([0,0,3]) hull() {
            translate([0,0,0]) cylinder(d=6.5, h=100, $fn=30);
            translate([25/2+3,0,0]) cylinder(d=6.5, h=100, $fn=30);
        }

    }
}