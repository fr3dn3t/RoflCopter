include <screwprop.scad>;
$fn = 140;
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
    spaceUnderPCB = 1;
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
    motorArmGapSpace = 0.25;
    
//servoMount
    showServoMount = true;
        
//motor arm
    motorArmThickness = 6;
    motorArmLength = 320;
    
//bladeGear
    bladeGearDiameter = 4.2;
    bladeGearLength = 16.5;
    
    bladeGearFixingRingHeight = 5.5;
    bladeGearFixingRingDiameter = 8.35;
    
//  PinHeader
    pinHeaderWidth = 1.6;
    pinHeaderLength = 36;
    pinHeaderHeight = 9.32;
    pinHeaderOffset = 6.2;
    
//DIPFORTy1
    DIPFORTy1Length =   51; 
    DIPFORTy1Width  =   18;
    DIPFORTy1Height =   1.2;
    
//rotor
    rotorWidth = 55;
    
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
    
//solenoid arm
    steelDia = 1.3;
    width = 3.3;
    innerWidth = 1.2;

    depth = 5;
    gapDepth = 2.8;

module foil(translateY, translateX, x, foilLength) {
    translate([translateX,-translateY,0]) {
        rotate([90,0,0]) {   
            linear_extrude(foilLength) {
                polygon(points=[
                    [	x*	1.00000	,	x*	0.00000	]	,
                    [	x*	0.96407	,	x*	0.00722	]	,
                    [	x*	0.93037	,	x*	0.01391	]	,
                    [	x*	0.89874	,	x*	0.02010	]	,
                    [	x*	0.86902	,	x*	0.02584	]	,
                    [	x*	0.84106	,	x*	0.03114	]	,
                    [	x*	0.81469	,	x*	0.03605	]	,
                    [	x*	0.78977	,	x*	0.04059	]	,
                    [	x*	0.76612	,	x*	0.04480	]	,
                    [	x*	0.74359	,	x*	0.04870	]	,
                    [	x*	0.72202	,	x*	0.05233	]	,
                    [	x*	0.70126	,	x*	0.05572	]	,
                    [	x*	0.68114	,	x*	0.05890	]	,
                    [	x*	0.66150	,	x*	0.06191	]	,
                    [	x*	0.64219	,	x*	0.06476	]	,
                    [	x*	0.62306	,	x*	0.06751	]	,
                    [	x*	0.60393	,	x*	0.07017	]	,
                    [	x*	0.58474	,	x*	0.07277	]	,
                    [	x*	0.56552	,	x*	0.07529	]	,
                    [	x*	0.54632	,	x*	0.07773	]	,
                    [	x*	0.52716	,	x*	0.08008	]	,
                    [	x*	0.50810	,	x*	0.08234	]	,
                    [	x*	0.48917	,	x*	0.08450	]	,
                    [	x*	0.47041	,	x*	0.08654	]	,
                    [	x*	0.45186	,	x*	0.08847	]	,
                    [	x*	0.43357	,	x*	0.09028	]	,
                    [	x*	0.41557	,	x*	0.09196	]	,
                    [	x*	0.39790	,	x*	0.09350	]	,
                    [	x*	0.38060	,	x*	0.09489	]	,
                    [	x*	0.36371	,	x*	0.09613	]	,
                    [	x*	0.34728	,	x*	0.09721	]	,
                    [	x*	0.33135	,	x*	0.09813	]	,
                    [	x*	0.31594	,	x*	0.09887	]	,
                    [	x*	0.30106	,	x*	0.09944	]	,
                    [	x*	0.28671	,	x*	0.09984	]	,
                    [	x*	0.27287	,	x*	0.10007	]	,
                    [	x*	0.25952	,	x*	0.10015	]	,
                    [	x*	0.24667	,	x*	0.10006	]	,
                    [	x*	0.23430	,	x*	0.09982	]	,
                    [	x*	0.22239	,	x*	0.09944	]	,
                    [	x*	0.21094	,	x*	0.09890	]	,
                    [	x*	0.19994	,	x*	0.09822	]	,
                    [	x*	0.18937	,	x*	0.09740	]	,
                    [	x*	0.17922	,	x*	0.09645	]	,
                    [	x*	0.16949	,	x*	0.09536	]	,
                    [	x*	0.16016	,	x*	0.09415	]	,
                    [	x*	0.15122	,	x*	0.09280	]	,
                    [	x*	0.14266	,	x*	0.09134	]	,
                    [	x*	0.13447	,	x*	0.08976	]	,
                    [	x*	0.12664	,	x*	0.08806	]	,
                    [	x*	0.11914	,	x*	0.08625	]	,
                    [	x*	0.11197	,	x*	0.08432	]	,
                    [	x*	0.10511	,	x*	0.08227	]	,
                    [	x*	0.09854	,	x*	0.08011	]	,
                    [	x*	0.09226	,	x*	0.07783	]	,
                    [	x*	0.08624	,	x*	0.07544	]	,
                    [	x*	0.08047	,	x*	0.07293	]	,
                    [	x*	0.07494	,	x*	0.07032	]	,
                    [	x*	0.06963	,	x*	0.06759	]	,
                    [	x*	0.06452	,	x*	0.06475	]	,
                    [	x*	0.05961	,	x*	0.06180	]	,
                    [	x*	0.05487	,	x*	0.05874	]	,
                    [	x*	0.05030	,	x*	0.05556	]	,
                    [	x*	0.04588	,	x*	0.05229	]	,
                    [	x*	0.04160	,	x*	0.04891	]	,
                    [	x*	0.03747	,	x*	0.04545	]	,
                    [	x*	0.03350	,	x*	0.04192	]	,
                    [	x*	0.02969	,	x*	0.03834	]	,
                    [	x*	0.02605	,	x*	0.03472	]	,
                    [	x*	0.02258	,	x*	0.03109	]	,
                    [	x*	0.01929	,	x*	0.02745	]	,
                    [	x*	0.01618	,	x*	0.02382	]	,
                    [	x*	0.01326	,	x*	0.02021	]	,
                    [	x*	0.01053	,	x*	0.01665	]	,
                    [	x*	0.00800	,	x*	0.01315	]	,
                    [	x*	0.00568	,	x*	0.00972	]	,
                    [	x*	0.00357	,	x*	0.00638	]	,
                    [	x*	0.00167	,	x*	0.00314	]	,
                    [	x*	0.00000	,	x*	0.00003	]	
                ]);
            }
        }
    }
}

