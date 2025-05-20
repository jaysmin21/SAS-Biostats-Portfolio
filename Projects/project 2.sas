libname proj2 "C:\723\Project 2";
run;
proc print data=proj2.zambia_anthro_project2;
run;

proc means data=proj2.zambia_anthro_project2;
class V190A;
var V012 Age;
run;

proc anova data=proj2.zambia_anthro_project2;
class V190A;
model V012 age=V190A;
means V190A;
run;

proc freq data=proj2.zambia_anthro_project2;
tables V190A*v024/chisq nocol nopercent;
run;
proc freq data=proj2.zambia_anthro_project2;
tables V190A*v025/chisq nocol nopercent;
run;
proc freq data=proj2.zambia_anthro_project2;
tables V190A*v106/chisq nocol nopercent;
run;
proc freq data=proj2.zambia_anthro_project2;
tables V190A*sex/chisq nocol nopercent;
run;
proc freq data=proj2.zambia_anthro_project2;
tables V190A*size_birth_rec/chisq nocol nopercent;
run;

proc glm data=proj2.zambia_anthro_project2 ;
	class v190a (ref='Middle') v024 (ref='Lusaka') v025 (ref='Rural') v106 (ref='Secondary') sex (ref='Male') size_birth_rec (ref='Average and larger');
model _ZLEN = V190A v024 v025 v106 sex size_birth_rec v012 age / solution clparm;
run;

proc glm data=proj2.zambia_anthro_project2 plots(maxpoints=none)=diagnostics (unpack);
	class v190a (ref='Middle');
model _ZLEN = V190A / solution clparm;
run;

proc logistic data=proj2.zambia_anthro_project2 descending;
	class v190a (ref='Middle') v024 (ref='Lusaka') v025 (ref='Rural') v106 (ref='Secondary') sex (ref='Male') size_birth_rec (ref='Average and larger')/ param=ref;
model Severe_stunting = V190A v024 v025 v106 sex size_birth_rec v012 age ;
run;

proc glm data=proj2.zambia_anthro_project2 ;
	by v025;
class v190a (ref='Middle') v024 (ref='Lusaka') v106 (ref='Secondary') size_birth_rec (ref='Average and larger');
model _ZLEN = V190A v024 v106 size_birth_rec v012 age / solution clparm;
run;

