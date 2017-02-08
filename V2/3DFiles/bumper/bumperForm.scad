//h = 9.5

$fn = 100;

rotate([-90,0,0]) {
    difference() {
        translate([-5,0,0]) {
            cube([10,5,10]);
        }

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
            }
        }
        translate([0,0,4.5]) {
            cylinder(d = 1, h = 5.8);
        }
    }
}

translate([3.8,1.7,0]) {
    cylinder(d = 1.8, h = 1.8);
}

translate([-3.8,1.7,0]) {
    cylinder(d = 1.8, h = 1.8);
}
translate([3.8,8.7,0]) {
    cylinder(d = 1.8, h = 1.8);
}

translate([-3.8,8.7,0]) {
    cylinder(d = 1.8, h = 1.8);
}

translate([12,0,0]) {
    
    difference() {
        union() {
            rotate([-90,0,0]) {
                difference() {
                    translate([-5,0,0]) {
                        cube([10,5,10]);
                    }

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
                        }
                    }
                    translate([0,0,4.5]) {
                        cylinder(d = 1, h = 5.8);
                    }
                }
            }
        }
    
        translate([3.8,1.7,-2]) {
            cylinder(d = 2, h = 2.1);
        }

        translate([-3.8,1.7,-2]) {
            cylinder(d = 2, h = 2.1);
        }
        translate([3.8,8.7,-2]) {
            cylinder(d = 2, h = 2.1);
        }

        translate([-3.8,8.7,-2]) {
            cylinder(d = 2, h = 2.1);
        }
    }
}
