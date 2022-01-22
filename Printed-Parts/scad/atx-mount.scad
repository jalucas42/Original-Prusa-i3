// Small tabs to mount ATX power supply to 3030 rail with m3 screws.

thickness = 2.0;

mount(ofs=16.0);
for (i=[-1,1]) translate([i*30,30,0]) rotate([0,0,i*50]) mount(ofs=6.0);

module mount(ofs=6.0) {
    difference() {
        hull() {
            for (i=[-1,1]) translate([i*12,0,0]) cylinder(d=12, h=thickness, center=false);
            translate([0,30/2+ofs,0]) cylinder(d=12, h=thickness, center=false);        
        }
        for (i=[-1,1]) translate([i*12,0,-1]) cylinder(d=3.6, h=thickness+2, center=false, $fn=12);
        translate([0,30/2+ofs,-1]) cylinder(d=3.7, h=thickness+2, center=false, $fn=12);        
    }    
}