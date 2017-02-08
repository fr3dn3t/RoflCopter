 $fn = 100;
 //Servo
    //Servo Case
        servoLength = 23.15;
        servoWidth = 25.95;
        servoDepth = 12;
    //Servo Arm
        servoArmLength = 10;
        servoArmWidth = 3;
        servoArmThickness = 1;
    //Servo shaft
        servoShaftDiameter = 4;
        servoShaftHeight = 10;
        servoShaftOffset = 4;
        
        servoOffset = 2.5;
        
//PCB
    pcbHeight = 1.5;
    spaceUnderPCB = 2;
//IMU
    imuLength = 20.5;
    imuWidth = 10.5;
    imuHeight = 2;
 
//RadioReciever
    recieverLength = 25;
    recieverWidth = 12;
    recieverHeight = 2;
    
//2.4ghz serial
    serialLength = 18.5;
    serialWidth = 13.5;
    serialHeight = 2;
    
//mount plate
    mountPlateHeight = 9;
    motorArmGapSpace = 0.5;
    
//servoMount
    showServoMount = true;
        
//motor arm
    motorArmThickness = 6;
    motorArmLength = 320;
    
//bladeGear
    bladeGearDiameter = 4;
    bladeGearLength = 16.5;
    
    bladeGearFixingRingHeight = 3.5;
    bladeGearFixingRingDiameter = 7.2;
    
//teensyPinHeader
    pinHeaderWidth = 1.6;
    pinHeaderLength = 36;
    pinHeaderHeight = 9.32;
    pinHeaderOffset = 7.62;
    
//rotor
    rotorLength = 250;
    rotorWidth = 50;
    
//motorMount
    motorDiameter = 13;
    motorMountLength = 30;
    
//bumper
    bumperPosX = servoWidth*0.61;
    bumperPosY = 18;
    showBumper = false;
    
    bumperHole = 3.5;
    
//tsop
    showTsopBottom = false;

translate([0,-servoWidth/2,0]) {
    color("red") { 
     //servo 1
        //servoArm
        translate([-servoLength,-servoOffset,0]) {   
            translate([6,0,6]) {
              rotate([ 90, 0, 0]) {
                    cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                    translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            cube([servoArmWidth,servoArmLength,servoArmThickness]);
                        }
                    }
                }
            }
            //servoMotorBlock
            cube([ servoLength, servoWidth, servoDepth]);
            //ServoMountOuther
            difference() {
                translate([-4.5,2.7,0]) {
                    cube([4.5,2.3,servoDepth]);
                }
                translate([-2,5.1,servoDepth/2]) {
                    rotate([90,0,0]) {
                        cylinder(d = 2.5, h = 2.5, $fn = 100);
                    }
                    translate([-3,-2.41,-0.5]) {
                        cube([2,2.4,1]);
                    }
                }
            }
            //servoMountInner
            rotate([0,180,0]) {
                difference() {
                    translate([-servoLength-4.5,2.7,-servoDepth]) {
                        cube([4.5,2.3,servoDepth]);
                    }
                    translate([-2-servoLength,5.1,-servoDepth/2]) {
                        rotate([90,0,0]) {
                            cylinder(d = 2.5, h = 2.5, $fn = 100);
                        }
                        translate([-3,-2.41,-0.5]) {
                            cube([2,2.4,1]);
                        }
                    }
                }
            }
        }
    }

    translate([servoLength,servoWidth+servoOffset,0]) {
     //servo 2
        //servoArm
        rotate([0,0,180]) {          
            translate([6,0,6]) {
                  rotate([ 90, 0, 0]) {
                        cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                      translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            cube([servoArmWidth,servoArmLength,servoArmThickness]);
                        }
                    }
                }
            }
            //servoMotorBlock
            cube([ servoLength, servoWidth, servoDepth]);
            //servoMountOuther
            difference() {
                translate([-4.5,2.7,0]) {
                    cube([4.5,2.3,servoDepth]);
                }
                translate([-2,5.1,servoDepth/2]) {
                    rotate([90,0,0]) {
                        cylinder(d = 2.5, h = 2.5, $fn = 100);
                    }
                    translate([-3,-2.41,-0.5]) {
                        cube([2,2.4,1]);
                    }
                }
            }
            //servoMountInner
            rotate([0,180,0]) {
                difference() {
                    translate([-servoLength-4.5,2.7,-servoDepth]) {
                        cube([4.5,2.3,servoDepth]);
                    }
                    translate([-2-servoLength,5.1,-servoDepth/2]) {
                        rotate([90,0,0]) {
                            cylinder(d = 2.5, h = 2.5, $fn = 100);
                        }
                        translate([-3,-2.41,-0.5]) {
                            cube([2,2.4,1]);
                        }
                    }
                }
            }
        }
    }
}

