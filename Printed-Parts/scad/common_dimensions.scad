
x_rod_distance = 45;

thinwall = 3;

belt_width = 6;
belt_thickness = 1.5;

// Account for idler bearing and stepper pinion being different diameters
x_stepper_pinion_od = 12.0;
x_idler_bearing_od = 22.0; // 608 bearing
x_idler_bearing_id = 8.0; // 608 bearing
x_idler_bearing_width = 7.0; // 608 bearing
x_idler_to_stepper_offset = (x_stepper_pinion_od-x_idler_bearing_od)/2; 


// T8 NUT dimensions
t8nut_od = 25.0; // 22.0 actual 
t8nut_id = 13.2; //10.2 actual

// Z rod/bearing dimensions
z_rod_diam = 10.0; 
z_rod_diam_tight = z_rod_diam - 0.07; // Adjust diam based on test prints
z_bearing_diam = 19.0; // LM10UU
z_bearing_length = 29.0; // LM10UU

// X rod/bearing dimensions
x_rod_diam = 10.0; 
x_rod_diam_tight = x_rod_diam - 0.07; // Adjust tightness based on test prints
x_bearing_diam = 19.0; // LM10UU
x_bearing_length = 29.0; // LM10UU

z_bottom_wall_width = 6;
z_bottom_width = 43 + 2*z_bottom_wall_width;
z_bottom_height = 43;

z_top_wall_width = z_bottom_wall_width;
z_top_width = 30;
z_top_height = 22;
z_top_generate_rod_holder = false; // Optionally generate a Z rod holder, which limits the length of the Z rod, or no holder, which allows a longer Z rod to be used.

z_rod_to_rail = z_bottom_wall_width + 43/2 ; // Z-rod center (and X-axis) offset from 3030 rail front face - dictated by NEMA17 stepper center (44mm / side)

z_motor_ofs = z_bearing_diam/2 + thinwall + t8nut_id/2; //17; // Z-motor offset from Z-rod (center-to-center) - both are aligned with X axis

x_end_base_height = x_rod_distance + x_rod_diam + 2*thinwall; //58 + 10;
x_end_base_depth = 18; //17;
x_end_base_width = x_bearing_diam + 2*thinwall + 1 + x_idler_bearing_id+4;
x_end_belt_hole_height = x_rod_distance-x_rod_diam-2*thinwall; //31-5; // To fit between NEMA17 mounting screws
x_end_belt_hole_width = x_idler_bearing_width+2; // x_end_base_depth-2*thinwall; // 10;
x_end_idler_open_end = true; // Specify whether x-idler end has closed ends with tension screws, or straight rod cutouts to allow longer rods.

x_to_z_offset = x_end_base_depth-2; // 15; // Used to offset the X pushrods/belt from the Z rod.

z_bearing_size = z_bearing_diam + 2 * thinwall;

y_rod_diam = 10.0;
y_rod_diam_tight = y_rod_diam - 0.0; // Adjust tightness based on test prints
y_rod_to_rail = 2*thinwall + y_rod_diam/2; // y rod center to 3030 rail.  11+4 from Haribo holder with 8mm rod. Use 2x thinwall to give room for ziptie hole.
y_rod_screw_diam = 3.0;

y_bearing_od = 19.0; // LM10uu
y_bearing_length = 29.0; // LM10uu

y_bearing_holder_width = 50;
y_bearing_holder_depth = y_bearing_length;
y_bearing_holder_rod_ofs = thinwall*2 + y_bearing_od/2; // Offset from Y rod to mounting plate.  Use 2x thinwall to give room for ziptie hole.
y_bearing_holder_height = y_bearing_holder_rod_ofs+y_bearing_od*0.25;

z_railguide_width = 8.30; // 3030
z_railguide_depth = 2.0;
z_railguide_keepout = 12; // 3030 dropin nut is 11, plus margin
