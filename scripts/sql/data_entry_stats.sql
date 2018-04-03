-- --------------------------------------------------------------------------------
--  call data_entry_stats('2010-01-18', '2010-01-19', NULL);
--     will get you the data entry stats for all users
--     starting from 2010-JAN-18 at 12:00AM to 2010-JAN-18 at 11:59PM
--    NB: the last column is when we are calling this and need to aggregate results
--       see data_entry_stats_monthly for an example usage
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`data_entry_stats`$$

CREATE PROCEDURE `openmrs`.`data_entry_stats` (
_startdate date,
_enddate date,
_tablename varchar(32)
)
BEGIN

-- get the raw patients
drop table if exists data_entry_patients;
create temporary table data_entry_patients
as
select creator as userid
, patient_id
from patient
where patient.date_created > _startdate
and patient.date_created < _enddate
and patient.voided=0;


-- get number of patients created
drop table if exists data_entry_newpats;
create temporary table data_entry_newpats
as
select userid
, count(*) as NewPat
from data_entry_patients
group by userid;

ALTER TABLE `data_entry_newpats` ADD INDEX ( userid );

-- get the distinct list patients
drop table if exists data_entry_upats_new;
create temporary table data_entry_upats_new
as
select userid
, patient_id
from data_entry_patients
group by userid, patient_id;

-- ALTER TABLE `data_entry_upats_new` ADD INDEX ( patient_id );


drop table if exists data_entry_patients;

-- get the raw encounters
drop table if exists data_entry_encounters;
create temporary table data_entry_encounters
as
select creator as userid
, encounter_type
, patient_id
from encounter
where encounter.date_created > _startdate
and encounter.date_created < _enddate
and encounter.voided=0;

-- get number of baseline and followup forms completed
drop table if exists data_entry_forms;
create temporary table data_entry_forms
as
select userid
, SUM(IF(encounter_type=2,1,0)) AS Followup
, SUM(IF(encounter_type=1,1,0)) AS Baseline
, SUM(IF(encounter_type=11,1,0)) AS Regimen
, SUM(IF(encounter_type=15,1,0)) AS Lab
, count(*)-SUM(IF(encounter_type in (1, 2, 11, 15),1,0)) as Unknown
, count(distinct(patient_id)) as EncPats
from data_entry_encounters
group by userid;

ALTER TABLE `data_entry_forms` ADD INDEX ( userid );

-- get the distinct list patients from encounters
drop table if exists data_entry_upats_upd_tmp;
create temporary table data_entry_upats_upd_tmp
as
select userid
, patient_id
from data_entry_encounters
group by userid, patient_id;

drop table if exists data_entry_encounters;


-- since we dont have full outer join, we need to union a left join and right join
drop table if exists data_entry_lj1;
create temporary table data_entry_lj1
as
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.Followup
, b.Baseline
, b.Regimen
, b.Lab
, b.EncPats
, b.Unknown
from data_entry_newpats as a
left join data_entry_forms b on (a.userid=b.userid);

-- combined NPs and Forms
drop table if exists data_entry_intermediate;
create temporary table data_entry_intermediate
as
select * from data_entry_lj1
union
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.Followup
, b.Baseline
, b.Regimen
, b.Lab
, b.EncPats
, b.Unknown
from data_entry_newpats as a
right join data_entry_forms b on (a.userid=b.userid);

ALTER TABLE `data_entry_intermediate` ADD INDEX ( userid );


drop table if exists data_entry_newpats;
drop table if exists data_entry_forms;

drop table if exists data_entry_obs;
create temporary table data_entry_obs
as
select creator as userid
, person_id as patient_id
from obs
where date_created > _startdate
and date_created < _enddate
and voided=0
and encounter_id is null
and concept_id<>2876;

-- get number of non-followup form obs
drop table if exists data_entry_otherobs;
create temporary table data_entry_otherobs
as
select userid
, count(*) AS OthObs
, count(distinct(patient_id)) AS ObsPats
from data_entry_obs
group by userid;

ALTER TABLE `data_entry_otherobs` ADD INDEX ( userid );


-- get the distinct list patients from observations
-- and dump them into the enc table
insert into data_entry_upats_upd_tmp
select userid
, patient_id
from data_entry_obs
group by userid, patient_id;

drop table if exists data_entry_obs;

-- make a distinct list of the updated patients
drop table if exists data_entry_upats_upd;
create temporary table data_entry_upats_upd
as
select userid
, patient_id
from data_entry_upats_upd_tmp
group by userid, patient_id;

