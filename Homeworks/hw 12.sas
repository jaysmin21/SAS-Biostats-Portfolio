libname hw12 "C:\723\Class 12";
run;


proc sort data=hw12.bone_dem2025; by id; run;
proc sort data=hw12.bone_out2025; by id; run;
proc format ;
value female_sexf 0="Male" 1="Female";
value smokerf 0="No" 1="Yes";
value osteoporosisf 0="No" 1="Yes";
value HX_fracturef 0="No" 1="Yes";
value $regionf 'w'="West" 'm'="Midwest" 'n'="Northeast" 's'="South";
value bmigrpf 0="Underweight" 1="Normal" 2="Overweight" 3="Obese";
run;
data merged;
merge hw12.bone_dem2025 hw12.bone_out2025;
by id;

Region = substr(ID, 1, 1);
   if BMI < 18.5 then BMIGRP = 0;
    else if 18.5 <= BMI < 25 then BMIGRP = 1;
    else if 25 <= BMI < 30 then BMIGRP = 2;
    else if BMI >= 30 then BMIGRP = 3;
	    if BMIGRP = . or SBP = . or DBP = . then delete;
	format female_sex female_sexf. smoker smokerf. osteoporosis osteoporosisf. HX_fracture HX_fracturef. region $regionf. bmigrp bmigrpf. date date7.;
	run;

	proc print data=merged (obs=25);
	run;
proc means data=merged n min q1 median q3 max;
var SBP;
run;
	data merged2;
	set merged;
	if 0<=sbp<126 then quart_sbp=1;
	else if 126<=sbp<142 then quart_sbp=2;
	else if 142<=sbp<159 then quart_sbp=3;
	else if 159<=sbp<175 then quart_sbp=4;
	run;

	proc print data=merged2 (obs =20);
	var id region date age bmi bmigrp sbp quart_sbp;
	run;
proc freq data=merged2;
tables hx_fracture*bmigrp/chisq;
run;

proc corr data=merged2 pearson fisher;
var femur_bmd sbp;
run;


proc anova data=merged2;
class quart_sbp;
model femur_bmd=quart_sbp;
means quart_sbp;
run;


