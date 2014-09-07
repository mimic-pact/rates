-- this creates a view which filters out only the first ICU stays
-- for "subjects" 
CREATE VIEW "USER7"."ICU_FIRST_STAY2" ( "ICUSTAY_ID",
     "SUBJECT_ID",
     "INTIME",
     "OUTTIME",
     "LOS",
     "FIRST_CAREUNIT",
     "LAST_CAREUNIT" ) AS SELECT
     "ICUSTAY_ID" ,
     "SUBJECT_ID" ,
     "INTIME" ,
     "OUTTIME" ,
     "LOS" ,
     "FIRST_CAREUNIT" ,
     "LAST_CAREUNIT" 
from "MIMIC2V26"."icustayevents" 
where "INTIME" in (select
     min("INTIME") 
    from "MIMIC2V26"."icustayevents" 
    group by "SUBJECT_ID") 
order by "SUBJECT_ID"