module prop() {
    mirror([1,0,0]) {screwprop(33, 4.5, 20, 5.5);}
    mirror([1,0,0]) {rotate(a=[0,90,0])  {screwprop(33, 4.5, 20, 5.5);};}
    mirror([1,0,0]) {rotate(a=[0,180,0]) {screwprop(33, 4.5,  20, 5.5);};}
    mirror([1,0,0]) {rotate(a=[0,270,0]) {screwprop(33, 4.5, 20, 5.5);};}


        difference() {
            union() {
                translate([0,2.3,0])rotate(a=[90,0,0]) cylinder(h = 6.7, r=5.1, $fn=70);
                translate([0,2.5,0])rotate(a=[90,0,0]) cylinder(h = 7, r=4.8, $fn=70);
            }
            translate([0,2.5,0])rotate(a=[90,0,0]) cylinder(h = 7, r=2, $fn=70);
        }

    translate([0,2.2,0]) {
        rotate([90,0,0]) {
            rotate_extrude(convexity = 10)
                translate([10.2/2-0.3, 0, 0])
                    circle(r = 0.3);
        }
    }

    translate([0,3,0]) {
        rotate([90,0,0]) {
            cylinder(d=9.4, h=0.7);
            translate([0,0,0]) {
                difference() {
                    resize(newsize=[8.5,8.5,16]) sphere(r=30);
                    translate([0,0,10]) {
                      cube([20,20,20],center=true);
                    }
                }
            }
        }
    }
}

module motor() {
    difference() {
        cylinder(d1=16, d2=17.5, h=4);
        translate([7.5,0,0]) {
            cylinder(d=8,h=3.85);
        }
        translate([-7.5,0,0]) {
            cylinder(d=8,h=3.85);
        }
        translate([0,7.5,0]) {
            cylinder(d=8,h=3.85);
        }
        translate([0,-7.5,0]) {
            cylinder(d=8,h=3.85);
        }
        translate([0,0,3.85]) {
            cylinder(d=15, h=0.15);
        }
    }
    translate([0,0,4.1]) {
        cylinder(d=17.5, h=6);
    }
    translate([0,0,10.1]) {
        cylinder(d1=17.5, d2=14, h=2);
    }
}

