//Tooth data based on:
// Parametric Pulley with multiple belt profiles
// by droftarts January 2012

module GT2_2mm(h=8)
	{
	linear_extrude(height=h) polygon([[0.747183,-0.5],[0.747183,0],[0.647876,0.037218],[0.598311,0.130528],[0.578556,0.238423],[0.547158,0.343077],[0.504649,0.443762],[0.451556,0.53975],[0.358229,0.636924],[0.2484,0.707276],[0.127259,0.750044],[0,0.76447],[-0.127259,0.750044],[-0.2484,0.707276],[-0.358229,0.636924],[-0.451556,0.53975],[-0.504797,0.443762],[-0.547291,0.343077],[-0.578605,0.238423],[-0.598311,0.130528],[-0.648009,0.037218],[-0.747183,0],[-0.747183,-0.5]]);
	}

gt2_tooth_width = 1.494;
gt2_pitch = 2;
    
module gt2_fulltooth(h=8)
{
    translate([gt2_tooth_width/2,0,0])
    GT2_2mm(h=8);
    
    translate([gt2_tooth_width,-0.5,0])
    cube([gt2_pitch-gt2_tooth_width,0.5,h]);
}

module gt2_belt_linear_section(h=8, length=10)
{
    translate([0,0,-h/2])
    {
    for(i=[0:length/gt2_pitch])
    {
        translate([2*i,0,0])
        gt2_fulltooth();
    }
    }
}
//"GT2 2mm" , GT2_2mm_pulley_dia , 0.764 , 1.494 ); }
//module pulley( belt_type , pulley_OD , tooth_depth , tooth_width )
//gt2_fulltooth();

//gt2_belt_linear_section();
   