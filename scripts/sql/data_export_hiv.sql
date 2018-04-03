-- --------------------------------------------------------------------------------
-- call data_export_hiv('RA', '/home/achi/mysql_out');
--   param1 is the site's 2 letter abbreviation
--   param2 is the directory where data_export_hiv.csv will be created
--      if the param2 is null, it will output to caller
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`data_export_hiv`$$
CREATE PROCEDURE `openmrs`.`data_export_hiv`(
_site char(2)
,_export_dir varchar(30)

)
BEGIN

-- select * from mysql.proc where name='data_export_hiv'\G

#create a "patient state id" to "patient state readable text" lookup table
-- select pws.program_workflow_state_id, pws.concept_id, cn.name
-- from program_workflow_state as pws
-- left join concept_name as cn on pws.concept_id=cn.concept_id and cn.voided=0 and cn.locale='en'
-- where pws.program_workflow_id=1
-- group by program_workflow_state_id;
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

select CAST(NOW() as date) into @now;

SELECT @now + INTERVAL 1 DAY INTO @future_date;

-- get the location id
select location_id into @site_id
from location where description=_site;

-- get the list of patients at that location
DROP TABLE IF EXISTS `de_patient_hc`;
create temporary table `de_patient_hc`
as
select pe.person_id as patient_id, CAST((pa.value+0) as signed) as loc
from person_attribute as pa
left join person as pe on pa.person_id=pe.person_id and pe.voided=0
left join patient as p on pa.person_id=p.patient_id and p.voided=0
left join patient_identifier as pi on pa.person_id=pi.patient_id and pi.identifier_type=6 and pi.voided=0
where pa.person_attribute_type_id=7 and pa.voided=0 and pa.value=@site_id
and pe.person_id is not null
and p.patient_id is not null
and (pi.identifier is null OR pi.identifier like CONCAT(_site, '%'));

ALTER TABLE `de_patient_hc` ADD INDEX ( patient_id );

-- get the list of patients with a paper file # starting with the prefix
DROP TABLE IF EXISTS `de_patient_pi`;
create temporary table `de_patient_pi`
as
select pi.patient_id, pi.identifier, pi.location_id as pi_loc_id
, NULL as loc
from patient_identifier as pi
left join patient as pa on pi.patient_id=pa.patient_id and pa.voided=0
where pi.identifier_type=6 and pi.voided=0 and pi.identifier like CONCAT(_site, '%')
and pa.patient_id is not null;

ALTER TABLE `de_patient_pi` ADD INDEX ( patient_id );

-- merge the list of patients between those with the h/c person_attribute and those with a paper file # with the appropriate prefix; we simulate a full outer join by doing a left join, right join
DROP TABLE IF EXISTS `de_patient_tmp`;
create temporary table `de_patient_tmp`
as
select COALESCE(dpp.patient_id, dph.patient_id) as patient_id
,dpp.identifier, dpp.pi_loc_id
,dph.loc as loc
from de_patient_pi as dpp
left join de_patient_hc as dph on dpp.patient_id=dph.patient_id;

ALTER TABLE `de_patient_tmp` ADD INDEX ( patient_id );

DROP TABLE IF EXISTS `de_patient`;
create temporary table `de_patient`
as
select * from de_patient_tmp
union
select COALESCE(dpp.patient_id, dph.patient_id) as patient_id
,dpp.identifier, dpp.pi_loc_id
,dph.loc as loc
from de_patient_pi as dpp
right join de_patient_hc as dph on dpp.patient_id=dph.patient_id;

ALTER TABLE `de_patient` ADD INDEX ( patient_id );


-- we need to get the right patient program for each patient
--  unfortunately, some of the programs are marked as completed e.g. when patient state was moved to abandoned, and then they came back
-- so we need to do a bunch of stuff to get the latest patient program
DROP TABLE IF EXISTS `de_get_pp`;
create temporary table `de_get_pp`
as
select dp.patient_id, dp.identifier, dp.pi_loc_id
, pp.patient_program_id
, CAST(pp.date_enrolled as date) as date_enrolled
, CAST(COALESCE(pp.date_completed, @future_date) as date) as date_completed
, dp.loc
, ps.state
, ps.start_date
, COALESCE(ps.end_date, @future_date) as end_date
from de_patient as dp
left join patient_program as pp on dp.patient_id=pp.patient_id and pp.program_id=1 and pp.voided=0
left join patient_state as ps on pp.patient_program_id=ps.patient_program_id and ps.voided=0;

ALTER TABLE `de_get_pp` ADD INDEX ( patient_id );


-- now get the latest enrollment and latest state end date to get the current state
DROP TABLE IF EXISTS `de_get_pp_latest`;
create temporary table `de_get_pp_latest`
as
select * from (
select patient_id, identifier, pi_loc_id
, date_completed, state, start_date, end_date, loc
from de_get_pp
order by date_completed DESC, end_date DESC) as a
group by patient_id;

ALTER TABLE `de_get_pp_latest` ADD INDEX ( patient_id );

UPDATE de_get_pp_latest
SET end_date=NULL
WHERE end_date=@future_date;

