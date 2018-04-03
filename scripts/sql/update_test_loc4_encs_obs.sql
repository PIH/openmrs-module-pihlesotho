-- --------------------------------------------------------------------------------
-- call update_test_loc4_encs_obs();
--   make all enc and obs locations set to the test clinic
-- --------------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`update_test_loc4_encs_obs`$$
CREATE PROCEDURE `openmrs`.`update_test_loc4_encs_obs`()
BEGIN

update encounter as e
left join person_attribute as pa on e.patient_id=pa.person_id and pa.person_attribute_type_id=7 and pa.voided=0
set e.location_id=27
where pa.value=27
and e.location_id<>27
;

update obs as o
left join person_attribute as pa on o.person_id=pa.person_id and pa.person_attribute_type_id=7 and pa.voided=0
set o.location_id=27
where pa.value=27
and o.location_id<>27
;

END$$

DELIMITER ;

