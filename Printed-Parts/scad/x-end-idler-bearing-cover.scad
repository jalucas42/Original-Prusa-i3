
$fn=30;
layer_height = 0.3175;

target_thickness = 9;

bearing_od = 11.0;
bearing_id = 5.0;
bearing_width = 4.0;

translate([0,0,-6*layer_height]) cover();
translate([0,0,-target_thickness/2+bearing_width/2]) spacer();

module cover() {
    difference() {
        union() {
            translate([0,0, 0*layer_height]) cylinder(h= 2*layer_height, d=bearing_od+4+6);
            translate([0,0, 2*layer_height]) cylinder(h=9*layer_height, d=bearing_od+4, $fn=120);
        }
        translate([0,0,(12-6)*layer_height]) cylinder(d=bearing_od, h=bearing_width);
        cylinder(d=bearing_od-2, h=100, center=true);
        //cylinder(d1=bearing_od, d2=bearing_od-2, h=4*layer_height);
    }
}

module spacer() {
    difference() {
        union() {
            cylinder(d=bearing_id+0.25, h=target_thickness/2, $fn=30);
            cylinder(d=bearing_id+3, h=target_thickness/2-bearing_width/2, $fn=30);
        }
        translate([0,0,-1]) cylinder(d=3.3, h=100, $fn = 30);
    }
    
}
