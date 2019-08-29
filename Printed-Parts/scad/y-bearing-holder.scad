
use <polyholes.scad>
use <printable_bearing.scad>

bearing_diameter = 14.5;
thinwall = 3;
bearing_size = bearing_diameter + 2 * thinwall;


module y_bearing_holder_base() {
    hull() {
        translate([0,0,0]) cube([27,35,5.5]);
        translate([0,35/2,5.5+bearing_size/2-thinwall]) rotate([0,90,0]) cylinder(d=bearing_size, h=27);
    }
}

module y_bearing_holder_holes() {
    // Cutout for printable bearing
    //translate([-1,35/2,5.5+bearing_size/2-thinwall]) rotate([0,90,0]) printable_bearing_negative( length=27+2, od=bearing_size );
    translate([-1,35/2,5.5+bearing_size/2-thinwall]) rotate([0,90,0]) bearing_cutout( length=27+2, od=bearing_size );
    
    ofs = 4;
    
    // Cutout screw holes
    translate([0+ofs,0+ofs,-1]) rotate([0,0,0]) poly_cylinder(r=1.5, h=50);
    translate([0+ofs,35-ofs,-1]) rotate([0,0,0]) poly_cylinder(r=1.5, h=50);
    translate([27-ofs,0+ofs,-1]) rotate([0,0,0]) poly_cylinder(r=1.5, h=50);
    translate([27-ofs,35-ofs,-1]) rotate([0,0,0]) poly_cylinder(r=1.5, h=50);

    // Cutout screw holes
    translate([0+ofs,0+ofs,3]) rotate([0,0,0]) cylinder(r=6.5/2, h=50, $fn=6);
    translate([0+ofs,35-ofs,3]) rotate([0,0,0]) cylinder(r=6.5/2, h=50, $fn=6);
    translate([27-ofs,0+ofs,3]) rotate([0,0,0]) cylinder(r=6.5/2, h=50, $fn=6);
    translate([27-ofs,35-ofs,3]) rotate([0,0,0]) cylinder(r=6.5/2, h=50, $fn=6);

}



module y_bearing_holder() {
    difference() {
        y_bearing_holder_base();
        y_bearing_holder_holes();
    }
}

//my_linear_bearing_cutout( length=27, od=bearing_size );
rotate([0,-90,0]) y_bearing_holder();