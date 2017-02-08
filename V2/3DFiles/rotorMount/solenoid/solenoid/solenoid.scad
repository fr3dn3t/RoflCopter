$fn=50;

difference() {
    translate([0.9,5.4875,2.35]) {
        rotate([90,0,90]) {
            cylinder(d=4.5, h=22.2);
        }
    }
    translate([2,4.75,2.35]) {
        rotate([90,0,90]) {
            cylinder(d = 2.6, h = 24);
        }
    }
}

difference() {
    cube([24,9.5,4.7]);
    translate([1.9,0.9,0]) {
        cube([20.2,7.5,4.7]);
    }
    translate([2,4.75,2.35]) {
        rotate([90,0,90]) {
            cylinder(d = 2.6, h = 24);
        }
    }
    
}



difference() {
    translate([14,0,-0.5]) {
        cube([8,3.2,0.9]);
    }
    translate([17.8,1.55,-0.6]) {
        cylinder(d = 1.5, h = 2);
    }
}