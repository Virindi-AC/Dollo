use <../../include/vitamins/e3d_hot_end.scad>
use <pulley_tooth.scad>
use <../xycarriage_simple/carriage.scad>
include <../../globals.scad>
include <../../include.scad>

current_x = -90;
current_y = 90;

/*
//1x Dollo
frame_inside_dimension = 120+60;
center_rail_len = 183;
center_rail_diameter = 6;
outer_rod_diameter = 8;
outer_rail_len = 152;
*/

/*
//1.5x Dollo
frame_inside_dimension = 180+60;
center_rail_len = 243;
center_rail_diameter = 6;
outer_rod_diameter = 8;
outer_rail_len = 206;
*/


//P5 250
center_rail_len = 319;
center_rail_diameter = 6;
outer_rod_diameter = 10;
outer_rail_len = 278;
frame_inside_dimension = 250+60;


/*
//???
center_rail_len = 313;
center_rail_diameter = 10;
outer_rod_diameter = 10;
outer_rail_len = 278;
frame_inside_dimension = 250+60;
*/

//center_rail_diameter = 20;
center_rail_diff = outer_rod_diameter + 1; //For outer rod > inner rod d
echo(str("center_rail_diff = ",center_rail_diff));

outer_carriage_rod_w = 15;
//outer_carriage_extra_w = 15;
outer_carriage_extra_w = outer_rod_diameter+8;
clamp_zone = outer_rod_diameter+2;
vertical_corner_clamp = 5;
outer_carriage_length = 40;

outer_rod_bearing_length = 9.75;
outer_rod_bearing_diameter = 12.2;
outer_rail_pos = center_rail_len/2 - outer_carriage_extra_w - outer_carriage_rod_w/2;
echo(str("outer_rail_pos = ",outer_rail_pos));

show_frame = true;
show_build_plate = true;

frame_top_clearance = 18;
frame_bar_size = 30;
frame_translate = frame_bar_size/2+frame_inside_dimension/2;

motor_size = 42; //NEMA17
motor_h = 43.33; //NEMA17 Mid
motor_center_ring_d = 22;
motor_screw_dist_onaxis = 31;
motor_from_rail = 15+outer_carriage_extra_w;
motor_screw_hole_diameter = 3.4;
motor_screw_countersink_diameter = 6.0;
motor_screw_length = 30.0;
motor_face_screw_engagement = 4.5; //Measured 5.39

y_rail_z = -(outer_rod_diameter/2+center_rail_diameter/2+2);
x_rail_z = -(outer_rod_diameter/2+center_rail_diameter/2+2) - center_rail_diff;

center_carriage_width = 50;
print_zone = center_rail_len - (center_rail_diameter + outer_carriage_rod_w+outer_carriage_extra_w
+center_carriage_width //Center carriage
//+2*clamp_zone-outer_rod_diameter //Clamp zone
+motor_size //Clamp zone
);
build_plate_size = print_zone;

pulley_h = 16;
pulley_rim_d = 16;
pulley_belt_region_height = 7.5;
pulley_setscrew_region_height = 5.5;
pulley_setscrew_region_d = 16;
pulley_tooth_diameter = 40/PI;
pulley_rim_thickness = (pulley_h - pulley_belt_region_height - pulley_setscrew_region_height)/2;

pulley_bearing_h = 5;
pulley_bearing_od = 16;
pulley_bearing_spacer_thickness = 1.12;
pulley_bearing_spacer_od = 10;

pulley_nut_h = 5;
pulley_nut_d = 9.2456;

pulley_screw_thread_length = 35;
pulley_screw_head_length = 5;
pulley_screw_head_diameter = 8.5;

belt_full_thickness = 1.43;
belt_height = 6;

echo(str("pulley_rim_thickness=",pulley_rim_thickness));

idler_adjustment_zone = 4;
idler_clamp_backing_thickness = 8;


v_cut_size = 0.3;
h_cut_size = 0.1;

/*
center_rod_bearing_diameter = 12.0;
center_rod_bearing_length = 19.0;

translate([current_x,current_y,0])
{
translate([center_carriage_width/2-center_rod_bearing_length,0,0])
rotate([0,90,0])
cylinder(d=center_rod_bearing_diameter,h=center_rod_bearing_length);

translate([-(center_carriage_width/2-center_rod_bearing_length),0,0])
rotate([0,-90,0])
cylinder(d=center_rod_bearing_diameter,h=center_rod_bearing_length);

translate([0,center_carriage_width/2-center_rod_bearing_length,-center_rail_diff])
rotate([-90,0,0])
cylinder(d=center_rod_bearing_diameter,h=center_rod_bearing_length);

translate([0,-(center_carriage_width/2-center_rod_bearing_length),-center_rail_diff])
rotate([90,0,0])
cylinder(d=center_rod_bearing_diameter,h=center_rod_bearing_length);
}
*/

echo(str("Print zone: ", print_zone
, "mm"));

echo(str("Frame outer dimension: ", frame_inside_dimension + frame_bar_size*2, "mm"));

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

module pulley_20t()
{
    difference()
    {
        union()
        {
            color("lightgray")
            translate([0,0,-pulley_h+pulley_belt_region_height/2+pulley_rim_thickness])
            cylinder(d=40/PI,h=pulley_h,center=false);
            
            color("lightgray")
            translate([0,0,pulley_belt_region_height/2])
            cylinder(d=pulley_rim_d,h=pulley_rim_thickness,center=false);
            
            color("lightgray")
            translate([0,0,-pulley_rim_thickness-pulley_belt_region_height/2])
            cylinder(d=pulley_rim_d,h=pulley_rim_thickness,center=false);
            
            color("lightgray")
            translate([0,0,-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_setscrew_region_height)])
            cylinder(d=pulley_setscrew_region_d,h=pulley_setscrew_region_height,center=false);
        }

        //Bore
        cylinder(h=pulley_h*2+0.1,center=true,d=5.1);
        
        //Set screw
        translate([0,0,-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_setscrew_region_height) + 3.5])
        rotate([-90,0,0])
        cylinder(h=pulley_rim_d/2,d=3.3);
        
        //Set screw
        translate([0,0,-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_setscrew_region_height) + 3.5])
        rotate([0,90,0])
        cylinder(h=pulley_rim_d/2,d=3.3);
    }
}

