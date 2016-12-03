/*
Most things in this file is represented as one millimeter, so keep that in mind while changing things.
Some of the setting are not mm but at variables that you can set, such as 2*x=2x and you are setting what x is.
I will try to specify when things are variables and not exact measurements.
*/

// printer slop, used by snappy parts
slop = 0.15;

//Virindi settings
dovetail_male_width_scale = 0.98;
dovetail_male_height_scale = 0.91;

obj_leg = 30;
leg_length = 5.5;
small_number = 0.001;
metal_core_rode_global = 5;


///////////////// number of holes /////////////////////
z_hole_number = 8;
other_holes = 8;

///////////////// Pins /////////////////////

//pins that poke out
ball_size = 10;
pin_height = 20;
pin_diameter = 6;


//holes
hole_ball_size = ball_size;
hole_pin_height = pin_height;
hole_pin_diameter = pin_diameter;

///////////////// Z THINGS /////////////////////

berring_slot_width = 7.5;
berring_slot_depth = 6.5;
metal_core_rode = 5;

///////////////// X THINGS /////////////////////

//male dove tails
max_width=8;
min_width=5;
depth=5;
height=obj_leg/2;

//female dove tails, this is found on the y mounts
girl_max_width=11;
girl_min_width=5;
girl_depth=5;
girl_height=obj_leg;


///////////////// Y THINGS /////////////////////
/*
The Y is so normal that all of those global variables at the top should change all of the setting in it, this section is set her incase there are variables set in the future development of this project.
*/

// stepper
motor_side_length = 43.2;
motor_bolt_hole_distance = 31;
motor_center_hole = 23;
motor_shaft_dia = 5;
motor_shaft_hole_dia = 5+2*slop;

// bolts etc.
bolt_hole_dia = 3+2*slop;
bolt_head_hole_dia = 5.8;

m3_nut_side = 5.65;

// threaded rod
lifter_rod_diam = 9.86;
hole_threaded_rod = lifter_rod_diam+2*slop;
