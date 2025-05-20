libname hw6 "C:\723\Class 6\HW6";
proc format;
	value sitef 0="Gym" 1="YMCA" 2="School Grounds";
	value methodf 0="Recorded audio" 1="in-person instruction";
run;

data fitness2;
	set hw6.fitness;
	format site sitef. method methodf.;
	if Physical_Fitness_Score >= 70 then pass_test = 1;
	else if Physical_Fitness_Score < 70 then pass_test =2;
run;

proc freq data=fitness2;
	tables pass_test / binomial (p=0.75);
	run;

proc freq data=fitness2;
tables method*pass_test / chisq expected measures nocol nopercent;
run;


