
$fn = 100;

ri = 6.66/2; // Radius innen
ral = 7.74/2; // Radius außen Lagerseiten
ra = 11/2; // Radiu außen

hl = 7; // Höhe Lager
h = 40; // Geamthöhe

difference(){
	union(){
		cylinder(r=ral, h=h);
		translate([0,0,hl]) cylinder(r=ra, h=h-2*hl);
	}
	translate([0,0,-1]) cylinder(r=ri, h=h+2);
}