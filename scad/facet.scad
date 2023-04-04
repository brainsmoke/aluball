
use <bracket.scad>
use <screw.scad>;

function length (v) = sqrt(v[0]*v[0]+v[1]*v[1]);

points=[ [4.758293e-01,1.110223e-16],[1.996786e-01,-4.319051e-01],[-3.082417e-01,-3.624922e-01],[-4.583818e-01,1.276702e-01],[8.379381e-02,6.131512e-01] ];
sizes=[.05,.05,.3,.05,.35];

/*

points=[ [4.758293e-01,1.110223e-16],[1.996786e-01,-4.319051e-01],[-3.082417e-01,-3.624922e-01],[-4.583818e-01,1.276702e-01],[8.379381e-02,6.131512e-01] ];
sizes=[.05,.05,.3,.05,.35];
padding=1.5;
s=100

for i in range(5):
    j = (i+1)%5
    a, b = points[i], points[j]
    ax, ay = a
    bx, by = b
    dx, dy = bx-ax, by-ay
    d = (dx*dx+dy*dy)**.5
    print(d*s-padding*2-sizes[i]*s-sizes[j]*s)

*/


p=[[.195,-.08],[-0.18,0.13874118]];
/*
[.0,-.25],[-.0,.22],[.24, -.0],[-.25,.15]
];
*/
s=[.12,.1];

module pcb()
{
    difference()
    {
    polygon(points);
        union()
        {
            for (i=[0:4])
                translate(points[i])
                    circle(sizes[i],$fn=50);

            for (i=[0:len(p)-1])translate(p[i])circle(s[i],$fn=50);

        }
    }
}

dihedral_angle=136.30923289232;

padding=1.5;

holes = [

	[[6.632,3.2],[-6.632,3.2]],
	[[6.632,3.2]],
	[[6.632,3.2]],
	[[6.632,3.2],[-6.632,3.2]],
	[[6.632,3.2],[-6.632,3.2]]

];

slits = [

	[3,6.632*2-3, 38.2641/2],
	[3] ,
	[3] ,
	[3,6.632*2-3] ,
	[3,6.632*2-3]

];


module ball_bracket( i,s ) {

	a=[points[i][0],points[i][1],0]*s;
	b=[points[(i+1)%5][0],points[(i+1)%5][1],0]*s;
	l=length(b-a)-sizes[i]*s-sizes[(i+1)%5]*s - 2*padding;

echo("edge: ",i," length: ",l);
	holes_gen = [ for(h=holes[i]) ( h[0] < 0 ? [l+h[0], h[1]] : h ) ];

	rotate([ 0,-dihedral_angle/2-90,90 ])
	translate([0,-l/2-sizes[i]*s - padding,0])
	angle_bracket(l, 6, 2.5,
	              dihedral_angle,
	              holes_gen, 2, 4.8,
	              slits[i], 1.3,
	              $fn=20);
}


module facet(s,t) {
translate([0,0,s]) linear_extrude(height=t) rotate(180+105.5) scale([s,s])
	pcb();

translate([0,0,s]) 
rotate([0,0,180+105.5])
for (i=[0:4])
{
	a=[points[i][0],points[i][1],0]*s;
	b=[points[(i+1)%5][0],points[(i+1)%5][1],0]*s;
	dir = (b-a)/length(b-a);


	translate(a)
	multmatrix([[dir[0],-dir[1],0,0],[dir[1],dir[0],0,0],[0,0,1,0],[0,0,0,1]])
	{
			ball_bracket(i,s);

		
	a=[points[i][0],points[i][1],0]*s;
	b=[points[(i+1)%5][0],points[(i+1)%5][1],0]*s;
	l=length(b-a)-sizes[i]*s-sizes[(i+1)%5]*s - 2*padding;
	holes_gen = [ for(h=holes[i]) ( h[0] < 0 ? [l+h[0], h[1]] : h ) ];

		rotate([ 0,0,0 ])
		for (pos = holes_gen) translate([-pos[0]+sizes[i]*s+padding+l,-pos[1],1])
			screw(2, 4, 4, 0.9, 1.2);
	}
}
}

facet(100,1);