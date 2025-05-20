libname hw5 "C:\723\Class 5\hw5";
proc sort data=hw5.glucose;
by city;
run;
proc means data=hw5.glucose;
var glucoselevelafter;
by city;
run;

proc ttest data=hw5.glucose;
class city;
var glucoselevelafter;
run;

data glucose2;
set hw5.glucose;
glucosediff= (glucoselevelafter - glucoselevelbefore);
run;

proc sort data=glucose2;
by GlucoseMonitorType;
run;
proc boxplot data=glucose2;
title 'Boxplot of the Change in Glucose by Monitoring Device';
plot glucosediff*GlucoseMonitorType / cboxes=black;
run;

proc ttest data=glucose2;
class GlucoseMonitorType;
var glucosediff;
run;