pulley_assembly_bearing_top_face = pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_bearing_h;

pulley_assembly_bearing_bottom_face = -(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height+pulley_bearing_h);

pulley_assembly_center_region_bottom = -(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height) -0.5;
pulley_assembly_center_region_top = pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness +0.5;

pulley_assembly_nut_top = pulley_assembly_center_region_top + pulley_bearing_h - 0.5 + pulley_nut_h;
pulley_assembly_nut_bottom = pulley_assembly_center_region_bottom - pulley_bearing_h + 0.5 - pulley_nut_h;
echo(str("pulley_assembly_nut_top: ",pulley_assembly_nut_top));
echo(str("pulley_assembly_nut_bottom: ",pulley_assembly_nut_bottom));
echo(str("pulley_assembly_nut_top - pulley_assembly_nut_bottom: ",pulley_assembly_nut_top - pulley_assembly_nut_bottom));

module pulley_bearing_assembly()
{
    pulley_20t();
    
    //Bearing - top
    translate([0,0,pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness])
    cylinder(d=pulley_bearing_od,h=pulley_bearing_h,center=false);
    
    //Bearing - bottom
    translate([0,0,-pulley_bearing_h-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height)])
    cylinder(d=pulley_bearing_od,h=pulley_bearing_h,center=false);
    
    //Spacer - top
    color([0.5,0.7,0])
    translate([0,0,-pulley_bearing_spacer_thickness+pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness])
    cylinder(d=pulley_bearing_spacer_od,h=pulley_bearing_spacer_thickness,center=false);
    
    //Spacer - bottom
    color([0.5,0.7,0])
    translate([0,0,-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height)])
    cylinder(d=pulley_bearing_spacer_od,h=pulley_bearing_spacer_thickness,center=false);
    
    /*
    translate([0,0,pulley_bearing_h/2+pulley_h/2+pulley_bearing_spacer_thickness])
    cylinder(d=pulley_bearing_od,h=pulley_bearing_h,center=true);
    */
    
    //Nut - top
    /*
    color([0.4,0.4,0.4])
    translate([0,0,pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_bearing_h])
    cylinder(d=pulley_nut_d,h=pulley_nut_h,$fn=6);
    */
    
    //Screw - head
    color([0.4,0.4,0.4])
    translate([0,0,pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_bearing_h])
    difference()
    {
        cylinder(d=pulley_screw_head_diameter,h=pulley_screw_head_length,$fn=20);
        
        translate([0,0,2])
        cylinder(d=4.5,h=pulley_screw_head_length,$fn=6);
    }
    
    //Screw - thread
    color([0.4,0.4,0.4])
    translate([0,0,pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_bearing_h-pulley_screw_thread_length])
    cylinder(d=5,h=pulley_screw_thread_length);
    
    //Nut - bottom
    color([0.4,0.4,0.4])
    translate([0,0,-pulley_nut_h-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height+pulley_bearing_h)])
    cylinder(d=pulley_nut_d,h=pulley_nut_h,$fn=6);
}

module pulley_bearing_assembly_cutout()
{
    //Bearing - top
    translate([0,0,pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness])
    cylinder(d=pulley_bearing_od+0.2,h=pulley_bearing_h,center=false);
    
    //Bearing - bottom
    translate([0,0,-pulley_bearing_h-(pulley_rim_thickness+pulley_belt_region_height/2+pulley_bearing_spacer_thickness+pulley_setscrew_region_height)])
    cylinder(d=pulley_bearing_od+0.2,h=pulley_bearing_h,center=false);
    
    //Center region
    translate([0,0,pulley_assembly_center_region_bottom])
    cylinder(h=pulley_assembly_center_region_top-pulley_assembly_center_region_bottom,d=pulley_rim_d+3);
    
    //Nut cutout
    nut_cutout_top = pulley_assembly_center_region_top + pulley_bearing_h - 0.5 + pulley_nut_h+20;
    nut_cutout_bottom = pulley_assembly_center_region_bottom - pulley_bearing_h + 0.5 - pulley_nut_h - 20;
    
    translate([0,0,nut_cutout_bottom])
    cylinder(h=nut_cutout_top-nut_cutout_bottom,d=pulley_nut_d+3);
}
/*
pulley_bearing_assembly();

translate([16,0,0])
pulley_bearing_assembly_cutout();
*/

module motor()
{
    //Main block
    color([0.5,0.5,0.5])
    cube([motor_size,motor_size,motor_h],center=true);
    
    //Shaft
    color("lightgray")
    translate([0,0,17.25/2+motor_h/2])
    cylinder(d=5,h=17.25,center=true);
    
    color([0.5,0.5,0.5])
    translate([0,0,1+motor_h/2])
    cylinder(d=motor_center_ring_d,h=2,center=true);
    
    translate([0,0,motor_h/2 + 6.8])
    rotate([180,0,0])
    pulley_20t();
}

module motor_blockonly()
{
    color([0.5,0.5,0.5])
    cube([motor_size,motor_size,motor_h],center=true);
}

motor_to_pulley_translate = -(motor_h/2 + 6.8);

module center_rails()
{
    //Center rail X
    translate([0,current_y,0])
    color("lightgray")
    rotate([0,90,0]) cylinder(h=center_rail_len,d=center_rail_diameter,center=true);

    //Center rail Y
    translate([current_x,0,0])
    translate([0,0,-center_rail_diff])
    color("lightgray")
    rotate([90,0,0]) cylinder(h=center_rail_len,d=center_rail_diameter,center=true);
}

module outer_rails()
{
    //Outer Y rails
    translate([outer_rail_pos,0,y_rail_z])
    rotate([90,0,0]) cylinder(h=outer_rail_len,d=outer_rod_diameter,center=true);

    translate([-outer_rail_pos,0,y_rail_z])
    rotate([90,0,0]) cylinder(h=outer_rail_len,d=outer_rod_diameter,center=true);

    //Outer X rails
    translate([0,outer_rail_pos,x_rail_z])
    rotate([0,90,0]) cylinder(h=outer_rail_len,d=outer_rod_diameter,center=true);

