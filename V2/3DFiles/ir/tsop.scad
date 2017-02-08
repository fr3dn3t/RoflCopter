$fn = 100;
cube([5.2,3,7.5]);
translate([2.6,3,0]) {
    cylinder(d = 4.2, h = 4.5);
    translate([0,0,4.5]) {
        sphere(r=2.1);
    }
}