//pcb
difference() {
    translate([0,0,servoDepth+spaceUnderPCB+1]) {
        color("pink") {
            cylinder(h = pcbHeight, d=servoWidth*2.15, $fn = 6); 
        }
        color("black") {
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
           // rotate([0,0,90]) {
                cube([imuLength,imuWidth,imuHeight]);
            //}
        }
        //Reciever
        translate([-recieverLength/2,recieverWidth/1.3,0]) {
            cube([recieverLength,recieverWidth,recieverHeight]);
        }
        //2.4ghz serial
       translate([-serialLength/2,-serialWidth*1.65,0]) {
            cube([serialLength,serialWidth,serialHeight]);
        }
        //bumperHole
        
        
        if(showBumper) {
            //bumper1
            translate([-bumperPosX,bumperPosY,-1]) {
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
                        translate([0,0,3.8]) {
                            cylinder(d = 1, h = 5.8);
                        }
                    }
                }
            }
            
            //bumper2
            translate([bumperPosX,bumperPosY,-1]) {
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
                        translate([0,0,3.8]) {
                            cylinder(d = 1, h = 5.8);
                        }
                    }
                }
            }
            
            rotate([0,0,180]) {
                //bumper3
                translate([-bumperPosX,bumperPosY,-1]) {
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
                            translate([0,0,3.8]) {
                                cylinder(d = 1, h = 5.8);
                            }
                        }
                    }
                }
                
                //bumper4
                translate([bumperPosX,bumperPosY,-1]) {
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
                            translate([0,0,3.8]) {
                                cylinder(d = 1, h = 5.8);
                            }
                        }
                    }
                }
            }
        }  
    }
    //bumperHoles
    translate([-bumperPosX,bumperPosY,servoDepth+1]) {
        cylinder(d = 4.5, h = 1.5);
    }
    translate([bumperPosX,bumperPosY,servoDepth+1]) {
        cylinder(d = 4.5, h = 1.5);
    }
    rotate([0,0,180]) {
        translate([-bumperPosX,bumperPosY,servoDepth+1]) {
            cylinder(d = 4.5, h = 1.5);
        }
        translate([bumperPosX,bumperPosY,servoDepth+1]) {
            cylinder(d = 4.5, h = 1.5);
        }
    }
    
    //servoSpacer
    translate([servoWidth*0.85,-14,servoDepth+0.9+spaceUnderPCB]) {
       cube([10,28,1.9]);
    }
    rotate([0,0,180]) {
        translate([servoWidth*0.85,-14,servoDepth+0.9+spaceUnderPCB]) {
           cube([10,28,1.9]);
        }
    }
}
    
  

