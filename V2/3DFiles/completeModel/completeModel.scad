//Servo
    //Servo Case
        servoLength = 26.4;
        servoWidth = 22.7;
        servoDepth = 12;
    //Servo Arm
        servoArmLength = 20;
        servoArmWidth = 3;
        servoArmThickness = 1;
    //Servo shaft
        servoShaftDiameter = 4;
        servoShaftHeight = 4;
        servoShaftOffset = 6;
        
//PCB
    pcbHeight = 1;
    
//IMU
    imuLength = 20.5;
    imuWidth = 10.5;
    imuHeight = 0;
 
//RadioReciever
    recieverLength = 25;
    recieverWidth = 12;
    recieverHeight = 0;
    
//2.4ghz serial
    serialLength = 18.5;
    serialWidth = 13.5;
    serialHeight = 0;
    
//mount plate
    mountPlateHeight = 9;
    motorArmGapSpace = 0.25;
        
//motor arm
    motorArmThickness = 6;
    motorArmLength = 350;
    
//bladeGear
    bladeGearDiameter = 4;
    bladeGearLength = 12;
    
    bladeGearFixingRingHeight = 4;
    bladeGearFixingRingDiameter = 7.2;
    
//teensyPinHeader
    pinHeaderWidth = 1.6;
    pinHeaderLength = 36;
    pinHeaderHeight = 11;
    pinHeaderOffset = 7.62;
    
//rotor
    rotorLength = 280;
    rotorWidth = 50;
    
//motorMount
    motorDiameter = 13;
    motorMountLength = 30;

translate([0,-servoWidth/2,0]) {
    color("red") { 
     //servo 1
        translate([-servoLength,0,0]) {   
            translate([6,0,6]) {
              rotate([ 90, 0, 0]) {
                    cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                    translate([-1.5,0,servoShaftHeight-1]) {
                        cube([servoArmWidth,servoArmLength,servoArmThickness]);
                    }
                }
            }
            cube([ servoLength, servoWidth, servoDepth]);
        }
    }

    translate([servoLength,servoWidth,0]) {
     //servo 2
        rotate([0,0,180]) {          
            translate([6,0,6]) {
                  rotate([ 90, 0, 0]) {
                        cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                      translate([-1.5,0,servoShaftHeight-1]) {
                        cube([servoArmWidth,servoArmLength,servoArmThickness]);
                    }
                }
            }
            cube([ servoLength, servoWidth, servoDepth]);
        }
    }
}

//pcb

    translate([0,0,servoDepth]) {
        color("pink") {
            cylinder(h = pcbHeight, d=servoWidth*2.3, $fn = 6); 
            //teensyPinHeader1
            translate([-pinHeaderLength/2,pinHeaderOffset-pinHeaderWidth/2,0]) {
                cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight]);
            }
            //teensyPinHeader1
            rotate([0,0,180]) {
                translate([-pinHeaderLength/2,pinHeaderOffset-pinHeaderWidth/2,0]) {
                    cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight]);
                }
            }
        }
        //IMU
        translate([-imuLength/2,-imuWidth/2+1.3,pcbHeight]) {
            cube([imuLength,imuWidth,imuHeight]);
        }
        //Reciever
        translate([-recieverLength/2,recieverWidth/1.3,pcbHeight]) {
            cube([recieverLength,recieverWidth,recieverHeight]);
        }
        //2.4ghz serial
       translate([-serialLength/2,-serialWidth*1.65,pcbHeight]) {
            #cube([serialLength,serialWidth,serialHeight]);
        }
    }

   
//mountPlate
color("purple") {
    translate([0,0,servoDepth+pcbHeight]) {
        difference() {
            cylinder(h = mountPlateHeight, d=servoWidth*2.3, $fn=6);
            //rotorBaldeBearingGap1
            translate([0,servoWidth,mountPlateHeight/2]) {
                rotate([90,0,0]) {
                    cylinder(h = bladeGearLength, d = bladeGearDiameter, $fn=100);
                }
                translate([0,-servoWidth+14,0]) {
                    rotate([90,0,0]) {
                        cylinder(h = bladeGearFixingRingHeight, d=bladeGearFixingRingDiameter, $fn=100);
                    }
                    translate([-bladeGearFixingRingDiameter/2,-bladeGearFixingRingHeight,0]){
                       cube([bladeGearFixingRingDiameter,bladeGearFixingRingHeight,mountPlateHeight/2+1]);
                    }
                }
            }
            //rotorBaldeBearingGap2
            rotate([0,0,180]) {
                translate([0,servoWidth,mountPlateHeight/2]) {
                    rotate([90,0,0]) {
                        cylinder(h = bladeGearLength, d = bladeGearDiameter, $fn=100);
                    }
                    translate([0,-servoWidth+14,0]) {
                        rotate([90,0,0]) {
                            cylinder(h = bladeGearFixingRingHeight, d=bladeGearFixingRingDiameter, $fn=100);
                        }
                        translate([-bladeGearFixingRingDiameter/2,-bladeGearFixingRingHeight,0]){
                           cube([bladeGearFixingRingDiameter,bladeGearFixingRingHeight,mountPlateHeight/2+1]);
                        }
                    }
                }
            }
            //teensyPinHeader1
            translate([-(pinHeaderLength+1)/2,pinHeaderOffset-(pinHeaderWidth+1)/2,0]) {
                cube([pinHeaderLength+1,pinHeaderWidth+1,pinHeaderHeight]);
            }
            //teensyPinHeader1
            rotate([0,0,180]) {
                translate([-(pinHeaderLength+1)/2,pinHeaderOffset-(pinHeaderWidth+1)/2,0]) {
                    cube([pinHeaderLength+1,pinHeaderWidth+1,pinHeaderHeight]);
                }
            }
            //motorArmGap
            translate([motorArmLength/2,-(motorArmThickness+motorArmGapSpace)/2,1.5-motorArmGapSpace/2]) {
                rotate([0,0,90]) {
                    cube([motorArmThickness+motorArmGapSpace,motorArmLength,motorArmThickness+motorArmGapSpace]);
                }
            }
            //IMUGap
            translate([-(imuLength+1.5)/2,-(imuWidth+1.5)/2+1.3,-0.1]) {
                cube([imuLength+1.5,imuWidth+1.5,imuHeight+0.5]);
            }
        }
    }
}

//motorArm
translate([motorArmLength/2,-motorArmThickness/2,servoDepth+pcbHeight+1.5]) {
    rotate([0,0,90]) {
        cube([motorArmThickness,motorArmLength,motorArmThickness]);
    }
    
}

//teensy
translate([-18,-9,servoDepth+pcbHeight+mountPlateHeight+1]) {
    color("green") {
        cube([36,18,1]); 
    }
}


//battery1
color("blue") {
    translate([-servoLength,servoWidth/2+1,(servoDepth-17)]) {
        cube([40,12,17]);
    }
}
//battery2
color("blue") {
    translate([-servoLength/2,-servoWidth-1,(servoDepth-17)]) {
        cube([40,12,17]);
    }
}


//rotor1
translate([-rotorWidth/2.5,servoWidth+1,servoDepth+pcbHeight+mountPlateHeight/1.8]) {
    cube([rotorWidth,rotorLength,2]);
}

//rotor2
rotate([0,0,180]) {
    translate([-rotorWidth/2.5,servoWidth+1,servoDepth+pcbHeight+mountPlateHeight/1.8]) {
        cube([rotorWidth,rotorLength,2]);
    }
}
