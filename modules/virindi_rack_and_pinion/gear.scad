//globals
$fn=50;
obj_round = 50;
twist_ratio = 1.62; // based on obj_height = 50 / twist=81
obj_height = 44;
twist=obj_height * twist_ratio;
shaft = 5.24;
d_shaft = true;

module master(){
	module rightGear(twist) {
		rotate([0, 0, -25]) {
			translate([0, 0, obj_height/4])
			linear_extrude(height = obj_height/2, center = true, twist = twist, convexity = 10)
			    import (file = "small_gear.dxf", layer = "Layer_1");
			circle(r = 1);
		}
	}

    module gearObject() {

        module gear() {

            union() {
                rightGear(twist);
                mirror([0,0,1]) rightGear(twist);
                
                translate([0,0,10])
                cylinder(d=16.2,h=12);
            }

        }

        module hole() {
            cylinder(d=shaft, h=obj_height*2.1, center=true);
        }

        module bolt_hole() {
            translate([0, 0, 14])
           {
               //translate([5,0,0]) rotate([0,90,0]) cylinder(d=6.8, h=10);
               rotate([0,90,0]) cylinder(d=3, h=10);
               //translate([1.5,0,6.8]) rotate([0,45,0]) translate([10,0,50]) cube([10,4,100],center=true);
               translate([4.5,0,25-3.5]) cube([2.7,5.7,50],center=true);
           }
        }

        module bone() {
            difference() {
                gear(twist=twist);
                hole();
            }
        }
        difference()
        {
            union() {
                if (d_shaft == true)
                {
                    translate([5.6/2 - 0.7, -2.5, -obj_height/2]) cube([1.5,5,obj_height], center=false);
                }
                bone();
            }
            bolt_hole();
            rotate([0,0,360/3]) bolt_hole();
            rotate([0,0,2*360/3]) bolt_hole();
            
            /*
            translate([0,0,obj_height/2+12-6.8/2])
            difference()
            {
                cylinder(d=30,h=obj_height,center=true);
                cylinder(d=10.6,h=obj_height+1,center=true);
            }
            */
        }
    }
gearObject();
}

intersection(){
    master();
}