------------------------
-- QUESTION: What factors may pre-dispose to CDIFF risk?
-- QUESTION: What is appropriate treatment?
-- QUESTION: What is likelihood and predictors of recurrence?


-- start by getting the patient population

-- find billed items for c diff 
-- 2012 ICD-9-CM Diagnosis Code 008.45, Intestinal infection due to Clostridium difficile
-- based on icd9 codes
SELECT  
"SUBJECT_ID",
"HADM_ID",
"SEQUENCE",
"CODE",
"DESCRIPTION"
 FROM "MIMIC2V26"."icd9"
 WHERE CODE like '008.45'

SELECT DISTINCT "SUBJECT_ID"
 FROM "MIMIC2V26"."icd9"
 WHERE CODE like '008.45'
-- 688 results



-- find coded_items for c.diff
select 
"ITEMID",
"CODE",
"TYPE",
"CATEGORY",
"LABEL",
"DESCRIPTION"
 FROM "MIMIC2V26"."d_codeditems" WHERE lower(type) like '%microbiology%'
 ORDER BY label; -- scroll down to 'CL%'
-- codes are:
-- 80,139 CLOSTRIDIUM DIFFICILE
-- 80,038 CLOSTRIDIUM PERFINGENS
-- 80,129 CLOSTRIDIUM SEPTICUM
-- 80,039 CLOSTRIDIUM SPECIES
-- 80,238 CLOSTRIDIUM SPECIES NOT PERFRINGENS OR C. SEPTICUM



-- find microbiology_events that match the coded items from the list above 
select 
"AB_ITEMID",
"DILUTION_AMOUNT",
"DILUTION_COMPARISON",
"INTERPRETATION",
"SUBJECT_ID",
"HADM_ID",
"CHARTTIME",
"SPEC_ITEMID",
"ORG_ITEMID",
"ISOLATE_NUM"
 FROM "MIMIC2V26"."microbiologyevents"
 WHERE "ORG_ITEMID" IN (80139, 80038, 80129, 80039, 80238) 

-- select unique patient ids having micro event with above-listed organism codes
SELECT DISTINCT  "SUBJECT_ID"
 FROM "MIMIC2V26"."microbiologyevents"
 WHERE "ORG_ITEMID" IN (80139, 80038, 80129, 80039, 80238) 
-- 586 results


SELECT DISTINCT  "SUBJECT_ID"
 FROM "MIMIC2V26"."microbiologyevents"
 WHERE "ORG_ITEMID" IN (80139, 80038, 80129, 80039, 80238) 
UNION 
SELECT DISTINCT "SUBJECT_ID"
 FROM "MIMIC2V26"."icd9"
 WHERE CODE like '008.45'
-- 796 patients


SELECT DISTINCT  "SUBJECT_ID"
 FROM "MIMIC2V26"."microbiologyevents"
 WHERE "ORG_ITEMID" IN (80139)
UNION 
SELECT DISTINCT "SUBJECT_ID"
 FROM "MIMIC2V26"."icd9"
 WHERE CODE like '008.45'
-- 796 patients


-- microbiology for pure CDIFF patients 
SELECT DISTINCT  "SUBJECT_ID"
 FROM "MIMIC2V26"."microbiologyevents"
 WHERE "ORG_ITEMID" IN (80139)




--------------------------
-- MEDS
--------------------------
-- commonly used antibiotics to treat CDIFF
-- flagyl
-- vancomycin
-- 





























