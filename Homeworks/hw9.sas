libname hw9 "C:\723\Class 9\HW9";
run;
proc means data=hw9.y6_hw9 n nmiss;
run;
proc print data=hw9.y6_hw9;
run;

data hw9_2;
set hw9.y6_hw9;
bmi= (y6e2/y6e3)*703;
if y6_bmiz1 = . then childobese=.;
else if y6_bmiz1>=2 then childobese=1;
else if y6_bmiz1<2 then childobese=0;
if y6_haz1=. then childmal =.;
else if y6_haz1 >0 then childmal=1;
else if y6_haz1<=0 then childmal=0;
run;
proc print data=hw9_2;
var childmal y6_haz1;
run;

proc gchart data= hw9_2;
vbar bmi;
title "Histogram of Mother's BMI";
run;

proc corr data=hw9_2  spearman fisher;
	var bmi y6_haz1 ;
	title "Spearman Correlation between Child’s Z-score of BMI-for-age and Mother's BMI";
	run;

proc reg data=hw9_2 plots;
model bmi=y6c5 /clb;
run;

proc logistic data=hw9_2 descending;
class childmal (param=ref ref='0');
model childmal=bmi;
run;