module flap() {
    mirror([1,0,0]) {   
        difference() {
            union() {
               rotate([0,0,0]) {    
                    hull() {
                        rotate([0,0,0]) {
                            cube([0.1,75,0.5]);
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
                if(true) {
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
        }      
    }
}

module solenoidArm() {
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
                translate([depth,-(width*1.3)/2,0]) {
                    cube([0.1,width*1.3,2]);
                }
            }
        }
        cylinder(d=steelDia, h=2);
        translate([gapDepth,-innerWidth/2,0]) {
            cube([gapDepth,innerWidth,2]);
            translate([0,innerWidth/2,0]) {
                cylinder(d=innerWidth, h=2);
            }
        }
    }
    difference() {
        translate([depth,0,0]) {
            cylinder(d=width*1.3, h=2);
        }
        translate([gapDepth,-innerWidth/2,0]) {
            cube([gapDepth,innerWidth,2]);
        }
        translate([gapDepth+gapDepth,-innerWidth/2,0]) {
            translate([0,innerWidth/2,0]) {
                cylinder(d=innerWidth, h=2);
            }
        }
    }
}
translate([0,-servoWidth/2,0]) {
    color("red") { 
     //servo 1
        //servoArm
        translate([-servoLength,-servoOffset,0]) {   
            translate([6,0,6]) {
              rotate([ 90, 0, 0]) {
                    cylinder(h = 4, d = 9);
                    translate([5,0,0]) {
                        cylinder(h = 3, d = 6);
                    }
                    cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                    translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            difference() {
                                cube([servoArmWidth,servoArmLength,servoArmThickness]);
                                translate([1.5,8,-1]) {
                                    rotate([0,0,0]) {
                                        cylinder(h = 3, d = 0.8);
                                    }
                                }
                            }
                        }
                    }
                    //gestänge
                    translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            translate([1.5,8,-6]) {
                                rotate([0,0,0]) {
                                    cylinder(h = 8, d = 0.6);
                                }
                                sphere(d=0.6);
                                translate([0,0,0]) {
                                    rotate([45,90,0]) {
                                        cylinder(h = 20, d = 0.6);
                                    }
                                }
                                translate([14.1,-14.3,]) {sphere(d=0.6);}
                                translate([14,-14.3,]) {
                                    rotate([0,90,0]) {
                                        cylinder(h = 11.5, d = 0.6);
                                    }
                                }
                                translate([25.35,-14.3,-3.8]) {
                                    cylinder(h = 4, d = 0.6);
                                }
                            }   
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
        color("lightblue") { 
        //servoArm
        rotate([0,0,180]) {          
            translate([6,0,6]) {
                rotate([ 90, 0, 0]) {
                    cylinder(h = 4, d = 9);
                  translate([5,0,0]) {
                      cylinder(h = 3, d = 6);
                  }
                  cylinder(h = servoShaftHeight, d = servoShaftDiameter, $fn = 100);
                  translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            difference() {
                                cube([servoArmWidth,servoArmLength,servoArmThickness]);
                                translate([1.5,8,-1]) {
                                    rotate([0,0,0]) {
                                        cylinder(h = 3, d = 0.8);
                                    }
                                }
                            }
                        }
                  }
                  //gestänge
                    translate([-1.5,0,servoShaftHeight-1]) {
                        rotate([180,0,0]) {
                            translate([1.5,8,-6]) {
                                rotate([0,0,0]) {
                                    cylinder(h = 8, d = 0.6);
                                }
                                sphere(d=0.6);
                                translate([0,0,0]) {
                                    rotate([45,90,0]) {
                                        cylinder(h = 20, d = 0.6);
                                    }
                                }
                                translate([14.1,-14.3,]) {sphere(d=0.6);}
                                translate([14,-14.3,]) {
                                    rotate([0,90,0]) {
                                        cylinder(h = 11.5, d = 0.6);
                                    }
                                }
                                translate([25.35,-14.3,-3.8]) {
                                    cylinder(h = 4, d = 0.6);
                                }
                            }   
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
}

//pcb
difference() {
    translate([0,0,servoDepth+spaceUnderPCB]) {
        color("pink") {
            cylinder(h = pcbHeight, d=servoWidth*2.15, $fn = 6); 
        }
        color("black") {
            //DIPFORTy1PinHeader1
            translate([-pinHeaderLength/2,pinHeaderOffset-pinHeaderWidth/2,0]) {
                cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight]);
            }
            //DIPFORTy1PinHeader1
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
    }
    //bumperHoles
    translate([-bumperPosX,bumperPosY,servoDepth+2]) {
        cylinder(d = 4, h = 1.5);
    }
    translate([bumperPosX,bumperPosY,servoDepth+2]) {
        cylinder(d = 4, h = 1.5);
    }
    rotate([0,0,180]) {
        translate([-bumperPosX,bumperPosY,servoDepth+2]) {
            cylinder(d = 4, h = 1.5);
        }
        translate([bumperPosX,bumperPosY,servoDepth+2]) {
            cylinder(d = 4, h = 1.5);
        }
    }
    
    //servoSpacer
    translate([servoWidth*0.85,-14,servoDepth+2]) {
       cube([10,28,1.9]);
    }
    rotate([0,0,180]) {
        translate([servoWidth*0.85,-14,servoDepth+2]) {
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
                translate([0,-servoWidth+18,0]) {
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
                    translate([0,-servoWidth+18,0]) {
                        rotate([90,0,0]) {
                            cylinder(h = bladeGearFixingRingHeight, d=bladeGearFixingRingDiameter, $fn=100);
                        }
                        translate([-bladeGearFixingRingDiameter/2,-bladeGearFixingRingHeight,0]){
                           cube([bladeGearFixingRingDiameter,bladeGearFixingRingHeight,mountPlateHeight/2+1]);
                        }
                    }
                }
            }
            //DIPFORTy1PinHeader1
            translate([-(pinHeaderLength+1)/2,pinHeaderOffset-(pinHeaderWidth+1)/2,0]) {
                cube([pinHeaderLength+1,pinHeaderWidth+3.35,pinHeaderHeight]);
            }
            //DIPFORTy1PinHeader2
            rotate([0,0,180]) {
                translate([-(pinHeaderLength+1)/2,pinHeaderOffset-(pinHeaderWidth+1)/2,0]) {
                    cube([pinHeaderLength+1,pinHeaderWidth+3.35,pinHeaderHeight]);
                }
            }
            //motorArmGap
            translate([motorArmLength/2,-(motorArmThickness+motorArmGapSpace)/2,3-motorArmGapSpace/2]) {
                rotate([0,0,90]) {
                    cube([motorArmThickness+motorArmGapSpace,motorArmLength,motorArmThickness+motorArmGapSpace]);
                }
            }
            //IMUGap
            translate([-(imuLength+1.5)/2,-(imuWidth+3.5)/2+1.3,-0.1]) {
                 cube([imuLength+1.5,imuWidth+2.5,imuHeight-0.5]);
            }
            
            //bumperHole1
            translate([-bumperPosX,bumperPosY,0]) {
                cylinder(d = 5.6, h = 7);
            }
            //bumperHole2
            translate([bumperPosX,bumperPosY,0]) {
                cylinder(d = 5.6, h = 7);
            }
            
            rotate([0,0,180]) {
                //bumperHole3
                translate([-bumperPosX,bumperPosY,0]) {
                    cylinder(d = 5.6, h = 7);
                }
                //bumperHole4
                translate([bumperPosX,bumperPosY,0]) {
                    cylinder(d = 5.6, h = 7);
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
            
            //tsop gap
             translate([-21,7,0]) {
                rotate([0,0,60]) {
                    cube([5.65,3.2,8.7]);
                    translate([2.825,3,0]) {
                        cylinder(d = 4.3, h = 5.7);
                        translate([0,0,5.7]) {
                            sphere(r=2.15);
                        }
                    }
                    translate([2.525,3,2]) {
                        cube([0.6,3.4052,5]);
                    }
                    translate([-0.85,1,0]) {
                        cube([7.3,0.9,2.3]);
                    }
               }
            }
        }
        translate([0,servoWidth-2,mountPlateHeight/2]) {
            translate([0,-servoWidth+18,0]) {
                translate([0,-0.3,0]) {
                    difference() {
                        rotate([90,0,0]) {
                            cylinder(d=9, h=4.8);
                        }
                        translate([0,-2.6,3]) {
                            cylinder(d=1.5, h=3, $fn=6);
                        }
                    }
                    translate([0,-2.6,4.2]) {
                        difference() {
                            cylinder(d=2, h=0.7);
                            translate([0,0,-2]) {
                                cylinder(d=1.5, h=3, $fn=6);
                            }
                        }
                    }
                }
            }
        }
        
        rotate([0,0,180]) {
            translate([0,servoWidth-2,mountPlateHeight/2]) {
                translate([0,-servoWidth+18,0]) {
                    translate([0,-0.3,0]) {
                        difference() {
                            rotate([90,0,0]) {
                                cylinder(d=9, h=4.8);
                            }
                            translate([0,-2.6,3]) {
                                cylinder(d=1.5, h=3, $fn=6);
                            }
                        }
                        translate([0,-2.6,4.2]) {
                            difference() {
                                cylinder(d=2, h=0.7);
                                translate([0,0,-2]) {
                                    cylinder(d=1.5, h=3, $fn=6);
                                }
                            }
                        }
                    }
                }
            }
        }
        
           /* translate([0,servoWidth-2,mountPlateHeight/2]) {
                translate([0,32,0]) {
                    rotate([90,0,0]) {
                       cylinder(h = 40, d = 3, $fn=100);
                    }
                }
            }*/
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
        translate([0,0,-3.5-spaceUnderPCB]) {
            difference() {
                cylinder(h = 3.5+spaceUnderPCB, d=servoWidth*2.5, $fn=6);
                translate([0,0,-0.1]) {
                    cylinder(h = 3.6+spaceUnderPCB, d=servoWidth*2.435, $fn=6);
                }
                translate([servoLength+4,servoDepth-17,-0.1]) {
                    cube([7,9,4+spaceUnderPCB]);
                }
                rotate([0,0,180]) {
                    translate([servoLength+4,servoDepth-17,-0.1]) {
                        cube([7,9,4+spaceUnderPCB]);
                    }
                }    
            }
            translate([servoLength+5.56,servoDepth-17,-0]) {
                cube([0.84,7,3.5+spaceUnderPCB]);
            }
            rotate([0,0,180]) {
                translate([servoLength+5.56,servoDepth-17,-0]) {
                    cube([0.84,7,3.5+spaceUnderPCB]);
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
                translate([servoLength+2,servoDepth-1.3,-mountPlateHeight-spaceUnderPCB-0.5]) {
                    rotate([90,0,0]) {
                       cylinder(d = 2, h = 5.3, $fn = 100);//screw mustn't be longer than 8mm (6mm + 2.3mm)
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
                    translate([servoLength+2,servoDepth-1.30,-mountPlateHeight-spaceUnderPCB-0.5]) {
                        rotate([90,0,0]) {
                           cylinder(d = 2, h = 5,3, $fn = 100);//screw mustn't be longer than 8mm (6mm + 2.3mm)
                        }
                    }
                }
            }
        }
    }
}

//bumper
    translate([0,0,servoDepth+spaceUnderPCB]) {
        if(showBumper) {
            //bumperConstruction1
            translate([-bumperPosX,bumperPosY,2]) {
                //metallicPartFixedInMountBlock
                color("silver") {
                    difference() {
                        union() {
                            cylinder(d = 4.90, h = 9.5);
                            translate([0,0,9.5]) {
                                cylinder(d1 = 4.9, d2 = 6.9, h = 1);
                                translate([0,0,-5]) {
                                    difference() {
                                        sphere(d=13.85);
                                        translate([0,0,-7]) {
                                            cylinder(d = 14, h = 13);
                                        }
                                        translate([-3.5,-0.6,6]) {
                                            cube([7,1.2,1]);
                                        }
                                    }
                                }
                            }
                        }
                        cylinder(d=4, h = 9.5);
                       
                    }
                }
                //upperORing
                translate([0,0,0.5]) {
                    color("grey") {
                        rotate_extrude(convexity = 10)
                        translate([3.5, 0, 0])
                        circle(r = 1);
                    }
                }
                //lowerORing
                translate([0,0,-3]) {
                    color("grey") {
                        rotate_extrude(convexity = 10)
                        translate([3, 0, 0])
                        circle(r = 1);
                    }
                }
                //plasticScrew
                color("white") {
                    translate([0,0,7]) {
                        rotate([180,0,0]) {
                            difference() {
                                union() {
                                    cylinder(d = 3.9, h = 10);
                                    translate([0,0,10]) {
                                        cylinder(d1 = 3.9, d2 = 7.4, h = 2);
                                        translate([0,0,-5]) {
                                            difference() {
                                                sphere(d=15.867);
                                                translate([0,0,-9]) {
                                                    cylinder(d = 18, h = 16);
                                                }
                                                translate([-4,-0.6,6.42]) {
                                                    cube([8,1.2,1.5]);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //bumperConstruction2
            translate([-bumperPosX,-bumperPosY,2]) {
                //metallicPartFixedInMountBlock
                color("silver") {
                    difference() {
                        union() {
                            cylinder(d = 4.90, h = 9.5);
                            translate([0,0,9.5]) {
                                cylinder(d1 = 4.9, d2 = 6.9, h = 1);
                                translate([0,0,-5]) {
                                    difference() {
                                        sphere(d=13.85);
                                        translate([0,0,-7]) {
                                            cylinder(d = 14, h = 13);
                                        }
                                        translate([-3.5,-0.6,6]) {
                                            cube([7,1.2,1]);
                                        }
                                    }
                                }
                            }
                        }
                        cylinder(d=4, h = 9.5);
                       
                    }
                }
                //upperORing
                translate([0,0,0.5]) {
                    color("grey") {
                        rotate_extrude(convexity = 10)
                        translate([3.5, 0, 0])
                        circle(r = 1);
                    }
                }
                //lowerORing
                translate([0,0,-3]) {
                    color("grey") {
                        rotate_extrude(convexity = 10)
                        translate([3, 0, 0])
                        circle(r = 1);
                    }
                }
                //plasticScrew
                color("white") {
                    translate([0,0,7]) {
                        rotate([180,0,0]) {
                            difference() {
                                union() {
                                    cylinder(d = 3.9, h = 10);
                                    translate([0,0,10]) {
                                        cylinder(d1 = 3.9, d2 = 7.4, h = 2);
                                        translate([0,0,-5]) {
                                            difference() {
                                                sphere(d=15.867);
                                                translate([0,0,-9]) {
                                                    cylinder(d = 18, h = 16);
                                                }
                                                translate([-4,-0.6,6.42]) {
                                                    cube([8,1.2,1.5]);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            rotate([0,0,180]) {
                //bumperConstruction3
                translate([-bumperPosX,bumperPosY,2]) {
                    //metallicPartFixedInMountBlock
                    color("silver") {
                        difference() {
                            union() {
                                cylinder(d = 4.90, h = 9.5);
                                translate([0,0,9.5]) {
                                    cylinder(d1 = 4.9, d2 = 6.9, h = 1);
                                    translate([0,0,-5]) {
                                        difference() {
                                            sphere(d=13.85);
                                            translate([0,0,-7]) {
                                                cylinder(d = 14, h = 13);
                                            }
                                            translate([-3.5,-0.6,6]) {
                                                cube([7,1.2,1]);
                                            }
                                        }
                                    }
                                }
                            }
                            cylinder(d=4, h = 9.5);
                           
                        }
                    }
                    //upperORing
                    translate([0,0,0.5]) {
                        color("grey") {
                            rotate_extrude(convexity = 10)
                            translate([3.5, 0, 0])
                            circle(r = 1);
                        }
                    }
                    //lowerORing
                    translate([0,0,-3]) {
                        color("grey") {
                            rotate_extrude(convexity = 10)
                            translate([3, 0, 0])
                            circle(r = 1);
                        }
                    }
                    //plasticScrew
                    color("white") {
                        translate([0,0,7]) {
                            rotate([180,0,0]) {
                                difference() {
                                    union() {
                                        cylinder(d = 3.9, h = 10);
                                        translate([0,0,10]) {
                                            cylinder(d1 = 3.9, d2 = 7.4, h = 2);
                                            translate([0,0,-5]) {
                                                difference() {
                                                    sphere(d=15.867);
                                                    translate([0,0,-9]) {
                                                        cylinder(d = 18, h = 16);
                                                    }
                                                    translate([-4,-0.6,6.42]) {
                                                        cube([8,1.2,1.5]);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                //bumperConstruction4
                translate([-bumperPosX,-bumperPosY,2]) {
                    //metallicPartFixedInMountBlock
                    color("silver") {
                        difference() {
                            union() {
                                cylinder(d = 4.90, h = 9.5);
                                translate([0,0,9.5]) {
                                    cylinder(d1 = 4.9, d2 = 6.9, h = 1);
                                    translate([0,0,-5]) {
                                        difference() {
                                            sphere(d=13.85);
                                            translate([0,0,-7]) {
                                                cylinder(d = 14, h = 13);
                                            }
                                            translate([-3.5,-0.6,6]) {
                                                cube([7,1.2,1]);
                                            }
                                        }
                                    }
                                }
                            }
                            cylinder(d=4, h = 9.5);
                           
                        }
                    }
                    //upperORing
                    translate([0,0,0.5]) {
                        color("grey") {
                            rotate_extrude(convexity = 10)
                            translate([3.5, 0, 0])
                            circle(r = 1);
                        }
                    }
                    //lowerORing
                    translate([0,0,-3]) {
                        color("grey") {
                            rotate_extrude(convexity = 10)
                            translate([3, 0, 0])
                            circle(r = 1);
                        }
                    }
                    //plasticScrew
                    color("white") {
                        translate([0,0,7]) {
                            rotate([180,0,0]) {
                                difference() {
                                    union() {
                                        cylinder(d = 3.9, h = 10);
                                        translate([0,0,10]) {
                                            cylinder(d1 = 3.9, d2 = 7.4, h = 2);
                                            translate([0,0,-5]) {
                                                difference() {
                                                    sphere(d=15.867);
                                                    translate([0,0,-9]) {
                                                        cylinder(d = 18, h = 16);
                                                    }
                                                    translate([-4,-0.6,6.42]) {
                                                        cube([8,1.2,1.5]);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
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

//DIPFORTy1
translate([-DIPFORTy1Length/2,-DIPFORTy1Width/2,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2.5]) {
    color("green") {
        cube([DIPFORTy1Length,DIPFORTy1Width,DIPFORTy1Height]); 
    }
    color("black") {
        translate([7,3.5,1]) {
            cube([11,11,1.8]); 
        }
        translate([25,10.3,1]) {
            cube([5,5,1.5]); 
        }
    }
    color("black") {
       translate([0,0.6,-1.5]) {
            cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight/6.2]);
        } 
        translate([0,15.8,-1.5]) {
            cube([pinHeaderLength,pinHeaderWidth,pinHeaderHeight/6.2]);
        } 
    }
    color("white") {
        translate([1.5,0.8,0]) {
            for(h=[0:19]) {
                translate([h*2.54,0.2,1]) {
                    cylinder(d1=1, d2=0.4, h=1);
                }
            }
        }
        translate([1.5,16.8,0]) {
            for(h=[0:19]) {
                translate([h*2.54,0.2,1]) {
                    cylinder(d1=1, d2=0.4, h=1);
                }
            }
        }
    }
}

//rotor1
difference() {
    translate([-(rotorWidth*0.40),-servoWidth-3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.3]) {
        translate([0,6.34303,0]) {
            hull() {
                foil(	1000*	0.00634303	,	1000*	0.010813	,	1000*	0.0219	    ,	100*	0.00761164	);
                foil(	1000*	0.00761164	,	1000*	0.009675	,	1000*	0.0243	    ,	100*	0.00888024	);
                foil(	1000*	0.00888024	,	1000*	0.0086	    ,	1000*	0.0272	    ,	100*	0.0101488	);
                foil(	1000*	0.0101488	,	1000*	0.0076	    ,	1000*	0.0301	    ,	100*	0.0152233	);
                foil(	1000*	0.0152233	,	1000*	0.00355	    ,	1000*	0.0445	    ,	100*	0.0164919	);
                foil(	1000*	0.0164919	,	1000*	0.002533	,	1000*	0.04832	    ,	100*	0.0177605	);
                foil(	1000*	0.0177605	,	1000*	0.001475	,	1000*	0.0516	    ,	100*	0.0190291	);
                foil(	1000*	0.0190291	,	1000*	0.0005	    ,	1000*	0.053937	,	100*	0.0202977	);
                foil(	1000*	0.0202977	,	1000*	0	        ,	1000*	0.055	    ,	100*	0.224019	);
                foil(	1000*	0.224019	,	1000*	0	        ,	1000*	0.055	    ,	100*	0.227571	);
                foil(	1000*	0.227571	,	1000*	0.0008	    ,	1000*	0.0542	    ,	100*	0.232138	);
                foil(	1000*	0.232138	,	1000*	0.003	    ,	1000*	0.052	    ,	100*	0.23569	    );
                foil(	1000*	0.23569	    ,	1000*	0.006	    ,	1000*	0.049	    ,	100*	0.238227	);
                foil(	1000*	0.238227	,	1000*	0.01	    ,	1000*	0.0445	    ,	100*	0.241272	);
                foil(	1000*	0.241272	,	1000*	0.015	    ,  	1000*	0.039	    ,	100*	0.244114	);
                foil(	1000*	0.244114	,	1000*	0.021	    ,	1000*	0.032	    ,	100*	0.247564	);
                foil(	1000*	0.247564	,	1000*	0.0305	    ,	1000*	0.0205	    ,	100*	0.249239	);
                foil(	1000*	0.249239	,	1000*	0.03725	    ,	1000*	0.0117	    ,	100*	0.25	    );
                foil(	1000*	0.25	    ,	1000*	0.044	    ,	1000*	0.003	    ,	100*	0.248	    );
            }
        }
        //flap1
        translate([-13,215,0]) {
            rotate([0,-3,0]) {
                flap();
            }
        }
        translate([-12.5,72,0]) { 
            rotate([-90,0,0]) {
                cylinder(d=0.9,h=245);
            }
        }
        translate([-12.5,74,0]) {
            rotate([90,90,0]) {
                solenoidArm();
            }
        }
    }
    rotate([0,0,180]) {
        translate([0,0,servoDepth+pcbHeight+spaceUnderPCB+2]) {
            translate([0,servoWidth-2,mountPlateHeight/2]) {
                translate([0,32,0]) {
                    rotate([90,0,0]) {
                       #cylinder(h = 40, d = 3.1, $fn=100);
                    }
                }
            }
        }
    }
}

//rotorblatthalterung
translate([0,-servoWidth-3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.3]) {
    difference() {
        hull() {
            translate([-11.185,-1,-2.5]) {
                cube([21.9,1,2.5]);
            }
            translate([-15,-26,-2.5]) {
                cube([35,1,2.5]);
            }

            translate([-22,-14.3,-0.4]) {
                cube([1,1,0.4]);
            }

            translate([-22,-26,-0.4]) {
                cube([1,1,0.4]);
            }

            translate([32,-26,-0.4]) {
                cube([1,1,0.4]);
            }

            translate([32,-13.6,-0.4]) {
                cube([1,1,0.4]);
            }

            translate([27,-30,-0.4]) {
                cube([1,1,0.4]);
            }

            translate([-17,-30,-0.4]) {
                cube([1,1,0.4]);
            }
        }

        translate([-5,-3,-2]) {
            rotate([0,180,180]) {
               // difference() {
                    translate([-0.25,1,0]) {
                        cube([10.5,5.25,1]);
                    }
                    translate([1.85,3.5,-4]) {
                        cylinder(d = 1.5, h = 6);
                    }
                    translate([8.05,3.5,-4]) {
                        cylinder(d = 1.5, h = 6);
                    }
              //  }

                difference() {
                    //hull() {
                        translate([-0.25,-0.3,0]) {
                            cube([10.5,1.3,2]);
                        }
                        translate([10+2.3,0,6]) {
                            cube([0.9,1,5.3]);
                        }
                   // }
                    translate([0,1.1,14.5]) {
                        rotate([90,0,0]) {
                            cylinder(d = 25, h = 1.5);
                        }
                    }
                }

                translate([10+3.22,1,11.1]) {
                    rotate([90,0,0]) {
                        cylinder(d = 2.39, h = 1);
                    }
                }

                translate([10+2.3,0,6]) {
                    cube([2.1,1,5.3]);
                }
            }
        }



        translate([2,-21,-5]) {
            difference() {
                translate([0.9,5.4875,2.35]) {
                    rotate([90,0,90]) {
                        //cylinder(d=4.5, h=22.2);
                    }
                }
                translate([2,4.75,2.35]) {
                    rotate([90,0,90]) {
                        //cylinder(d = 2.6, h = 24);
                    }
                }
            }

            difference() {
                cube([24,9.5,4.7]);
                translate([1.9,0.9,0]) {
                    cube([20.2,2.25,4.7]);
                }
                translate([2,4.75,2.35]) {
                    rotate([90,0,90]) {
                       // cylinder(d = 2.6, h = 24);
                    }
                }
                
            }

            translate([0,9.5,0]) {
                    cube([1.9,1.7,4.7]);
                }

            //difference() {
                translate([14,0,-0.9]) {
                    cube([8,3.2,0.9]);
                }
                translate([17.8,1.55,2.3]) {
                    cylinder(d = 1.5, h = 2);
                }
            //}
        }
        
        //translate([-(rotorWidth*0.40),-servoWidth,0]) {
            rotate([0,0,180]) {
                translate([0,0,0]) {
                    translate([0,servoWidth-2,0]) {
                        rotate([90,0,0]) {
                         #  cylinder(h = 40, d = 3.2, $fn=100);
                        }
                    }
                }
            }
        //}
    }
    
    //Ruderhorn
    color("lightgreen") {
        translate([-5,-3,-2]) {
            rotate([0,180,180]) {
                difference() {
                    translate([0,1,0]) {
                        cube([10,5,1]);
                    }
                    translate([1.85,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                    translate([8.05,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                }

                difference() {
                    hull() {
                        cube([10,1,2]);
                        translate([10+2.3,0,6]) {
                            cube([0.9,1,5.3]);
                        }
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                    translate([0,1.1,14.5]) {
                        rotate([90,0,0]) {
                            cylinder(d = 25, h = 1.5);
                        }
                    }
                }

                translate([10+3.22,1,11.1]) {
                    difference() {
                        rotate([90,0,0]) {
                            cylinder(d = 2.39, h = 1);
                        }
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }

                difference() {
                    translate([10+2.3,0,6]) {
                        cube([2.1,1,5.3]);
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }
            }
        }
    }

    //solenoid
    translate([2,-21,-5.5]) {
        difference() {
            translate([0.9,5.4875,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d=4.5, h=22.2);
                }
            }
            translate([2,4.75,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d = 2.6, h = 24);
                }
            }
        }
        
        translate([2,4.75,2.35]) {
            rotate([90,0,90]) {
                cylinder(d = 2.6, h = 24);
            }
        }
        translate([26,4.75,2.35]) {
            rotate([90,0,90]) {
                cylinder(d1 = 2.6, d2 = 1, h = 2);
            }
        }
        translate([28,4.75,2.35]) {sphere(d=1);}
        translate([28,4.75,2.35]) {
            rotate([180,0,0]) {
                cylinder(d = 1, h = 1);
            }
        }
        
        translate([28,4.75,1.35]) {sphere(d=1);}
        translate([28,4.75,1.35]) {
            rotate([90,0,0]) {
                cylinder(d = 1, h = 0.5);
            }
        }
        
        translate([28,4.25,1.35]) {sphere(d=1);}
        translate([28,4.25,1.35]) {
            rotate([90,0,90]) {
                cylinder(d = 1, h = 4);
            }
        }
        
        translate([32,4.25,1.35]) {sphere(d=1);}
        translate([32,4.25,1.35]) {
            rotate([270,0,0]) {
                cylinder(d = 1, h = 3.5);
            }
        }

        difference() {
            cube([24,9.5,4.7]);
            translate([1.9,0.9,0]) {
                cube([20.2,7.5,4.7]);
            }
            translate([2,4.75,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d = 2.6, h = 24);
                }
            }
            
        }
        
        difference() {
            translate([14,0,-0.5]) {
                cube([8,3.2,0.9]);
            }
            translate([17.8,1.55,-0.6]) {
                cylinder(d = 1.5, h = 2);
            }
        }
    }

}

//rotorblatthalterung
rotate([0,0,180]) {
    translate([0,-servoWidth-3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.3]) {
        difference() {
            hull() {
                translate([-11.185,-1,-2.5]) {
                    cube([21.9,1,2.5]);
                }
                translate([-15,-26,-2.5]) {
                    cube([35,1,2.5]);
                }

                translate([-22,-14.3,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([-22,-26,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([32,-26,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([32,-13.6,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([27,-30,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([-17,-30,-0.4]) {
                    cube([1,1,0.4]);
                }
            }

            translate([-5,-3,-2]) {
                rotate([0,180,180]) {
                   // difference() {
                        translate([-0.25,1,0]) {
                            cube([10.5,5.25,1]);
                        }
                        translate([1.85,3.5,-4]) {
                            cylinder(d = 1.5, h = 6);
                        }
                        translate([8.05,3.5,-4]) {
                            cylinder(d = 1.5, h = 6);
                        }
                  //  }

                    difference() {
                        //hull() {
                            translate([-0.25,-0.3,0]) {
                                cube([10.5,1.3,2]);
                            }
                            translate([10+2.3,0,6]) {
                                cube([0.9,1,5.3]);
                            }
                       // }
                        translate([0,1.1,14.5]) {
                            rotate([90,0,0]) {
                                cylinder(d = 25, h = 1.5);
                            }
                        }
                    }

                    translate([10+3.22,1,11.1]) {
                        rotate([90,0,0]) {
                            cylinder(d = 2.39, h = 1);
                        }
                    }

                    translate([10+2.3,0,6]) {
                        cube([2.1,1,5.3]);
                    }
                }
            }



            translate([2,-21,-5]) {
                difference() {
                    translate([0.9,5.4875,2.35]) {
                        rotate([90,0,90]) {
                            //cylinder(d=4.5, h=22.2);
                        }
                    }
                    translate([2,4.75,2.35]) {
                        rotate([90,0,90]) {
                            //cylinder(d = 2.6, h = 24);
                        }
                    }
                }

                difference() {
                    cube([24,9.5,4.7]);
                    translate([1.9,0.9,0]) {
                        cube([20.2,2.25,4.7]);
                    }
                    translate([2,4.75,2.35]) {
                        rotate([90,0,90]) {
                           // cylinder(d = 2.6, h = 24);
                        }
                    }
                    
                }

                translate([0,9.5,0]) {
                        cube([1.9,1.7,4.7]);
                    }

                //difference() {
                    translate([14,0,-0.9]) {
                        cube([8,3.2,0.9]);
                    }
                    translate([17.8,1.55,2.3]) {
                        cylinder(d = 1.5, h = 2);
                    }
                //}
            }
            
            //translate([-(rotorWidth*0.40),-servoWidth,0]) {
                rotate([0,0,180]) {
                    translate([0,0,0]) {
                        translate([0,servoWidth-2,0]) {
                            rotate([90,0,0]) {
                             #  cylinder(h = 40, d = 3.2, $fn=100);
                            }
                        }
                    }
                }
            //}
        }
        
        //Ruderhorn
        translate([-5,-3,-2]) {
            rotate([0,180,180]) {
                difference() {
                    translate([0,1,0]) {
                        cube([10,5,1]);
                    }
                    translate([1.85,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                    translate([8.05,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                }

                difference() {
                    hull() {
                        cube([10,1,2]);
                        translate([10+2.3,0,6]) {
                            cube([0.9,1,5.3]);
                        }
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                    translate([0,1.1,14.5]) {
                        rotate([90,0,0]) {
                            cylinder(d = 25, h = 1.5);
                        }
                    }
                }

                translate([10+3.22,1,11.1]) {
                    difference() {
                        rotate([90,0,0]) {
                            cylinder(d = 2.39, h = 1);
                        }
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }

                difference() {
                    translate([10+2.3,0,6]) {
                        cube([2.1,1,5.3]);
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }
            }
        }

        //solenoid
    translate([2,-21,-5.5]) {
        difference() {
            translate([0.9,5.4875,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d=4.5, h=22.2);
                }
            }
            translate([2,4.75,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d = 2.6, h = 24);
                }
            }
        }
        
        translate([2,4.75,2.35]) {
            rotate([90,0,90]) {
                cylinder(d = 2.6, h = 24);
            }
        }
        translate([26,4.75,2.35]) {
            rotate([90,0,90]) {
                cylinder(d1 = 2.6, d2 = 1, h = 2);
            }
        }
        translate([28,4.75,2.35]) {sphere(d=1);}
        translate([28,4.75,2.35]) {
            rotate([180,0,0]) {
                cylinder(d = 1, h = 1);
            }
        }
        
        translate([28,4.75,1.35]) {sphere(d=1);}
        translate([28,4.75,1.35]) {
            rotate([90,0,0]) {
                cylinder(d = 1, h = 0.5);
            }
        }
        
        translate([28,4.25,1.35]) {sphere(d=1);}
        translate([28,4.25,1.35]) {
            rotate([90,0,90]) {
                cylinder(d = 1, h = 4);
            }
        }
        
        translate([32,4.25,1.35]) {sphere(d=1);}
        translate([32,4.25,1.35]) {
            rotate([270,0,0]) {
                cylinder(d = 1, h = 3.5);
            }
        }

        difference() {
            cube([24,9.5,4.7]);
            translate([1.9,0.9,0]) {
                cube([20.2,7.5,4.7]);
            }
            translate([2,4.75,2.35]) {
                rotate([90,0,90]) {
                    cylinder(d = 2.6, h = 24);
                }
            }
            
        }
        
        difference() {
            translate([14,0,-0.5]) {
                cube([8,3.2,0.9]);
            }
            translate([17.8,1.55,-0.6]) {
                cylinder(d = 1.5, h = 2);
            }
        }
    }

    }

    //rotorblatthalterung
    translate([0,-servoWidth-3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.3]) {
        difference() {
            hull() {
                translate([-11.185,-1,-2.5]) {
                    cube([21.9,1,2.5]);
                }
                translate([-15,-26,-2.5]) {
                    cube([35,1,2.5]);
                }

                translate([-22,-14.3,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([-22,-26,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([32,-26,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([32,-13.6,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([27,-30,-0.4]) {
                    cube([1,1,0.4]);
                }

                translate([-17,-30,-0.4]) {
                    cube([1,1,0.4]);
                }
            }

            translate([-5,-3,-2]) {
                rotate([0,180,180]) {
                   // difference() {
                        translate([-0.25,1,0]) {
                            cube([10.5,5.25,1]);
                        }
                        translate([1.85,3.5,-4]) {
                            cylinder(d = 1.5, h = 6);
                        }
                        translate([8.05,3.5,-4]) {
                            cylinder(d = 1.5, h = 6);
                        }
                  //  }

                    difference() {
                        //hull() {
                            translate([-0.25,-0.3,0]) {
                                cube([10.5,1.3,2]);
                            }
                            translate([10+2.3,0,6]) {
                                cube([0.9,1,5.3]);
                            }
                       // }
                        translate([0,1.1,14.5]) {
                            rotate([90,0,0]) {
                                cylinder(d = 25, h = 1.5);
                            }
                        }
                    }

                    translate([10+3.22,1,11.1]) {
                        rotate([90,0,0]) {
                            cylinder(d = 2.39, h = 1);
                        }
                    }

                    translate([10+2.3,0,6]) {
                        cube([2.1,1,5.3]);
                    }
                }
            }



            translate([2,-21,-5]) {
                difference() {
                    translate([0.9,5.4875,2.35]) {
                        rotate([90,0,90]) {
                            //cylinder(d=4.5, h=22.2);
                        }
                    }
                    translate([2,4.75,2.35]) {
                        rotate([90,0,90]) {
                            //cylinder(d = 2.6, h = 24);
                        }
                    }
                }

                difference() {
                    cube([24,9.5,4.7]);
                    translate([1.9,0.9,0]) {
                        cube([20.2,2.25,4.7]);
                    }
                    translate([2,4.75,2.35]) {
                        rotate([90,0,90]) {
                           // cylinder(d = 2.6, h = 24);
                        }
                    }
                    
                }

                translate([0,9.5,0]) {
                        cube([1.9,1.7,4.7]);
                    }

                //difference() {
                    translate([14,0,-0.9]) {
                        cube([8,3.2,0.9]);
                    }
                    translate([17.8,1.55,2.3]) {
                        cylinder(d = 1.5, h = 2);
                    }
                //}
            }
            
            //translate([-(rotorWidth*0.40),-servoWidth,0]) {
                rotate([0,0,180]) {
                    translate([0,0,0]) {
                        translate([0,servoWidth-2,0]) {
                            rotate([90,0,0]) {
                             #  cylinder(h = 40, d = 3.2, $fn=100);
                            }
                        }
                    }
                }
            //}
        }
        
        //Ruderhorn
        translate([-5,-3,-2]) {
            rotate([0,180,180]) {
                difference() {
                    translate([0,1,0]) {
                        cube([10,5,1]);
                    }
                    translate([1.85,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                    translate([8.05,3.5,0]) {
                        cylinder(d = 1.5, h = 2);
                    }
                }

                difference() {
                    hull() {
                        cube([10,1,2]);
                        translate([10+2.3,0,6]) {
                            cube([0.9,1,5.3]);
                        }
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                    translate([0,1.1,14.5]) {
                        rotate([90,0,0]) {
                            cylinder(d = 25, h = 1.5);
                        }
                    }
                }

                translate([10+3.22,1,11.1]) {
                    difference() {
                        rotate([90,0,0]) {
                            cylinder(d = 2.39, h = 1);
                        }
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }

                difference() {
                    translate([10+2.3,0,6]) {
                        cube([2.1,1,5.3]);
                    }
                    translate([10+3.22,1,11.1]) {
                        translate([0,1,0]) {
                            rotate([90,0,0]) {
                               cylinder(d = 0.8, h = 3);
                            }
                        }
                    }
                }
            }
        }

        //solenoid
        translate([2,-21,-5.5]) {
            difference() {
                translate([0.9,5.4875,2.35]) {
                    rotate([90,0,90]) {
                        cylinder(d=4.5, h=22.2);
                    }
                }
                translate([2,4.75,2.35]) {
                    rotate([90,0,90]) {
                        cylinder(d = 2.6, h = 24);
                    }
                }
            }

            difference() {
                cube([24,9.5,4.7]);
                translate([1.9,0.9,0]) {
                    cube([20.2,7.5,4.7]);
                }
                translate([2,4.75,2.35]) {
                    rotate([90,0,90]) {
                        cylinder(d = 2.6, h = 24);
                    }
                }
                
            }
            
            difference() {
                translate([14,0,-0.5]) {
                    cube([8,3.2,0.9]);
                }
                translate([17.8,1.55,-0.6]) {
                    cylinder(d = 1.5, h = 2);
                }
            }
        }
    }
}

//rotor2
rotate([0,0,180]) {
    difference() {
        translate([-(rotorWidth*0.40),-servoWidth- 3,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight/1.3]) {
            translate([0,6.34303,0]) {
                hull() {
                    foil(	1000*	0.00634303	,	1000*	0.010813	,	1000*	0.0219	    ,	100*	0.00761164	);
                    foil(	1000*	0.00761164	,	1000*	0.009675	,	1000*	0.0243	    ,	100*	0.00888024	);
                    foil(	1000*	0.00888024	,	1000*	0.0086	    ,	1000*	0.0272	    ,	100*	0.0101488	);
                    foil(	1000*	0.0101488	,	1000*	0.0076	    ,	1000*	0.0301	    ,	100*	0.0152233	);
                    foil(	1000*	0.0152233	,	1000*	0.00355	    ,	1000*	0.0445	    ,	100*	0.0164919	);
                    foil(	1000*	0.0164919	,	1000*	0.002533	,	1000*	0.04832	    ,	100*	0.0177605	);
                    foil(	1000*	0.0177605	,	1000*	0.001475	,	1000*	0.0516	    ,	100*	0.0190291	);
                    foil(	1000*	0.0190291	,	1000*	0.0005	    ,	1000*	0.053937	,	100*	0.0202977	);
                    foil(	1000*	0.0202977	,	1000*	0	        ,	1000*	0.055	    ,	100*	0.224019	);
                    foil(	1000*	0.224019	,	1000*	0	        ,	1000*	0.055	    ,	100*	0.227571	);
                    foil(	1000*	0.227571	,	1000*	0.0008	    ,	1000*	0.0542	    ,	100*	0.232138	);
                    foil(	1000*	0.232138	,	1000*	0.003	    ,	1000*	0.052	    ,	100*	0.23569	    );
                    foil(	1000*	0.23569	    ,	1000*	0.006	    ,	1000*	0.049	    ,	100*	0.238227	);
                    foil(	1000*	0.238227	,	1000*	0.01	    ,	1000*	0.0445	    ,	100*	0.241272	);
                    foil(	1000*	0.241272	,	1000*	0.015	    ,  	1000*	0.039	    ,	100*	0.244114	);
                    foil(	1000*	0.244114	,	1000*	0.021	    ,	1000*	0.032	    ,	100*	0.247564	);
                    foil(	1000*	0.247564	,	1000*	0.0305	    ,	1000*	0.0205	    ,	100*	0.249239	);
                    foil(	1000*	0.249239	,	1000*	0.03725	    ,	1000*	0.0117	    ,	100*	0.25	    );
                    foil(	1000*	0.25	    ,	1000*	0.044	    ,	1000*	0.003	    ,	100*	0.248	    );
                }
            }
            //flap1
            translate([-13,215,0]) {
                rotate([0,-3,0]) {
                    flap();
                }
            }
            translate([-12.5,72,0]) { 
                rotate([-90,0,0]) {
                    cylinder(d=0.9,h=245);
                }
            }
            translate([-12.5,74,0]) {
                rotate([90,90,0]) {
                    solenoidArm();
                }
            }
        }
        rotate([0,0,180]) {
            translate([0,0,servoDepth+pcbHeight+spaceUnderPCB+2]) {
                translate([0,servoWidth-2,mountPlateHeight/2]) {
                    translate([0,32,0]) {
                        rotate([90,0,0]) {
                           cylinder(h = 40, d = 3.1, $fn=100);
                        }
                    }
                }
            }
        }
    }
}


//motorMount1
translate([motorArmLength/2+21,0,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness/2]) {
    rotate([0,-90,90]) {
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
    rotate([0,-90,-90]) {
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

//prop1
translate([motorArmLength/2+21,-17,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness/2]) {
    translate([0,0.4,0]) {
        rotate([180,-35,0]) {
            prop();
        }
    }
    translate([0,17,0]) {
        rotate([90,0,0]) {
            motor();
        }
    }
}

//prop2
translate([-motorArmLength/2-21,15,servoDepth+pcbHeight+spaceUnderPCB+mountPlateHeight+2-motorArmThickness/2]) {
    translate([0,0.4,0]) {
        rotate([0,15,0]) {
            prop();
        }
    }
    translate([0,-16,0]) {
        rotate([90,0,180]) {
            motor();
        }
    }
}