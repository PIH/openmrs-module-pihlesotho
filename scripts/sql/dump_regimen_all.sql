-- call dump_regimen_all(2010, 10, NULL);


-- --------------------------------------------------------------------------------
-- Routine DDL
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`dump_regimen_all`$$
CREATE PROCEDURE `openmrs`.`dump_regimen_all`(
_year int,
_month int,
_export_dir varchar(32)
)
BEGIN

DROP TABLE IF EXISTS `regimens`;
CREATE temporary TABLE `regimens` (
  `regimen` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `regimens` VALUES ('1a(30)'),('1b(30)'),('1c'),('1d'),('1e'),('1f'),('2b'),('4a'),('4b'),('4c'),('4d');

SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(_month AS CHAR), 2, '0'), '-01'))
INTO @firstday;

SELECT LAST_DAY(@firstday)
INTO @lastday;

DROP TABLE IF EXISTS `regimen_pickups`;
create temporary table `regimen_pickups`
as
select
person_id,
obs_datetime,
location_id,
CAST(value_text as char(6)) as regimen
from obs as o
where o.concept_id=2876
and o.obs_datetime between @firstday and @lastday
and o.voided=0;

ALTER TABLE `regimen_pickups` ADD INDEX ( person_id );


#latest weight up until the end of the month
DROP TABLE IF EXISTS `latest_weight`;
create temporary table `latest_weight`
as
select * from (
select person_id, obs_datetime, value_numeric as weight
from obs
where concept_id=5089
and obs_datetime < @lastday
order by obs_datetime DESC) as a
group by person_id;

ALTER TABLE `latest_weight` ADD INDEX ( person_id );

call dump_regimen_for_site('NH', @firstday, _export_dir);
call dump_regimen_for_site('NK', @firstday, _export_dir);
call dump_regimen_for_site('BB', @firstday, _export_dir);
call dump_regimen_for_site('LK', @firstday, _export_dir);
call dump_regimen_for_site('MG', @firstday, _export_dir);
call dump_regimen_for_site('RA', @firstday, _export_dir);
call dump_regimen_for_site('TY', @firstday, _export_dir);

DROP TABLE `regimens`;
DROP TABLE `regimen_pickups`;

END$$

DELIMITER ;

-- --------------------------------------------------------------------------------
-- Routine DDL
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`dump_regimen_for_site`$$

CREATE PROCEDURE `openmrs`.`dump_regimen_for_site`(
_site char(2)
, _firstday date
, _export_dir varchar(32)
)
BEGIN

SELECT DATE_FORMAT(@firstday, '%Y')
INTO @year;

SELECT DATE_FORMAT(@firstday, '%m')
INTO @month;

select location_id into @location_id
from location where description like _site;

IF _export_dir IS NULL THEN
 SELECT '/tmp' into _export_dir;
END IF;

DROP TABLE IF EXISTS `regimen_pickups_by_loc`;
create temporary table regimen_pickups_by_loc
as
select p.person_id
,pi.identifier
,CAST(p.gender as char(1)) as gender
,(YEAR(COALESCE(p.death_date, rp.obs_datetime)) - YEAR(p.birthdate) - (date_format(COALESCE(p.death_date, rp.obs_datetime),'00-%m-%d') < date_format(p.birthdate,'00-%m-%d'))) as age
,lw.weight
,CAST(lw.obs_datetime as date) as weight_date
,rp.regimen
,CAST(rp.obs_datetime as date) as regimen_date
,pa.value as loc_pat
,rp.location_id as loc_obs
from regimen_pickups as rp
left join person as p on rp.person_id=p.person_id
left join person_attribute as pa on rp.person_id=pa.person_id and pa.person_attribute_type_id=7 and pa.voided=0
left join patient_identifier as pi on rp.person_id=pi.patient_id and pi.identifier_type=2 and pi.voided=0
left join latest_weight as lw on lw.person_id=rp.person_id
where rp.location_id=@location_id and pa.value=@location_id
order by p.person_id ASC, rp.obs_datetime DESC;

-- create index regimen_idx on regimen_pickups_by_loc (regimen(6));
-- create index gender_idx on regimen_pickups_by_loc (gender(1));
-- create index age_idx on regimen_pickups_by_loc (age);


select concat("SELECT 'patient_id', 'artu_num', 'gender', 'age', 'weight', 'weight_date', 'regimen', 'regimen_date', 'patient_location', 'obs_location' UNION
SELECT person_id
, identifier
, gender
, age
, weight
, weight_date
, regimen
, regimen_date
, loc_pat
, loc_obs
FROM regimen_pickups_by_loc
INTO OUTFILE '", _export_dir, '/regimen_', @year, '-', @month, '_', _site, '_raw', ".csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("SELECT 'regimen', 'M', 'F', 'total' UNION
SELECT regimen
, SUM(IF(gender='M',1,0)) AS M
, SUM(IF(gender='F',1,0)) AS F
, COUNT(*) as total
FROM regimens
INNER JOIN regimen_pickups_by_loc USING (regimen)
GROUP BY regimen
INTO OUTFILE '", _export_dir, '/regimen_', @year, '-', @month, '_', _site, '_stat_gender', ".csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

select concat("SELECT 'regimen', '<3.0', '3.0-3.9', '4.0-5.9', '6.0-9.9', '10.0-13.9', '14.0-19.9', '20.0-24.9', '>25' UNION
select regimen
, SUM(IF(weight<3.0, 1, 0)) as `<3.0`
, SUM(IF(weight>=3.0 AND weight<4.0, 1, 0)) as `3.0-3.9`
, SUM(IF(weight>=4.0 AND weight<6.0, 1, 0)) as `4.0-5.9`
, SUM(IF(weight>=6.0 AND weight<10.0, 1, 0)) as `6.0-9.9`
, SUM(IF(weight>=10.0 AND weight<14.0, 1, 0)) as `10.0-13.9`
, SUM(IF(weight>=14.0 AND weight<20.0, 1, 0)) as `14.0-19.9`
, SUM(IF(weight>=20.0 AND weight<25.0, 1, 0)) as `20.0-24.9`
, SUM(IF(weight>=25.0, 1, 0)) as `>25`
from regimens
inner join regimen_pickups_by_loc using (regimen)
group by regimen
INTO OUTFILE '", _export_dir, '/regimen_', @year, '-', @month, '_', _site, '_stat_weight', ".csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'") into @output_cmd;
PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

DROP TABLE regimen_pickups_by_loc;

END$$

DELIMITER ;