-- ALTER TABLE `data_entry_upats_upd` ADD INDEX ( patient_id );

drop table if exists data_entry_upats_upd_tmp;

-- since we dont have full outer join, we need to union a left join and right join
drop table if exists data_entry_lj2;
create temporary table data_entry_lj2
as
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.OthObs
, b.ObsPats
, a.Followup
, a.Baseline
, a.Regimen
, a.Lab
, a.Unknown
, a.EncPats
from data_entry_intermediate as a
left join data_entry_otherobs b on (a.userid=b.userid);

-- combined NewPatients, Forms, Regimens, Non-Form Obs
drop table if exists data_entry_fj_final;
create temporary table data_entry_fj_final
as
select * from data_entry_lj2
union
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.OthObs
, b.ObsPats
, a.Followup
, a.Baseline
, a.Regimen
, a.Lab
, a.Unknown
, a.EncPats
from data_entry_intermediate as a
right join data_entry_otherobs b on (a.userid=b.userid);

ALTER TABLE `data_entry_fj_final` ADD INDEX ( userid );

drop table if exists data_entry_intermediate;
drop table if exists data_entry_otherobs;

-- now we separate patients from obs/encs from new patients
drop table if exists data_entry_upats;
create temporary table data_entry_upats
as
select u.userid
, COUNT(u.patient_id) as UpdPat
from data_entry_upats_upd as u
left join data_entry_upats_new as n on u.patient_id=n.patient_id
where n.patient_id is null
group by u.userid;

ALTER TABLE `data_entry_upats` ADD INDEX ( userid );

-- since we dont have full outer join, we need to union a left join and right join
drop table if exists data_entry_lj3;
create temporary table data_entry_lj3
as
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.UpdPat
, a.OthObs
, a.ObsPats
, a.Followup
, a.Baseline
, a.Regimen
, a.Lab
, a.Unknown
, a.EncPats
from data_entry_fj_final as a
left join data_entry_upats b on (a.userid=b.userid);

-- combined NewPatients, Forms, Regimens, Non-Form Obs
drop table if exists data_entry;
create temporary table data_entry
as
select * from data_entry_lj3
union
select COALESCE(a.userid, b.userid) as userid
, a.NewPat
, b.UpdPat
, a.OthObs
, a.ObsPats
, a.Followup
, a.Baseline
, a.Regimen
, a.Lab
, a.Unknown
, a.EncPats
from data_entry_fj_final as a
right join data_entry_upats b on (a.userid=b.userid);

drop table if exists data_entry_fj_final;
drop table if exists data_entry_upats;

IF _tablename IS NULL THEN
  select CONCAT(pn.given_name, ' ', pn.family_name) as Name
  , COALESCE(de.NewPat, 0) as NewP
  , COALESCE(de.UpdPat, 0) as UpdP
  , COALESCE(de.Baseline, 0) as BslV
  , COALESCE(de.Followup, 0) as FupV
  , COALESCE(de.Regimen, 0) as Rx
  , COALESCE(de.Lab, 0) as Lab
  , COALESCE(de.Unknown, 0) as `?`
  , COALESCE(de.EncPats, 0) as EncP
  , COALESCE(de.OthObs, 0) as OthO
  , COALESCE(de.ObsPats, 0) as ObsP
  , _startdate as `Start`
  , _enddate as `End`
  from data_entry as de
  left join person_name as pn on de.userid=pn.person_id
  order by Name ASC;
ELSE

  select concat("insert into ", _tablename, " (userid, Name, NewP, UpdP, BslV, FupV, Rx, Lab, `?`, EncP, OthO, ObsP, `Start`, `End`) select de.userid as userid, CONCAT(pn.given_name, ' ', pn.family_name) as Name, COALESCE(de.NewPat, 0) as NewP, COALESCE(de.UpdPat, 0) as UpdP, COALESCE(de.Baseline, 0) as BslV, COALESCE(de.Followup, 0) as FupV, COALESCE(de.Regimen, 0) as Rx, COALESCE(de.Lab, 0) as Lab, COALESCE(de.Unknown, 0) as `?`, COALESCE(de.EncPats, 0) as EncP, COALESCE(de.OthObs, 0) as OthO, COALESCE(de.ObsPats, 0) as ObsP, '", _startdate, "' as `Start`, '", _enddate, "' as `End` from data_entry as de left join person_name as pn on de.userid=pn.person_id order by Name ASC") into @output_cmd;

PREPARE stmt FROM @output_cmd;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


END IF;

END$$

DELIMITER ;
