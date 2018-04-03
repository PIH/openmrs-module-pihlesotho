-- -----------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`dump_enrollments`$$
CREATE PROCEDURE `openmrs`.`dump_enrollments`(
_year int(4)
)
BEGIN

SELECT CONCAT(_year - 1, '-12-31') into @start;

SELECT CONCAT(_year + 1, '-01-01') into @end;

DROP TABLE IF EXISTS `de_states`;
CREATE TEMPORARY TABLE `de_states` (
  `id` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `value` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `de_states`
VALUES
 (1, 1487, 'act_OnART')
,(2, 1490, 'act_PreART')
,(3, 1488, 'ina_Dead')
,(4, 1489, 'ina_Lost')
,(5, 1744, 'ina_XferOut')
,(26, 1769, 'bad_HIVI')
,(27, 1647, 'act_PMTC')
,(28, 6314, 'act_RTrack')
,(37, 6977, 'ina_Refuse')
,(38, 6976, 'act_XferIn')
,(39, 6978, 'ina_RxSusp')
,(40, 6983, 'act_RHosp')
;

DROP TABLE IF EXISTS `de_patients`;
create temporary table `de_patients`
as
select p.patient_id
, CAST(pp.date_enrolled as date) as date_enrolled
, pe.birthdate
, l.description as hc
,(YEAR(pp.date_enrolled) - YEAR(pe.birthdate) - (date_format(pp.date_enrolled,'00-%m-%d') < date_format(pe.birthdate,'00-%m-%d'))) as age
, ps.start_date
, ds.value as initial_state
from patient_program as pp
left join patient as p on p.patient_id=pp.patient_id and p.voided=0
left join patient_state as ps on pp.patient_program_id=ps.patient_program_id and ps.voided=0
left join de_states as ds on ds.id=ps.state
left join person as pe on pe.person_id=pp.patient_id and pe.voided=0
left join person_attribute as pa on pa.person_id=pp.patient_id and pa.person_attribute_type_id=7 and pa.voided=0
left join location as l on pa.value=l.location_id
where p.patient_id is not null
and pa.value <> 27
and pp.program_id=1
and pp.voided=0
and pp.date_enrolled > @start
and pp.date_enrolled < @end;

ALTER TABLE `de_patients` ADD INDEX ( patient_id );


DROP TABLE IF EXISTS `de_get_pp_earliest`;
create temporary table `de_get_pp_earliest`
as
select * from (
select patient_id
, date_enrolled
, start_date as state_start_date
, initial_state
, DATEDIFF(start_date, date_enrolled) as time_passed
, birthdate
, age
, hc
from de_patients
order by date_enrolled ASC, start_date ASC) as a
group by patient_id;

ALTER TABLE `de_get_pp_earliest` ADD INDEX ( patient_id );

select concat("select
'patient_id'
, 'date_enrolled'
, 'state_start_date'
, 'initial_state'
, 'time_passed'
, 'birthdate'
, 'age'
, 'hc'
union
select *
from de_get_pp_earliest
INTO OUTFILE '/home/achi/mysql_out/enrollments_export_", _year, ".csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';") INTO @output_cmd;

  PREPARE stmt FROM @output_cmd;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;


END$$

DELIMITER ;
