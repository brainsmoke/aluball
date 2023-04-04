
d=.001;

module screw_hole(pos, depth, drill, nut)
{
	x = pos[0];
	y = pos[1];

	translate([x,y,-d/2])
	union()
	{
		cylinder(depth+d, drill/2);
		translate( [0,0,depth-1.5] )
			cylinder(depth, nut/2, nut/2, $fn=6);
	}
}

module plate(length, width, depth)
{
	translate([-length/2,0,0])
		cube([length, width, depth]);
}

module plate_holes(length, width, depth, holes, drill, nut, slits, slitwidth)
{
	translate([-length/2,0,0])
	{
		for (pos = holes)
			screw_hole(pos, depth, drill, nut);

		for (l = slits)
			translate([l-slitwidth/2,-d/2,-d])
				cube([slitwidth, width+d, slitwidth+d]);
	}
}

module angle_bracket(length, width, depth, dihedral, holes, drill, nut, slits, slitwidth)
{
	difference() {
		for(i = [-1,1] )
			rotate([ 90-dihedral/2,0,i*90])
				plate(length, width, depth);

		for(i = [-1,1] )
		{
			slits_side = concat( slits,  [ for (s = slits) (length-s) ]);
			rotate([ (180-dihedral)/2,0,i*90])
				plate_holes(length, width, depth, holes, drill, nut, slits_side, slitwidth);
		}
	}
}

dihedral_angle=136.30923289232;
rotate([ 0,90-dihedral_angle/2,0 ])
angle_bracket(16.30,          /* length        */
              6,              /* width         */
              2.5,            /* depth         */
              dihedral_angle, /* angle         */
              [               /* list of holes */
                [2.5,3.2],
                [16.30-2.5,3.2]
              ],
              2,              /* hole diameter (per printer tweaking) */
              4.5,            /* nut diameter (same)                  */
              [6],            /* slits (symmetrical) :-(              */
              1.3,            /* width/height of slits                */
              $fn=20);
