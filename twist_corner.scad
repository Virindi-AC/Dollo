include <include.scad>;
include <globals.scad>;
include <gears.scad>;









///////////////////// FOCUS ON THIS NOW //////////////////////////////
tooth_depth = (sqrt(18)/2)+2;
twisted_depth = 2;
units = 2;
r =37;
mirror = true;
double = false; //this will make the piece twist in both directions. only works if you have a high pitch screw

gearOne = -16.5;
gear_reverse = -10;
gearLarge = -32.6+(gearOne/2);
///////////////////// FOCUS ON THIS NOW //////////////////////////////




















	module wrap(){
				translate([-16.5,30+4,-30]) rotate([0,0,-90]) mirror([0,0,1]) male_dovetail();
				translate([-30,30+4,-16.5]) rotate([-90,180,-90]) mirror([0,0,1]) male_dovetail();
		
				rotate([90,0,0]) translate([-35,-1,-25]) cylinder(h=35, r=9);
				mirror([1,0,-1]) rotate([90,0,0]) translate([-35,-1,-25]) cylinder(h=31, r=9);

	}	
	module wrap_add(){
				translate([-15,33.5+4,-15]) rotate([0,0,-90]) mirror([0,0,1]) cube([7,32,.5]);
				translate([-15,33.5+4,-15]) rotate([-90,0,-90]) mirror([0,0,1]) cube([7,32,.5]);
	}

module arm_movement(){
	difference(){
		//part im trying to make
	difference(){
		translate([-95+tooth_depth,-95+tooth_depth,30]) rotate([0,0,45]) cube([45,45,((units+1)*30)-.25], center=true);
		translate([-105+(-15/2),-105+(-15/2),30]) cube([45,45,30*5], center=true);
	}
	//twist
	
	for (extrude=[0:3]){
		translate([0+(gearLarge+(gearLarge/2))+tooth_depth,0+(gearLarge+(gearLarge/2))+tooth_depth,extrude*20]) color([0,1,0]) rotate([0,0,(360/22)*1.75]) twist_large($fn=200);
		translate([21.5-95,21.5-95,extrude*30-45]) rotate([90,0,90]) wrap();
	}
	
	}
	for (support = [1:2]){
		translate([-105,-74.5,support*30-45]) rotate([90,0,180])  wrap_add();
	}
}

module finished(){
	intersection(){
		translate([95,95,0]) arm_movement();
		hull(){
			translate([tooth_depth+26,1,0]) cylinder(h=(units+2)*30, r=2);
			translate([1,tooth_depth+26,0]) cylinder(h=(units+2)*30, r=2);

			translate([-(tooth_depth+26),1,0]) cylinder(h=(units+2)*30, r=2);
			translate([1,-(tooth_depth+26),0]) cylinder(h=(units+2)*30, r=2);
		}
	}
}


intersection(){
	translate([0,0,-4]) rotate([-4,0,45]) finished();
	translate([-50,-50,0]) cube([100,100,units*30]);
}