    translate([0,-outer_rail_pos,x_rail_z])
    rotate([0,90,0]) cylinder(h=outer_rail_len,d=outer_rod_diameter,center=true);
}

module outer_carriage()
{
    top_and_bottom = 8;
    
    oc_h = top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z)+center_rail_diameter/2+top_and_bottom;
    oc_z = -(top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z));
    
    block_xmin = -clamp_zone;
    block_xmax = motor_from_rail - pulley_tooth_diameter/2 - belt_full_thickness;
    
    block_xsize = block_xmax-block_xmin;
    
    side_block_xmin = clamp_zone;
    side_block_xsize = block_xsize - 2*clamp_zone;
    
    top_clamp_ysize = center_rail_diameter + 2*(3+3+3);
    
    side_screw_z_top = (oc_z+oc_h-center_rail_diameter/2)/2+center_rail_diameter/2;        
    side_screw_z = (oc_z-outer_rod_bearing_diameter/2+y_rail_z)/2;
    side_screw_from_ocz = oc_z - side_screw_z;
    side_screw_len = 30.5;
    
    
    //Stuff for the clamp block
    clamp_block_h = belt_height + 14;
    
    clamp_block_xmin = block_xmax+0.5;
    clamp_block_xsize = 4;
    clamp_block_xmax = clamp_block_xmin+clamp_block_xsize;
    
    clamp_block_screw_length = 10.5;
    clamp_block_nut_trap_length = clamp_block_xmax - clamp_zone - clamp_block_screw_length+3;
    
    clamp_screw_z_top = (clamp_block_h-belt_height)/4+belt_height/2;        
    
    echo(str("Outer carriage height = ",oc_h));
    echo(str("Outer carriage width = ",block_xsize));
    echo(str("side_block_xsize = ",side_block_xsize));
    
    //Main block
    color([0.4,0.8,0.4])
    difference()
    {
        translate([block_xmin,-outer_carriage_length/2,oc_z])
        cube([block_xsize,outer_carriage_length,oc_h]);
        
        //Outer rod
        translate([0,0,y_rail_z])
        rotate([90,0,0])
        cylinder(d=outer_rod_diameter+2,h=outer_carriage_length+0.1,center=true);
        
        //Outer rod bearings
        translate([0,-outer_rod_bearing_length/2+outer_carriage_length/2+0.1,y_rail_z])
        rotate([90,0,0])
        cylinder(d=outer_rod_bearing_diameter,h=outer_rod_bearing_length+0.2,center=true);
        
        translate([0,+outer_rod_bearing_length/2-outer_carriage_length/2-0.1,y_rail_z])
        rotate([90,0,0])
        cylinder(d=outer_rod_bearing_diameter,h=outer_rod_bearing_length+0.2,center=true);
        
        //Center rod
        rotate([0,90,0])
        cylinder(d=center_rail_diameter,h=1000,center=true);
        
        //Cut: top
        translate([block_xmin-0.01,-outer_carriage_length/2-0.1,-h_cut_size/2])
        cube([0.02+clamp_zone*2, outer_carriage_length+0.2,h_cut_size]);
        
        //Cut: side
        translate([clamp_zone,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([h_cut_size,outer_carriage_length+0.2,oc_h+0.2]);
        
        //Make the top piece smaller
        translate([-clamp_zone-0.02,top_clamp_ysize/2,0])
        cube([clamp_zone*2+0.02,outer_carriage_length/2,40]);
        translate([-clamp_zone-0.02,-top_clamp_ysize/2-outer_carriage_length/2,0])
        cube([clamp_zone*2+0.02,outer_carriage_length/2,40]);
        
        //Top piece to bottom screws
        topbottomscrew_x = (2*clamp_zone - outer_rod_bearing_diameter)/4+outer_rod_bearing_diameter/2;
        topbottomscrew_y = (top_clamp_ysize - center_rail_diameter)/4+center_rail_diameter/2;
        
        translate([topbottomscrew_x,topbottomscrew_y,oc_z-0.1])
        cylinder(h=oc_h+0.2,d=3.4);
        
        translate([-topbottomscrew_x,topbottomscrew_y,oc_z-0.1])
        cylinder(h=oc_h+0.2,d=3.4);
        
        translate([topbottomscrew_x,-topbottomscrew_y,oc_z-0.1])
        cylinder(h=oc_h+0.2,d=3.4);
        
        translate([-topbottomscrew_x,-topbottomscrew_y,oc_z-0.1])
        cylinder(h=oc_h+0.2,d=3.4);
        
        //Side piece to main screws
        translate([-clamp_zone-0.1,0,side_screw_z_top])
        rotate([0,90,0])
        cylinder(d=3.4,h=block_xsize+0.2);

        translate([-clamp_zone-0.1,-outer_carriage_length/2-side_screw_from_ocz,side_screw_z])
        rotate([0,90,0])
        cylinder(d=3.4,h=block_xsize+0.2);
        
        translate([-clamp_zone-0.1,outer_carriage_length/2+side_screw_from_ocz,side_screw_z])
        rotate([0,90,0])
        cylinder(d=3.4,h=block_xsize+0.2);
       
        //Head countersinks
        translate([block_xmin + (block_xsize-side_screw_len),0,side_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=6,h=block_xsize+0.2);
        
        translate([block_xmin + (block_xsize-side_screw_len),-outer_carriage_length/2-side_screw_from_ocz,side_screw_z])
        rotate([0,-90,0])
        cylinder(d=6,h=block_xsize+0.2);
        
        translate([block_xmin + (block_xsize-side_screw_len),outer_carriage_length/2+side_screw_from_ocz,side_screw_z])
        rotate([0,-90,0])
        cylinder(d=6,h=block_xsize+0.2);
        
        //Nut traps
        translate([block_xmax-3.4,0,side_screw_z_top])
        rotate([0,90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([block_xmax-3.4,-outer_carriage_length/2-side_screw_from_ocz,side_screw_z])
        rotate([0,90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([block_xmax-3.4,+outer_carriage_length/2+side_screw_from_ocz,side_screw_z])
        rotate([0,90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        //**************FROM CLAMP BLOCK********************
        //Screws
        translate([clamp_block_xmax+0.1,-outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,-outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        //Nuts
        translate([clamp_block_xmax-clamp_block_screw_length+3,-outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3,outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3,-outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3,outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
    }
    
    //Clamp block
    color([0.6,0.6,0])
    difference()
    {
        translate([clamp_block_xmin,-outer_carriage_length/2,-clamp_block_h/2])
        cube([clamp_block_xsize,outer_carriage_length,clamp_block_h]);
        
        //Center rod
        translate([clamp_block_xmin-0.1,0,0])
        rotate([0,90,0])
        cylinder(d=center_rail_diameter,h=clamp_block_xsize+0.2);
        
        //Screws
        translate([clamp_block_xmax+0.1,-outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,-outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        translate([clamp_block_xmax+0.1,outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        cylinder(d=3.4,h=clamp_block_screw_length+0.2);
        
        //Nuts
        translate([clamp_block_xmax-clamp_block_screw_length+3-0.05,-outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3-0.05,outer_carriage_length/4,clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3-0.05,-outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        translate([clamp_block_xmax-clamp_block_screw_length+3-0.05,outer_carriage_length/4,-clamp_screw_z_top])
        rotate([0,-90,0])
        rotate([0,0,90])
        nut_by_flats(f=5.54+0.35,h=clamp_block_nut_trap_length,horizontal=false);
        
        //Teeth
        translate([block_xmax,-center_rail_diameter/2-1,0])
        rotate([0,0,-90])
        translate([0,0.5,0])
        gt2_belt_linear_section(h=belt_height+2, length=outer_carriage_length/2);
        
        //Teeth
        mirror([0,1,0])
        translate([block_xmax,-center_rail_diameter/2-1,0])
        rotate([0,0,-90])
        translate([0,0.5,0])
        gt2_belt_linear_section(h=belt_height+2, length=outer_carriage_length/2);
    }
}

module belt(pulley_dist=100,pulley_d=40/PI,height=6)
{
    color([0.3,0.3,0.3])
    {
        difference()
        {
            union()
            {
                cylinder(d=pulley_d+belt_full_thickness*2,h=height,center=true);
                
                translate([pulley_dist,0,0])
                cylinder(d=pulley_d+belt_full_thickness*2,h=height,center=true);
                
                translate([pulley_dist/2,0,0])
                cube([pulley_dist,pulley_d+belt_full_thickness*2,height],center=true);
            }
            
            cylinder(d=pulley_d,h=height+0.1,center=true);
            
            translate([pulley_dist,0,0])
            cylinder(d=pulley_d,h=height+0.1,center=true);            
            
            translate([pulley_dist/2,0,0])
            cube([pulley_dist,pulley_d,height+0.1],center=true);
            
        }
    }
}
//belt();

module belts()
{
    //Idler pos:
    //translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
    
    //Motor pos:
    //translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate-center_rail_diff])
    
    difference()
    {
        translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
        belt(pulley_dist=outer_rail_pos*2);
        
        translate([current_x,outer_rail_pos+motor_from_rail-(40/PI)/2-(belt_full_thickness)/2,-center_rail_diff])
        cube([center_rail_diameter+4,belt_full_thickness+1,6.1],center=true);
    }
    
    rotate([0,0,180])
    difference()
    {
        translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
        belt(pulley_dist=outer_rail_pos*2);
        
        translate([-current_x,outer_rail_pos+motor_from_rail-(40/PI)/2-(belt_full_thickness)/2,-center_rail_diff])
        cube([center_rail_diameter+4,belt_full_thickness+1,6.1],center=true);
    }
    
    rotate([0,0,90])
    difference()
    {
        translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
        belt(pulley_dist=outer_rail_pos*2);
        
        translate([current_y,outer_rail_pos+motor_from_rail-(40/PI)/2-(belt_full_thickness)/2,0])
        cube([center_rail_diameter+4,belt_full_thickness+1,6.1],center=true);
    }
    

    rotate([0,0,270])
    difference()
    {
        translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
        belt(pulley_dist=outer_rail_pos*2);
        
        translate([-current_y,outer_rail_pos+motor_from_rail-(40/PI)/2-(belt_full_thickness)/2,0])
        cube([center_rail_diameter+4,belt_full_thickness+1,6.1],center=true);
    }


    /*
    rotate([0,0,180])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
    belt(pulley_dist=outer_rail_pos*2);
    
    rotate([0,0,90])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
    belt(pulley_dist=outer_rail_pos*2);
    
    rotate([0,0,270])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
    belt(pulley_dist=outer_rail_pos*2);
    */
}

module outer_rail_bearing()
{
    color([0.4,0.4,0.4])
    difference()
    {
        cylinder(d=outer_rod_bearing_diameter,h=outer_rod_bearing_length,center=true);
        
        cylinder(d=outer_rod_diameter,h=outer_rod_bearing_length+0.1,center=true);
    }
}

module outer_rail_bearings()
{
    //Y RAIL BEARINGS
    translate([outer_rail_pos,current_y-outer_rod_bearing_length/2+outer_carriage_length/2,y_rail_z])
    rotate([90,0,0])
    outer_rail_bearing();
    
    translate([outer_rail_pos,current_y+outer_rod_bearing_length/2-outer_carriage_length/2,y_rail_z])
    rotate([90,0,0])
    outer_rail_bearing();
    
    translate([-outer_rail_pos,current_y-outer_rod_bearing_length/2+outer_carriage_length/2,y_rail_z])
    rotate([90,0,0])
    outer_rail_bearing();
    
    translate([-outer_rail_pos,current_y+outer_rod_bearing_length/2-outer_carriage_length/2,y_rail_z])
    rotate([90,0,0])
    outer_rail_bearing();
    
    //X RAIL BEARINGS
    translate([current_x-outer_rod_bearing_length/2+outer_carriage_length/2,outer_rail_pos,x_rail_z])
    rotate([0,90,0])
    outer_rail_bearing();
    
    translate([current_x+outer_rod_bearing_length/2-outer_carriage_length/2,outer_rail_pos,x_rail_z])
    rotate([0,90,0])
    outer_rail_bearing();
    
    translate([current_x-outer_rod_bearing_length/2+outer_carriage_length/2,-outer_rail_pos,x_rail_z])
    rotate([0,90,0])
    outer_rail_bearing();
    
    translate([current_x+outer_rod_bearing_length/2-outer_carriage_length/2,-outer_rail_pos,x_rail_z])
    rotate([0,90,0])
    outer_rail_bearing();
}

//Outer clamps
module clamp_righthand()
{
    motor_face = (motor_h/2+motor_to_pulley_translate-center_rail_diff);

    block_bottom = x_rail_z - outer_rod_diameter/2 - vertical_corner_clamp;
    block_h = frame_top_clearance //Frame loc
        -block_bottom;
    block_top = block_bottom+block_h;
    
    block_x = outer_rail_pos-motor_size/2;
    block_x_sz = (frame_translate+frame_bar_size/2) - block_x;
    
    //block_y = outer_rail_pos-clamp_zone;
    //block_y_sz = motor_size/2+motor_from_rail+clamp_zone-3;
    block_y = outer_rail_pos-motor_size/2;
    block_y_sz = motor_size/2+motor_from_rail+clamp_zone-3+(motor_size/2-clamp_zone);
    old_block_y = outer_rail_pos-clamp_zone;
    
    //vertical_corner_clamp
    color([0.8,0.4,0.4])
    difference()
    {
        translate([block_x,block_y,block_bottom])
        cube([block_x_sz,block_y_sz, block_h
    ]);
        
        //Motor
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate-center_rail_diff])
        motor_blockonly();
        translate([outer_rail_pos-0.1,outer_rail_pos+motor_from_rail,motor_to_pulley_translate-center_rail_diff])
        motor_blockonly();
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail+0.1,motor_to_pulley_translate-center_rail_diff])
        motor_blockonly();
        
        //Motor screw holes
        //motor_screw_dist_onaxis
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_to_pulley_translate-center_rail_diff])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_to_pulley_translate-center_rail_diff])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_to_pulley_translate-center_rail_diff])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_to_pulley_translate-center_rail_diff])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        
        //Motor screw head countersinks
        motor_screw_top = motor_face + motor_screw_length - motor_face_screw_engagement;
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        
        shaftcut_h = pulley_h+14;

        //Frame: vertical
        translate([frame_translate,frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
        translate([frame_translate+0.1,frame_translate,-50+frame_top_clearance]) cube([30,30,120],center=true);
        translate([frame_translate,frame_translate+0.1,-50+frame_top_clearance]) cube([30,30,120],center=true);
        
        //Pulley circle
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail,0])
        cylinder(h=1000,d=motor_center_ring_d+0.4,center=true);
        
        //Belt hole
        translate([-50+outer_rail_pos,outer_rail_pos+motor_from_rail-(motor_center_ring_d+0.4)/2,-center_rail_diff-(shaftcut_h)/2])
        cube([50,motor_center_ring_d+0.4,shaftcut_h]);
        
        //Rods
        translate([outer_rail_pos,outer_rail_pos-motor_size-0.01,y_rail_z])
        rotate([-90,0,0]) cylinder(h=motor_size+motor_from_rail,d=outer_rod_diameter);
        
        translate([outer_rail_pos-motor_size/2-0.1,outer_rail_pos,x_rail_z])
        rotate([0,90,0]) cylinder(h=motor_size+frame_bar_size+0.2,d=outer_rod_diameter);
        
        //Rod plate screws

        //Frame dovetails
        //X
        translate([frame_translate,frame_translate-frame_bar_size/2,-100])
        rotate([0,0,180])
        male_dovetail(height=200);
        
        //Y
        translate([frame_translate-frame_bar_size/2,frame_translate,-100])
        rotate([0,0,90])
        male_dovetail(height=200);
        
        //ZX
        translate([frame_translate,frame_translate,+frame_top_clearance])
        rotate([0,-90,0])
        rotate([0,0,90])
        male_dovetail(height=200);
        
        //ZY
        //translate([frame_translate,frame_translate-100,+frame_top_clearance])
        //rotate([-90,0,0])
        //rotate([0,0,0])
        //male_dovetail(height=200);
    
        //Idler region cutout
        back_cut_y = frame_translate-frame_bar_size/2-12;
        //translate([frame_translate+15-6,back_cut_y-15,-50+frame_top_clearance+1]) cube([60,60,100],center=true);
            rotate([0,0,270])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
        pulley_bearing_assembly_cutout();
        
        /*
        rotate([0,0,270])
    translate([-outer_rail_pos-4,outer_rail_pos+motor_from_rail,0])
        pulley_bearing_assembly_cutout();
        */
        rotate([0,0,270])
    translate([-outer_rail_pos-4,outer_rail_pos+motor_from_rail,0])
        cylinder(d=pulley_bearing_od,h=1000,center=true);
        
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos-25,0])
        cube([pulley_rim_d+1,50,pulley_belt_region_height+3],center=true);
        
        translate([frame_translate-frame_bar_size/2,outer_rail_pos,-50+frame_top_clearance+1-50])
        cube([60,back_cut_y-outer_rail_pos,100]);
        echo(str("bxy  ",back_cut_y-outer_rail_pos));
        
        //Idler screw holes
        translate([8,0,14])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([-8,0,14])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([8,0,-19.5])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([-8,0,-19.5])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        //Idler nuts
        trap_depth = 5+3;
        
        translate([8,-trap_depth,14])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([-8,-trap_depth,14])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([8,-trap_depth,-19.5])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([-8,-trap_depth,-19.5])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        //Cut out the dovetail so it is <45 degrees up
        translate([8-2.5,-5,14])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        scale([1,1,1.2])
        rotate([-90,0,0])
        difference()
        {
            rotate([0,0,45])
            translate([0,0,5])
            cube([10.1,10.1,10],center=true);
            
            translate([-10,0,0])
            cube([20,20,30],center=true);
        }
        
        translate([8-2.5,-5,-19.5])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        scale([1,1,1.2])
        rotate([-90,0,0])
        difference()
        {
            rotate([0,0,45])
            translate([0,0,5])
            cube([10.1,10.1,10],center=true);
            
            translate([-10,0,0])
            cube([20,20,30],center=true);
        }
        
        //Cut off the idler
        translate([frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([v_cut_size,100,100],center=true);
        
        //Cut the idler to the old size
        translate([(frame_translate-frame_bar_size/2+v_cut_size/2-0.01),block_y-1,-50])
        cube([block_x+block_x_sz-(frame_translate-frame_bar_size/2+v_cut_size/2)+1,1+old_block_y-block_y,100]);
        
        //Vertical cuts for the rod clamps
        //XZ
        translate([-100+frame_translate-frame_bar_size/2,outer_rail_pos+motor_from_rail-motor_size/2-v_cut_size,-100+y_rail_z])
        cube([100,v_cut_size,100]);
        
        //YZ
        translate([frame_translate-frame_bar_size/2,outer_rail_pos+motor_from_rail-motor_size/2-100,-100+y_rail_z])
        cube([v_cut_size,100,100]);
        
        //Horizontal cuts for the rod clamps
        //Top rod
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z])
        cube([100,100,h_cut_size]);
        
        //Bottom rod
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,x_rail_z])
        cube([100,100,h_cut_size]);
        
        //Rod clamp screws
        translate([(outer_rod_diameter/2+3.5),(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([-(outer_rod_diameter/2+3.5),(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([(outer_rod_diameter/2+3.5),-(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([-(outer_rod_diameter/2+3.5),-(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
    }
}

module clamp_righthand_split()
{
    clamp_righthand();
}

module clamp_lefthand()
{
    motor_face = (motor_h/2+motor_to_pulley_translate);

    block_bottom = x_rail_z - outer_rod_diameter/2 - vertical_corner_clamp;
    block_h = frame_top_clearance //Frame loc
        -block_bottom;
    block_top = block_bottom+block_h;
    
    block_x = outer_rail_pos-motor_size/2;
    block_x_sz = (frame_translate+frame_bar_size/2) - block_x;
    
    //block_y = outer_rail_pos-clamp_zone;
    //block_y_sz = motor_size/2+motor_from_rail+clamp_zone-3;
    block_y = outer_rail_pos-motor_size/2;
    block_y_sz = motor_size/2+motor_from_rail+clamp_zone-3+(motor_size/2-clamp_zone);
    old_block_y = outer_rail_pos-clamp_zone;

    //vertical_corner_clamp
    color([0.4,0.4,0.8])
    difference()
    {
        translate([block_x,block_y,block_bottom])
        cube([block_x_sz,block_y_sz, block_h
    ]);
        
        //Motor
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate])
        motor_blockonly();
        translate([outer_rail_pos-0.1,outer_rail_pos+motor_from_rail,motor_to_pulley_translate])
        motor_blockonly();
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail+0.1,motor_to_pulley_translate])
        motor_blockonly();
        
        //Motor screw holes
        //motor_screw_dist_onaxis
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_to_pulley_translate])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_to_pulley_translate])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_to_pulley_translate])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_to_pulley_translate])
        cylinder(d=motor_screw_hole_diameter,h=1000,center=true);
        
        //Motor screw head countersinks
        motor_screw_length_left = 18.25; //Crap, these are shorter than 30
        motor_screw_top = motor_face + motor_screw_length_left - motor_face_screw_engagement;
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail+motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos+motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        translate([outer_rail_pos-motor_screw_dist_onaxis/2,outer_rail_pos+motor_from_rail-motor_screw_dist_onaxis/2,motor_screw_top])
        cylinder(d=motor_screw_countersink_diameter,h=100);
        
        shaftcut_h = pulley_h+14+center_rail_diff;

        //Frame: vertical
        translate([frame_translate,frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
        translate([frame_translate+0.1,frame_translate,-50+frame_top_clearance]) cube([30,30,120],center=true);
        translate([frame_translate,frame_translate+0.1,-50+frame_top_clearance]) cube([30,30,120],center=true);
        
        //Pulley circle
        translate([outer_rail_pos,outer_rail_pos+motor_from_rail,0])
        cylinder(h=1000,d=motor_center_ring_d+0.4,center=true);
        
        //Belt hole
        translate([-50+outer_rail_pos,outer_rail_pos+motor_from_rail-(motor_center_ring_d+0.4)/2,-center_rail_diff-(shaftcut_h)/2])
        cube([50,motor_center_ring_d+0.4,shaftcut_h]);
        
        //Rods
        translate([outer_rail_pos,outer_rail_pos-motor_size-0.01,x_rail_z])
        rotate([-90,0,0]) cylinder(h=motor_size+motor_from_rail,d=outer_rod_diameter);
        
        translate([outer_rail_pos-motor_size/2-0.1,outer_rail_pos,y_rail_z])
        rotate([0,90,0]) cylinder(h=motor_size+frame_bar_size+0.2,d=outer_rod_diameter);
        
        //Frame dovetails
        //X
        translate([frame_translate,frame_translate-frame_bar_size/2,-100])
        rotate([0,0,180])
        male_dovetail(height=200);
        
        //Y
        translate([frame_translate-frame_bar_size/2,frame_translate,-100])
        rotate([0,0,90])
        male_dovetail(height=200);
        
        //ZX
        translate([frame_translate,frame_translate,+frame_top_clearance])
        rotate([0,-90,0])
        rotate([0,0,90])
        male_dovetail(height=200);
        
        //ZY
        //translate([frame_translate,frame_translate-100,+frame_top_clearance])
        //rotate([-90,0,0])
        //rotate([0,0,0])
        //male_dovetail(height=200);
    
        //Idler region cutout
        back_cut_y = frame_translate-frame_bar_size/2-12;

        rotate([0,0,270])
        translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
        rotate([180,0,0])
        pulley_bearing_assembly_cutout();
        
        rotate([0,0,270])
        translate([-outer_rail_pos-4,outer_rail_pos+motor_from_rail,0])
        cylinder(d=pulley_bearing_od,h=1000,center=true);
        
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos-25,-center_rail_diff])
        cube([pulley_rim_d+1,50,pulley_belt_region_height+3],center=true);
        
        translate([frame_translate-frame_bar_size/2,outer_rail_pos,-50+frame_top_clearance+1-50])
        cube([60,back_cut_y-outer_rail_pos,100]);
        echo(str("bxy  ",back_cut_y-outer_rail_pos));
        
        //Idler screw holes
        translate([8,0,14-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([-8,0,14-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([8,0,-19.5-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        translate([-8,0,-19.5-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,outer_rail_pos,0])
        rotate([90,0,0])
        cylinder(d=3.4,h=100,center=true);
        
        //Idler nuts
        trap_depth = 5+3;
        
        translate([8,-trap_depth,14-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([-8,-trap_depth,14-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([8,-trap_depth,-19.5-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        translate([-8,-trap_depth,-19.5-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        rotate([-90,0,0])
        nut_by_flats(f=5.54+0.35,h=10,horizontal=false);
        
        //Cut out the dovetail so it is <45 degrees up
        translate([8-2.5,-5,14-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        scale([1,1,1.2])
        rotate([-90,0,0])
        difference()
        {
            rotate([0,0,45])
            translate([0,0,5])
            cube([10.1,10.1,10],center=true);
            
            translate([-10,0,0])
            cube([20,20,30],center=true);
        }
        
        translate([8-2.5,-5,-19.5-pulley_bearing_h])
        translate([outer_rail_pos+motor_from_rail,frame_translate-frame_bar_size/2,0])
        scale([1,1,1.2])
        rotate([-90,0,0])
        difference()
        {
            rotate([0,0,45])
            translate([0,0,5])
            cube([10.1,10.1,10],center=true);
            
            translate([-10,0,0])
            cube([20,20,30],center=true);
        }
        
        //Cut off the idler
        translate([frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([v_cut_size,100,100],center=true);
        
        //Cut the idler to the old size
        translate([(frame_translate-frame_bar_size/2+v_cut_size/2-0.01),block_y-1,-50])
        cube([block_x+block_x_sz-(frame_translate-frame_bar_size/2+v_cut_size/2)+1,1+old_block_y-block_y,100]);
        
        //Vertical cuts for the rod clamps
        //XZ
        translate([-100+frame_translate-frame_bar_size/2,outer_rail_pos+motor_from_rail-motor_size/2-v_cut_size,-100+y_rail_z])
        cube([100,v_cut_size,100]);
        
        //YZ
        translate([frame_translate-frame_bar_size/2,outer_rail_pos+motor_from_rail-motor_size/2-100,-100+y_rail_z])
        cube([v_cut_size,100,100]);
        
        //Horizontal cuts for the rod clamps
        //Top rod
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z])
        cube([100,100,h_cut_size]);
        
        //Bottom rod
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,x_rail_z])
        cube([100,100,h_cut_size]);
        
        //Rod clamp screws
        translate([(outer_rod_diameter/2+3.5),(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([-(outer_rod_diameter/2+3.5),(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([(outer_rod_diameter/2+3.5),-(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
        
        translate([-(outer_rod_diameter/2+3.5),-(outer_rod_diameter/2+3.5),0])
        union()
        {
            translate([outer_rail_pos,outer_rail_pos,block_bottom])
            cylinder(h=50,d=3.4);
            
            translate([outer_rail_pos,outer_rail_pos,block_bottom+50-8])
            nut_by_flats(f=5.54+0.35,h=100,horizontal=true);
        }
    }
}

module motors()
{
    //Motor
    translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate-center_rail_diff])
    motor();

    rotate([0,0,90])
    translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate])
    motor();

    rotate([0,0,180])
    translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate-center_rail_diff])
    motor();

    rotate([0,0,270])
    translate([outer_rail_pos,outer_rail_pos+motor_from_rail,motor_to_pulley_translate])
    motor();
}

module idlers()
{
    //Idler
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
    rotate([180,0,0])
    pulley_bearing_assembly();

    rotate([0,0,90])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
    pulley_bearing_assembly();

    rotate([0,0,180])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,-center_rail_diff])
    rotate([180,0,0])
    pulley_bearing_assembly();

    rotate([0,0,270])
    translate([-outer_rail_pos,outer_rail_pos+motor_from_rail,0])
    pulley_bearing_assembly();
}

module frame()
{
    //Frame
    color("white")
    {
    translate([frame_translate,frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
    translate([frame_translate,-frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
    translate([-frame_translate,frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
    translate([-frame_translate,-frame_translate,-50+frame_top_clearance]) cube([30,30,100],center=true);
    translate([0,frame_translate,frame_top_clearance+15]) cube([frame_inside_dimension,30,30],center=true);
    translate([0,-frame_translate,frame_top_clearance+15]) cube([frame_inside_dimension,30,30],center=true);
    translate([frame_translate,0,frame_top_clearance+15]) cube([30,frame_inside_dimension,30],center=true);
    translate([-frame_translate,0,frame_top_clearance+15]) cube([30,frame_inside_dimension,30],center=true);
    }
}

module build_plate()
{
    //Build plate
    translate([0,0,-(-(-center_rail_diff+2.88-7)     +46.5)-9.5-1.5])
    color("lightblue")
    cube([build_plate_size,build_plate_size,3],center=true);
}

module hotend()
{
    //Hotend
    translate([current_x,current_y,0])
    translate([15,15,-4])
    rotate([0,0,90])
    {
    //Note: my china hotend is shorter than nophead's model
    e3d_hot_end([4,   "HEE3DCLNB: E3D clone aliexpress",66-3.2,  6.8, 16,    46, "lightgrey", 12,    5.6,  15, [1, 5,  -4.5], 14.5, 21]);
        
    color("white")
        translate([0,0,-30])
        cylinder(h=68+30,d=4);
    }
}

module assembly()
{
    motors();
    idlers();
    belts();
    
    clamp_righthand_split();
    //rotate([0,0,180]) clamp_righthand_split();
    rotate([0,0,90]) clamp_lefthand();
    
    translate([outer_rail_pos,current_y,0])
    outer_carriage();
    
    translate([-outer_rail_pos,current_y,0])
    rotate([0,0,180])
    outer_carriage();
    
    translate([current_x,outer_rail_pos,-center_rail_diff])
    rotate([0,0,90])
    outer_carriage();
    
    translate([current_x,-outer_rail_pos,-center_rail_diff])
    rotate([0,0,-90])
    outer_carriage();
    
    outer_rails();
    center_rails();
    
    outer_rail_bearings();
    
    if (show_build_plate == true)
    {
        build_plate();
    }
    
    if (show_frame == true)
    {
        frame();
    }

    //hotend();
    
    translate([current_x,current_y,0])
    xycarriage_simple_assembly();
}

module clamp_rh_main()
{
    //To print: main block
    rotate([180,0,0])
    difference()
    {
        clamp_righthand_split();
        
        //Cut to remove rail clamps
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
        cube([100,100,100]);
        
        //Cut to remove idler block
        translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([100,100,100],center=true);
    }
}

module clamp_rh_idler()
{
    //To print: idler mount
    rotate([90,0,0])
    intersection()
    {
        difference()
        {
            clamp_righthand_split();
            
            //Cut to remove rail clamps
            translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
            cube([100,100,100]);
        }
        
        translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([100,100,100],center=true);
    }
}

module clamp_rh_mid()
{
    //To print: clamp mid
    rotate([180,0,0])
    intersection()
    {
        difference()
        {
            clamp_righthand_split();
            
            //Cut to remove idler block
            translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
            cube([100,100,100],center=true);
        }
        
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-center_rail_diff])
        cube([100,100,center_rail_diff]);
    }
}

module clamp_rh_bottom()
{
    //To print: clamp bottom
    rotate([0,0,0])
    difference()
    {
        intersection()
        {
            difference()
            {
                clamp_righthand_split();
                
                //Cut to remove idler block
                translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
                cube([100,100,100],center=true);
            }
            
            translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
            cube([100,100,100]);
        }
        
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-center_rail_diff])
        cube([100,100,center_rail_diff]);
    }
}

//*************************************
//LEFT
module clamp_lh_main()
{
    //To print: main block
    rotate([180,0,0])
    difference()
    {
        clamp_lefthand();
        
        //Cut to remove rail clamps
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
        cube([100,100,100]);
        
        //Cut to remove idler block
        translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([100,100,100],center=true);
    }
}

module clamp_lh_idler()
{
    //To print: idler mount
    rotate([90,0,0])
    intersection()
    {
        difference()
        {
            clamp_lefthand();
            
            //Cut to remove rail clamps
            translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
            cube([100,100,100]);
        }
        
        translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
        cube([100,100,100],center=true);
    }
}

module clamp_lh_mid()
{
    //To print: clamp mid
    rotate([180,0,0])
    intersection()
    {
        difference()
        {
            clamp_lefthand();
            
            //Cut to remove idler block
            translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
            cube([100,100,100],center=true);
        }
        
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-center_rail_diff])
        cube([100,100,center_rail_diff]);
    }
}

module clamp_lh_bottom()
{
    //To print: clamp bottom
    rotate([0,0,0])
    difference()
    {
        intersection()
        {
            difference()
            {
                clamp_lefthand();
                
                //Cut to remove idler block
                translate([50+frame_translate-frame_bar_size/2+v_cut_size/2,outer_rail_pos-50+1,0])
                cube([100,100,100],center=true);
            }
            
            translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-100])
            cube([100,100,100]);
        }
        
        translate([frame_translate-frame_bar_size/2-100,outer_rail_pos+motor_from_rail-motor_size/2-100,y_rail_z-center_rail_diff])
        cube([100,100,center_rail_diff]);
    }
}

module outer_carriage_main()
{
    //From outer carriage
    top_and_bottom=8;
    oc_h = top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z)+center_rail_diameter/2+top_and_bottom;
    oc_z = -(top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z));
    
    block_xmin = -clamp_zone;
    
    difference()
    {
        outer_carriage();
        
        //Cut: top
        translate([block_xmin-0.01,-outer_carriage_length/2-0.1,-h_cut_size/2])
        cube([0.02+clamp_zone*2, outer_carriage_length+0.2,100]);
        
        //Cut: side
        translate([clamp_zone,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([100,outer_carriage_length+0.2,oc_h+0.2]);
    }
}

module outer_carriage_top()
{
    //From outer carriage
    top_and_bottom=8;
    oc_h = top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z)+center_rail_diameter/2+top_and_bottom;
    oc_z = -(top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z));
    
    block_xmin = -clamp_zone;
    
    rotate([180,0,0])
    difference()
    {
        outer_carriage();
        
        //Cut: top
        mirror([0,0,1])
        translate([block_xmin-0.01,-outer_carriage_length/2-0.1,-h_cut_size/2])
        cube([0.02+clamp_zone*2, outer_carriage_length+0.2,100]);
        
        //Cut: side
        translate([clamp_zone,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([100,outer_carriage_length+0.2,oc_h+0.2]);
    }
}

module outer_carriage_side()
{
    //From outer carriage
    top_and_bottom=8;
    oc_h = top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z)+center_rail_diameter/2+top_and_bottom;
    oc_z = -(top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z));
    
    block_xmin = -clamp_zone;
    block_xmax = motor_from_rail - pulley_tooth_diameter/2 - belt_full_thickness;
    
    block_xsize = block_xmax-block_xmin;
    
    rotate([0,90,0])
    difference()
    {
        outer_carriage();
       
        //Cut: side in
        translate([clamp_zone-100,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([100,outer_carriage_length+0.2,oc_h+0.2]);
        
        //Cut: side out
        translate([block_xmax,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([100,outer_carriage_length+0.2,oc_h+0.2]);
    }
}

module outer_carriage_clamp()
{
    //From outer carriage
    top_and_bottom=8;
    oc_h = top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z)+center_rail_diameter/2+top_and_bottom;
    oc_z = -(top_and_bottom+outer_rod_bearing_diameter/2+(0-y_rail_z));
    
    block_xmin = -clamp_zone;
    block_xmax = motor_from_rail - pulley_tooth_diameter/2 - belt_full_thickness;
    
    block_xsize = block_xmax-block_xmin;
    
    rotate([0,90,0])
    difference()
    {
        outer_carriage();
        
        //Cut: side out
        translate([block_xmax-100+0.01,-outer_carriage_length/2-0.1,oc_z-0.1])
        cube([100,outer_carriage_length+0.2,oc_h+0.2]);
    }
}

//clamp_rh_main();
//clamp_rh_idler();
//clamp_rh_mid();
//clamp_rh_bottom();

//clamp_lh_main();
//clamp_lh_idler();
//clamp_lh_mid();
//clamp_lh_bottom();

//outer_carriage_main();
//outer_carriage_top();
//outer_carriage_side();
//outer_carriage_clamp();

assembly();