
$fn = 100;

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
sT = 1; // Spiel Transportzahn

asT = 10; // Abstand seitlich Transportzahn

// Nabe
Ni = 6; // Anzahl Kanten
ri = 11.4/2; // Abstand Kante zu Mittelpunkt


NC = 6; // Anzahl Kettenglieder im Eingriff

bFZ = 6; // Breite Fuehrungszahn
hFZ = 10; // Hoehe Fuehrungszahn
sFZ = 1; // Spiel Fuehrungszahn


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

difference(){
	union(){
		hull(){
			for(i = [0:NC-1]){
				rotate([0,-angM*i,0]) translate([+Hb/2*tan(angM/2)-Lr/2,-B,r]){
					cube([Lr-Hb*tan(angM/2),B,0.1]);
				}
			}
		}
		for(i = [0:NC-1]){
			rotate([0,-angM*i,0]) translate([-Lr/2+(Hb/2-tR+sR)*tan(angM/2),0,r]){
				for(j = [0:-NR]){
					translate([0,j*aR-bR/2-Rerr+sR,0]) cube([Lr-(Hb/2-tR+sR)*2*tan(angM/2),bR-sR*2,tR-sR]);
				}
			}
		}
	}

	rotate([90,0,0])
	hull(){
		for(i = [0:Ni-1]){
			rotate([0,0,i*360/Ni]) translate([ri,-ri*tan(360/2/Ni),-1]) cube([0.01,2*ri*tan(360/2/Ni),B+2]);
		}
	}

	for(i = [0:NC-1]){
		rotate([0,-angM*i,0]) translate([-Lr/2,-B/2-bFZ/2-sFZ,r-hFZ-sFZ]){
			cube([Lr,bFZ+sFZ*2,hFZ+sFZ+tR+1]);
		}
	}
}


for(i = [0:NC-1]){
	rotate([0,-angM*i,0]){
		translate([-Lr/2, 0, r]){
			for(j = [0:NT-1]){
				intersection(){
					union(){
						translate([j*alT+olT+sT,-bT/2-B/2-asT+sT,0]) cube([lT-sT*2,bT-sT*2,tT-sT]);
						translate([j*alT+olT+sT,-bT/2-B/2+asT+sT,0]) cube([lT-sT*2,bT-sT*2,tT-sT]);
					}
					translate([0,0,Hb/2]) rotate([90,0,0]) cylinder(r=j*alT+olT+lT-sT,h=B);
					translate([Lr,0,Hb/2]) rotate([90,0,0]) cylinder(r=Lr-(j*alT+olT)-sT,h=B);
				}
				difference(){
					union(){
						translate([sqrt(pow(j*alT +olT+sT,2)-pow(Hb/2,2)),-bT/2-B/2-asT+sT,0]) cube([(j*alT +olT+sT) -sqrt(pow(j*alT +olT+sT,2)-pow(Hb/2,2)) +(lT-sT*2)+(Lr-(j*alT+olT+lT)+sT) -sqrt(pow(Lr-(j*alT+olT+lT)+sT,2)-pow(Hb/2,2)) ,bT-sT*2,Hb/2]);
						translate([sqrt(pow(j*alT +olT+sT,2)-pow(Hb/2,2)),-bT/2-B/2+asT+sT,0]) cube([(j*alT +olT+sT) -sqrt(pow(j*alT +olT+sT,2)-pow(Hb/2,2)) +(lT-sT*2)+(Lr-(j*alT+olT+lT)+sT) -sqrt(pow(Lr-(j*alT+olT+lT)+sT,2)-pow(Hb/2,2)) ,bT-sT*2,Hb/2]);
					}
					translate([0,0,Hb/2]) rotate([90,0,0]) cylinder(r=j*alT+olT+sT,h=B);
					translate([Lr,0,Hb/2]) rotate([90,0,0]) cylinder(r=Lr-(j*alT+olT+lT)+sT,h=B);

				}
			}

			// Kettenglied ---
			translate([0,0,Hb/2])
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
			}
		}
	}
}

