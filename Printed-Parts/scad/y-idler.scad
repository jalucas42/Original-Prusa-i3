// PRUSA iteration3
// Y idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include <common_dimensions.scad>

y_idler_width = 20;

module y_idler_base(){
    hull() {
        translate([-y_idler_width/2,0,0]) rotate([-90,0,0]) cube([y_idler_width,x_beam_width,6]);
        translate([0,12,y_rail_to_idler]) rotate([0,90,0]) cylinder(d=10, h=y_idler_bearing_width+6, $fn=60, center=true);
    }
    %translate([0,12,y_rail_to_idler]) rotate([0,90,0]) cylinder(d=y_idler_bearing_od, h=y_idler_bearing_width, $fn=60, center=true);

    // Rail guide + support
    for (i=[0,1]) mirror([i,0,0]) {
        translate([-y_idler_width/2,-z_railguide_depth,-x_beam_width/2-x_railguide_width/2]) cube([(y_idler_width-z_railguide_keepout-1)/2,z_railguide_depth,x_railguide_width]);
        translate([-y_idler_width/2,-z_railguide_depth-0.5,-x_beam_width]) cube([(y_idler_width-z_railguide_keepout-1)/2,1,x_beam_width/2-x_railguide_width/2]);
        translate([-y_idler_width/2,-z_railguide_depth-0.5-4,-x_beam_width]) cube([(y_idler_width*.75)/2,4,1]);
    }

}

module y_idler_holes(){

    // Cutout for the bearing itself
    translate([-(y_idler_bearing_width+0.5)/2,-50,y_rail_to_idler-14/2]) cube([y_idler_bearing_width+0.5, 100, 14]);
    
    // M3 screw to mount bearing
    translate([0,12,y_rail_to_idler]) rotate([0,90,0]) cylinder(d=3.4, h=100, $fn=6, center=true);

    // Nut trap for M3 screw (2mm wall)
    translate([y_idler_bearing_width/2+0.25+2,12,y_rail_to_idler]) rotate([0,90,0]) cylinder(d=6.4, h=100, $fn=6, center=false);

    // Nut trap for M3 screw (2mm wall)
    translate([-(y_idler_bearing_width/2+0.25+2),12,y_rail_to_idler]) rotate([0,-90,0]) cylinder(d=6.4, h=100, $fn=60, center=false);

    // M3 screw to mount to rail
    translate([0,0,-x_beam_width/2]) rotate([-90,-90,0]) cylinder(d=3.4, h=100, $fn=6, center=false);
    translate([0,2,-x_beam_width/2]) rotate([-90,-90,0]) cylinder(d=7.0, h=100, $fn=60, center=false);

    // Center line markers
    translate([0,0,0]) rotate([-90,90,0]) cylinder(d=3.4, h=100, $fn=3, center=true);
    translate([0,0,-x_beam_width-1]) rotate([-90,-90,0]) cylinder(d=3.4, h=100, $fn=3, center=true);
    
}

// Final part
module y_idler(){
    difference(){
        y_idler_base();
        y_idler_holes();
    }
}

y_idler();
