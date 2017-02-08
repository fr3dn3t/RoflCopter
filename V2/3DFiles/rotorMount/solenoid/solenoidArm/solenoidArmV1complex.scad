$fn=100;

steelDia = 1.3;
width = 3.3;
innerWidth = 1.2;

depth = 6;
gapDepth = 3;

difference() {
    cylinder(d=width, h=2);
    cylinder(d=steelDia, h=2);
}
difference() {
    union() {
        hull() {
            translate([0,-width/2,0]) {
                cube([0.1,width,2]);
            }
            translate([depth,-(width*1.5)/2,0]) {
                cube([0.1,width*1.5,2]);
            }
        }
    }
    cylinder(d=steelDia, h=2);
    translate([gapDepth,-innerWidth/2,0]) {
        cube([5,innerWidth,2]);
        translate([0,innerWidth/2,0]) {
            cylinder(d=innerWidth, h=2);
        }
    }
}
translate([depth,-(((width*1.5)-innerWidth)/2)+0.33,0]) {
    cylinder(d=((width*1.5)-innerWidth)/2, h=2);
}
translate([depth,(((width*1.5)-innerWidth)/2)-0.33,0]) {
    cylinder(d=((width*1.5)-innerWidth)/2, h=2);
}