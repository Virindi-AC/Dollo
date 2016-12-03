include <../../include.scad>;
include <../../globals.scad>;
use <../../include/publicDomainGearV1.1.scad>
use <../../include/snappy-reprap/xy_sled_parts.scad>

motor_shaft_hole_dia = 5+2*slop;

//globals
$fn=50;
obj_round = 50;
 // based on obj_height = 50 / twist=81
//obj_height = 20;

shaft = motor_shaft_hole_dia;

shaft_len = 22;
shaft_has_flat = true;
shaft_flat_len = 15;

function get_twist(obj_height, twist_ratio) = (twist_ratio == 1) ? 1 : obj_height * twist_ratio;

module gear_master(obj_height, twist_ratio){

	module rightGear(twist, obj_height) {
		rotate([0, 0, -25]) {
			translate([0, 0, obj_height/4])
			linear_extrude(height = obj_height/2, center = true, twist = twist, convexity = 10)
			    import (file = "small_gear.dxf", layer = "Layer_1");
			circle(r = 1);
		}
	}

    module gearObject(obj_height) {

        module gear(twist, obj_height) {

            union() {
                rightGear(twist, obj_height);
                mirror([0,0,1]) rightGear(twist, obj_height);
            }

        }

        module bone(obj_height) {
            twist = get_twist(obj_height, twist_ratio);
            echo(twist);
            difference() {
                gear(twist, obj_height);
                hole(obj_height);
            }
        }
        bone(obj_height);
    }
    
    gearObject(obj_height);
}

module hole(obj_height) {
    cylinder(d=shaft, h=obj_height*2.1, center=true);
}

module bolt_hole(obj_height) {
    hole_pos = shaft_len - shaft_flat_len + shaft_flat_len/2;
    translate([0, 0, obj_height/2-hole_pos]) rotate([0,90,0]) cylinder(d=2.5, h=10);
}

module flat_of_shaft(obj_height) {
    if (shaft_has_flat) {
        translate([5.6/2-0.7+slop,-2.5,-obj_height/2]) cube([1.5,5,obj_height-(shaft_len-shaft_flat_len)], center=false);
    }
}

// original style gear. tune height if so inclined; longer gear seems to cause uneven movement, though...
module gear_v1() {
    twist_ratio = 1.62;
    difference() {
        union() {
            flat_of_shaft(22);
            gear_master(22, twist_ratio);
        }
        #bolt_hole(22);
    }
}

// flat body
module nogear(height, diameter=10) {
    difference() {
        cylinder(d=diameter, h=height);
        hole(height);
    }
}

// v2 is to be used with the new style rack
module gear_v2() {
    twist_ratio = 1.62;
    mirror([0,1,0]) difference() {
        union() {
            translate([0,0,12/2+(12-20)/2]) nogear(8);
            translate([0,0,6]) flat_of_shaft(22);
            translate([0,0,(12-20)/2]) gear_master(12, twist_ratio);
        }
        translate([0,0,9]) #bolt_hole(20);
    }
}
//translate([20,0,0]) gear_v1();
//translate([20,0,0]) gear_v2();



module gear_v3() {
    difference() {
        union() {
            difference() {
                union() {
                    nogear(7, 17);
                    translate([0,0,10]) gear (
                        mm_per_tooth    = 5,
                        number_of_teeth = 8,
                        thickness       = 6,
                        hole_diameter   = 2,
                        twist           = 25.9808,
                        teeth_to_hide   = 0,
                        pressure_angle  = 20,
                        backlash        = slop/2
                    );
                    translate([0,0,16]) mirror([0,1,0]) rotate([0,0,25.9808]) gear (
                        mm_per_tooth    = 5,
                        number_of_teeth = 8,
                        thickness       = 6,
                        hole_diameter   = 2,
                        twist           = 25.9808,
                        teeth_to_hide   = 0,
                        pressure_angle  = 20,
                        backlash        = slop/2
                    );
                    translate([0,0,7]) cylinder(d=motor_shaft_hole_dia+2, h=12);
                }
                translate([0,0,7]) hole(14);
                union() {
                    difference() {
                        translate([0,0,19.5]) cylinder(h=3, d=20, center=true);
                        translate([0,0,18.5]) cylinder(h=2+0.05, d1=20, d2=8, center=true);
                    }
                }
            }
            translate([0,0,14]) flat_of_shaft(24);
        }
        translate([0,0,8]) #bolt_hole(20);
        #translate([5.1,0,3.3]) cube([2.5+2*slop, m3_nut_side+2*slop, 7], center=true);
    }
}

gear_v3();