-- make sure we are getting the first enrollment (since there may be multiple enrollments
DROP TABLE IF EXISTS `de_get_pp_first`;
create temporary table `de_get_pp_first`
as
select * from (select patient_id, date_enrolled, date_completed
from de_get_pp
order by date_enrolled ASC) as a
group by patient_id;

ALTER TABLE `de_get_pp_first` ADD INDEX ( patient_id );


DROP TABLE IF EXISTS `de_main`;
create temporary table `de_main`
as
select dgpl.patient_id, dgpl.identifier, dgpl.pi_loc_id
, dgpl.state, cast(dgpl.start_date as date) as state_startdate, cast(dgpl.end_date as date) as state_enddate
, dgpl.loc
, p.gender, p.birthdate, cast(p.death_date as date) as deathdate, p.dead
, pea.city_village, pea.address3, pea.county_district, COALESCE(pea.country, 0) as country, pea.latitude, pea.longitude
, pn.given_name, pn.family_name
, dgpf.date_enrolled
, dgpf.date_completed
, min(enc.encounter_datetime) as enc_firstdate, max(enc.encounter_datetime) as enc_latestdate
from de_get_pp_latest as dgpl
left join person as p on dgpl.patient_id=p.person_id and p.voided=0
left join person_address as pea on dgpl.patient_id=pea.person_id and pea.voided=0 and preferred=1
left join person_name as pn on dgpl.patient_id=pn.person_id and pn.voided=0
left join de_get_pp_first as dgpf on dgpl.patient_id=dgpf.patient_id
left join encounter as enc on dgpl.patient_id=enc.patient_id and enc.voided=0 and enc.encounter_type in (1, 2)
group by dgpl.patient_id;

ALTER TABLE `de_main` ADD INDEX ( patient_id );

UPDATE de_main as de
SET date_completed=NULL
WHERE date_completed=@future_date;

DROP TABLE IF EXISTS `de_obs`;
create temporary table `de_obs`
as
select obs.person_id, obs.encounter_id, cast(obs.obs_datetime as date) as obs_date, cast(obs.value_datetime as date) as value_date, obs.value_numeric, obs.value_text, obs.concept_id, obs.value_coded
from obs
left join de_main as dm on obs.person_id=dm.patient_id
where obs.concept_id IN (1480, 2676, 2876, 5096, 5497, 5089, 5090, 856, 6998) and obs.voided=0
and dm.patient_id is not null;

ALTER TABLE `de_obs` ADD INDEX ( person_id );


#latest next_return_visit
DROP TABLE IF EXISTS `de_rvisit`;
create temporary table `de_rvisit`
as
select person_id, max(value_date) as next_return_visit
from de_obs
where concept_id=5096
group by person_id;

ALTER TABLE `de_rvisit` ADD INDEX ( person_id );


#latest next_refill1
DROP TABLE IF EXISTS `de_refill1`;
create temporary table `de_refill1`
as
select person_id, max(value_date) as next_refill
from de_obs
where concept_id=2676
group by person_id;

ALTER TABLE `de_refill1` ADD INDEX ( person_id );

#latest next_refill2
DROP TABLE IF EXISTS `de_refill2`;
create temporary table `de_refill2`
as
select person_id, max(value_date) as next_refill
from de_obs
where concept_id=6974
group by person_id;

ALTER TABLE `de_refill2` ADD INDEX ( person_id );

#vl_latest
DROP TABLE IF EXISTS `de_vl_latest`;
create temporary table `de_vl_latest`
as
select * from (
select person_id, obs_date as vl_latestdate, value_numeric as vl_latest
from de_obs
where concept_id=856
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_vl_latest` ADD INDEX ( person_id );

#vlu_latest
DROP TABLE IF EXISTS `de_vlu_latest`;
create temporary table `de_vlu_latest`
as
select * from (
select person_id, obs_date as vlu_latestdate, value_numeric as vlu_latest
from de_obs
where concept_id=6998
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_vlu_latest` ADD INDEX ( person_id );

#cd4_latest
DROP TABLE IF EXISTS `de_cd4_latest`;
create temporary table `de_cd4_latest`
as
select * from (
select person_id, obs_date as cd4_latestdate, value_numeric as cd4_latest
from de_obs
where concept_id=5497
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_cd4_latest` ADD INDEX ( person_id );

#cd4_first
DROP TABLE IF EXISTS `de_cd4_first`;
create temporary table `de_cd4_first`
as
select * from (
select person_id, obs_date as cd4_firstdate, value_numeric as cd4_first
from de_obs
where concept_id=5497
order by obs_date ASC) as a
group by person_id;

ALTER TABLE `de_cd4_first` ADD INDEX ( person_id );


#arv_latest
DROP TABLE IF EXISTS `de_arv_latest`;
create temporary table `de_arv_latest`
as
select * from (
select person_id, obs_date as arv_latestdate, CAST(value_text as char(8)) as arv_latest
from de_obs
where concept_id=2876
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_arv_latest` ADD INDEX ( person_id );

#arv_first
DROP TABLE IF EXISTS `de_arv_first`;
create temporary table `de_arv_first`
as
select * from (
select person_id, obs_date as arv_firstdate, CAST(value_text as char(8)) as arv_first
from de_obs
where concept_id=2876
order by obs_date ASC) as a
group by person_id;

ALTER TABLE `de_arv_first` ADD INDEX ( person_id );

#whos_obs
DROP TABLE IF EXISTS `de_whos_obs`;
create temporary table `de_whos_obs`
as
select person_id
, obs_date
, (value_coded - 1203) as obs_value
, encounter_id
from de_obs
where concept_id=1480
order by value_coded DESC, obs_date ASC;

ALTER TABLE `de_whos_obs` ADD INDEX ( person_id );

#whos_firstmax (who stage max - earliest date with max value)
DROP TABLE IF EXISTS `de_whos_firstmax`;
create temporary table `de_whos_firstmax`
as
select * from
(select person_id
, obs_date as whos_firstmaxdate
, obs_value as whos_firstmax
from de_whos_obs
order by obs_value DESC, obs_date ASC) as a
group by person_id;

ALTER TABLE `de_whos_firstmax` ADD INDEX ( person_id );

DROP TABLE IF EXISTS `de_whos_firstchg`;
create temporary table `de_whos_firstchg`
as
select * from (
select dwo.encounter_id, dwo.person_id, dwo.obs_value, dwo.obs_date
from de_whos_firstmax as dwm
left join de_whos_obs as dwo on dwo.person_id=dwm.person_id
and dwo.obs_value < dwm.whos_firstmax and dwo.obs_date > dwm.whos_firstmaxdate
where dwo.person_id is not null
order by dwo.obs_value DESC, dwo.obs_date ASC) as a
group by person_id;

ALTER TABLE `de_whos_firstchg` ADD INDEX ( person_id );

#weight
DROP TABLE IF EXISTS `de_weight`;
create temporary table `de_weight`
as
select * from (
select person_id, obs_date as weightdate, value_numeric as weight
from de_obs
where concept_id=5089
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_weight` ADD INDEX ( person_id );

#height
DROP TABLE IF EXISTS `de_height`;
create temporary table `de_height`
as
select * from (
select person_id, obs_date as heightdate, value_numeric as height
from de_obs
where concept_id=5090
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_height` ADD INDEX ( person_id );


DROP TABLE IF EXISTS `de_final`;
-- create table `de_final`
create temporary table `de_final`
as
select dm.patient_id
,dm.identifier as paperf_no
,dm.pi_loc_id as paperf_no_loc
,pi.identifier as artu_no
,pi.location_id as artu_no_loc
,dm.given_name as pat_gname
,dm.family_name as pat_surname
,dm.county_district as district
,dm.address3 as council
,dm.city_village as village
,dm.country as addr_hier_match
,dm.latitude as latitude
,dm.longitude as longitude
,rpn.given_name as chw_gname
,rpn.family_name as chw_surname
,dm.gender
,(YEAR(COALESCE(dm.deathdate, @now)) - YEAR(dm.birthdate) - (date_format(COALESCE(dm.deathdate, @now),'00-%m-%d') < date_format(dm.birthdate,'00-%m-%d'))) as age
,dm.birthdate
,dm.deathdate
,dm.dead
,cast(dm.enc_firstdate as date) as enc_firstdate
,cast(dm.enc_latestdate as date) as enc_latestdate
,CONCAT(pn.given_name, ' ', pn.family_name) as enc_provider
,dm.date_enrolled as enrolldate
,dm.date_completed as completedate
,dm.state as state_id
,dm.loc as loc_id
,des.value as state
,DATEDIFF(@now, dm.state_startdate) as state_dayspassed
,dm.state_startdate
,dm.state_enddate
,dm.state in (1, 2, 27, 28, 38, 40) as state_active
,dv.next_return_visit
,dr1.next_refill as next_refill1
,dr2.next_refill as next_refill2
,vll.vl_latest
,vll.vl_latestdate
,vlul.vlu_latest
,vlul.vlu_latestdate
,dcf.cd4_firstdate
,dcf.cd4_first
,dcl.cd4_latestdate
,dcl.cd4_latest
,daf.arv_firstdate
,daf.arv_first
,dal.arv_latestdate
,dal.arv_latest
,dwm.whos_firstmax
,dwm.whos_firstmaxdate
,dwc.obs_value as whos_invalid
,dwc.obs_date as whos_invaliddate
,CONCAT(dwp.given_name, ' ', dwp.family_name) as whos_invalidprovider
,dw.weightdate
,dw.weight
,dh.heightdate
,dh.height
from de_main as dm
left join de_rvisit as dv on dm.patient_id=dv.person_id
left join de_refill1 as dr1 on dm.patient_id=dr1.person_id
left join de_refill2 as dr2 on dm.patient_id=dr2.person_id
left join de_vl_latest as vll on dm.patient_id=vll.person_id
left join de_vlu_latest as vlul on dm.patient_id=vlul.person_id
left join de_cd4_first as dcf on dm.patient_id=dcf.person_id
left join de_cd4_latest as dcl on dm.patient_id=dcl.person_id
left join de_arv_first as daf on dm.patient_id=daf.person_id
left join de_arv_latest as dal on dm.patient_id=dal.person_id
left join de_whos_firstmax as dwm on dm.patient_id=dwm.person_id
left join de_whos_firstchg as dwc on dm.patient_id=dwc.person_id
left join encounter as dwe on dwc.encounter_id=dwe.encounter_id
left join encounter_provider as ep on dwe.encounter_id=ep.encounter_id
left join person_name as dwp on ep.provider_id=dwp.person_id
left join de_weight as dw on dm.patient_id=dw.person_id
left join de_height as dh on dm.patient_id=dh.person_id
left join relationship as r on dm.patient_id=r.person_b and r.relationship=1
left join person_name as rpn on rpn.person_id=r.person_a
left join patient_identifier as pi on dm.patient_id=pi.patient_id and pi.identifier_type=2 and pi.voided=0
left join de_states as des on dm.state=des.id
left join encounter as enc on dm.patient_id=enc.patient_id and enc.encounter_type in (1,2) and enc.encounter_datetime=dm.enc_latestdate
left join person_name as pn on ep.provider_id=pn.person_id
group by dm.patient_id
;

/*
DROP TABLE IF EXISTS `de_states`;
DROP TABLE IF EXISTS `de_get_pp`;
DROP TABLE IF EXISTS `de_get_pp_latest`;
DROP TABLE IF EXISTS `de_get_pp_first`;
DROP TABLE IF EXISTS `de_main`;
DROP TABLE IF EXISTS `de_obs`;
DROP TABLE IF EXISTS `de_rvisit`;
DROP TABLE IF EXISTS `de_refill1`;
DROP TABLE IF EXISTS `de_refill2`;
DROP TABLE IF EXISTS `de_cd4_latest`;
DROP TABLE IF EXISTS `de_cd4_first`;
DROP TABLE IF EXISTS `de_arv_latest`;
DROP TABLE IF EXISTS `de_arv_first`;
DROP TABLE IF EXISTS `de_weight`;
DROP TABLE IF EXISTS `de_height`;
DROP TABLE IF EXISTS `de_chw_gname`;
DROP TABLE IF EXISTS `de_chw_surname`;
*/

-- IF _export_dir IS NULL THEN

    -- output to the caller
    -- select * from de_final order by de_final.paperf_no ASC;

    -- DROP TABLE IF EXISTS `de_final`;

-- ELSE

IF _export_dir IS NOT NULL THEN

  SELECT concat("
  SELECT 'patient_id', 'paperf_no', 'artu_no'
  , 'pat_gname', 'pat_surname'
  , 'district', 'council', 'village', 'addr_hier_match', 'latitude', 'longitude'
  , 'chw_given', 'chw_surname'
  , 'gender', 'age', 'birthdate', 'dead', 'deathdate'
  , 'enc_firstdate', 'enc_latestdate', 'enc_provider'
  , 'enrolldate', 'completedate'
  , 'state', 'state_dayspassed', 'state_startdate', 'state_enddate', 'state_active'
  , 'next_return_visit', 'next_refill1', 'next_refill2'
  , 'vl_latest', 'vl_latestdate', 'vlu_latest', 'vlu_latestdate'
  , 'cd4_firstdate', 'cd4_first', 'cd4_latestdate', 'cd4_latest'
  , 'arv_firstdate', 'arv_first', 'arv_latestdate', 'arv_latest'
  , 'whos_firstmax', 'whos_firstmaxdate', 'whos_invalid', 'whos_invaliddate', 'whos_invalidprovider'
  , 'weightdate', 'weight'
  , 'heightdate', 'height'
  UNION
  select patient_id
  , coalesce(paperf_no, '')
  , coalesce(artu_no, '')
  , coalesce(pat_gname, '')
  , coalesce(pat_surname, '')
  , coalesce(district, '')
  , coalesce(council, '')
  , coalesce(village, '')
  , coalesce(addr_hier_match, '')
  , coalesce(latitude, '')
  , coalesce(longitude, '')
  , coalesce(chw_gname, '')
  , coalesce(chw_surname, '')
  , coalesce(gender, '')
  , coalesce(age, '')
  , coalesce(birthdate, '')
  , coalesce(dead, '')
  , coalesce(deathdate, '')
  , coalesce(enc_firstdate, '')
  , coalesce(enc_latestdate, '')
  , coalesce(enc_provider, '')
  , coalesce(enrolldate, '')
  , coalesce(completedate, '')
  , coalesce(state, '')
  , coalesce(state_dayspassed, '')
  , coalesce(state_startdate, '')
  , coalesce(state_enddate, '')
  , coalesce(state_active, '')
  , coalesce(next_return_visit, '')
  , coalesce(next_refill1, '')
  , coalesce(next_refill2, '')
  , coalesce(vl_latest, '')
  , coalesce(vl_latestdate, '')
  , coalesce(vlu_latest, '')
  , coalesce(vlu_latestdate, '')
  , coalesce(cd4_firstdate, '')
  , coalesce(cd4_first, '')
  , coalesce(cd4_latestdate, '')
  , coalesce(cd4_latest, '')
  , coalesce(arv_firstdate, '')
  , coalesce(arv_first, '')
  , coalesce(arv_latestdate, '')
  , coalesce(arv_latest, '')
  , coalesce(whos_firstmax, '')
  , coalesce(whos_firstmaxdate, '')
  , coalesce(whos_invalid, '')
  , coalesce(whos_invaliddate, '')
  , coalesce(whos_invalidprovider, '')
  , coalesce(weightdate, '')
  , coalesce(weight, '')
  , coalesce(heightdate, '')
  , coalesce(height, '')
  FROM de_final
  INTO OUTFILE '", _export_dir, "/data_export_hiv.csv'
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '\"'
  LINES TERMINATED BY '\n';") INTO @output_cmd;

  PREPARE stmt FROM @output_cmd;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  -- DROP TABLE IF EXISTS `de_final`;

END IF;

END
             definer: root@localhost
             created: 2017-03-30 17:03:36
            modified: 2017-03-30 17:03:36
            sql_mode: 
             comment: 
character_set_client: utf8
collation_connection: utf8_general_ci
        db_collation: utf8_general_ci
           body_utf8: BEGIN

#create a "patient state id" to "patient state readable text" lookup table
-- select pws.program_workflow_state_id, pws.concept_id, cn.name
-- from program_workflow_state as pws
-- left join concept_name as cn on pws.concept_id=cn.concept_id and cn.voided=0 and cn.locale='en'
-- where pws.program_workflow_id=1
-- group by program_workflow_state_id;
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

select CAST(NOW() as date) into @now;

SELECT @now + INTERVAL 1 DAY INTO @future_date;

-- get the location id
select location_id into @site_id
from location where description=_site;

-- get the list of patients at that location
DROP TABLE IF EXISTS `de_patient_hc`;
create temporary table `de_patient_hc`
as
select pe.person_id as patient_id, CAST((pa.value+0) as signed) as loc
from person_attribute as pa
left join person as pe on pa.person_id=pe.person_id and pe.voided=0
left join patient as p on pa.person_id=p.patient_id and p.voided=0
left join patient_identifier as pi on pa.person_id=pi.patient_id and pi.identifier_type=6 and pi.voided=0
where pa.person_attribute_type_id=7 and pa.voided=0 and pa.value=@site_id
and pe.person_id is not null
and p.patient_id is not null
and (pi.identifier is null OR pi.identifier like CONCAT(_site, '%'));

ALTER TABLE `de_patient_hc` ADD INDEX ( patient_id );

-- get the list of patients with a paper file # starting with the prefix
DROP TABLE IF EXISTS `de_patient_pi`;
create temporary table `de_patient_pi`
as
select pi.patient_id, pi.identifier, pi.location_id as pi_loc_id
, NULL as loc
from patient_identifier as pi
left join patient as pa on pi.patient_id=pa.patient_id and pa.voided=0
where pi.identifier_type=6 and pi.voided=0 and pi.identifier like CONCAT(_site, '%')
and pa.patient_id is not null;

ALTER TABLE `de_patient_pi` ADD INDEX ( patient_id );

-- merge the list of patients between those with the h/c person_attribute and those with a paper file # with the appropriate prefix; we simulate a full outer join by doing a left join, right join
DROP TABLE IF EXISTS `de_patient_tmp`;
create temporary table `de_patient_tmp`
as
select COALESCE(dpp.patient_id, dph.patient_id) as patient_id
,dpp.identifier, dpp.pi_loc_id
,dph.loc as loc
from de_patient_pi as dpp
left join de_patient_hc as dph on dpp.patient_id=dph.patient_id;

ALTER TABLE `de_patient_tmp` ADD INDEX ( patient_id );

DROP TABLE IF EXISTS `de_patient`;
create temporary table `de_patient`
as
select * from de_patient_tmp
union
select COALESCE(dpp.patient_id, dph.patient_id) as patient_id
,dpp.identifier, dpp.pi_loc_id
,dph.loc as loc
from de_patient_pi as dpp
right join de_patient_hc as dph on dpp.patient_id=dph.patient_id;

ALTER TABLE `de_patient` ADD INDEX ( patient_id );


-- we need to get the right patient program for each patient
--  unfortunately, some of the programs are marked as completed e.g. when patient state was moved to abandoned, and then they came back
-- so we need to do a bunch of stuff to get the latest patient program
DROP TABLE IF EXISTS `de_get_pp`;
create temporary table `de_get_pp`
as
select dp.patient_id, dp.identifier, dp.pi_loc_id
, pp.patient_program_id
, CAST(pp.date_enrolled as date) as date_enrolled
, CAST(COALESCE(pp.date_completed, @future_date) as date) as date_completed
, dp.loc
, ps.state
, ps.start_date
, COALESCE(ps.end_date, @future_date) as end_date
from de_patient as dp
left join patient_program as pp on dp.patient_id=pp.patient_id and pp.program_id=1 and pp.voided=0
left join patient_state as ps on pp.patient_program_id=ps.patient_program_id and ps.voided=0;

ALTER TABLE `de_get_pp` ADD INDEX ( patient_id );


-- now get the latest enrollment and latest state end date to get the current state
DROP TABLE IF EXISTS `de_get_pp_latest`;
create temporary table `de_get_pp_latest`
as
select * from (
select patient_id, identifier, pi_loc_id
, date_completed, state, start_date, end_date, loc
from de_get_pp
order by date_completed DESC, end_date DESC) as a
group by patient_id;

ALTER TABLE `de_get_pp_latest` ADD INDEX ( patient_id );

UPDATE de_get_pp_latest
SET end_date=NULL
WHERE end_date=@future_date;

-- make sure we are getting the first enrollment (since there may be multiple enrollments
DROP TABLE IF EXISTS `de_get_pp_first`;
create temporary table `de_get_pp_first`
as
select * from (select patient_id, date_enrolled, date_completed
from de_get_pp
order by date_enrolled ASC) as a
group by patient_id;

ALTER TABLE `de_get_pp_first` ADD INDEX ( patient_id );


DROP TABLE IF EXISTS `de_main`;
create temporary table `de_main`
as
select dgpl.patient_id, dgpl.identifier, dgpl.pi_loc_id
, dgpl.state, cast(dgpl.start_date as date) as state_startdate, cast(dgpl.end_date as date) as state_enddate
, dgpl.loc
, p.gender, p.birthdate, cast(p.death_date as date) as deathdate, p.dead
, pea.city_village, pea.address3, pea.county_district, COALESCE(pea.country, 0) as country, pea.latitude, pea.longitude
, pn.given_name, pn.family_name
, dgpf.date_enrolled
, dgpf.date_completed
, min(enc.encounter_datetime) as enc_firstdate, max(enc.encounter_datetime) as enc_latestdate
from de_get_pp_latest as dgpl
left join person as p on dgpl.patient_id=p.person_id and p.voided=0
left join person_address as pea on dgpl.patient_id=pea.person_id and pea.voided=0 and preferred=1
left join person_name as pn on dgpl.patient_id=pn.person_id and pn.voided=0
left join de_get_pp_first as dgpf on dgpl.patient_id=dgpf.patient_id
left join encounter as enc on dgpl.patient_id=enc.patient_id and enc.voided=0 and enc.encounter_type in (1, 2)
group by dgpl.patient_id;

ALTER TABLE `de_main` ADD INDEX ( patient_id );

UPDATE de_main as de
SET date_completed=NULL
WHERE date_completed=@future_date;

DROP TABLE IF EXISTS `de_obs`;
create temporary table `de_obs`
as
select obs.person_id, obs.encounter_id, cast(obs.obs_datetime as date) as obs_date, cast(obs.value_datetime as date) as value_date, obs.value_numeric, obs.value_text, obs.concept_id, obs.value_coded
from obs
left join de_main as dm on obs.person_id=dm.patient_id
where obs.concept_id IN (1480, 2676, 2876, 5096, 5497, 5089, 5090, 856, 6998) and obs.voided=0
and dm.patient_id is not null;

ALTER TABLE `de_obs` ADD INDEX ( person_id );


#latest next_return_visit
DROP TABLE IF EXISTS `de_rvisit`;
create temporary table `de_rvisit`
as
select person_id, max(value_date) as next_return_visit
from de_obs
where concept_id=5096
group by person_id;

ALTER TABLE `de_rvisit` ADD INDEX ( person_id );


#latest next_refill1
DROP TABLE IF EXISTS `de_refill1`;
create temporary table `de_refill1`
as
select person_id, max(value_date) as next_refill
from de_obs
where concept_id=2676
group by person_id;

ALTER TABLE `de_refill1` ADD INDEX ( person_id );

#latest next_refill2
DROP TABLE IF EXISTS `de_refill2`;
create temporary table `de_refill2`
as
select person_id, max(value_date) as next_refill
from de_obs
where concept_id=6974
group by person_id;

ALTER TABLE `de_refill2` ADD INDEX ( person_id );

#vl_latest
DROP TABLE IF EXISTS `de_vl_latest`;
create temporary table `de_vl_latest`
as
select * from (
select person_id, obs_date as vl_latestdate, value_numeric as vl_latest
from de_obs
where concept_id=856
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_vl_latest` ADD INDEX ( person_id );

#vlu_latest
DROP TABLE IF EXISTS `de_vlu_latest`;
create temporary table `de_vlu_latest`
as
select * from (
select person_id, obs_date as vlu_latestdate, value_numeric as vlu_latest
from de_obs
where concept_id=6998
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_vlu_latest` ADD INDEX ( person_id );

#cd4_latest
DROP TABLE IF EXISTS `de_cd4_latest`;
create temporary table `de_cd4_latest`
as
select * from (
select person_id, obs_date as cd4_latestdate, value_numeric as cd4_latest
from de_obs
where concept_id=5497
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_cd4_latest` ADD INDEX ( person_id );

#cd4_first
DROP TABLE IF EXISTS `de_cd4_first`;
create temporary table `de_cd4_first`
as
select * from (
select person_id, obs_date as cd4_firstdate, value_numeric as cd4_first
from de_obs
where concept_id=5497
order by obs_date ASC) as a
group by person_id;

ALTER TABLE `de_cd4_first` ADD INDEX ( person_id );


#arv_latest
DROP TABLE IF EXISTS `de_arv_latest`;
create temporary table `de_arv_latest`
as
select * from (
select person_id, obs_date as arv_latestdate, CAST(value_text as char(8)) as arv_latest
from de_obs
where concept_id=2876
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_arv_latest` ADD INDEX ( person_id );

#arv_first
DROP TABLE IF EXISTS `de_arv_first`;
create temporary table `de_arv_first`
as
select * from (
select person_id, obs_date as arv_firstdate, CAST(value_text as char(8)) as arv_first
from de_obs
where concept_id=2876
order by obs_date ASC) as a
group by person_id;

ALTER TABLE `de_arv_first` ADD INDEX ( person_id );

#whos_obs
DROP TABLE IF EXISTS `de_whos_obs`;
create temporary table `de_whos_obs`
as
select person_id
, obs_date
, (value_coded - 1203) as obs_value
, encounter_id
from de_obs
where concept_id=1480
order by value_coded DESC, obs_date ASC;

ALTER TABLE `de_whos_obs` ADD INDEX ( person_id );

#whos_firstmax (who stage max - earliest date with max value)
DROP TABLE IF EXISTS `de_whos_firstmax`;
create temporary table `de_whos_firstmax`
as
select * from
(select person_id
, obs_date as whos_firstmaxdate
, obs_value as whos_firstmax
from de_whos_obs
order by obs_value DESC, obs_date ASC) as a
group by person_id;

ALTER TABLE `de_whos_firstmax` ADD INDEX ( person_id );

DROP TABLE IF EXISTS `de_whos_firstchg`;
create temporary table `de_whos_firstchg`
as
select * from (
select dwo.encounter_id, dwo.person_id, dwo.obs_value, dwo.obs_date
from de_whos_firstmax as dwm
left join de_whos_obs as dwo on dwo.person_id=dwm.person_id
and dwo.obs_value < dwm.whos_firstmax and dwo.obs_date > dwm.whos_firstmaxdate
where dwo.person_id is not null
order by dwo.obs_value DESC, dwo.obs_date ASC) as a
group by person_id;

ALTER TABLE `de_whos_firstchg` ADD INDEX ( person_id );

#weight
DROP TABLE IF EXISTS `de_weight`;
create temporary table `de_weight`
as
select * from (
select person_id, obs_date as weightdate, value_numeric as weight
from de_obs
where concept_id=5089
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_weight` ADD INDEX ( person_id );

#height
DROP TABLE IF EXISTS `de_height`;
create temporary table `de_height`
as
select * from (
select person_id, obs_date as heightdate, value_numeric as height
from de_obs
where concept_id=5090
order by obs_date DESC) as a
group by person_id;

ALTER TABLE `de_height` ADD INDEX ( person_id );


DROP TABLE IF EXISTS `de_final`;
-- create table `de_final`
create temporary table `de_final`
as
select dm.patient_id
,dm.identifier as paperf_no
,dm.pi_loc_id as paperf_no_loc
,pi.identifier as artu_no
,pi.location_id as artu_no_loc
,dm.given_name as pat_gname
,dm.family_name as pat_surname
,dm.county_district as district
,dm.address3 as council
,dm.city_village as village
,dm.country as addr_hier_match
,dm.latitude as latitude
,dm.longitude as longitude
,rpn.given_name as chw_gname
,rpn.family_name as chw_surname
,dm.gender
,(YEAR(COALESCE(dm.deathdate, @now)) - YEAR(dm.birthdate) - (date_format(COALESCE(dm.deathdate, @now),'00-%m-%d') < date_format(dm.birthdate,'00-%m-%d'))) as age
,dm.birthdate
,dm.deathdate
,dm.dead
,cast(dm.enc_firstdate as date) as enc_firstdate
,cast(dm.enc_latestdate as date) as enc_latestdate
,CONCAT(pn.given_name, ' ', pn.family_name) as enc_provider
,dm.date_enrolled as enrolldate
,dm.date_completed as completedate
,dm.state as state_id
,dm.loc as loc_id
,des.value as state
,DATEDIFF(@now, dm.state_startdate) as state_dayspassed
,dm.state_startdate
,dm.state_enddate
,dm.state in (1, 2, 27, 28, 38, 40) as state_active
,dv.next_return_visit
,dr1.next_refill as next_refill1
,dr2.next_refill as next_refill2
,vll.vl_latest
,vll.vl_latestdate
,vlul.vlu_latest
,vlul.vlu_latestdate
,dcf.cd4_firstdate
,dcf.cd4_first
,dcl.cd4_latestdate
,dcl.cd4_latest
,daf.arv_firstdate
,daf.arv_first
,dal.arv_latestdate
,dal.arv_latest
,dwm.whos_firstmax
,dwm.whos_firstmaxdate
,dwc.obs_value as whos_invalid
,dwc.obs_date as whos_invaliddate
,CONCAT(dwp.given_name, ' ', dwp.family_name) as whos_invalidprovider
,dw.weightdate
,dw.weight
,dh.heightdate
,dh.height
from de_main as dm
left join de_rvisit as dv on dm.patient_id=dv.person_id
left join de_refill1 as dr1 on dm.patient_id=dr1.person_id
left join de_refill2 as dr2 on dm.patient_id=dr2.person_id
left join de_vl_latest as vll on dm.patient_id=vll.person_id
left join de_vlu_latest as vlul on dm.patient_id=vlul.person_id
left join de_cd4_first as dcf on dm.patient_id=dcf.person_id
left join de_cd4_latest as dcl on dm.patient_id=dcl.person_id
left join de_arv_first as daf on dm.patient_id=daf.person_id
left join de_arv_latest as dal on dm.patient_id=dal.person_id
left join de_whos_firstmax as dwm on dm.patient_id=dwm.person_id
left join de_whos_firstchg as dwc on dm.patient_id=dwc.person_id
left join encounter as dwe on dwc.encounter_id=dwe.encounter_id
left join encounter_provider as ep on dwe.encounter_id=ep.encounter_id
left join person_name as dwp on ep.provider_id=dwp.person_id
left join de_weight as dw on dm.patient_id=dw.person_id
left join de_height as dh on dm.patient_id=dh.person_id
left join relationship as r on dm.patient_id=r.person_b and r.relationship=1
left join person_name as rpn on rpn.person_id=r.person_a
left join patient_identifier as pi on dm.patient_id=pi.patient_id and pi.identifier_type=2 and pi.voided=0
left join de_states as des on dm.state=des.id
left join encounter as enc on dm.patient_id=enc.patient_id and enc.encounter_type in (1,2) and enc.encounter_datetime=dm.enc_latestdate
left join person_name as pn on ep.provider_id=pn.person_id
group by dm.patient_id
;

/*
DROP TABLE IF EXISTS `de_states`;
DROP TABLE IF EXISTS `de_get_pp`;
DROP TABLE IF EXISTS `de_get_pp_latest`;
DROP TABLE IF EXISTS `de_get_pp_first`;
DROP TABLE IF EXISTS `de_main`;
DROP TABLE IF EXISTS `de_obs`;
DROP TABLE IF EXISTS `de_rvisit`;
DROP TABLE IF EXISTS `de_refill1`;
DROP TABLE IF EXISTS `de_refill2`;
DROP TABLE IF EXISTS `de_cd4_latest`;
DROP TABLE IF EXISTS `de_cd4_first`;
DROP TABLE IF EXISTS `de_arv_latest`;
DROP TABLE IF EXISTS `de_arv_first`;
DROP TABLE IF EXISTS `de_weight`;
DROP TABLE IF EXISTS `de_height`;
DROP TABLE IF EXISTS `de_chw_gname`;
DROP TABLE IF EXISTS `de_chw_surname`;
*/

-- IF _export_dir IS NULL THEN

    -- output to the caller
    -- select * from de_final order by de_final.paperf_no ASC;

    -- DROP TABLE IF EXISTS `de_final`;

-- ELSE

IF _export_dir IS NOT NULL THEN

  SELECT concat("
  SELECT 'patient_id', 'paperf_no', 'artu_no'
  , 'pat_gname', 'pat_surname'
  , 'district', 'council', 'village', 'addr_hier_match', 'latitude', 'longitude'
  , 'chw_given', 'chw_surname'
  , 'gender', 'age', 'birthdate', 'dead', 'deathdate'
  , 'enc_firstdate', 'enc_latestdate', 'enc_provider'
  , 'enrolldate', 'completedate'
  , 'state', 'state_dayspassed', 'state_startdate', 'state_enddate', 'state_active'
  , 'next_return_visit', 'next_refill1', 'next_refill2'
  , 'vl_latest', 'vl_latestdate', 'vlu_latest', 'vlu_latestdate'
  , 'cd4_firstdate', 'cd4_first', 'cd4_latestdate', 'cd4_latest'
  , 'arv_firstdate', 'arv_first', 'arv_latestdate', 'arv_latest'
  , 'whos_firstmax', 'whos_firstmaxdate', 'whos_invalid', 'whos_invaliddate', 'whos_invalidprovider'
  , 'weightdate', 'weight'
  , 'heightdate', 'height'
  UNION
  select patient_id
  , coalesce(paperf_no, '')
  , coalesce(artu_no, '')
  , coalesce(pat_gname, '')
  , coalesce(pat_surname, '')
  , coalesce(district, '')
  , coalesce(council, '')
  , coalesce(village, '')
  , coalesce(addr_hier_match, '')
  , coalesce(latitude, '')
  , coalesce(longitude, '')
  , coalesce(chw_gname, '')
  , coalesce(chw_surname, '')
  , coalesce(gender, '')
  , coalesce(age, '')
  , coalesce(birthdate, '')
  , coalesce(dead, '')
  , coalesce(deathdate, '')
  , coalesce(enc_firstdate, '')
  , coalesce(enc_latestdate, '')
  , coalesce(enc_provider, '')
  , coalesce(enrolldate, '')
  , coalesce(completedate, '')
  , coalesce(state, '')
  , coalesce(state_dayspassed, '')
  , coalesce(state_startdate, '')
  , coalesce(state_enddate, '')
  , coalesce(state_active, '')
  , coalesce(next_return_visit, '')
  , coalesce(next_refill1, '')
  , coalesce(next_refill2, '')
  , coalesce(vl_latest, '')
  , coalesce(vl_latestdate, '')
  , coalesce(vlu_latest, '')
  , coalesce(vlu_latestdate, '')
  , coalesce(cd4_firstdate, '')
  , coalesce(cd4_first, '')
  , coalesce(cd4_latestdate, '')
  , coalesce(cd4_latest, '')
  , coalesce(arv_firstdate, '')
  , coalesce(arv_first, '')
  , coalesce(arv_latestdate, '')
  , coalesce(arv_latest, '')
  , coalesce(whos_firstmax, '')
  , coalesce(whos_firstmaxdate, '')
  , coalesce(whos_invalid, '')
  , coalesce(whos_invaliddate, '')
  , coalesce(whos_invalidprovider, '')
  , coalesce(weightdate, '')
  , coalesce(weight, '')
  , coalesce(heightdate, '')
  , coalesce(height, '')
  FROM de_final
  INTO OUTFILE '", _export_dir, "/data_export_hiv.csv'
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '
';") INTO @output_cmd;

  PREPARE stmt FROM @output_cmd;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

  -- DROP TABLE IF EXISTS `de_final`;

END IF;

END$$

DELIMITER ;
