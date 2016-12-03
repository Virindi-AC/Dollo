//Dollo hotend/sensor/fan carriage by Virindi
//BOM:
//-China E3D v6 Clone
//-Sensor LJC18A3-H-Z/BX or other similar size sensor
//-Blower Fan XS235 (50mm blower fan)
//-M3 screws and nuts...

include <../../globals.scad>;
include <../../include.scad>;

use <../../include/vitamins/e3d_hot_end.scad>
use <../virindi_rack_and_pinion/motor_mount_small.scad>
use <../printed_structural/extension.scad>
use <x_spacer_cut.scad>

module nut_by_flats(f,h,horizontal=true,center=false){
    if (center)
    {
        translate([0,0,-h/2])
        {
            cornerdiameter =  (f / 2) / cos (180 / 6);
            cylinder(h = h, r = cornerdiameter, $fn = 6);
            if(horizontal){
                for(i = [1:6]){
                    rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
                }
            }
        }
    }
    else
    {
        cornerdiameter =  (f / 2) / cos (180 / 6);
        cylinder(h = h, r = cornerdiameter, $fn = 6);
        if(horizontal){
            for(i = [1:6]){
                rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
            }
        }

    }
}

module proximity_sensor()
{
    color([0,0.3,1])
    translate([0,0,48])
    cylinder(h=13.25,d=17.83,$fn=40);
    
    color("lightgrey")
    cylinder(h=48,d=17.83,$fn=40);
    
    color([1.0,0.658,0.122])
    translate([0,0,-9.0])
    cylinder(h=9.0,d=16.40,$fn=40);
    
    //Bottom nut
    color("lightgrey")
    translate([0,0,40-12.5-5.5/2+8])
    cylinder(h=5.6,d=29.75,$fn=40);
    
    //Top nut
    color("lightgrey")
    translate([0,0,40+5.5 -10+8])
    cylinder(h=5.6,d=29.75,$fn=40);
    
    color([0.5,0.5,0.5])
    translate([5,0,48])
    cylinder(h=60,d=6);
}

sensor_sep = 30;
sensor_offset_y = 8;

hotend_x = -sensor_sep/2;
hotend_y = 0;
sensor_x = sensor_sep/2;
sensor_y = -sensor_offset_y;

module main_carriage_m()
{
    //Main block
    difference()
    {
        translate([0,-6,-2])
        cube([60,38,15],center=true);
        
        //Sensor
        translate([sensor_x,sensor_y,0])
        {
            cylinder(d=18.0,h=100,center=true);
            
            translate([0,0,5.5 -10])
            cylinder(d=32,h=100);
        }
        
        //Hotend
        translate([hotend_x,hotend_y,0])
        {
            //cylinder(d=16.1,h=100,center=true);
            union()
            {
            rotate([0,0,90])
            {
            e3d_hot_end([4,   "HEE3DCLNB: E3D clone aliexpress",66,  6.8, 16,    46, "lightgrey", 12,    5.6,  15, [1, 5,  -4.5], 14.5, 21]);
            }
            translate([0,0,-30])
            cylinder(h=68+30,d=4);
            }
        }
        

        
        //Hotend Corner
        translate([-50-7.3,-50-7  +6,0])
        cube([100,70,100],center=true);
        
        //Hotend Side
        translate([-77,0,0])
        cube([100,70,100],center=true);
        
        //Sensor Corner: Top
        translate([50+17,50-20,30-4.5])
        cube([100,70,60],center=true);
        
        //Sensor Corner: Bottom
        translate([50+17,50-20+11,30-11])
        cube([100,70,60],center=true);
        
        //Sensor Side
        translate([80-4,0,0])
        cube([100,70,60],center=true);
        
        //Slit
        translate([hotend_x,0,0])
        cube([0.1,100,100],center=true);
        
        /*
        //Tie: bottom
        translate([-60,-13,-9.51])
        rotate([90,0,0])
        rotate([0,90,0])
        male_dovetail(height=60);

        //Tie: top
        translate([-50,-13,5.51])
        rotate([90,0,0])
        rotate([0,90,0])
        translate([0,0,60])
        rotate([180,0,0])
        male_dovetail(height=60);
        */
        
        //Screw: inner
        translate([-6,10.2,-2])
        rotate([0,90,0])
        rotate([0,0,30])
        cylinder(h=50,d=3.5,center=true,$fn=6);
        
        //Screw: outer
        outer_screw_y = 10.2 - 21;
        translate([-6,outer_screw_y,-2])
        rotate([0,90,0])
        rotate([0,0,30])
        cylinder(h=50,d=3.5,center=true,$fn=6);
        
        //Outer screw captive nut
        translate([-9,outer_screw_y,0])
        cube([3,5.9,100],center=true);
        
        //Connection screw hole to fan bracket
        translate([0,-4,3.5])
        rotate([90,0,0])
        cylinder(d=3.5,h=50,center=true);
        
        //Countersink for fan bracket screw
        translate([0,-48,3.5])
        rotate([90,0,0])
        cylinder(d=6,h=50,center=true);
    }

