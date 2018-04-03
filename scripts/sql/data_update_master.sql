-- --------------------------------------------------------------------------------
-- call data_update_master;
--   runs all SPs that are periodically run through the cron job
-- --------------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`data_update_master`$$
CREATE PROCEDURE `openmrs`.`data_update_master`()
BEGIN

call void_danglers();
call update_preferred_id();
call update_test_loc4_encs_obs();
call update_gis_xref();

END$$

DELIMITER ;

