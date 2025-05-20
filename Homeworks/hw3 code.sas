proc format;
	value  ynf 0="No"
			 	1 = "Yes";
	value trtf 0="Placebo"
				1= "Beta blocker";
	value sbpf 1 = "Normal"
				2="Elevated"
				3="Stage 1 hypertension"
				4="Stage 2 hypertension";
	value $trialf 'M'='Main'
					'A'='Ancillary';
	run;


libname hw3 "C:\723\Class 3\Hw3";
data beta_temp;
set hw3.beta_blockers_hw3;
	if age >=65 then age65=1;
	else if age < 65 then age65=0;
	if lvef <= 45 then trial="M";
	else if lvef > 45 then trial="A";
label age65='Age 65+ years'
		trt = 'Randomization Group';
format age65 mi diab htn death ynf. trt trtf. trial $trialf. sbp_cat sbpf.;
run;


proc sort data = beta_temp;
	by age65;
	run;
proc univariate data=beta_temp;
var creat; 
histogram creat;
by age65;
run;
proc sort data=beta_temp;
by trt;
run;
proc means data =beta_temp;
var age hfduration trt;
by trt;
run;
proc means data =beta_temp;
var age hfduration trt;
run; 
proc freq data=beta_temp;
table sbp_cat death;
run;
proc freq data=beta_temp;
table sbp_cat death;
by trt;
run;

data hw3.beta_main;
set beta_temp;
if trial = "M";
keep id trt age sex lvef hfduration_y death;
run;

data hw3.beta_ancillary;
set beta_temp;
if trial = "A";
keep id trt age sex lvef hfduration_y death;
run;
