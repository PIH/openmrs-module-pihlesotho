DELIMITER $$

-- so we can get rid of unused locations that have links to data in other tables

DROP PROCEDURE IF EXISTS `openmrs`.`remove_locations`$$

CREATE PROCEDURE `openmrs`.`remove_locations`(
)
BEGIN

/*
-- checks
select patient_id, location_id from encounter where location_id in (6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26) and voided=0;
select patient_id from patient_identifier where location_id in (6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26) and voided=0;
select person_id from obs where location_id in (6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26) and voided=0;

-- corrections
update encounter set location_id=3 where patient_id=7924 and location_id=6;
update encounter set location_id=10 where patient_id=5046 and location_id=6;
update encounter set location_id=5 where patient_id in (10172, 10278) and location_id=6;

update obs set location_id=3 where person_id=7924 and location_id in (6);
update obs set location_id=10 where person_id in (5046, 9298) and location_id in (6);
update obs set location_id=5 where person_id in (2489,10172, 10278) and location_id in (6);
update obs set location_id=8 where person_id=12319 and location_id in (6);

update obs set location_id=10 where person_id=9219 and location_id in ('6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26');
update obs set location_id=8 where person_id=10731 and location_id in ('6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26') and voided=0;
*/

select '6,9,11,12,13,14,16,17,18,19,20,21,22,23,24,25,26' into @x;

-- updates
select concat("
update encounter set location_id=27 where location_id in (", @x, ");
") into @output_cmd;

PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("
update patient_identifier set location_id=27 where location_id in (", @x, ");") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("
update specimentracking_event set location_id=27 where location_id in (", @x, ");") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("
update specimentracking_identifier set location_id=27 where location_id in (", @x, ");") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("
update obs set location_id=27 where location_id in (", @x, ");") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


END$$

DELIMITER ;


