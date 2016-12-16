include <../../include/publicDomainGearV1.1.scad>;


///////////////////// FOCUS ON THIS NOW //////////////////////////////
pillar_space = 180;
twist_gears = 0;
thickness_gears = 3;
hole_diameter_gears = 3.5;
pin_position = 7;
radius = 37;
$fn = 40;
tooth_depth_twist = 2;
mirror = true;
mm_per_tooth_gears    = 9;
pressure_angle_gears  = 28;
twist_height_units = 3;
///////////////////// FOCUS ON THIS NOW //////////////////////////////


module frame(){
    translate([-pillar_space/2,-pillar_space/2,0]) cube([30,30,30], center=true);
    translate([pillar_space/2,pillar_space/2,0]) cube([30,30,30], center=true);
    translate([-pillar_space/2,pillar_space/2,0]) cube([30,30,30], center=true);
    translate([pillar_space/2,-pillar_space/2,0]) cube([30,30,30], center=true);
}
//frame();

//%rotate([0,0,45]) cube([200,200,10], center=true);
holes = 32;
module motor_mount(){
    //rotate([0,0,45]) cube([42,42,5], center=true);
    translate([holes/2,holes/2,0]) cylinder(d=5, h=50);
    translate([-holes/2,holes/2,0]) cylinder(d=5, h=50);
    translate([-holes/2,-holes/2,0]) cylinder(d=5, h=50);
    translate([holes/2,-holes/2,0]) cylinder(d=5, h=50);
}

    
//rotate([0,0,45])motor_mount();
module pins(height=10, z=0, d=5){
    translate([pin_position,pin_position,z]) cylinder(h=height, d=d);
    translate([-pin_position,-pin_position,z]) cylinder(h=height, d=d);
}



module gear_one(hole_diameter_gears=5.5){

    


    module bolt_hole() {
        translate([0, 0, 12-5.5])
       {
           //translate([5,0,0]) rotate([0,90,0]) cylinder(d=6.8, h=10);
           rotate([0,90,0]) cylinder(d=3, h=10);
           //translate([1.5,0,6.8]) rotate([0,45,0]) translate([10,0,50]) cube([10,4,100],center=true);
           translate([4.5,0,25-3.5]) cube([2.7,5.7,50],center=true);
       }
    }
    
    //subtract set screw holes
    difference()
    {
        //combine d shaft with gear+riser
        union()
        {
            //subtract center hole
            difference()
            {
                //combine gear with riser
                union()
                {
                    //Top twist (currently zero twist)
                    translate([0,0,thickness_gears]) mirror([0,0,1]) gear(mm_per_tooth_gears,9,thickness_gears,hole_diameter_gears,twist_gears);
                    
                    //Bottom twist
                    gear(mm_per_tooth_gears,9,thickness_gears,hole_diameter_gears,twist_gears);
                            
                    translate([0,0,10-5.5])
                    cylinder(d=16.2,h=6);
                }
                //center hole
                translate([0,0,9-5.5])
                cylinder(d=hole_diameter_gears, h=10, $fn=20);
            }
        
            //D shaft block
            translate([0,4.5,thickness_gears/2+3]) cube([5,5,thickness_gears*2+6], center=true);
        }
        
        //Set screw holes
        rotate([0,0,90]) bolt_hole();
        rotate([0,0,90]) rotate([0,0,360/3]) bolt_hole();
        rotate([0,0,90]) rotate([0,0,2*360/3]) bolt_hole();
    }
}
		
		
		//test

		//end test
		
		
module gear_large() {
	 difference(){
		union(){
			difference(){
				translate([0,0,0]) gear(mm_per_tooth_gears,22,thickness_gears+8,hole_diameter_gears,twist_gears);
				translate([15,-4,4]) linear_extrude(h=20) text("", font="fontawesome");
			}
			intersection(){
				hull(){
					translate([0,0,-7]) scale([1,1,.25]) sphere(r=40, $fn=100);
                    translate([0,0,(-10*twist_height_units)+5]) scale([1,1,.25]) sphere(r=40, $fn=100);
									
				}
				translate([0,0,-22]) twist_large();
			}
		}
		cylinder(h=100, d=3.25, center=true);
		translate([0,0,(-10*2)-3]) sphere(d=6, center=true);
	}
}

module middle_gear(){         
    gear(mm_per_tooth_gears,12,thickness_gears,hole_diameter_gears,twist_gears);
    mirror([0,0,1]) translate([0,0,thickness_gears]) gear(mm_per_tooth_gears,12,thickness_gears,hole_diameter_gears,twist_gears);
}

module reverse_gear_one(){         
    gear(mm_per_tooth_gears,6,thickness_gears*2,hole_diameter_gears,twist_gears);
}

module reverse_gear_two(){         
	gear(mm_per_tooth_gears,10,thickness_gears*2,hole_diameter_gears,twist_gears);
}

module scaled_middle_gear(scaling=1){
    hole_diameter = (1-scaling+1) * hole_diameter_gears;
    echo (hole_diameter);
	scale([scaling, scaling, 1]) gear(mm_per_tooth_gears, 10, thickness_gears*2, hole_diameter, twist_gears);
}

module twist() {
    difference() {
        translate([35,35,0]) linear_extrude(height = 10, center = false, convexity = 10, twist = 360, $fn = 50) translate([tooth_depth_twist, 0, 0]) circle(r = radius);
        union(){
            translate([35,35,3]) cylinder(d=3.5, h=50, center=true);
            translate([35, 35, 0]) pins(height=20, d=5.5 );
        }
    }   
}

module twist_large_extrude() {
    linear_extrude(height = 10*2, center = false, convexity = 10, twist = 360*2, $fn = 60)
        translate([tooth_depth_twist, 0, 0]){
						circle(r = radius);
            }
}

module twist_large() {
    difference(){
        difference() {
            twist_large_extrude();
            //union(){
            //    translate([0,0,3]) cylinder(d=3.5, h=50, center=true);
            //    translate([0, 0, 0]) pins(height=20, d=3.5 );
            //}
        }
        cylinder(r=radius-2, h=10*3);
        //difference(){
        //    rotate([0,-3.5,0]) translate([0,37,-2.5]) cube([100,37*2,10], center=true);
        //    translate([35,2,2]) sphere(r=5);
        //}
        //difference(){
        //    rotate([0,3.5,0]) translate([0,-37,22]) cube([100,37*2,10], center=true);
        //    translate([35,-2,19]) sphere(r=5);
        //}
    }
	difference(){
		cylinder(h=10*2, r=radius-2);
		//rotate([180,0,0])translate([20,-4,-3]) linear_extrude(h=5) text("", font="fontawesome");
	}
}

//gear_large();
//twist();
//reverse_gear_one();
//reverse_gear_two();
//scaled_middle_gear(scaling=1.021);
//twist_large();
//middle_gear();
//gear_one();

// for finding out gear's diameter
//difference() {
//    translate([0,0,-20]) cylinder(d=77.7, h=20, $fn=120);
//    translate([0,0,-20]) cylinder(d=3, h=30);
//}



