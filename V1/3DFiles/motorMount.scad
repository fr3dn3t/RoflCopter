stick_length = 17;
stick_dia = 7;
wd = 5;

motor_r = 6.5;

rotate([-90,0,0]) {

	intersection() {
			difference() {
			cube([stick_dia + 2*wd, stick_length + wd + 2*motor_r + wd, stick_dia + 2*wd]);
		
			translate([wd,0,wd]) {	
				cube([stick_dia,stick_length,stick_dia]);
			}

			translate([0,stick_length + wd + motor_r,motor_r + wd/2]) {
				rotate([0,90,0])
				cylinder(h=stick_dia + 2*wd, r=motor_r, $fn=100);
			}

			translate([-(wd + stick_dia + 2),0,0]) {
				cube([stick_dia + 2*wd, stick_length - 3, stick_dia + 2*wd]);
			}
			translate([wd + stick_dia + 2,0,0]) {
				cube([stick_dia + 2*wd, stick_length - 3, stick_dia + 2*wd]);
			}
			translate([0,0,wd + stick_dia + 2]) {
				cube([stick_dia + 2*wd, stick_length - 3, stick_dia + 2*wd]);
			}
			translate([0,0,-(wd + stick_dia + 2)]) {
				cube([stick_dia + 2*wd, stick_length - 3, stick_dia + 2*wd]);
			}
			translate([0,stick_length - 3,0]) {
				rotate([0,0,0])
				cylinder(h=stick_dia + 2*wd, r=3, $fn=100);
			}
			translate([0,stick_length - 3,stick_dia + 2*wd]) {
				rotate([0,90,0])
				cylinder(h=stick_dia + 2*wd, r=3, $fn=100);
			}
			translate([0,stick_length - 3,0]) {
				rotate([0,90,0])
				cylinder(h=stick_dia + 2*wd, r=3, $fn=100);
			}
			translate([stick_dia + 2*wd,stick_length - 3,0]) {
				rotate([0,0,0])
				cylinder(h=stick_dia + 2*wd, r=3, $fn=100);
			}
			
		}
		translate([8.5,stick_length + wd + 2*motor_r + wd,8.5]) {
			rotate([90,0,0])
			cylinder(h=stick_length + wd + 2*motor_r + wd, r=9.5, $fn=100);
		}
	}
}
