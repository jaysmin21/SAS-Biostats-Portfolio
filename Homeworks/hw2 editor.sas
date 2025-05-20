libname hw2 "C:\723\Class 2\HW2";
run;
proc import out=hw2.betahw2
	datafile="C:\723\Class 2\beta_blockers_HW1HW2.csv"
	DBMS=csv replace;
	getnames=yes;
	run;

data beta_v2;
	set hw2.betahw2;
if hfduration =9999 then hfduration= .;
	if nyha = -9 then nyha = .;
	if mi = -9 then mi=.;
	if diab =-9 then diab= .;
	if htn = -9 then htn = .;
if sex = "F" then sex_char=1;
	else sex_char=0;
if sbp = . then sbp_cat=.;
	else if sbp <120 then sbp_cat=1;
	else if 120<=sbp<=129 then sbp_cat=2;
	else if 130<=sbp<=139 then sbp_cat=3;
	else if sbp>=140 then sbp_cat=4;
hfduration_y= hfduration/12;
run;


proc print data = beta_v2;
run;

proc means data=beta_v2 n nmiss median q1 q3;
	var lvef bmi hfduration_y;
	run;
data hw2.beta_final;
	set beta_v2;
	run;
