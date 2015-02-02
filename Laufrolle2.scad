
$fn = 100;

R = 50/2; // Radius Laufrolle
rW = 14/2; // Radius Welle
rL = 22.7/2; // Radius Lager
rD = 24/2; // Radius Deckel

tL = 7.5; // Tiefe Lager
tD = 0.0; // Tiefe Deckel

rS = 3/2; // Schraubenradius
nS = 0; // Anzahl Schrauben
aS = 17/2; // Abstand der Schraueb vom Mittelpunkt

alT = 45; // Abstand laengs Transportzahn
olT = 15;

L = 1*alT; // Laenge
B = 40;	// Breite
NF = 3; // Anzahl Flansche
rF = 6/2; // Innenradius Flansch
sF = 0.2; // Spiel Flansch auf beweglicher Seite
aFr	= 3; // Abstand Flansch radial
aFa	= 0.5; // Abstand Flansch axial
Hb = 15; // Hoehe Bodenelement
Ht = 25; // Gesamthoehe
angP = 45; // Winkel Profil
LP = 30;

tR = 3;	// Tiefe Rillen fuer Laufrolle
bR = 4; // Breite Rillen fuer Laufrolle
aR = 17; // Abstand Rillen fuer Laufrolle
sR = 1; // Spiel Rillen

tT = 12; // Tiefe Transportzahn
bT = 7; // Breite Transportzahn
lT = 18; // Längen Tranportzahn

asT = 10; // Abstand seitlich Transportzahn

bFZ = 6; // Breite Fuehrungszahn
hFZ = 10; // Hoehe Fuehrungszahn
sFZ = 1; // Spiel Fuehrungszahn
lFZ = 30; // Laenge Fuehrungszahn
angFZ = 45; // Winkel Fuehrungszahn-Stirnseiten






NR = round(B/aR);
Rerr = (B/aR-NR)*aR/2;

NT = round(L/alT);

// Berechnungen fuer Flansche und deren Abstaende
bfg = B/2-aFa*(NF-1);
bf1 = bfg / NF;
bf2 = bfg / (NF-1);
bf1n = bf2 + aFa*2;
bf2n = bf1 + aFa*2;

angM = 360/NC;

Lr = L;


// Korrektur, damit die Stege fuer die Rillen exakt aufeinander stossen
r = Lr/2/tan(angM/2) - Hb/2;
c = (r+tR)/r;

rotate([90,0,0]){
	difference(){
		union(){
			cylinder(r=R-hFZ-sFZ,h=B);
			translate([0,0,B/2-bFZ/2-sFZ/2]) cylinder(r1=R,r2=R-hFZ-sFZ,h=B/2-(B/2-bFZ/2-sFZ/2));
			translate([0,0,B/2]) cylinder(r2=R,r1=R-hFZ-sFZ,h=B/2-(B/2-bFZ/2-sFZ/2));
			cylinder(r=R,h=B/2-bFZ/2-sFZ/2);
			translate([0,0,B/2+bFZ/2+sFZ/2]) cylinder(r=R,h=B/2-bFZ/2-sFZ/2);
			for(j = [0:-NR]){
				if(j != -NR/2){
					translate([0,0,-j*aR-bR/2+Rerr+sR]) cylinder(r=R+tR-sR,h=bR-sR*2);
				}
			}
		}
		translate([0,0,-1]) cylinder(r=rL,h=tL+tD+1);
		translate([0,0,-1]) cylinder(r=rD,h=tD+1);
		translate([0,0,B-tL-tD]) cylinder(r=rL,h=tL+tD+1);
		translate([0,0,B-tD]) cylinder(r=rD,h=tD+1);

		for(i = [0:nS-1]){
			rotate([0,0,i*360/nS]) translate([aS,0,-1]) cylinder(r=sR,h=B+2);
		}
		translate([0,0,-1]) cylinder(r=rW,h=B+2);
	}
}


for(i = [0:2]){
	translate([-Lr/2, 0, R]){

		// Kettenglied ---
		translate([i*L,0,Hb/2])
		%union(){
			difference(){
				hull(){
					rotate([90,0,0]) cylinder(r=Hb/2, h=B);
					translate([L,0,0]) rotate([90,0,0]) cylinder(r=Hb/2, h=B);
				}
				translate([0,1,0]) rotate([90,0,0]) cylinder(r=rF+sF, h=B+2);
				translate([L,1,0]) rotate([90,0,0]) cylinder(r=rF, h=B+2);
			
				for(i = [0:NF-1]){
					translate([0,-i*(bf2+bf2n)+aFa,0]) rotate([90,0,0]) cylinder(r=Hb/2+aFr, h=bf2n);
				}
				for(i = [0:NF-2]){
					translate([L,-i*(bf1+bf1n)-(bf2n+bf1)/2+aFa,0]) rotate([90,0,0]) cylinder(r=Hb/2+aFr, h=bf1n);
				}
			
				for(i = [0:-NR]){
					translate([-Hb-1,(i)*aR-bR/2-Rerr,-Hb/2-1]) cube([L+Hb*2+2,bR,tR+1]);
				}
				
				for(i = [-2:NT]){
					translate([i*alT +olT,-bT/2-B/2-asT,-Hb/2-1]) cube([lT,bT,tT+1]);
					translate([i*alT +olT,-bT/2-B/2+asT,-Hb/2-1]) cube([lT,bT,tT+1]);
				}
			}
			hull(){
				translate([L/2-LP/2,-B,Hb/2]) cube([LP,B,0.1]);
				translate([L/2-LP/2+(Ht-Hb)*tan(angP),-B,Ht-Hb/2]) cube([LP-2*(Ht-Hb)*tan(angP),B,0.1]);
			}
			hull(){
				translate([L/2,-B/2,-Hb/2]) scale([1,bFZ/lFZ,1]) cylinder(r=lFZ/2,h=0.1);
				translate([L/2-lFZ/2+hFZ*tan(angFZ),-B/2-0.05,-Hb/2-hFZ]) cube([lFZ-hFZ*tan(angFZ)*2,0.1,0.1]);
			}

		}
	}
}

