include <../../include.scad>;
include <../../globals.scad>;
//if you can do pretty far over hangs, like an SLA printer or something then take this off by setting it to flase.
    support = true;
	slot_translate = .5;
	rod_size = .5;
module basic_corner(){
	module added(){
			translate([0,0,15]) cube([obj_leg,obj_leg,obj_leg*2], center=true);
			translate([0,15,0]) cube([obj_leg,obj_leg*2,obj_leg], center=true);
			translate([15,0,0]) cube([obj_leg*2,obj_leg,obj_leg], center=true);
	}
	module taken(){
		rotate([0,0,90]) cylinder(d=9, h=obj_leg*5, center=true, $fn=6);
		rotate([90,0,0]) rotate([0,90,0]) cylinder(d=9, h=obj_leg*5, center=true, $fn=6);
		rotate([90,0,0]) cylinder(d=9, h=obj_leg*5, center=true, $fn=6);
		cylinder(d=23, h=28, center=true);
		rotate([0,90,0]) cylinder(d=23, h=28, center=true);
		rotate([90,0,0]) cylinder(d=23, h=28, center=true);
		module wrap(){
			translate([0,-15,0]) male_dovetail(height=50);
			rotate([0,0,90]) translate([0,-15,0]) male_dovetail(height=50);
			rotate([0,0,180]) translate([0,-15,0]) male_dovetail(height=50);
			rotate([0,0,-90]) translate([0,-15,0]) male_dovetail(height=50);
		}
		wrap();
		rotate([0,90,0]) wrap();
		rotate([-90,90,0]) wrap();
		rotate([0,45,180]) translate([0,-45,0]) tie_end();
		rotate([0,45,90]) translate([0,-45,0]) tie_end();
		rotate([-90,0,45]) translate([0,-45,0]) tie_end();

	}
	module corner() {
		difference(){
			added();
			taken();
		}
	};
	rotate([45,0,0]) corner();
};
module full_corner(){

	module support_pillers(){
		
        //These seem to not have a lot of effect.
		translate([48-slot_translate/2,3,0]) cylinder(h=11,d=4);
		translate([48-slot_translate/2,-3,0]) cylinder(h=11,d=4);
		
        //These do not perform well, joining with the part perimeter.
        //Support this area with slic3r supports. Set support overhang
        //threshold to do this.
        /*
        difference()
        {
            union(){
            translate([39-slot_translate/2,18,24]) rotate([0,-40,0]) cylinder(h=6,d=4);
            translate([39-slot_translate/2,-18,24]) rotate([0,-40,0]) cylinder(h=6,d=4);
            }
            translate([0,0,27.7+100])
            cube(200,200,200,center=true);
            
            translate([-100+(39-slot_translate/2)-3.9,0,0])
            cube(200,200,200,center=true);
        }
        */
	}
	if (support==true)
	{
		support_pillers();
		rotate([0,0,(360/3)*2]) support_pillers();
		rotate([0,0,(360/3)*1]) support_pillers();
        
        //Center rod hole tops
        translate([9.3,0,0])
        cylinder(h=11.3,d=4);
        
        rotate([0,0,(360/3)*2])
        translate([9.3,0,0])
        cylinder(h=11.3,d=4);
        
        rotate([0,0,(360/3)*1])
        translate([9.3,0,0])
        cylinder(h=11.3,d=4);
        
        //Center vee
        rotate([0,0,(360/6)*1])
        translate([7.4,0,0])
        cylinder(h=16.25,d=2);
        
        rotate([0,0,(360/6)*1 + (360/3)*1])
        translate([7.4,0,0])
        cylinder(h=16.25,d=2);
        
        rotate([0,0,(360/6)*1 + (360/3)*2])
        translate([7.4,0,0])
        cylinder(h=16.25,d=2);
	}

	difference(){
		translate([0,0,0]) rotate([0,-35,0])basic_corner();
		union(){
			cylinder(h=50, d=15);
			//translate([-20,0,0]) cylinder(h=50, d=7);
			//translate([10,17,0]) cylinder(h=50, d=7);
			//translate([10,-17,0]) cylinder(h=50, d=7);
			translate([0,0,-25]) cube([200,200,50], center=true);
		}
	}
}

/*
//For 90 degree printing
translate([0,0,15])
rotate([-45,0,0])
rotate([0,35,0])
*/
full_corner();

/*
//For 90 degree printing
module supportside()
{
    sup_w = 4;
    
    translate([15.3,-16-sup_w,0])
    cube([29.7,sup_w,14]);
    
    difference()
    {
        union()
        {
            translate([15.3,-16-sup_w,14])
            rotate([-45,0,0])
            cube([29.7,sup_w,20]);
        }
        
        translate([0,0,17.5+50+6.3])
        rotate([16.7,0,0])
        cube([100,100,100],center=true);
        
        translate([0,50-16+5.5,0])
        cube([100,100,100],center=true);
    }
}

if (support == true)
{
    supportside();
}
*/