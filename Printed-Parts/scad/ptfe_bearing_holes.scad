
ptfe_bearing_holes();

module ptfe_bearing_holes(rod_diam=10, tightness=0.0, length=25, ptfe_od=4.0, num_sections=7, bearing_od=19, clearance=1.5) {
    render() {
        $fn = 60;
        rod_diam_tight = rod_diam - tightness;
        translate([0,0,0]) cylinder( d=rod_diam+2, h=length+300, center=true, $fn=30 );
        for (i=[0:num_sections-1]) rotate([0,0,i*360/num_sections]) {
            //%translate([rod_diam_tight/2+ptfe_od/2,0,-1]) cylinder( d=ptfe_od, h=length+2 );
            translate([rod_diam_tight/2+ptfe_od/2,0,]) cylinder( d=ptfe_od/cos(180/12), h=length, center=false, $fn=12 );
            intersection() {
                translate([bearing_od/2-3/2,-3/2,]) cube([3,3,length]);
                cylinder(d=bearing_od+clearance, h=length, $fn=30);
            }
        }

        // Cut clearance hole around bearing so it can flex
        translate([0,0,0]) difference() {
            cylinder(d=bearing_od+2*clearance, h=length, $fn=60);
            cylinder(d=bearing_od+0.001, h=length, $fn=60);
        }
    }        
}

