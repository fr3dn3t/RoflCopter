//h = 9.5

$fn = 100;

union() {
    difference() {
        union() {
            cylinder(d = 5, h = 1);
            translate([0,0,1]) {
                cylinder(d=3.5, h=1.5);
                translate([0,0,1.5]) {
                    cylinder(d=5.5, h=1);
                    translate([0,0,1]) {
                        cylinder(d=6.5, h=1);
                        translate([0,0,1]) {
                            cylinder(d=6.5, h=2);
                            translate([0,0,2]) {
                                cylinder(d=5.5, h=1);
                                translate([0,0,1]) {
                                    cylinder(d=3.5, h=2);
                                }
                            }
                        }
                    }  
                } 
            }
        }
        translate([0,0,3.8]) {
            cylinder(d = 1, h = 5.8);
        }
    }
}