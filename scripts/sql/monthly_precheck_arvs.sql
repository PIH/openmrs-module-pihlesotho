-- --------------------------------------------------------------------
-- usage: call monthly_precheck_arvs(2012, 3);
--   param1 is the year of reporting
--   param2 is the month of reporting
-- desc: this SP provides a dump across all sites of regimen pickups
-- --------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`monthly_precheck_arvs`$$

CREATE PROCEDURE `openmrs`.`monthly_precheck_arvs`(
_year int(4)
, _month int(2)
)
BEGIN

SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(_month AS CHAR), 2, '0'), '-01'))
INTO @firstday;

SELECT LAST_DAY(@firstday)
INTO @lastday;

SELECT CAST(@firstday - INTERVAL 1 MONTH as date)
INTO @monthago;

select 'regimen codes and site locations are hardcoded' as note;

-- raw table to extract pickups over the biggest timeframe
DROP TABLE IF EXISTS `mpa_obs`;
CREATE temporary TABLE `mpa_obs`
as
select CAST(obs.value_text as char(8)) as regimen
, obs_datetime
, location.description as loc
, person_id
from obs
left join location on obs.location_id=location.location_id
where obs.concept_id=2876
and voided = 0
and obs_datetime >= @monthago
and obs_datetime <= @lastday;

DROP TABLE IF EXISTS `mpa_regimens`;
CREATE temporary TABLE `mpa_regimens` (
  `code` varchar(8) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `mpa_regimens` VALUES ('1a(30)'),('1b(30)'),('1c'),('1d'),('1e'),('1f'),('2a'),('2b'),('2c'),('2d'),('2e'),('4a'),('4b'),('4c'),('4d'),('AZT'),('OTH');

select 'breakdown of patients picking up regimens between:' as details, @monthago as `start`, @lastday as `end`;

select code as regimen
, COALESCE(BB, 0) as BB
, COALESCE(LK, 0) as LK
, COALESCE(MG, 0) as MG
, COALESCE(NH, 0) as NH
, COALESCE(NK, 0) as NK
, COALESCE(RA, 0) as RA
, COALESCE(TY, 0) as TY
  from mpa_regimens
left join (
select regimen
, SUM(IF(loc='BB',1,0)) as BB
, SUM(IF(loc='LK',1,0)) as LK
, SUM(IF(loc='MG',1,0)) as MG
, SUM(IF(loc='NH',1,0)) as NH
, SUM(IF(loc='NK',1,0)) as NK
, SUM(IF(loc='RA',1,0)) as RA
, SUM(IF(loc='TY',1,0)) as TY
from (select * from mpa_obs group by person_id) as a
group by regimen) as b on mpa_regimens.code=b.regimen;


select 'breakdown of pickups between:' as details, @firstday as `start`, @lastday as `end`;

select code as regimen
, COALESCE(BB, 0) as BB
, COALESCE(LK, 0) as LK
, COALESCE(MG, 0) as MG
, COALESCE(NH, 0) as NH
, COALESCE(NK, 0) as NK
, COALESCE(RA, 0) as RA
, COALESCE(TY, 0) as TY
  from mpa_regimens
left join (
select regimen
, SUM(IF(loc='BB',1,0)) as BB
, SUM(IF(loc='LK',1,0)) as LK
, SUM(IF(loc='MG',1,0)) as MG
, SUM(IF(loc='NH',1,0)) as NH
, SUM(IF(loc='NK',1,0)) as NK
, SUM(IF(loc='RA',1,0)) as RA
, SUM(IF(loc='TY',1,0)) as TY
from (select * from mpa_obs where obs_datetime >= @firstday) as a
group by regimen) as b on mpa_regimens.code=b.regimen;

END$$

DELIMITER ;
