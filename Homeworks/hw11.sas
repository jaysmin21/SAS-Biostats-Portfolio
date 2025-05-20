proc import out=hw_11
datafile="C:\723\Class 11\HW 11\hw11_nhanes2018_spr2025.csv"
dbms=csv replace;
getnames=yes;
run;

libname hw11 "C:\723\Class 11\HW 11";
run;

proc print data=hw_11;
run;

proc reg data=hw_11;
model BMI=smoker;
run;

proc reg data=hw_11;
model hsCRP=smoker;
run;

proc reg data=hw_11;
model hscrp=bmi;
run;

proc reg data=hw_11;
model hscrp=smoker bmi;
run;

data hw11.hw_11_new;
set hw_11;
bmi_smoke=bmi*smoker;
run;

proc reg data=hw11.hw_11_new;
model hscrp=female_sex age bmi smoker bmi_smoke;
run;

proc sort data=hw11.hw_11_new;
by smoker;
run;

proc reg data=hw11.hw_11_new;
by smoker;
model hscrp=bmi female_sex age;
run;

proc means data=hw11.hw_11_new n nmiss;
var hscrp;
run;



data hw_new;
set hw11.hw_11_new;
length sug_cat $15;
if sugar <= 25 then sug_cat="low";
else if 26<=sugar<=50 then sug_cat="moderate";
else if 51<=sugar<=75 then sug_cat="High";
else if sugar>75 then sug_cat="very high";

if hscrp <1 then loCRP=1;
else if hsCRP >=1 then loCRP = 0; 
run;

proc print data=hw_new;
var hscrp locrp;
run;

proc logistic data=hw_new descending;
class sug_cat (ref="low")/param=ref;
model locrp= sug_cat;
run;



proc logistic data=hw_new descending;
class sug_cat (ref="low") female_sex /param=ref;
model locrp= sug_cat female_sex bmi age;
run;


proc freq data=hw_new;
tables sug_cat sugar;
run;
