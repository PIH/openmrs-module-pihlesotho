-- used to analyze pre-art patients outcomes
-- load this sp: source <file name>;
-- run this sp: call <sp name>();
-- to be consistent with x-site indicators for lesotho, ART initiation date is calculated based on the day that patients pick up their first Rx of ARVs

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`pre_art_study`$$
CREATE PROCEDURE `openmrs`.`pre_art_study`(
)
BEGIN


DROP TABLE IF EXISTS `pas_aun_prefix`;
CREATE TEMPORARY TABLE `pas_aun_prefix` (
  `id` int(11) DEFAULT NULL
 , `site` char(2) DEFAULT NULL
 , `aun` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `pas_aun_prefix`
VALUES
 (2, 'NH', 'F02')
,(3, 'NK', 'F05')
,(4, 'BB', 'K03')
,(5, 'LK', 'H04')
,(7, 'MG', 'K07')
,(8, 'RA', 'K01') -- this is actually k011!
,(10, 'TY', 'J08')
;

-- we need to get all unvoided patients
DROP TABLE IF EXISTS `pas_patient`;
CREATE TEMPORARY TABLE `pas_patient` as
select pa.patient_id
, pi.identifier as ppf_num
, piaun.identifier as artu_num
, COALESCE(SUBSTRING(piaun.identifier, 1, 3) <> aun, 0) as art_xfer
, pe.gender
, pe.birthdate -- no need to cast this to date
, cast(pe.death_date as date) as deathdate
, pe.dead
, pea.city_village as village
, pea.county_district as district
, l.description as loc
from patient as pa
left join patient_identifier as pi on pa.patient_id=pi.patient_id and pi.identifier_type=6 and pi.voided=0
left join patient_identifier as piaun on pa.patient_id=piaun.patient_id and piaun.identifier_type=2 and piaun.voided=0
left join person as pe on pa.patient_id=pe.person_id and pe.voided=0
left join person_address as pea on pa.patient_id=pea.person_id and pea.voided=0
left join person_attribute as peat on pa.patient_id=peat.person_id and peat.person_attribute_type_id=7 and peat.voided=0
left join location as l on peat.value=l.location_id
left join pas_aun_prefix as pap on pap.id=l.location_id
where pa.voided=0
and pe.person_id is not null
and peat.value<>27 -- ignore test clinic
group by pa.patient_id;

ALTER TABLE `pas_patient` ADD INDEX ( patient_id );
SeLeCt 'created pas_patient';

-- because some of the programs are marked as completed (e.g. when patient state was moved to abandoned, and then they came back) we need to do a bunch of stuff to get the latest patient program and state, in addition to the correct program enrollment date

select CAST(NOW() as date) into @now;
SELECT @now + INTERVAL 1 DAY INTO @future_date;

DROP TABLE IF EXISTS `pas_ppps`;
create temporary table `pas_ppps`
as
select cp.patient_id
, pp.patient_program_id
, CAST(pp.date_enrolled as date) as date_enrolled
, CAST(pp.date_enrolled as date) + INTERVAL 1 YEAR as date_one_year_post_enroll
, CAST(COALESCE(pp.date_completed, @future_date) as date) as date_completed
, ps.state
, ps.start_date
, COALESCE(ps.end_date, @future_date) as end_date
from pas_patient as cp
left join patient_program as pp on cp.patient_id=pp.patient_id and pp.program_id=1 and pp.voided=0
left join patient_state as ps on pp.patient_program_id=ps.patient_program_id and ps.voided=0;

ALTER TABLE `pas_ppps` ADD INDEX ( patient_id );
SeLeCt 'created pas_ppps';

-- now get the current enrollment and current state end date to get the current state
DROP TABLE IF EXISTS `pas_ppps_current`;
create temporary table `pas_ppps_current`
as
select * from (
select patient_id, date_completed, state, start_date, end_date
from pas_ppps
where end_date >= date_one_year_post_enroll
and start_date < date_one_year_post_enroll
order by date_completed DESC, end_date DESC) as a
group by patient_id;

-- fix the end dates that we modified to sort correctly
UPDATE pas_ppps_current
SET end_date=NULL
WHERE end_date=@future_date;

ALTER TABLE `pas_ppps_current` ADD INDEX ( patient_id );
SeLeCt 'created pas_ppps_latest';

-- make sure we are getting the initial enrollment (since there may be multiple enrollments
DROP TABLE IF EXISTS `pas_ppps_initial`;
create temporary table `pas_ppps_initial`
as
select * from (select patient_id, date_enrolled, date_one_year_post_enroll
from pas_ppps
order by date_enrolled ASC) as a
group by patient_id;

ALTER TABLE `pas_ppps_initial` ADD INDEX ( patient_id );
SeLeCt 'created pas_initial';

DROP TABLE IF EXISTS `pas_states`;
CREATE TEMPORARY TABLE `pas_states` (
  `id` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `value` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `pas_states`
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

-- let's create a smaller obs table with ART pickup, CD4, WHO Stage, height and weight
DROP TABLE IF EXISTS `pas_obs`;
create temporary table `pas_obs`
as
select person_id as patient_id, cast(obs_datetime as date) as obs_date, concept_id, value_numeric, value_coded
from obs
where concept_id IN (2876, 5497, 1480, 5090, 5089)
and voided=0
order by obs_datetime;
SeLeCt 'created pas_obs';

-- get the min value for ARV as the startdate
DROP TABLE IF EXISTS `pas_arv_min`;
create temporary table `pas_arv_min`
as
select * from (
select patient_id, obs_date
from pas_obs
where concept_id=2876
order by obs_date ASC) as a
group by patient_id;

ALTER TABLE `pas_arv_min` ADD INDEX ( patient_id );
SeLeCt 'created pas_arv_min';

-- combine the states, patient dems and ARVs to get cutoff dates for art initiation and enrollment
DROP TABLE IF EXISTS `pas_patient_join`;
create temporary table `pas_patient_join`
as
select pp.*
, ppi.date_enrolled as enroll_date
, ppi.date_one_year_post_enroll as one_yr_penroll_date
,(ppi.date_enrolled + INTERVAL 14 DAY) as enroll_cutoffdate
, pam.obs_date as artstart_date
,(pam.obs_date + INTERVAL 14 DAY) as artstart_cutoffdate
from pas_patient as pp
left join pas_ppps_initial as ppi on pp.patient_id=ppi.patient_id
left join pas_arv_min as pam on pp.patient_id=pam.patient_id
;
SeLeCt 'created pas_patient_join';

-- get the max date value for CD4 within 14 days of enroll
DROP TABLE IF EXISTS `pas_cd4_enroll`;
create temporary table `pas_cd4_enroll`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.enroll_cutoffdate
where concept_id=5497
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_cd4_enroll` ADD INDEX ( patient_id );
SeLeCt 'created pas_cd4_enroll';

-- get the max date value for CD4 within 14 days of artstart
DROP TABLE IF EXISTS `pas_cd4_artstart`;
create temporary table `pas_cd4_artstart`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.artstart_cutoffdate
where concept_id=5497
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_cd4_artstart` ADD INDEX ( patient_id );
SeLeCt 'created pas_cd4_artstart';


-- get the max date value for WEIGHT within 14 days of enroll
DROP TABLE IF EXISTS `pas_weight_enroll`;
create temporary table `pas_weight_enroll`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.enroll_cutoffdate
where concept_id=5089
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_weight_enroll` ADD INDEX ( patient_id );
SeLeCt 'created pas_weight_enroll';

-- get the max date value for WEIGHT within 14 days of artstart
DROP TABLE IF EXISTS `pas_weight_artstart`;
create temporary table `pas_weight_artstart`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.artstart_cutoffdate
where concept_id=5089
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_weight_artstart` ADD INDEX ( patient_id );
SeLeCt 'created pas_weight_artstart';

-- get the max date value for HEIGHT within 14 days of enroll
DROP TABLE IF EXISTS `pas_height_enroll`;
create temporary table `pas_height_enroll`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.enroll_cutoffdate
where concept_id=5090
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_height_enroll` ADD INDEX ( patient_id );
SeLeCt 'created pas_height_enroll';

-- get the max date value for HEIGHT within 14 days of artstart
DROP TABLE IF EXISTS `pas_height_artstart`;
create temporary table `pas_height_artstart`
as
select * from (
select po.patient_id, obs_date, value_numeric as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.artstart_cutoffdate
where concept_id=5090
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_height_artstart` ADD INDEX ( patient_id );
SeLeCt 'created pas_height_artstart';

-- get the max date value for WHO stage within 14 days of ARV start
-- PIH:1204,PIH:1205,PIH:1206,PIH:1207" answerLabels="1,2,3,4"
DROP TABLE IF EXISTS `pas_who_artstart`;
create temporary table `pas_who_artstart`
as
select * from (
select po.patient_id, obs_date, (value_coded - 1203) as val
from pas_obs as po
left join pas_patient_join as ppj on po.patient_id=ppj.patient_id and po.obs_date <= ppj.artstart_cutoffdate
where concept_id=1480
and ppj.patient_id is not null
order by po.obs_date DESC) as a
group by patient_id;

ALTER TABLE `pas_who_artstart` ADD INDEX ( patient_id );
SeLeCt 'created pas_who_artstart';

-- get the min value for CD4
DROP TABLE IF EXISTS `pas_cd4_min`;
create temporary table `pas_cd4_min`
as
select * from (
select patient_id, obs_date, value_numeric as val
from pas_obs
where concept_id=5497
order by obs_date ASC) as a
group by patient_id;

ALTER TABLE `pas_cd4_min` ADD INDEX ( patient_id );
SeLeCt 'created pas_cd4_min';


-- get the min value for WEIGHT
DROP TABLE IF EXISTS `pas_weight_min`;
create temporary table `pas_weight_min`
as
select * from (
select patient_id, obs_date, value_numeric as val
from pas_obs
where concept_id=5089
order by obs_date ASC) as a
group by patient_id;

ALTER TABLE `pas_weight_min` ADD INDEX ( patient_id );
SeLeCt 'created pas_weight_min';

-- get the min value for HEIGHT
DROP TABLE IF EXISTS `pas_height_min`;
create temporary table `pas_height_min`
as
select * from (
select patient_id, obs_date, value_numeric as val
from pas_obs
where concept_id=5090
order by obs_date ASC) as a
group by patient_id;

ALTER TABLE `pas_height_min` ADD INDEX ( patient_id );
SeLeCt 'created pas_height_min';

DROP TABLE IF EXISTS `pas_patient_rejoin`;
create temporary table `pas_patient_rejoin`
as
select ppj.*
, pce.obs_date as cd4_enroll_date, pce.val as cd4_enroll_val
, pca.obs_date as cd4_artstart_date, pca.val as cd4_artstart_val
, pcm.obs_date as cd4_min_date, pcm.val as cd4_min_val
, pwe.obs_date as weight_enroll_date, pwe.val as weight_enroll_val
, pwa.obs_date as weight_artstart_date, pwa.val as weight_artstart_val
, pwm.obs_date as weight_min_date, pwm.val as weight_min_val
, phe.obs_date as height_enroll_date, phe.val as height_enroll_val
, pha.obs_date as height_artstart_date, pha.val as height_artstart_val
, phm.obs_date as height_min_date, phm.val as height_min_val
, (pwe.val/phe.val) as bmi_enroll
, (pwa.val/pha.val) as bmi_artstart
, pwsa.obs_date as whostage_artstart_date, pwsa.val as whostage_artstart_val
, cast(max(encb.encounter_datetime) as date) as enc_latestdate_1yr_benroll
, cast(min(enca.encounter_datetime) as date) as enc_latestdate_1yr_aenroll
, cast(max(enc.encounter_datetime) as date) as enc_latestdate
, ppc.date_completed as completion_date
, ps.value as state_1year
, cast(ppc.start_date as date) as state_1year_startdate
, cast(ppc.end_date as date) as state_1year_enddate
, COALESCE(ppj.one_yr_penroll_date > @now, 0) as 1year_obs
, COALESCE((ppj.enroll_date + INTERVAL 31 DAY) > ppj.artstart_date, 0) as artstart_w30d
from pas_patient_join as ppj
left join pas_cd4_enroll as pce on ppj.patient_id=pce.patient_id
left join pas_cd4_artstart as pca on ppj.patient_id=pca.patient_id
left join pas_cd4_min as pcm on ppj.patient_id=pcm.patient_id
left join pas_weight_enroll as pwe on ppj.patient_id=pwe.patient_id
left join pas_weight_artstart as pwa on ppj.patient_id=pwa.patient_id
left join pas_weight_min as pwm on ppj.patient_id=pwm.patient_id
left join pas_height_enroll as phe on ppj.patient_id=phe.patient_id
left join pas_height_artstart as pha on ppj.patient_id=pha.patient_id
left join pas_height_min as phm on ppj.patient_id=phm.patient_id
left join pas_who_artstart as pwsa on ppj.patient_id=pwsa.patient_id
left join encounter as enc on ppj.patient_id=enc.patient_id and enc.voided=0 and enc.encounter_type in (1, 2)
left join encounter as encb on ppj.patient_id=encb.patient_id and encb.voided=0 and encb.encounter_type in (1, 2) and encb.encounter_datetime < ppj.one_yr_penroll_date
left join encounter as enca on ppj.patient_id=enca.patient_id and enca.voided=0 and enca.encounter_type in (1, 2) and enca.encounter_datetime >= ppj.one_yr_penroll_date
left join pas_ppps_current as ppc on ppj.patient_id=ppc.patient_id
left join pas_states as ps on ppc.state=ps.id
group by ppj.patient_id
;

-- now export
select 'patient_id', 'ppf_num', 'artu_num', 'art_xfer', 'gender', 'birthdate', 'deathdate', 'dead', 'village', 'district', 'hc', 'enroll_date', 'one_yr_penroll_date', 'enroll_cutoffdate', 'artstart_date', 'artstart_cutoffdate', 'cd4_enroll_date', 'cd4_enroll_val', 'cd4_artstart_date', 'cd4_artstart_val', 'cd4_min_date', 'cd4_min_val', 'weight_enroll_date', 'weight_enroll_val', 'weight_artstart_date', 'weight_artstart_val', 'weight_min_date', 'weight_min_val', 'height_enroll_date', 'height_enroll_val', 'height_artstart_date', 'height_artstart_val', 'height_min_date', 'height_min_val', 'bmi_enroll', 'bmi_artstart', 'whostage_artstart_date', 'whostage_artstart_val', 'enc_latestdate_1yr_benroll', 'enc_latestdate_1yr_aenroll', 'enc_latestdate', 'completion_date', 'state_1year', 'state_1year_startdate', 'state_1year_enddate', '1year_obs', 'artstart_w30d'
union
select *
from pas_patient_rejoin
INTO OUTFILE '/home/achi/mysql_out/pas_export.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n';


END$$

DELIMITER ;
