
x_rod_distance = 45;

thinwall = 3;

// T8 NUT dimensions
t8nut_od = 25.0; // 22.0 actual 
t8nut_id = 13.2; //10.2 actual

// Z rod/bearing dimensions
z_rod_diam = 9.8; // Slightly undersized for pushrods
z_bearing_diam = 19.0; // LM10UU
z_bearing_length = 29.0; // LM10UU

// X rod/bearing dimensions
x_rod_diam = 9.8; // Slightly undersized for pushrods
x_bearing_diam = 19.0; // LM10UU
x_bearing_length = 29.0; // LM10UU

z_bottom_wall_width = 5;
z_bottom_width = 43 + 2*z_bottom_wall_width;
z_bottom_height = 43;

z_top_wall_width = z_bottom_wall_width;
z_top_width = 30;
z_top_height = 25;

z_rod_to_rail = z_bottom_wall_width + 43/2 ; // Z-rod center (and X-axis) offset from 3030 rail front face - dictated by NEMA17 stepper center (44mm / side)

z_motor_ofs = z_bearing_diam/2 + thinwall + t8nut_id/2; //17; // Z-motor offset from Z-rod (center-to-center) - both are aligned with X axis

x_end_base_height = 58;
x_end_base_depth = 18; //17;
x_end_base_width = 38;

x_to_z_offset = x_end_base_depth-2; // 15; // Used to offset the X pushrods/belt from the Z rod.

z_bearing_size = z_bearing_diam + 2 * thinwall;

