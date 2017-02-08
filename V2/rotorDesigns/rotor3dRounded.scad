module foil(translateY, translateX, x, foilLength) {
    translate([translateX,-translateY,0]) {
        rotate([90,0,0]) {   
            linear_extrude(foilLength) {
                polygon(points=[
                    [	x*	1.00000	,	x*	0.00000	]	,
                     [	x*	1.00000	,	x*	0.01500	]	,
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
                    [	x*	0.01053	,	x*	0.02665	]	,
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

module foilTip(translateY, translateX, x, foilLength) {
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
                    [	x*	0.01053	,	x*	0.02665	]	,
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
translate([0,6.34303,0]) {
    hull() {
        foil(	1000*	0.00634303	,	1000*	0.010813	,	1000*	0.0219	,	100*	0.00761164	);
        foil(	1000*	0.00761164	,	1000*	0.009675	,	1000*	0.0243	,	100*	0.00888024	);
        foil(	1000*	0.00888024	,	1000*	0.0086	,	1000*	0.0272	,	100*	0.0101488	);
        foil(	1000*	0.0101488	,	1000*	0.0076	,	1000*	0.0301	,	100*	0.0152233	);
        foil(	1000*	0.0152233	,	1000*	0.00355	,	1000*	0.0445	,	100*	0.0164919	);
        foil(	1000*	0.0164919	,	1000*	0.002533	,	1000*	0.04832	,	100*	0.0177605	);
        foil(	1000*	0.0177605	,	1000*	0.001475	,	1000*	0.0516	,	100*	0.0190291	);
        foil(	1000*	0.0190291	,	1000*	0.0005	,	1000*	0.053937	,	100*	0.0202977	);
        foil(	1000*	0.0202977	,	1000*	0	,	1000*	0.055	,	100*	0.224019	);
        foil(	1000*	0.224019	,	1000*	0	,	1000*	0.055	,	100*	0.227571	);
        foil(	1000*	0.227571	,	1000*	0.0008	,	1000*	0.0542	,	100*	0.232138	);
        foil(	1000*	0.232138	,	1000*	0.003	,	1000*	0.052	,	100*	0.23569	);
        foil(	1000*	0.23569	,	1000*	0.006	,	1000*	0.049	,	100*	0.238227	);
        foilTip(	1000*	0.238227	,	1000*	0.01	,	1000*	0.0445	,	100*	0.241272	);
        foilTip(	1000*	0.241272	,	1000*	0.015	,	1000*	0.039	,	100*	0.244114	);
        foilTip(	1000*	0.244114	,	1000*	0.021	,	1000*	0.032	,	100*	0.247564	);
        foilTip(	1000*	0.247564	,	1000*	0.0305	,	1000*	0.0205	,	100*	0.249239	);
        foilTip(	1000*	0.249239	,	1000*	0.03725	,	1000*	0.0117	,	100*	0.25	);
        foilTip(	1000*	0.25	,	1000*	0.044	,	1000*	0.003	,	100*	0.248	);
    }
}