
module screw(d, l, dk, k, s)
{
    difference(){

    union(){
    rotate_extrude(convexity=10, $fn=10)
    {
        square([dk/2-k/2,k]);
        translate([dk/2-k/2,k/2]) circle(k/2, $fn=8);
    }
    translate([0,0,-l])
    cylinder(l, d/2, d/2, $fn=12);
    }
    cylinder(l, s/2*sqrt(3)/2, s/2*sqrt(3)/2, $fn=6);
    }
}


screw(2, 5, 4, 0.9, 1.2);