//mountPlate
color("purple") {
    translate([0,0,servoDepth+pcbHeight+spaceUnderPCB+2]) {
        difference() {
            cylinder(h = mountPlateHeight, d=servoWidth*2.5, $fn=6);
            //rotorBaldeBearingGap1
            translate([0,servoWidth-2,mountPlateHeight/2]) {
                translate([0,4.2,0]) {
                    rotate([90,0,0]) {
                       cylinder(h = bladeGearLength, d = bladeGearDiameter, $fn=100);
                    }
                }
                translate([0,-servoWidth+15,0]) {
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
                translate([0,servoWidth-2,mountPlateHeight/2]) {
                    translate([0,4.2,0]) {
                        rotate([90,0,0]) {
                            cylinder(h = bladeGearLength, d = bladeGearDiameter, $fn=100);
                        }
                    }
                    translate([0,-servoWidth+15,0]) {
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
            //teensyPinHeader2
            rotate([0,0,180]) {
                translate([-(pinHeaderLength+1)/2,pinHeaderOffset-(pinHeaderWidth+1)/2,0]) {
                    cube([pinHeaderLength+1,pinHeaderWidth+1,pinHeaderHeight]);
                }
            }
            //motorArmGap
            translate([motorArmLength/2,-(motorArmThickness+motorArmGapSpace)/2,3-motorArmGapSpace/2]) {
                rotate([0,0,90]) {
                    cube([motorArmThickness+motorArmGapSpace,motorArmLength,motorArmThickness+motorArmGapSpace]);
                }
            }
            //IMUGap
            translate([-(imuLength+1.5)/2,-(imuWidth+1.5)/2+1.3,-0.1]) {
                cube([imuLength+1.5,imuWidth+1.5,imuHeight+0.5]);
            }
            
            //bumperHole1
            translate([-bumperPosX,bumperPosY,0]) {
                cylinder(d = 7.5, h = 4);
            }
            translate([-bumperPosX,bumperPosY,4]) {
                cylinder(d = 4.5, h = 1.5);
            }
            translate([-bumperPosX,bumperPosY,5.5]) {
                cylinder(d = 7.5, h = 3.5);
            }
            //bumperHole2
            translate([bumperPosX,bumperPosY,0]) {
                cylinder(d = 7.5, h = 4);
            }
            translate([bumperPosX,bumperPosY,4]) {
                cylinder(d = 4.5, h = 1.5);
            }
            translate([bumperPosX,bumperPosY,5.5]) {
                cylinder(d = 7.5, h = 3.5);
            }
            
            rotate([0,0,180]) {
                //bumperHole3
                translate([-bumperPosX,bumperPosY,0]) {
                    cylinder(d = 7.5, h = 4);
                }
                translate([-bumperPosX,bumperPosY,4]) {
                    cylinder(d = 4.5, h = 1.5);
                }
                translate([-bumperPosX,bumperPosY,5.5]) {
                    cylinder(d = 7.5, h = 3.5);
                }
                //bumperHole4
                translate([bumperPosX,bumperPosY,0]) {
                    cylinder(d = 7.5, h = 4);
                }
                translate([bumperPosX,bumperPosY,4]) {
                    cylinder(d = 4.5, h = 1.5);
                }
                translate([bumperPosX,bumperPosY,5.5]) {
                    cylinder(d = 7.5, h = 3.5);
                }
            }
            
            //rounded Edges top
            for(i = [0:60:360]) {
                rotate([0,0,i]) {
                    translate([(servoWidth*2.5)/2,0,mountPlateHeight-1]) {
                        difference() {
                            rotate([0,0,120]) {
                                cube([35,1,1]);
                            }
                            rotate([0,0,120]) {
                                translate([-0.1,1,0]) {
                                    rotate(a=[0,90,0]) {
                                    cylinder(d = 2,h = 35.2); 
                                    }
                                }
                            }     
                        }
                    }
                }
            }
            //rounded Edges bottom
            //edges without servoMounts
            rotate([0,0,60]) {
                translate([(servoWidth*2.5)/2,0,0]) {
                    difference() {
                        rotate([0,0,120]) {
                            cube([35,1,1]);
                        }
                        rotate([0,0,120]) {
                            translate([-0.1,1,1]) {
                                rotate(a=[0,90,0]) {
                                cylinder(d = 2,h = 35.2); 
                                }
                            }
                        }     
                    }
                }
            }
            rotate([0,0,240]) {
                translate([(servoWidth*2.5)/2,0,0]) {
                    difference() {
                        rotate([0,0,120]) {
                            cube([35,1,1]);
                        }
                        rotate([0,0,120]) {
                            translate([-0.1,1,1]) {
                                rotate(a=[0,90,0]) {
                                cylinder(d = 2,h = 35.2); 
                                }
                            }
                        }     
                    }
                }
            }
            //long edges with servoMounts
            rotate([0,0,120]) {
                translate([(servoWidth*2.5)/2,0,0]) {
                    difference() {
                        rotate([0,0,120]) {
                            cube([26.655,1,1]);
                        }
                        rotate([0,0,120]) {
                            translate([-0.1,1,1]) {
                                rotate(a=[0,90,0]) {
                                cylinder(d = 2,h = 27.2); 
                                }
                            }
                        }     
                    }
                }
            }
            rotate([0,0,300]) {
                translate([(servoWidth*2.5)/2,0,0]) {
                    difference() {
                        rotate([0,0,120]) {
                            cube([26.655,1,1]);
                        }
                        rotate([0,0,120]) {
                            translate([-0.1,1,1]) {
                                rotate(a=[0,90,0]) {
                                cylinder(d = 2,h = 27.2); 
                                }
                            }
                        }     
                    }
                }
            }
            //short edges with servoMounts
            translate([5.7734,-10,0]) {
                rotate([0,0,180]) {
                    translate([(servoWidth*2.5)/2,0,0]) {
                        difference() {
                            rotate([0,0,120]) {
                                cube([26,1,1]);
                            }
                            rotate([0,0,120]) {
                                translate([-0.1,1,1]) {
                                    rotate(a=[0,90,0]) {
                                    cylinder(d = 2,h = 26.2); 
                                    }
                                }
                            }     
                        }
                    }
                }
            }
            rotate([0,0,180]) {
                translate([5.7734,-10,0]) {
                    rotate([0,0,180]) {
                        translate([(servoWidth*2.5)/2,0,0]) {
                            difference() {
                                rotate([0,0,120]) {
                                    cube([26,1,1]);
                                }
                                rotate([0,0,120]) {
                                    translate([-0.1,1,1]) {
                                        rotate(a=[0,90,0]) {
                                        cylinder(d = 2,h = 26.2); 
                                        }
                                    }
                                }     
                            }
                        }
                    }
                }
            }
            //tsop gap
            translate([-21,7,0]) {
                rotate([0,0,60]) {
                    cube([5.2,3,8.5]);
                    translate([2.6,3,0]) {
                        cylinder(d = 4.2, h = 5.5);
                        translate([0,0,5.5]) {
                            sphere(r=2.1);
                        }
                    }
                    translate([2.35,3,2]) {
                        cube([0.5,10,5]);
                    }
                    translate([-1.05,1,0]) {
                        cube([7.3,0.9,2.3]);
                    }
                }
            }  
        }
        //tsop bottom
        if(showTsopBottom) {
            translate([-21.1,7.1,0]) {
                rotate([0,0,60]) {
                    difference() {
                        union() {
                            cube([5,3,1]);
                            translate([2.5,3,0]) {
                                cylinder(d = 4, h = 1);
                            }
                        }
                        translate([-1.05,1,0]) {
                            cube([2.1,0.9,1]);
                        }
                        translate([3.95,1,0]) {
                            cube([2.1,0.9,1]);
                        }
                        translate([2,1,0]) {
                            cube([1,0.9,1]);
                        }
                    }
                }
            }
        }
        //pcbWindProtectingWall
        translate([0,0,-5.5]) {
            difference() {
                cylinder(h = 5.5, d=servoWidth*2.41, $fn=6);
                translate([0,0,-0.1]) {
                    cylinder(h = 5.6, d=servoWidth*2.39, $fn=6);
                }
                translate([servoLength+4,servoDepth-17,-0.1]) {
                    cube([7,7,6]);
                }
                rotate([0,0,180]) {
                    translate([servoLength+4,servoDepth-17,-0.1]) {
                        cube([7,7,6]);
                    }
                }    
            }
            translate([servoLength+4.97,servoDepth-17,-0]) {
                cube([0.26,7,5.5]);
            }
            rotate([0,0,180]) {
                translate([servoLength+4.97,servoDepth-17,-0]) {
                    cube([0.26,7,5.5]);
                }
            }
        }
        
        
        
        if(showServoMount) {
            //servoMount1
            difference() {
                hull() {
                    translate([servoLength+0.1,servoDepth-3.5,-6.5-spaceUnderPCB-mountPlateHeight]) {
                                cube([4.5,2,servoDepth]);
                    }
                    translate([servoLength+0.1,servoDepth-3,0]) {
                       cube([3.35,1,0.1]);
                    }
                    translate([servoLength+0.1,servoDepth-12.1,0]) {
                       cube([9.1,0.1,0.1]);
                    }
                    translate([servoLength+0.1,servoDepth-17,0]) {
                       cube([6.3,0.1,0.1]);
                    }
                }
                translate([servoLength+2,servoDepth-1.49,-mountPlateHeight-spaceUnderPCB-0.5]) {
                    rotate([90,0,0]) {
                       cylinder(d = 1.3, h = 6.01, $fn = 100);//screw mustn't be longer than 8mm (6mm + 2.3mm)
                    }
                }
            }
            //servoMount2
            rotate([0,0,180]) {
                difference() {
                    hull() {
                        translate([servoLength+0.1,servoDepth-3.5,-6.5-spaceUnderPCB-mountPlateHeight]) {
                                    cube([4.5,2,servoDepth]);
                        }
                        translate([servoLength+0.1,servoDepth-3,0]) {
                           cube([3.35,1,0.1]);
                        }
                        translate([servoLength+0.1,servoDepth-12.1,0]) {
                           cube([9.1,0.1,0.1]);
                        }
                        translate([servoLength+0.1,servoDepth-17,0]) {
                           cube([6.3,0.1,0.1]);
                        }
                    }
                    translate([servoLength+2,servoDepth-1.49,-mountPlateHeight-spaceUnderPCB-0.5]) {
                        rotate([90,0,0]) {
                           cylinder(d = 1.3, h = 6.01, $fn = 100);//screw mustn't be longer than 8mm (6mm + 2.3mm)
                        }
                    }
                }
            }
        }
    }
}


//motorArm
translate([motorArmLength/2,-motorArmThickness/2,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness]) {
    rotate([0,0,90]) {
        cube([motorArmThickness,motorArmLength,motorArmThickness]);
    }
    
}

//teensy
translate([-18,-9,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2.5]) {
    color("green") {
        cube([36,18,1.2]); 
    }
    color("black") {
       translate([0,0.6,-1.5]) {
            cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight/6.2]);
        } 
        translate([0,15.8,-1.5]) {
            cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight/6.2]);
        } 
    }
}

//rotor1
translate([-rotorWidth/2.5,servoWidth+3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.8]) {
    cube([rotorWidth,rotorLength,2]);
}

//rotor2
rotate([0,0,180]) {
    translate([-rotorWidth/2,servoWidth+3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.8]) {
        cube([rotorWidth,rotorLength,2]);
    }
}


//motorMount1
translate([motorArmLength/2+21,0,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness/2]) {
    rotate([0,90,90]) {
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
    }
}

//motorMount2
translate([-motorArmLength/2-21,0,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness/2]) {
    rotate([0,90,-90]) {
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
    }
}