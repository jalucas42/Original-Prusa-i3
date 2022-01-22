// Little nub that centers bed spring around its mounting screw.  Need two nubs per spring.

difference() {
    base();
    holes();
}

module base() {
    cylinder(d=5.5, h=1.5+3.0, $fn=18, center=false);
    cylinder(d=12, h=1.5, $fn=18, center=false);
}

module holes() {
    cylinder(d=4.0, h=10, $fn=18, center=true);
}