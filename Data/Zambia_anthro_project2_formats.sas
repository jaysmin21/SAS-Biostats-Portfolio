*SAS Formats associated with Zambia_anthro_project2;

proc format;
  value province 1 = "Central"
                  2 = "Copperbelt"
                  3 = "Eastern"
                  4 = "Luapula"
                  5 = "Lusaka"
                  6 = "Muchinga"
                  7 = "Northern"
                  8 = "North Western"
                  9 = "Southern"
                  10 = "Western"
  ;
  value place 1 = "Urban"
               2 = "Rural"
  ;
  value educ 0 = "None"
              1 = "Primary"
              2 = "Secondary"
              3 = "Higher"
  ;
  value wealth 1 = "Poorest"
                2 = "Poorer"
                3 = "Middle"
                4 = "Richer"
                5 = "Richest"
  ;
  value smoker 0 = "No"
                1 = "Yes"
  ;
  value size_rec 1 = "Very small"
              2 = "Small"
              3 = "Average and larger"
  ;
  value sex 1 = "Male"
            2 = "Female"
  ;
  value child_age 1 = "<6"
                  2 = "6-11"
                  3 = "12-17"
                  4 = "18-23"
                  5 = "24-35"
                  6 = "36-47"
                  7 = "48-59"
  ;
  value mother_age 1 = "15-18"
                   2 = "19-24"
                   3 = "25-34"
                   4 = "35 and older"
  ;
  value stunted 1 = "Yes"
                2 = "No"
  ;
run;