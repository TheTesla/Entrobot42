
$fn = 100;

alT = 45; // Abstand laengs Transportzahn
olT = 15;

L = 1*alT; // Laenge
B = 40;	// Breite
NF = 3; // Anzahl Flansche
rF = 3.95/2; // Innenradius Flansch
sF = 0.2; // Spiel Flansch auf beweglicher Seite
aFr	= 3; // Abstand Flansch radial
aFa	= 0.5; // Abstand Flansch axial
Hb = 15; // Hoehe Bodenelement
Ht = 25; // Gesamthoehe
angP = 45; // Winkel Profil
LP = 30;
tR = 3;	// Tiefe Rille fuer Laufrolle
bR = 4; // Breite Rille fuer Laufrolle
aR = 17; // Abstand Rillen fuer Laufrolle

tT = 12; // Tiefe Transportzahn
bT = 7; // Breite Transportzahn
lT = 18; // Längen Tranportzahn
asT = 10; // Abstand seitlich Transportzahn

bFZ = 6; // Breite Fuehrungszahn
hFZ = 10; // Hoehe Fuehrungszahn
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
		if(i != -NR/2){
			translate([-Hb-1,(i)*aR-bR/2-Rerr,-Hb/2-1]) cube([L+Hb*2+2,bR,tR+1]);
		}
	}
	
	for(i = [-0:NT-1]){
		intersection(){
			union(){
				translate([i*alT +olT,-bT/2-B/2-asT,-Hb/2-1]) cube([lT,bT,tT+1]);
				translate([i*alT +olT,-bT/2-B/2+asT,-Hb/2-1]) cube([lT,bT,tT+1]);
			}
				translate([0,0,0]) rotate([90,0,0]) cylinder(r=i*alT+olT+lT,h=B);
				translate([L,0,0]) rotate([90,0,0]) cylinder(r=L-(i*alT+olT),h=B);
		}
		difference(){
					union(){
						translate([sqrt(pow(i*alT +olT,2)-pow(Hb/2,2)),-bT/2-B/2-asT,-Hb/2-1]) cube([(i*alT +olT) -sqrt(pow(i*alT +olT,2)-pow(Hb/2,2)) +(lT)+(L-(i*alT+olT+lT)) -sqrt(pow(L-(i*alT+olT+lT),2)-pow(Hb/2,2)) ,bT,Hb/2+1]);
						translate([sqrt(pow(i*alT +olT,2)-pow(Hb/2,2)),-bT/2-B/2+asT,-Hb/2-1]) cube([(i*alT +olT) -sqrt(pow(i*alT +olT,2)-pow(Hb/2,2)) +(lT)+(L-(i*alT+olT+lT)) -sqrt(pow(L-(i*alT+olT+lT),2)-pow(Hb/2,2)) ,bT,Hb/2+1]);
					}
					translate([0,0,0]) rotate([90,0,0]) cylinder(r=i*alT+olT,h=B);
					translate([L,0,0]) rotate([90,0,0]) cylinder(r=L-(i*alT+olT+lT),h=B);

				}

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
