proc import out=zambia_anthro_SAS
	datafile= "C:\723\Project 1\Zambia_anthro.csv"
	dbms=csv replace;
	getnames=yes;
	run;

libname project1 "C:\723\Project 1";
run;
proc means data=zambia_anthro_SAS n nmiss;
run;
proc print data=zambia_anthro_SAS;
run;
proc format;
	value V024f 1 = "Central"
2 = "Copperbelt"
3 = "Eastern"
4 = "Luapula"
5 = "Lusaka"
6 = "Muchinga"
7 = "Northern"
8 = "North Western"
9 = "Southern"
10= "Western";
value V025f 1 = 'Urban'
2 = 'Rural';
value v106f 0 = 'No education'
1 = 'Primary'
2 = 'Secondary'
3 = 'Higher';
value v190af 1 = 'Poorest'
2 = 'Poorer'
3 = 'Middle'
4 = 'Richer'
5 = 'Richest';
value v463af 0='no' 1='yes';
value _flenf 1 = "_ZLEN Value <-6, > 6, or missing"
0 = "-6<_ZLEN Value<6";
value sexf 1="male" 2="female";
value size_birthf 1 = 'Very small'
2 = 'Small'
3 = 'Average'
4 = 'Large'
5 = 'Very large';
value maternal_agecatf 1= '15-18' 
2 = '19-24' 3='25-34' 4='35 and older';
value child_agecatf 1='<6' 2='6=11' 3='12-17' 4='18-23'
5='24-35' 6='36-47' 7='48-59';
value size_birth_recf 1='very small' 2='small' 3='average or larger';
run;

data project1.zambia_anthro;
	set zambia_anthro_SAS;
if _zlen eq 999 then _zlen=.;
if age = 99 then age = .;
if height = 999 then height=.;
if size_birth=8 then size_birth=.;
if weight = 999 then weight = .;

if v012 = . then maternal_agecat =.;
else if 15<=v012<=18 then maternal_agecat = 1;
else if 19<=v012<=24 then maternal_agecat = 2;
else if 25 <=v012<=34 then maternal_agecat =3;
else if v012>= 35 then maternal_agecat =4;

if age = . then child_agecat=.;
else if age<6 then child_agecat=1;
else if 6<=age<=11 then child_agecat=2;
else if 12<=age<=17 then child_agecat=3;
else if 18<=age<=23 then child_agecat=4;
else if 24<=age<=35 then child_agecat=5;
else if 36<=age<=47 then child_agecat= 6;
else if 48<=age<=59 then child_agecat=7;

if size_birth = 1 then size_birth_rec=1;
else if size_birth = 2 then size_birth_rec= 2;
else if size_birth = 3 or size_birth=4 or size_birth=5 then size_birth_rec= 3;

if _zlen = . then severe_stunting = .;
else if _zlen <-2 then severe_stunting =1;
else if _zlen >= -2 then severe_stunting =2;

if _zlen =. then very_severe_stunting=.;
else if _zlen <-3 then very_severe_stunting=1;
else if _zlen >= -3 then very_severe_stunting=2;

label caseid='Case Identification (Mothers ID)'
	v012="Mother's age in years"
	v024='Province'
	v025= 'Type of place of residence (urban/rural)'
	v106="Mother's highest educational level"
	v190a='Household wealth index'
	v463a='Mother smokes cigarettes'
	_flen='Flag for _ZLEN<-6 or _ZLEN>6'
	_zlen='Length/height-for-age z-score'
	age ='Age of child in months'
	sex = 'Sex of child'
	size_birth='Size of child at birth'
	weight='Weight of child in kilograms'
	maternal_agecat="Materal age category"
	child_agecat="Child age category"
	size_birth_rec="Size of child at birth recommendation"
	severe_stunting="severe stunting"
	very_severe_stunting="very severe stunting";
format V024 V024f. V025 V025f. v106 v106f. v190a v190af.
v463a v463af. _flen _flenf. sex sexf. size_birth size_birthf.
maternal_agecat maternal_agecatf. child_agecat child_agecatf. 
size_birth_rec size_birth_recf.;
if age = . then delete;
if height=. then delete;
if weight=. then delete;
if _zlen=. then delete;
if _flen=1 then delete;
run;
proc print data = project1.zambia_anthro label;
run;

proc means data= project1.zambia_anthro;
	var v012 age _zlen;
	run;
proc freq data= project1.zambia_anthro;
	tables  severe_stunting very_severe_stunting maternal_agecat 
		v024 v025 v106 v190a v463a child_agecat sex;
		run;

proc ttest data=project1.zambia_anthro;
	class severe_stunting;
	var v012 age;
run;

proc freq data = project1.zambia_anthro;
	tables severe_stunting*(v024 v025 v106 v190a v463a sex)/chisq nocol nopercent;
	run;
