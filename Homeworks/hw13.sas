libname hw13 "C:\723\Class 13";
run;

proc import out=hw13.student
datafile="C:\723\Class 13\StudentsPerformance2025.csv"
dbms=csv replace;
getnames=yes;
run;

proc univariate data=hw13.student mu0=60 normal plot;
var math;


run;

proc sort data=hw13.student;
by preparation;
run; 

proc univariate data=hw13.student normal plots;
by preparation;
var math;
run;

proc npar1way data=hw13.student wilcoxon;
	class preparation;
	var math;
	exact wilcoxon;
	run;

proc sort data=hw13.student;
by parentEDU;
run; 
proc npar1way data=hw13.student wilcoxon;
	class parentedu;
	var math;
	run;

proc means data=hw13.student n median;
class parentedu;
var math;
run;


