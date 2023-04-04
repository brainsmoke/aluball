use <ball.scad>

module b(){
rotate([0,25.4,0])
ball(100, 1);
}

module funnel()
{

 difference()
{
    cylinder(15, r=5.4, center=true, $fn=50);
    cylinder(16, r=3, center=true, $fn=50);
    translate([0,0,-7.5])cylinder(15, r=3.75, center=true, $fn=50);
}
}


difference(){
translate([0,0,7.5]) funnel();
translate([0,0,119.5])b();
}
