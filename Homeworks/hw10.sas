libname hw10 "C:\723\Class 10\HW 10";
run;

proc print data=hw10.jhs_hw10;
run;

proc glm data=hw10.jhs_hw10;
class edu3cat(ref="High school graduate/GED") sex (ref="Male") currentsmoker (ref="No");
model bmi = edu3cat activeindex sex age currentsmoker sbp/solution clparm;
means sex;
lsmeans sex/stderr;
run;

proc ttest data=hw10.jhs_hw10;
class sex;
var bmi;
run;
