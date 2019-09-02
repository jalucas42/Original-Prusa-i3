
use <polyholes.scad>

include <common_dimensions.scad>

difference() {
    cylinder( d = x_idler_bearing_id+1, h=x_idler_bearing_width, $fn = 6, center=true);
    poly_cylinder( r = 1.6, h = x_idler_bearing_width, center=true);
}
