//cylinder(d = 18, h = 9, $fn = 100);

difference() {
    union() {
        difference() {
          hull() {
                translate([-6,8,-6]) {
                    cube([12,22,6]);
                }

                translate([0,0,-3]) {
                    cylinder(d = 16.1, h = 3, $fn = 100);
                }                
            }
          
            translate([4.4,4.4,-7]) {
                cylinder(d = 2.45, h = 7, $fn = 100);
            }
                translate([4.4,4.4,-6]) {
                    cylinder(d = 3.5, h = 2.5, $fn = 100);
                }
                
            translate([3.4,-3.4,-7]) {
                cylinder(d = 2.45, h = 7, $fn = 100);
            }
                translate([3.4,-3.4,-6]) {
                    cylinder(d = 3.5, h = 4.3, $fn = 100);
                }
            
            translate([-3.4,3.4,-7]) {
                cylinder(d = 2.45, h = 7, $fn = 100);
            }
                translate([-3.4,3.4,-6]) {
                    cylinder(d = 3.5, h = 2.5, $fn = 100);
                }
            
            translate([-4.4,-4.4,-7]) {
                cylinder(d = 2.45, h = 7, $fn = 100);
            }
                translate([-4.4,-4.4,-6]) {
                    cylinder(d = 3.5, h = 3.0, $fn = 100);
                }
            
            translate([0,0,-2]) {
                cylinder(d = 5.7, h = 2, $fn = 100);
            }
        }

        hull() {
            translate([-7.376,10,0]) {
                cube([14.75,0.05,0.05]); 
            }
            translate([-6,13,0]) {
                cube([12,17,6]); 
            }
        }
    }
    
    translate([-3.175,13,-3.175]) {
        cube([6.35,17,6.35]);
    }
}
    


