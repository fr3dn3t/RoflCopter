//tsop gap
$fn=100;
difference() {
    cube(8,14,40);
                translate([1.35,1.595,0]) {
                    cube([5.25,3,8.7]);
                    translate([2.625,3,0]) {
                        cylinder(d = 4.25, h = 5.7);
                        translate([0,0,5.7]) {
                            sphere(r=2.125);
                        }
                    }
                    translate([2.3,3,2]) {
                       # cube([1,3.4052,5]);
                    }
                    translate([-1.05,1,0]) {
                        cube([7.3,0.9,2.3]);
                    }
                }
            }