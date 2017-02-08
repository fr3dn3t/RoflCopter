$fn = 70;

difference() {
    translate([0,1,0]) {
        cube([10,5,1]);
    }
    translate([1.85,3.5,0]) {
        cylinder(d = 1.5, h = 2);
    }
    translate([8.05,3.5,0]) {
        cylinder(d = 1.5, h = 2);
    }
}

difference() {
    hull() {
        cube([10,1,2]);
        translate([10+2.3,0,6]) {
            cube([0.9,1,5.3]);
        }
    }
    translate([10+3.22,1,11.1]) {
        translate([0,1,0]) {
            rotate([90,0,0]) {
               cylinder(d = 0.8, h = 3);
            }
        }
    }
    translate([0,1.1,14.5]) {
        rotate([90,0,0]) {
            cylinder(d = 25, h = 1.5);
        }
    }
}

translate([10+3.22,1,11.1]) {
    difference() {
        rotate([90,0,0]) {
            cylinder(d = 2.39, h = 1);
        }
        translate([0,1,0]) {
            rotate([90,0,0]) {
               cylinder(d = 0.8, h = 3);
            }
        }
    }
}

difference() {
    translate([10+2.3,0,6]) {
        cube([2.1,1,5.3]);
    }
    translate([10+3.22,1,11.1]) {
        translate([0,1,0]) {
            rotate([90,0,0]) {
               cylinder(d = 0.8, h = 3);
            }
        }
    }
}
        
