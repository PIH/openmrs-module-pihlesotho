-- we assume that all null encounters were created by the drug needs module
-- therefore, since encounter type: "ART Drug Regimen Pickup" 
--    maps to encounter_type_id 11

UPDATE `encounter` SET `encounter_type`=11 WHERE `encounter_type` IS NULL;