title "SAS HW#1 - Jay Sminchak";
proc import out=beta_temp
	datafile="C:\723\Class 1\HW\beta_blockers_HW1HW2.csv"
	DBMS=csv replace;
	getnames=yes;
	run;

title1 "Beta Blockers Dataset, Obs 1-10";
proc print data=work.beta_temp (obs=10);
	var id trt sex death;
	run;
proc means data=work.beta_temp n mean std median min max;
	var age sbp;
	run;


