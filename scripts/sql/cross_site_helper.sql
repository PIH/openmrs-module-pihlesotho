-- --------------------------------------------------------------------------------
-- Routine DDL
-- --------------------------------------------------------------------------------

-- call `openmrs`.cross_site_helper(<question number>, <question type>, <table name to pivot on>);

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`cross_site_helper`$$

CREATE PROCEDURE `openmrs`.`cross_site_helper`(
_q_num int(1),
_q_type int(1),
_table_name char(32)
)
BEGIN

IF _q_type=1 THEN
  select concat("
   INSERT INTO csi_site_helper (q, loc_id, adult, child, total)
     SELECT
       ", _q_num, ",
       loc_id,
       SUM(IF(age>=15,1,0)) AS adult,
       SUM(IF(age<15,1,0)) AS child,
       count(*) AS total
     FROM ", _table_name, " GROUP BY loc_id WITH ROLLUP;
    ") into @output_cmd;
ELSEIF _q_type=2 THEN
  select concat("
   INSERT INTO csi_site_helper (q, loc_id, anum, cnum, tnum)
     SELECT
       ", _q_num, ",
       loc_id,
       SUM(IF(age>=15,1,0)) AS anum,
       SUM(IF(age<15,1,0)) AS cnum,
       count(*) AS tnum
     FROM ", _table_name, " GROUP BY loc_id WITH ROLLUP;
    ") into @output_cmd;
ELSE
  select concat("
   INSERT INTO csi_site_helper (q, loc_id, aden, cden, tden)
     SELECT
       ", _q_num, ",
       loc_id,
       SUM(IF(age>=15,1,0)) AS aden,
       SUM(IF(age<15,1,0)) AS cden,
       count(*) AS tnum
     FROM ", _table_name, " GROUP BY loc_id WITH ROLLUP;
    ") into @output_cmd;
END IF;

PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


END$$

DELIMITER ;


