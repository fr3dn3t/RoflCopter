$fn=100;

steelDia = 1.1;
width = 2.5;
innerWidth = 1.2;

difference() {
    cylinder(d=width, h=2);
    cylinder(d=steelDia, h=2);
}
difference() {
    union() {
        translate([0,-width/2,0]) {
            cube([7,width,2]);
        }
    }
    cylinder(d=steelDia, h=2);
    translate([3.5,-innerWidth/2,0]) {
        cube([4,innerWidth,2]);
    }
}