    //Mount face dovetails
    difference()
    {
    translate([0,0,30 + 12])
    translate([0,16,0])
    rotate([-90,0,0])
    rotate([0,0,45])
    {
    rotate([90,0,-45]) translate([-8,-3,22-11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) male_dovetail(height=30);
    rotate([90,0,-45]) translate([8,-3,22-11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) male_dovetail(height=30);
    }
    translate([0,0,50+65])
    cube([50,50,100],center=true);
    }

    //Mount face and bracing bar
    difference()
    {
        union()
        {
            //Side mounting bar
            translate([0,8,35])
            cube([34,10,60],center=true);
            
            //Top brace
            difference()
            {
            translate([-6.5-0.6+10.6/2,-1.5,28])
            rotate([-28,0,0])
            translate([0,-5,0])
            cube([10.6,10,62],center=true);

            //Bottom
            translate([0,0,-50+5])
            cube([100,100,100],center=true);

            //Side
            translate([0,50+3,50])
            cube([100,100,100],center=true);
                
            //Corner to not overhang tie
                /*
            translate([0,0,-53.8])
            rotate([50,0,0])
            cube([100,100,100],center=true);
                */
            }
        }
        
        //Sensor cut
        translate([sensor_x,sensor_y,0])
        cylinder(d=32,h=300,center=true);
        
        //Hotend cut
        translate([hotend_x,hotend_y,0])
        cylinder(d=17,h=300,center=true);
        
        //Screw to motor mount
        translate([0,12,19.3])
        rotate([90,0,0])
        cylinder(d=3.5,h=30,center=true);
        
        //Screw access to motor mount
        translate([0,0,63.6])
        rotate([90,0,0])
        cylinder(d=9,h=30,center=true);
        
        //Cut for hotend mount
        translate([-50+hotend_x,0,0])
        cube([100,30,200],center=true);
        
        /*
        //Tie: top (cuts the brace)
        translate([-50,-13,5.51])
        rotate([90,0,0])
        rotate([0,90,0])
        translate([0,0,60])
        rotate([180,0,0])
        male_dovetail(height=60);
        */
        
        //Connection screw hole to fan bracket
        translate([0,-4,3.5])
        rotate([90,0,0])
        cylinder(d=3.5,h=50,center=true);
        
        //Countersink for fan bracket screw
        translate([0,-48,3.5])
        rotate([90,0,0])
        cylinder(d=6,h=50,center=true);
    }
}

module main_carriage()
{
    mirror([1,0,0])
    main_carriage_m();
}

module main_carriage_left()
{
    difference()
    {
        main_carriage();
        
        translate([-100-hotend_x+0.001,0,0])
        cube([200,200,200],center=true);
    }
}

module main_carriage_right()
{
    difference()
    {
        main_carriage();
        
        translate([100-hotend_x-0.001,0,0])
        cube([200,200,200],center=true);
    }
}

module blower_fan()
{
    hole_horizontal = 43;
    hole_vertical = 38;
    color([0.3,0.3,0.3])
    difference()
    {
        union()
        {
            cylinder(h=15,d=47.7,center=true);
            
            translate([20/2-47.7/2,-25/2,0])
            cube([20,25,15],center=true);
            
            translate([-hole_horizontal/2,hole_vertical/2,0])
            cylinder(h=15,d=7,center=true);
            translate([hole_horizontal/2,-hole_vertical/2,0])
            cylinder(h=15,d=7,center=true);
            
            translate([-hole_horizontal/2+3,hole_vertical/2-3,0])
            cylinder(h=15,d=7+6,center=true);
            translate([hole_horizontal/2-3,-hole_vertical/2+3,0])
            cylinder(h=15,d=7+6,center=true);
        }
        
        //Center fan area
        translate([0,0,2])
        cylinder(h=15,d=31.3,center=true);
        
        //Screw holes
        translate([-hole_horizontal/2,hole_vertical/2,0])
        cylinder(h=16,d=4.5,center=true);        
        translate([hole_horizontal/2,-hole_vertical/2,0])
        cylinder(h=16,d=4.5,center=true);
    }
}

module fan_plate_m()
{
    //Angled plate
    hole_horizontal = 43;
    hole_vertical = 38;
    plate_t = 3;
    difference()
    {
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([0,0,plate_t/2+15/2])
        difference()
        {
            cube([50,50,plate_t],center=true);
            
            //Center fan area
            //rotate([0,0,30])
            //cylinder(h=plate_t+0.1,d=38,center=true,$fn=6);
            
            //Screw holes
            translate([-hole_horizontal/2,hole_vertical/2,0])
            cylinder(h=plate_t+0.1,d=3.5,center=true);        
            translate([hole_horizontal/2,-hole_vertical/2,0])
            cylinder(h=plate_t+0.1,d=3.5,center=true);
            
            //Top meh
            translate([0,50-2.5,0])
            cube([51,50,plate_t+0.1],center=true);
        }
        
        //**Stuff in global coordinate system**
        
        //Dovetails
        translate([0,-0.001,30 + 12])
        translate([0,16,0])
        rotate([-90,0,0])
        rotate([0,0,45])
        {
            rotate([90,0,-45]) translate([-8,-3,-55+11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) translate([0,0,-45]) male_dovetail(height=90);
            rotate([90,0,-45]) translate([8,-3,-55+11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) translate([0,0,-45]) male_dovetail(height=90);
        }
    }
    
    //Flat side
    hh = 57.13-4;
    shim = 0.1;
    difference()
    {
        translate([-1,16,-hh/2+11.8-shim/2])
        cube([50,6,hh-shim],center=true);
        
        //Corner cut
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([0,0,plate_t/2+15/2-plate_t])
        cube([51,51,plate_t],center=true);
        
        //Screw hole cut: small
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([hole_horizontal/2,-hole_vertical/2,10+plate_t/2+9])
        cylinder(h=50,d=3.5,center=true);
        
        //Screw hole cut: big cylinder
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([hole_horizontal/2,-hole_vertical/2,10+plate_t/2+9])
        cylinder(h=20,d=8,center=true);
        
        //Screw hole cut: square
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([hole_horizontal/2+4,-hole_vertical/2,10+plate_t/2+9])
        cube([8,8,20],center=true);
        
        //Hotend fan cut
        translate([-15,16,-25])
        cube([18,6.1,28],center=true);
        
        //Dovetails
        translate([0,-0.001,30 + 12])
        translate([0,16,0])
        rotate([-90,0,0])
        rotate([0,0,45])
        {
            rotate([90,0,-45]) translate([-8,-3,-55+11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) translate([0,0,-45]) male_dovetail(height=90);
            rotate([90,0,-45]) translate([8,-3,-55+11]) scale([dovetail_male_width_scale,dovetail_male_height_scale,1]) translate([0,0,-45]) male_dovetail(height=90);
        }
        
        //Connection screw hole
        translate([0,-4,3.5])
        rotate([90,0,0])
        cylinder(d=3.5,h=50,center=true);
        
        trap_depth = 2.5;
        translate([0,19-trap_depth,3.5])
        rotate([0,30,0])
        rotate([0,0,180])
        rotate([90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
    }
    
    //Gusset
    gusset_t = 28;
    difference()
    {
        translate([-1-gusset_t/2+25,31.5,-27+4])
        difference()
        {
            translate([0,2.5,0])
            cube([gusset_t,30,25],center=true);
            
            translate([0,0,-34.5])
            rotate([40,0,0])
            cube([gusset_t+0.1,120,50],center=true);
        }
        //Screw still has to go here.

        //Screw hole cut: square
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([hole_horizontal/2+4,-hole_vertical/2,10+plate_t/2+9])
        cube([8,8,20],center=true);

        //Screw hole cut
        translate([-1,40,-35+4])
        rotate([40,0,0])
        translate([hole_horizontal/2,-hole_vertical/2,10+plate_t/2+9])
        cylinder(h=40,d=8,center=true);
        
       
        //aaaand the top
        translate([0,0,50-29+4])
        cube([100,100,100],center=true);
    }
    
}

module fan_plate()
{
    mirror([1,0,0])
    fan_plate_m();
}

module assembly()
{
    //CARRIAGE
    main_carriage();

    //FAN
    translate([1,40,-35+4])
    rotate([40,0,0])
    rotate([180,0,180])
    blower_fan();
    
    //FAN MOUNT
    fan_plate();

    //SENSOR
    translate([-sensor_x,sensor_y,-48])
    proximity_sensor();

    //HOTEND
    translate([-hotend_x,hotend_y,0])
    rotate([0,0,90])
    {
    //Note: my china hotend is shorter than nophead's model
    e3d_hot_end([4,   "HEE3DCLNB: E3D clone aliexpress",66-3.2,  6.8, 16,    46, "lightgrey", 12,    5.6,  15, [1, 5,  -4.5], 14.5, 21]);
        
    color("white")
        translate([0,0,-30])
        cylinder(h=68+30,d=4);
    }

    
    //RAILS
    translate([0,0,30 + 12])
    {
    translate([0,16,0])
    rotate([-90,0,0])
    motor_mount();

    translate([0,52,-6-12])
    rotate([0,90,0])
    color([0.8,0.8,0.9])
    extension_finished();

    translate([-23,37,-18])
    rotate([0,0,-90])
    rotate([90,0,0])
    color([0.9,0.9,0.9])
    x_spacer();
    }
    
    color("pink")
    {
        hotend_from_top = 46.5;
        translate([26,0,-hotend_from_top-9.5])
        cube([4,4,hotend_from_top]);
        
        translate([16,0,-9.5-2-hotend_from_top])
        cube([12,40,2]);
    }
}

assembly();
//rotate([0,90,0]) main_carriage_left(); //Hotend holder piece
//main_carriage_right(); //Main
//rotate([0,-90,0]) fan_plate();

/*
hotend_depth = 75;
mounting_diamiter = 11.75;
top_diamiter = 16.5;
arm_thickness = 5;
snap_location = 47;
natch_height = 6;


module motor_mount_small(height=15){
	scale([.9,.9,.9]) 	translate([-8.75,1,snap_location]) male_dovetail(35);
}

module y_mount_added(){
	motor_mount_small();
	translate([1,-4+((10-arm_thickness)/2),hotend_depth/2]) cube([24.75,arm_thickness,hotend_depth], center=true);
    translate([1,-15,hotend_depth-(natch_height)]) cube([25,30,natch_height*2],center=true);
	translate([-4,-15,hotend_depth-15]) rotate([-45,0,0]) cube([15,30,natch_height*2],center=true);
	translate([1,1,0]) cube([25,8,5],center=true);
}

module y_mount_taken(){
        translate([0,-13,hotend_depth/2]) cylinder(h=70, d=mounting_diamiter);
	    translate([0,-13,0]) cylinder(h=70, d=top_diamiter);
		translate([0,-26,hotend_depth-natch_height]) rotate([0,-90,0]) cylinder(h=30, d=3.5, $fn=20);
		translate([0,-2,hotend_depth-natch_height+3]) rotate([0,-90,0]) cylinder(h=30, d=3.5, $fn=20);
}
module mount(){
	difference(){
		rotate([0,-90,0]){
			intersection(){
						translate([-15,-30,0]) cube([15,100,100]);
				difference(){
						y_mount_added();
						y_mount_taken();
				}
			}
					translate([-11.5,.7,37.5+(hotend_depth-80)]) cube([7,.3,42.5]);
		}
		translate([-hotend_depth/2,0,(-hotend_depth/2)-22.75/2]) cube([hotend_depth,hotend_depth,hotend_depth], center=true);
	}
}

mount();
translate([0,-65,0]) mirror([0,1,0]) mount();
*/