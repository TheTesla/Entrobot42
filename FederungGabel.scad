
$fn = 50;

Ar = 5; // Abstand Radial
Aa = 2; //Abstand Axial

B = 40; // Breite Laufrolle

H = 14;

Ba = 65; // Breite außen

Rlf = 10; // Radius Laufradflansch
Rls = 5.5/2; // Radius Laufradschraube

Raf = 7; // Radius Aufhängungsflansch
Ras = 5.5/2; // Radius Aufhängungsschraube
Ala = 50; // Abstand Aufhängung-Laufrad
Baf = 70; // Breite Aufhängungsflansch

Rlb = 12/2; // Radius Laufradbefestigung

Rfs = 8/2; // Radius Federsteg
Alfs = 90; // Abstand Laufrolle-Federsteg

La = Ala; // Länge außen
R = Alfs+1; // Aussparung Radius Laufrolle

Rskl = 11/2; // Radius Schraubenkopf Laufradschraube
Tskl = 7; // Tiefe Schraubenkopf Laufradschraube

Nm = 6; // Eckenanzahl Mutter
Tm = 5; // Tiefe Mutter
Rm = 8.26/2; // Radius Mutter (gegenüber liegende Flächen)

module prisma(Ni, ri, B)
{
	rotate([90,0,0])
	hull(){
		for(i = [0:Ni-1]){
			rotate([0,0,i*360/Ni]) translate([ri,-ri*tan(360/2/Ni),0]) cube([0.01,2*ri*tan(360/2/Ni),B]);
		}
	}
}

difference(){
	union(){
		cube([La,Ba,H]);
		translate([0,0,Rlf]) rotate([-90,0,0]) cylinder(r=Rlf, h=Ba);
		hull(){
			translate([Ala,-(Baf-Ba)/2,Raf]) rotate([-90,0,0]) cylinder(r=Raf, h=Baf);
			translate([Alfs,0,Rfs]) rotate([-90,0,0]) cylinder(r=Rfs, h=Ba);
		}
	}
	translate([-1-Rlf,Ba/2-(B+2*Aa)/2,-1]) cube([R+Ar+1+Rlf,B+2*Aa,H+2*Rlf]);
	translate([0,-1,Rlf]) rotate([-90,0,0]) cylinder(r=Rls,h=Ba+2);
	translate([Ala,-1-(Baf-Ba)/2,Raf]) rotate([-90,0,0])# cylinder(r=Ras, h=Baf+2);
	translate([0,-1,Rlf]) rotate([-90,0,0]) cylinder(r=Rskl, h=Tskl+1);
	translate([0,Ba+1,Rlf]) prisma(Nm, Rm, Tm+1);
}

difference(){
	translate([Ala,-(Baf-Ba)/2,Raf]) rotate([-90,0,0]) cylinder(r=Raf, h=Baf);
	translate([Ala,-1-(Baf-Ba)/2,Raf]) rotate([-90,0,0]) cylinder(r=Ras, h=Baf+2);

}

difference(){
	union(){
		translate([0,(Ba-B-Aa*2)/2,Rlf]) rotate([-90,0,0]) cylinder(r1=Rlf,r2=Rlb, h=Aa);
		translate([0,(Ba-B-Aa*2)/2+B+Aa,Rlf]) rotate([-90,0,0]) cylinder(r2=Rlf,r1=Rlb, h=Aa);
	}
	translate([0,-1,Rlf]) rotate([-90,0,0]) cylinder(r=Rls,h=Ba+2);

}

			translate([Alfs,0,Rfs]) rotate([-90,0,0]) cylinder(r=Rfs, h=Ba);

