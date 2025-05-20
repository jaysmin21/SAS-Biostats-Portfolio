proc import out=hw7_nhanes2018_spr_SAS
	datafile= "C:\723\Class 7\hw7\hw7_nhanes2018_spr2025.csv"
	dbms=csv replace;
	getnames=yes;
	run;
libname hw7 "C:\723\Class 7\hw7";
run;

data hw7.nhanes7;
LENGTH crp_grp $ 12;
	set hw7_nhanes2018_spr_SAS;
if hscrp <1 then crp_grp="Low";
	else if 1<=hscrp<3 then crp_grp="Intermediate";
	else if hscrp>=3 then crp_grp="High";
lgSBP=log(SBP);
run;

proc print data= hw7.nhanes7;
var hscrp crp_grp sbp lgsbp;
run;

proc means data=hw7.nhanes7 n min max mean std;
    var SBP hsCRP;
    class female_sex;
run;


proc freq data=hw7.nhanes7;
tables (smoker crp_grp)*female_sex/nocol nopercent;
run;

proc sort data=hw7.nhanes7;
	by crp_grp;
run;
proc boxplot data=hw7.nhanes7;
	plot lgsbp*crp_grp/boxconnect;
	run;
proc anova data=hw7.nhanes7;
	class crp_grp;
	model lgsbp=crp_grp;
	means crp_grp / tukey cldiff;
	run;
