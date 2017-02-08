$fn=100;
showBearing = true;

//mirror([0,1,0]) {   

    difference() {
        union() {
           rotate([0,0,0]) {    
                hull() {
                    rotate([0,0,0]) {
                        cube([0.1,75,0.4]);
                    }
                    translate([12.9,0,0]) {
                        rotate([0,0,0]) {
                            cube([0.1,75,0.4]);
                        }
                    }
                }
                
                hull() {
                    translate([0,74,0]) {
                        //rotate([0,90,0]) {
                            for(i=[26:-0.5:0.7]) {
                                translate([0,i-1,0]) {
                                    rotate([0,0,0]) {
                                        cube([0.1,1,0.4]);
                                    }
                                }
                                translate([0,26,0.3]) {
                                    rotate([180,0,0]) {
                                        translate([(9.13*log(i)),i-1,0]) {
                                            rotate([0,0,0]) {
                                                cube([0.1,0.1,0.40]);
                                            }
                                        }
                                    }
                                }
                            }
                        //}
                    }
                }
            }
            if(showBearing) {
                translate([-0.5,4,0.25]) {
                    rotate([90,0,0]) {
                        difference() {
                            cylinder(d=2, h=4);
                            cylinder(d=1, h=4);
                        }
                    }
                }
                translate([-0.5,90,0.25]) {
                    rotate([90,0,0]) {
                        difference() {
                            cylinder(d=2, h=4);
                            cylinder(d=1, h=4);
                        }
                    }
                }
                translate([-0.5,47,0.25]) {
                    rotate([90,0,0]) {
                        difference() {
                            cylinder(d=2, h=4);
                            cylinder(d=1, h=4);
                        }
                    }
                }
            }
        }
        /*
        translate([0,8,-0.1]) {
            rotate([0,0,0]) {
                cube([5.5,12.2,0.8]);
            }
        }
        translate([0,43.9,-0.1]) {
            rotate([0,0,0]) {
                cube([5.5,12.2,0.8]);
            }
        }
        translate([-0.1,80,-0.1]) {
            rotate([0,0,0]) {
                cube([4.5,12.2,0.8]);
            }
        }*/
        
    }
        
//}