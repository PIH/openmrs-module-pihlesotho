-- --------------------------------------------------------------------------------
-- Routine DDL
-- --------------------------------------------------------------------------------

-- call `openmrs`.cross_site(2010, 1);
-- would get results from the 1st quarter

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`cross_site`$$

CREATE PROCEDURE `openmrs`.`cross_site`(
_year int(4),
_quarter int(1)
)
BEGIN

SELECT 3 * _quarter INTO @month;

#dynamically determine dates
SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(@month AS CHAR), 2, '0'), '-01'))
INTO @basedate;

SELECT LAST_DAY(@basedate)
INTO @reportend;

SELECT CAST(@basedate - INTERVAL 2 MONTH as date)
INTO @reportstart;

SELECT CAST(@reportstart - INTERVAL 3 MONTH as date)
INTO @reportsixmo;

SELECT _year as `year`, _quarter as `qtr`, @reportstart, @reportend, @reportsixmo;


DROP TABLE IF EXISTS `csi_site_helper`;
CREATE TEMPORARY TABLE `csi_site_helper` (
  `q` char(2) DEFAULT NULL,
  `adult` float(7,2) DEFAULT NULL,
  `anum` int(11) DEFAULT NULL,
  `aden` int(11) DEFAULT NULL,
  `child` float(7,2) DEFAULT NULL,
  `cnum` int(11) DEFAULT NULL,
  `cden` int(11) DEFAULT NULL,
  `total` float(7,2) DEFAULT NULL,
  `tnum` int(11) DEFAULT NULL,
  `tden` int(11) DEFAULT NULL,
  `loc_id` char(2) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
   PRIMARY KEY(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

/*
Notes:

Age breakdown is based on the age at the end of the review quarter

Visits are defined as followup or baseline visits seeing a clinician; it does not include regimen pickups or lab results

PMTCT patients are excluded
*/

#q1, query all patients, ever
#caveat: we do not included patients enrolled after the end date

DROP TABLE IF EXISTS `csi_all_patients`;
CREATE TEMPORARY TABLE `csi_all_patients` as
select pa.patient_id
,((date_format(@reportend,'%Y') - date_format(pe.birthdate,'%Y')) - (date_format(@reportend,'00-%m-%d') < date_format(pe.birthdate,'00-%m-%d'))) AS age
,pp.date_enrolled
,peat.value as loc_id
from patient as pa
left join patient_program as pp on pa.patient_id=pp.patient_id and pp.program_id=1 and pp.voided=0 and (pp.date_enrolled <= @reportend or pp.date_enrolled is null)
left join person as pe on pa.patient_id=pe.person_id and pe.voided=0
left join person_attribute as peat on pa.patient_id=peat.person_id and peat.person_attribute_type_id=7 and peat.voided=0
where pa.voided=0
and peat.value<>27 -- ignore test clinic
and pp.patient_id is not null
and pe.person_id is not null
group by pa.patient_id;

SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q1a, @q1c
FROM csi_all_patients;

call cross_site_helper(1, 1, 'csi_all_patients');

select 'patient_id', 'age', 'date_enrolled', 'loc_id'
union
select *
from csi_all_patients
INTO OUTFILE '/home/achi/mysql_out/csi_q01_all_patients.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS `csi_all_patients`;

-- now get the "real list" of valid patients (exclude those who don't have an enroll date)

-- create a "patient state id" to "patient state readable text" lookup table
DROP TABLE IF EXISTS `csi_states`;
CREATE TEMPORARY TABLE `csi_states` (
  `id` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `value` char(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `csi_states`
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

-- first ARV pickup by patient
DROP TABLE IF EXISTS `csi_obs_arv`;
CREATE TEMPORARY TABLE `csi_obs_arv` as
select obs.person_id as patient_id
, cast(min(obs.obs_datetime) as date) as obs_date
from obs
where obs.concept_id=2876 #arv pickup concepts
and obs.voided=0
group by obs.person_id;

ALTER TABLE `csi_obs_arv` ADD INDEX ( patient_id );


-- latest cd4 by patient for the last six mo
DROP TABLE IF EXISTS `csi_obs_cd4`;
CREATE TEMPORARY TABLE `csi_obs_cd4` as
select obs.person_id as patient_id
, cast(max(obs.obs_datetime) as date) as obs_date
from obs
where obs.concept_id=5497 #cd4 concepts
and obs_datetime between @reportsixmo and @reportend
and obs.voided=0
group by obs.person_id;

ALTER TABLE `csi_obs_cd4` ADD INDEX ( patient_id );

DROP TABLE IF EXISTS `csi_patient_state`;
CREATE TEMPORARY TABLE `csi_patient_state` as
select * from(
select
 pa.patient_id
,cast(pp.date_enrolled as date) as date_enrolled
,ps.state as state_id
,COALESCE(ps.end_date, NOW()) as state_end_date
,pat.value as loc_id
from patient as pa
left join patient_program as pp on pa.patient_id=pp.patient_id and pp.program_id=1 and pp.voided=0 and pp.date_enrolled <= @reportend
left join patient_state as ps on pp.patient_program_id=ps.patient_program_id and ps.voided=0 and ps.start_date <= @reportend and (ps.end_date is null or ps.end_date > @reportend) and ps.state <> 27
left join person_attribute as pat on pa.patient_id=pat.person_id and pat.person_attribute_type_id=7 and pat.voided=0
where pa.voided=0
and ps.start_date is not null
and (pat.value is null or pat.value<>27) -- ignore test clinic
order by ps.end_date ASC) as a
group by patient_id;

ALTER TABLE `csi_patient_state` ADD INDEX ( patient_id );


DROP TABLE IF EXISTS `csi_patients_ever`;
CREATE TEMPORARY TABLE `csi_patients_ever` as
select
 cps.patient_id
,cps.date_enrolled
,cps.state_id
,cps.state_end_date
,cps.loc_id
,cs.value as state
,coa.obs_date as art_startdate
,coc.obs_date as cd4_date
-- ,pe.birthdate
,((date_format(@reportend,'%Y') - date_format(pe.birthdate,'%Y')) - (date_format(@reportend,'00-%m-%d') < date_format(pe.birthdate,'00-%m-%d'))) AS age
,pe.dead as is_dead
,pe.death_date as deathdate
from csi_patient_state as cps
left join csi_states as cs on cps.state_id=cs.id
left join csi_obs_arv as coa on cps.patient_id=coa.patient_id
left join csi_obs_cd4 as coc on cps.patient_id=coc.patient_id
left join person as pe on cps.patient_id=pe.person_id and pe.voided=0;

ALTER TABLE `csi_patients_ever` ADD INDEX ( patient_id );

select 'patient_id', 'date_enrolled', 'state_id', 'state_end_date', 'loc_id', 'state', 'art_startdate', 'cd4_date', 'age', 'is_dead', 'deathdate', 'loc_desc'
union
select cpe.*, location.description
from csi_patients_ever as cpe
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q02ss_patients_ever.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS `csi_patient_state`;
DROP TABLE IF EXISTS `csi_states`;
DROP TABLE IF EXISTS `csi_obs_arv`;
DROP TABLE IF EXISTS `csi_obs_cd4`;


#q2, new patients enrolled
#caveat: see q1

-- select *
DROP TABLE IF EXISTS `csi_patients_newly_enrolled`;
CREATE TEMPORARY TABLE `csi_patients_newly_enrolled` as
select *
FROM csi_patients_ever
where date_enrolled between @reportstart and @reportend;


SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q2a, @q2c
FROM csi_patients_newly_enrolled;

call cross_site_helper(2, 1, 'csi_patients_newly_enrolled');

#q3, pre-art patients currently enrolled
#caveat: not dead
#caveat: states: following, hiv infected, and referred for tracking (and art is started after report end)

DROP TABLE IF EXISTS `csi_patients_active_preart`;
CREATE TEMPORARY TABLE `csi_patients_active_preart` as
select
 patient_id
,age
,state
,state_id
,is_dead
,deathdate
,cd4_date
,loc_id
FROM csi_patients_ever
where (is_dead=0 OR (is_dead=1 and deathdate > @reportend))
and (state_id in (2, 26) OR (state_id in (28, 40) and (art_startdate is null or art_startdate > @reportend)))
;

-- select *
SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q3a, @q3c
FROM csi_patients_active_preart;

call cross_site_helper(3, 1, 'csi_patients_active_preart');

select 'patient_id', 'age', 'state', 'state_id', 'is_dead', 'deathdate', 'cd4_date', 'loc_id', 'loc_desc'
union
select cpap.*, location.description
from csi_patients_active_preart as cpap
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q03_patients_active_preart.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';


#q4, pre-art patients with a visit up to 6 months from end of quarter
# of q3
#caveat: this is all patients with a visit during the time period

DROP TABLE IF EXISTS `csi_encs_sixmo`;
CREATE TEMPORARY TABLE `csi_encs_sixmo` as
select * from(
select
 enc.patient_id
,enc.encounter_id
,CAST(enc.encounter_datetime as date) as encdate
from encounter as enc
where enc.encounter_type in (1,2) #followup or update
and enc.encounter_datetime between @reportsixmo and @reportend
and enc.voided=0
order by encdate DESC) as b
group by patient_id;


DROP TABLE IF EXISTS `csi_patients_active_preart_visit`;
CREATE TEMPORARY TABLE `csi_patients_active_preart_visit` as
SELECT
 cpap.patient_id
,cpap.age
,cpap.state
,cpap.state_id
,cpap.is_dead
,cpap.deathdate
,cpap.cd4_date
,cpap.loc_id
,ces.encounter_id
,ces.encdate
from csi_patients_active_preart as cpap
left join csi_encs_sixmo as ces on cpap.patient_id=ces.patient_id
where ces.patient_id is not null;


SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q4an, @q4cn
from csi_patients_active_preart_visit;

call cross_site_helper(4, 2, 'csi_patients_active_preart_visit');


select 'patient_id', 'age', 'state', 'state_id', 'is_dead', 'deathdate', 'cd4_date', 'loc_id', 'encounter_id', 'encdate', 'loc_desc'
union
select cpapv.*, location.description
from csi_patients_active_preart_visit as cpapv
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q04_patients_active_preart_visit.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';


#q5, art patients ever
#caveat: anyone in ART status, or has an ART create date before end date
#       we exclude anyone considered active pre-art

DROP TABLE IF EXISTS `csi_patients_ever_art`;
CREATE TEMPORARY TABLE `csi_patients_ever_art` as
select
 cse.patient_id
,cse.age
,cse.state
,cse.state_id
,cse.is_dead
,cse.deathdate
,cse.art_startdate
,cse.cd4_date
,cse.loc_id
FROM csi_patients_ever as cse
left join csi_patients_active_preart as cpap on cse.patient_id=cpap.patient_id
where cpap.patient_id is null
and cse.art_startdate <= @reportend;

DROP TABLE IF EXISTS `csi_patients_ever`;

SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q5a, @q5c
from csi_patients_ever_art;

call cross_site_helper(5, 1, 'csi_patients_ever_art');


select 'patient_id', 'age', 'state', 'state_id', 'is_dead', 'deathdate', 'art_startdate', 'cd4_date', 'loc_id', 'loc_desc'
union
select cpea.*, location.description from csi_patients_ever_art as cpea
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q05q08_patients_initiated_art.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';


#q6, current art
#caveat: not dead
#caveat: states: active and referred for tracking (based on art_startdate)

DROP TABLE IF EXISTS `csi_patients_active_art`;
CREATE TEMPORARY TABLE `csi_patients_active_art` as
select
 patient_id
,age
,state
,state_id
,art_startdate
,is_dead
,deathdate
,cd4_date
,loc_id
FROM csi_patients_ever_art
where (is_dead=0 OR (is_dead=1 and deathdate > @reportend))
and (state_id=1 OR (state_id in (28, 40) and art_startdate <= @reportend))
;

-- select *
SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q6a, @q6c
from csi_patients_active_art;

call cross_site_helper(6, 1, 'csi_patients_active_art');


#q7, art patients with a visit during the quarter
#caveat: of q6
#caveat: this is all patients with a visit during the time period

#first get all of the visits
DROP TABLE IF EXISTS `csi_encs_threemo`;
CREATE TEMPORARY TABLE `csi_encs_threemo` as
select *
from csi_encs_sixmo
where encdate >= @reportstart;


DROP TABLE IF EXISTS `csi_encs_sixmo`;

DROP TABLE IF EXISTS `csi_patients_active_art_visit`;
CREATE TEMPORARY TABLE `csi_patients_active_art_visit` as
SELECT
 cpaa.patient_id
,cpaa.age
,cpaa.state
,cpaa.state_id
,cpaa.is_dead
,cpaa.deathdate
,cpaa.art_startdate
,cpaa.cd4_date
,cpaa.loc_id
,cet.encounter_id
,cet.encdate
from csi_patients_active_art as cpaa
left join csi_encs_threemo as cet on cpaa.patient_id=cet.patient_id
where cet.patient_id is not null;

SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q7an, @q7cn
from csi_patients_active_art_visit;

call cross_site_helper(7, 2, 'csi_patients_active_art_visit');


select 'patient_id', 'age', 'state', 'state_id', 'is_dead', 'deathdate', 'art_startdate', 'cd4_date', 'loc_id', 'encounter_id', 'encdate', 'loc_desc'
union
select cpaav.*, location.description
from csi_patients_active_art_visit as cpaav
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q06q07_patients_active_art_visit.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';


#q8, patients initiated on art in this quarter
#caveat: earliest ARV pickup date for each patient that falls within the quarter
#caveat: includes transfer-ins


DROP TABLE IF EXISTS `csi_patients_newly_art`;
CREATE TEMPORARY TABLE `csi_patients_newly_art` as
select *
from csi_patients_ever_art
where art_startdate between @reportstart and @reportend;


SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q8a, @q8c
from csi_patients_newly_art;

call cross_site_helper(8, 1, 'csi_patients_newly_art');


DROP TABLE IF EXISTS `csi_patients_ever_art`;



#q9, pre-art patient cd4 recorded in last 6 months
#caveat: of q3

DROP TABLE IF EXISTS `csi_patients_preart_cd4`;
CREATE TEMPORARY TABLE `csi_patients_preart_cd4` as
select *
from csi_patients_active_preart
where cd4_date is not null;

SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q9an, @q9cn
from csi_patients_preart_cd4;

call cross_site_helper(9, 2, 'csi_patients_preart_cd4');

select 'patient_id', 'age', 'state', 'cd4_date', 'location'
union
select cpap.patient_id, cpap.age, cpap.state, cpap.cd4_date, location.description
from csi_patients_active_preart as cpap
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q09ss_patients_active_preart.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS `csi_patients_active_preart`;


#q10, art patients that have cd4 recorded in last 6 months
#caveat: of q6
#caveat: includes transfer-ins

-- select *
DROP TABLE IF EXISTS `csi_patients_art_cd4`;
CREATE TEMPORARY TABLE `csi_patients_art_cd4` as
select *
from csi_patients_active_art
where cd4_date is not null;

SELECT SUM(IF(age>=15,1,0)) AS adult, SUM(IF(age<15,1,0)) AS child
INTO @q10an, @q10cn
from csi_patients_art_cd4;

call cross_site_helper(10, 2, 'csi_patients_art_cd4');

select 'patient_id'
, 'age'
, 'state'
, 'art_startdate'
, 'cd4_date'
, 'location'
union
select cpaa.patient_id, cpaa.age, cpaa.state, cpaa.art_startdate, cpaa.cd4_date, location.description
from csi_patients_active_art as cpaa
left join location on loc_id=location.location_id
INTO OUTFILE '/home/achi/mysql_out/csi_q10ss_patients_active_art.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

DROP TABLE IF EXISTS `csi_patients_active_art`;



#q11, visits that had a weight recorded

DROP TABLE IF EXISTS `csi_visit_weights`;
CREATE TEMPORARY TABLE `csi_visit_weights` as
select
 cet.patient_id
-- ,pe.birthdate
,((date_format(@reportend,'%Y') - date_format(pe.birthdate,'%Y')) - (date_format(@reportend,'00-%m-%d') < date_format(pe.birthdate,'00-%m-%d'))) AS age
-- ,cet.encounter_id
,cet.encdate
-- ,obs.obs_id
,obs.obs_datetime
,obs.value_numeric as weight
,peat.value as loc_id
from `csi_encs_threemo` as cet
left join person as pe on cet.patient_id=pe.person_id and pe.voided=0
left join obs on cet.encounter_id=obs.encounter_id and obs.voided=0 and obs.concept_id=5089 and value_numeric <> 0
left join person_attribute as peat on pe.person_id=peat.person_id and peat.person_attribute_type_id=7 and peat.voided=0
where peat.value<>27 -- ignore test clinic
;

/*
select * from csi_encs_threemo
INTO OUTFILE '/home/achi/mysql_out/csi_encs_threemo.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/

DROP TABLE IF EXISTS `csi_encs_threemo`;

SELECT
 SUM(IF(age>=15 and weight is not null,1,0)) AS adult_weighted
,SUM(IF(age<15 and weight is not null,1,0)) AS child_weighted
,SUM(IF(age>=15,1,0)) AS adult
,SUM(IF(age<15,1,0)) AS child
into
@q11an, @q11cn, @q11a, @q11c
from `csi_visit_weights`;

DROP TABLE IF EXISTS `csi_patients_weighted`;
CREATE TEMPORARY TABLE `csi_patients_weighted` as
select *
from `csi_visit_weights`
where weight is not null;

call cross_site_helper(11, 2, 'csi_patients_weighted');
call cross_site_helper(12, 3, 'csi_visit_weights');


/*
select * from csi_visit_weights
INTO OUTFILE '/home/achi/mysql_out/csi_visit_weights.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/
DROP TABLE IF EXISTS `csi_visit_weights`;


DROP TABLE IF EXISTS `csi_export`;
CREATE TEMPORARY TABLE `csi_export` as
select CONCAT(COALESCE(location.description, 'All'), '_', LPAD(CAST(q AS CHAR), 2, '0')) as vlu
 , csh.*, location.description as site
from csi_site_helper as csh
left join location on loc_id=location.location_id
order by vlu ASC;

select 'vlu'
 ,'q'
 ,'adult'
 ,'anum'
 ,'aden'
 ,'child'
 ,'cnum'
 ,'cden'
 ,'total'
 ,'tnum'
 ,'tden'
 ,'loc_id'
 ,'id'
 ,'site'
union
select *
from csi_export
INTO OUTFILE '/home/achi/mysql_out/csi_sites.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


DROP TABLE IF EXISTS `csi_summary`;
CREATE TEMPORARY TABLE `csi_summary` (
  `q` char(2) DEFAULT NULL,
  `adult` float(7,2) DEFAULT NULL,
  `anum` int(11) DEFAULT NULL,
  `aden` int(11) DEFAULT NULL,
  `child` float(7,2) DEFAULT NULL,
  `cnum` int(11) DEFAULT NULL,
  `cden` int(11) DEFAULT NULL,
  `total` float(7,2) DEFAULT NULL,
  `tnum` int(11) DEFAULT NULL,
  `tden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `csi_summary`
values
 ('01', @q1a, null, null, @q1c, null, null, @q1a+@q1c, null, null)
,('02', @q2a, null, null, @q2c, null, null, @q2a+@q2c, null, null)
,('03', @q3a, null, null, @q3c, null, null, @q3a+@q3c, null, null)
,('04', (@q4an/@q3a)*100, @q4an, @q3a,
        (@q4cn/@q3c)*100, @q4cn, @q3c,
        (@q4an+@q4cn)/(@q3a+@q3c)*100, @q4an+@q4cn, @q3a+@q3c)
,('05', @q5a, null, null, @q5c, null, null, @q5a+@q5c, null, null)
,('06', @q6a, null, null, @q6c, null, null, @q6a+@q6c, null, null)
,('07', (@q7an/@q6a)*100, @q7an, @q6a,
        (@q7cn/@q6c)*100, @q7cn, @q6c,
        (@q7an+@q7cn)/(@q6a+@q6c)*100, @q7an+@q7cn, @q6a+@q6c)
,('08', @q8a, null, null, @q8c, null, null, @q8a+@q8c, null, null)
,('09', (@q9an/@q3a)*100, @q9an, @q3a,
        (@q9cn/@q3c)*100, @q9cn, @q3c,
        (@q9an+@q9cn)/(@q3a+@q3c)*100, @q9an+@q9cn, @q3a+@q3c)
,('10', (@q10an/@q6a)*100, @q10an, @q6a,
         (@q10cn/@q6c)*100, @q10cn, @q6c,
         (@q10an+@q10cn)/(@q6a+@q6c)*100, @q10an+@q10cn, @q6a+@q6c)
,('11', (@q11an/@q11a)*100, @q11an, @q11a,
         (@q11cn/@q11c)*100, @q11cn, @q11c,
         (@q11an+@q11cn)/(@q11a+@q11c)*100, @q11an+@q11cn, @q11a+@q11c)
;

select * from csi_summary;

DROP TABLE IF EXISTS `csi_summary`;

END$$

DELIMITER ;


