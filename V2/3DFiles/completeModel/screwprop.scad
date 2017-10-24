

module screwprop(radius, inside_radius, pitch, chord)
{
rad_res = 25;
chord_res = 25;
chord_cmass = 40;  // As a percent of cord, specifies the center of mass of the section.
thick_cmass = 5;   // As a percent of chord, specifies the center of mass of the section.

// Describes the upper surface as a percent of chord
function top_foil(p) = lookup(p, [
		[0, 0 ],
		[1.25, .04 ],
		[2.5, .0579],
		[5, .082],
		[7.5, .1 ],
            [10, .1138],
            [15, .13],
            [20, .1385],
            [25, .1429],
            [30, .1418],
            [35, .1384],
            [40, .1321],
            [50, .1129],
            [60, .0894],
            [70, .0622],
            [80, .0378],
            [90, .0157],
            [100, 0] 
	]);

// Describes the lower surface as a percent of chort
function bottom_foil(p) = lookup(p, [
		[0,0 ],
		[5, -.03 ],
		[10, -.04 ],
		[ 50, -.03 ],
		[ 100, 0 ]
	]);

// Modifies chord as a function of radius
function chord_modifier(p) = lookup(p, [
		[0, 1 ],
    [50, 1],
		[100, .6]
	]);  
	
// Modifies thickness as a function of radius
function thick_modifier(p) = lookup(p, [
		[0, 2 ],
            [50, 1],
		[100, 1]
	]); 
	 
// Angle of attack as a function of radius
function attack_modifier(p) = lookup(p, [
		[0, 0 ],
            [50, 0],
		[100, 0]
	]); 

// Internal variables
// First inside vars, scaled
x1=0; x2=0; // x must be slow axis
y11=0; y12=0;  y21=0; y22=0;
z11t=0; z12t=0;  z21t=0; z22t=0;
z11b=0; z12b=0;  z21b=0; z22b=0;
xtable1 = 0; xtable2 = 0;  // for table look up
ytable1 = 0; ytable2 = 0;  // for table look up
zoffset1 = 0; zoffset2 = 0;   // For center of mass adjustment

// First inside vars, scaled
ang1 = 0; ang2 = 0;

// Third inside vars
cos1 = 0; cos2 = 0; sin1 = 0; sin2 = 0;

// Forth inside vars
p0  = [0,0,0]; p1 = [0,0,0];p2  = [0,0,0]; p3 = [0,0,0];
p4  = [0,0,0]; p5 = [0,0,0];p6  = [0,0,0]; p7 = [0,0,0];

for ( x = [0:rad_res-1], y = [0:chord_res-1]) {
assign(    x1 = inside_radius+(radius - inside_radius)*(x/(rad_res)), 
           x2 =  inside_radius+(radius - inside_radius)*((x+1)/(rad_res))){

assign(    xtable1 = x1 *100  / radius,
           xtable2 = x2 *100  /radius,
           ytable1 = y*100/chord_res,
           ytable2 = (y+1)*100/chord_res){

assign(    ang1 = atan(x1*3.14159*2/pitch) - attack_modifier(xtable1), 
           ang2 = atan(x2*3.14159*2/pitch) - attack_modifier(xtable2),
           zoffset1 = -chord*thick_cmass*chord_modifier(xtable1)* thick_modifier(xtable1)/100,
           zoffset2 =- chord*thick_cmass*chord_modifier(xtable2)* thick_modifier(xtable2)/100){
           
assign(    cos1 = cos(ang1), cos2 = cos(ang2), 
           sin1 = sin(ang1), sin2 = sin(ang2),
           y11=chord_cmass*chord*chord_modifier(xtable1)/100 -  y*chord*chord_modifier(xtable1)/chord_res,
           y12=chord_cmass*chord*chord_modifier(xtable1)/100 - (y+1)*chord*chord_modifier(xtable1)/chord_res,
           y21=chord_cmass*chord*chord_modifier(xtable2)/100 -  y*chord*chord_modifier(xtable2)/chord_res, 
           y22=chord_cmass*chord*chord_modifier(xtable2)/100  - (y+1)*chord*chord_modifier(xtable2)/chord_res,
           z11t = zoffset1 + chord*chord_modifier(xtable1)*top_foil(ytable1)* thick_modifier(xtable1),
           z12t = zoffset1 + chord*chord_modifier(xtable1)*top_foil(ytable2)* thick_modifier(xtable1),
           z21t = zoffset2 + chord*chord_modifier(xtable2)*top_foil(ytable1)* thick_modifier(xtable2),
           z22t = zoffset2 + chord*chord_modifier(xtable2)*top_foil(ytable2)* thick_modifier(xtable2),          
           z11b = zoffset1 + chord*chord_modifier(xtable1)*bottom_foil(ytable1)* thick_modifier(xtable1),
           z12b = zoffset1 + chord*chord_modifier(xtable1)*bottom_foil(ytable2)* thick_modifier(xtable1),
           z21b = zoffset2 + chord*chord_modifier(xtable2)*bottom_foil(ytable1)* thick_modifier(xtable2),
           z22b = zoffset2 + chord*chord_modifier(xtable2)*bottom_foil(ytable2)* thick_modifier(xtable2)){

assign(   // rotational transform
           p0 = [x1, y11*cos1 + z11t*sin1, z11t*cos1 - y11*sin1],
           p1 = [x1, y12*cos1 + z12t*sin1, z12t*cos1 - y12*sin1],
           p2 = [x1, y11*cos1 + z11b*sin1, z11b*cos1 - y11*sin1],
           p3 = [x1, y12*cos1 + z12b*sin1, z12b*cos1 - y12*sin1],
           p4 = [x2, y21*cos2 + z21t*sin2, z21t*cos2 - y21*sin2],
           p5 = [x2, y22*cos2 + z22t*sin2, z22t*cos2 - y22*sin2],
           p6 = [x2, y21*cos2 + z21b*sin2, z21b*cos2 - y21*sin2],
           p7 = [x2, y22*cos2 + z22b*sin2, z22b*cos2 - y22*sin2]
){  
if(x == 0) {

    polyhedron
    (points = [p0, p1, p2, p3, p4, p5, p6, p7],
     triangles =  [
                 [0,1,2],  [2,1,3],  // inside endcap
            //    [4,6,5], [5,6,7],  // outside endcap
            //      [0,2,4],[2,4,6],[1,5,3],[7,5,3],    // interiors, not used ever
                    [0,4,5],[1,0,5],[2,3,6],[6,3,7]   // main surfaces
                  ]
     );  // end poly

} else{

  if(x==rad_res-1) {

    polyhedron
    (points = [p0, p1, p2, p3, p4, p5, p6, p7],
     triangles =  [
             //    [0,1,2],  [2,1,3],  // inside endcap
                [4,6,5], [5,6,7],  // outside endcap
            //      [0,2,4],[2,4,6],[1,5,3],[7,5,3],    // interiors, not used ever
                    [0,4,5],[1,0,5],[2,3,6],[6,3,7]   // main surfaces
                  ]
     );  // end poly

} else {

    polyhedron
    (points = [p0, p1, p2, p3, p4, p5, p6, p7],
     triangles =  [
             //    [0,1,2],  [2,1,3],  // inside endcap
            //    [4,6,5], [5,6,7],  // outside endcap
            //      [0,2,4],[2,4,6],[1,5,3],[7,5,3],    // interiors, not used ever
                    [0,4,5],[1,0,5],[2,3,6],[6,3,7]   // main surfaces
                  ]
     );  // end poly

  }
}

  }  // end assign
  }  // end assign
  }  // end assign
  }  // end assign
  }  // end assign  
};  // end for


};   // end module


////////////////////////////////
////////////////////////////////

   //   screwprop(12, 3, 20, 2.5);