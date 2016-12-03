///////// NEED TO REDO THE MATH BECUASE OF THE SNAP ON RAILS, WELL WORTH IT

$fn = 30;
include <../../globals.scad>;
include <../../include.scad>;


frame_width = 35.5;
tail_depth = 11;
rack_height = 12.5;
rack_slide_height = 8;
mount_max = 62.5;
wabble = 1.5;
not_tooth_gap = 0;
rack_gap = 2.5;
tower_height = 17.5+3;

text = "Dollo";
font = "Liberation Sans";

hole_length = 0.8;

//$fn=220;

// for rounded cube
diameter = 2;

//rounded_cube(x,y,z,diameter);


module y_mount_added(){    
    //base
    translate([0,2.25-2.25+rack_gap/2,-1]) rounded_cube(depth = 50+rack_gap*2, width = frame_width+15+1, height=4, center=true);
    
    // lower slide
    slide_depth = 11;
    slide_pos_y = frame_width-15+rack_gap;
	translate([0,slide_pos_y,2.5]) rounded_cube(height = 5, width = 50, depth = slide_depth, diameter = 3.5);
//towers
    //echo ((17.5+4.25)/2);

    //top tower
	translate([0-21,-25.75,0.625]) cube([42,18,tower_height]);
    
    tower_pos_y = slide_pos_y - slide_depth/2 - 15/2 - rack_height;

    // right tower
	translate([(32-21-4)+19/2,tower_pos_y,(17.5+4.25)/2]) rounded_cube(19,15,tower_height);
    translate([(32-21-4)+19-4.5,tower_pos_y+15/2-4.4,tower_height]) cylinder(d=7,h=2);
    
    // left tower
    difference() {
        translate([(-21-4)+24/2,tower_pos_y,(17.5+4.25)/2]) rounded_cube(26,15,tower_height);
        translate([(-21-4)+3.5,tower_pos_y+15/2-4.4,tower_height-1.5]) cylinder(d=7.25,h=2.5);
    }

    slide_size = (rack_height - rack_slide_height) * 2;
    translate([18,(not_tooth_gap/2)+5,2]) rounded_cube(height = 4, width = 15, depth = slide_size, diameter = 2);
	translate([-18,(not_tooth_gap/2)+5,2]) rounded_cube(height = 4, width = 15, depth = slide_size, diameter = 2);
}

module bolt_hole() {
    hull() {
        cylinder(d=bolt_hole_dia, h=70);
        translate([hole_length,hole_length,0]) cylinder(d=bolt_hole_dia, h=70);
    }
}

module bolt_head_hole() {
    hull() {
        cylinder(d=6.5, h=3);
        translate([hole_length,hole_length,0]) cylinder(d=6.5, h=3);
    }
}

module y_mount_taken(){
	halign = [
	   [0, "center"]
	 ];
	 
		 rotate([0,0,-90]) for (a = halign) {
		   translate([-16, 15,-3]) {
			 linear_extrude(height = 1) {
			   text(text = str(text), font = font, size = 8, halign = a[1]);
			 }
		   }
		 }
		 rotate([0,0,90]) for (a = halign) {
		   translate([16,15,-3]) {
			 linear_extrude(height = 1) {
			   text(text = str(text), font = font, size = 8, halign = a[1]);
			 }
		   }
		 }
		 
	rotate([0,0,45]) {
        translate([5.65-21,5.65-21,-10]) bolt_hole();
		translate([5.65+31-21,5.65-21,-10]) bolt_hole();
		translate([5.65-21,5.65+31-21,-10]) bolt_hole();
		translate([5.65+31-21,5.65+31-21,-10]) bolt_hole();

		//counter sink

        #translate([5.65-21,5.65-21,-3]) bolt_head_hole();
		#translate([5.65+31-21,5.65-21,-3]) bolt_head_hole();
		#translate([5.65-21,5.65+31-21,-3]) bolt_head_hole();
		#translate([5.65+31-21,5.65+31-21,2.5]) bolt_head_hole();

		translate([-70,-30,-5]) cube([50,50,50]);
		translate([-30,-70,-5]) cube([50,50,50]);

		translate([0,0,-5]) cylinder(d=motor_center_hole, h=20);
        translate([hole_length,hole_length,-5]) cylinder(d=motor_center_hole, h=20);

		#rotate([90,0,-45]) translate([-8,-3,-55+tail_depth]) male_dovetail(height=30);
		#rotate([90,0,-45]) translate([8,-3,-55+tail_depth]) male_dovetail(height=30);

		#rotate([90,0,-45]) translate([-8,-3,22-tail_depth]) male_dovetail(height=30);
		#rotate([90,0,-45]) translate([8,-3,22-tail_depth]) male_dovetail(height=30);
	}
}

module motor_mount( ){
	difference(){
		y_mount_added();
		y_mount_taken();
	}
}

module translated_mount(){
translate([(-obj_leg/2)-2.5,0,0]) rotate([0,90,0]) motor_mount();
}

module screw_driver(){
translated_mount();
}

module do_motor_mount() {
    rotate([0,-90,0]) difference(){
        screw_driver();
        translate([-15,0,0]) rotate([0,90,0]) union(){
            translate([5.65,5.65,-1]) cylinder(d=3.5, h=40);
            translate([5.65+31,5.65,-1]) cylinder(d=3.5, h=40);
            translate([5.65,5.65+31,-1]) cylinder(d=9, h=40);
            translate([5.65+31,5.65+31,-1]) cylinder(d=9, h=40);

            translate([-20,20,15]) rotate([90,0,45]) cylinder(h=70, d=22);
            translate([20,20,15]) rotate([90,0,-45]) cylinder(h=70, d=22);
        }
    }
}

do_motor_mount();