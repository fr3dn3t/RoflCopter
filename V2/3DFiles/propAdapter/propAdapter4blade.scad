difference() {
    cylinder(r1 = 2.95, r2 = 2.525, h = 1, $fn = 100);

cylinder(d = 4.4, h = 4, $fn = 100);
}
difference() {
translate([0,0,1]) {
        cylinder(d = 5.05, h = 3.5, $fn = 100);
    }
    #cylinder(d = 4.4, h = 4.5, $fn = 100);
}