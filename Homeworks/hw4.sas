proc gchart data=TMP1.cvl24;
vbar vaginal_ph_2;
title "Vaginal pH for all Participants at Baseline";
run;

proc means data=TMP1.cvl24;
var vaginal_ph_2;
run;

proc ttest data=TMP1.cvl24 h0=4 alpha=.05;
var vaginal_ph_2;
run;

proc means data=TMP1.cvl24;
var nugent_scores_2 nugent_scores_4;
run;

proc ttest data=TMP1.cvl24;
paired nugent_scores_4*nugent_scores_2;
run;
