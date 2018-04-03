-- --------------------------------------------------------------------------------
--  call data_entry_stats_weekpast(2010, 01, 11);
--     will give you all of the stats from 2010-JAN-04 to 2010-JAN-11
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`data_entry_stats_weekpast`$$

CREATE PROCEDURE `openmrs`.`data_entry_stats_weekpast` (
_year int,
_month int,
_date int
)
BEGIN

SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(_month AS CHAR), 2, '0'), '-', LPAD(CAST(_date AS CHAR), 2, '0')))
INTO @end;

SELECT CAST(@end - INTERVAL 7 DAY as date)
INTO @start;

DROP TABLE IF EXISTS `data_entry_stats_weekpast_out`;
CREATE TEMPORARY TABLE `data_entry_stats_weekpast_out` (
  `userid` int(11) DEFAULT NULL,
  `Name` varchar(101) DEFAULT NULL,
  `NewP` int(4) DEFAULT NULL,
  `UpdP` int(4) DEFAULT NULL,
  `BslV` int(4) DEFAULT NULL,
  `FupV` int(4) DEFAULT NULL,
  `Rx` int(4) DEFAULT NULL,
  `Lab` int(4) DEFAULT NULL,
  `?` int(4) DEFAULT NULL,
  `EncP` int(4) DEFAULT NULL,
  `OthO` int(4) DEFAULT NULL,
  `ObsP` int(4) DEFAULT NULL,
  `Start` date DEFAULT NULL,
  `End` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


a_loop: LOOP

  SELECT CAST(@start + INTERVAL 1 DAY as date)
  INTO @next;

  IF @next > @end THEN
    LEAVE a_loop;
  END IF;

  SELECT @start as `start`, @next as next;

  call data_entry_stats(@start, @next, 'data_entry_stats_weekpast_out');

  SELECT @next
  INTO @start;

END LOOP a_loop;


#create a "location id" to "location readable text" lookup table
DROP TABLE IF EXISTS `des_locations`;
CREATE TEMPORARY TABLE `des_locations` (
  `id` int(11) DEFAULT NULL,
  `value` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `des_locations`
VALUES
 (2, 'NH')
,(3, 'NK')
,(4, 'BB')
,(5, 'LK')
,(7, 'MG')
,(8, 'RA')
,(10, 'TY');


SELECT 'userid', 'Name', 'NewP', 'UpdP', 'BslV', 'FupV', 'Rx', 'Lab', '?', 'EncP', 'OthO', 'ObsP', 'Start', 'End', 'site'
UNION
select `userid`, `Name`, `NewP`, `UpdP`, `BslV`, `FupV`, `Rx`, `Lab`, `?`, `EncP`, `OthO`, `ObsP`, `Start`, `End`, COALESCE(lo.value, '') as site
from data_entry_stats_weekpast_out as deswo
left join user_property as up on deswo.userid=up.user_id and property='defaultLocation'
left join des_locations as lo on up.property_value=lo.id
INTO OUTFILE '/home/achi/mysql_out/data_entry_stats_weekpast_detail.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';




END$$

DELIMITER ;