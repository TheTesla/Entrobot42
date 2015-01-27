
Ni = 6; // Anzahl Kanten
ri = 11.4/2; // Abstand Kante zu Mittelpunkt
Na = 4;
ra = 20/2;

h = 20;



difference(){
	hull(){
		for(i = [0:Na-1]){
			rotate([0,0,i*360/Na]) translate([ra,-ra*tan(360/2/Na),0]) cube([0.01,2*ra*tan(360/2/Na),h]);
		}
	}

	hull(){
		for(i = [0:Ni-1]){
			rotate([0,0,i*360/Ni]) translate([ri,-ri*tan(360/2/Ni),-1]) cube([0.01,2*ri*tan(360/2/Ni),h+2]);
		}
	}

}