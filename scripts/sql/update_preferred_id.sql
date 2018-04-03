-- --------------------------------------------------------------------------------
-- call update_preferred_id();
--   make the paper file number the preferred ID
-- --------------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`update_preferred_id`$$
CREATE PROCEDURE `openmrs`.`update_preferred_id`()
BEGIN

select count(*) into @to_unset
from patient_identifier where voided=0 and preferred=1 and identifier_type<>6;

select count(*) into @to_set
from patient_identifier where voided=0 and preferred=0 and identifier_type=6;

select
@to_unset as records_to_unset,
@to_set as records_to_set;

update patient_identifier set preferred=0 where voided=0 and identifier_type<>6;
update patient_identifier set preferred=0 where voided=1 and identifier_type=6;
update patient_identifier set preferred=1 where voided=0 and identifier_type=6;

END$$

DELIMITER ;

