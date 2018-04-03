-- -------------------------------------------------------------------------
-- call data_quality_hiv('RA', '/tmp');
--   param1 is the site's 2 letter abbreviation
--   param2 is the directory where data_quality_hiv.csv will be created
--      if the param2 is null, it will output to caller
-- -------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`data_quality_hiv`$$

CREATE PROCEDURE `openmrs`.`data_quality_hiv`(
_site char(2)
,_export_dir varchar(30)
)
BEGIN

select CONCAT('^', format, '$') into @paperf_fmt
from patient_identifier_type
where patient_identifier_type_id=6;

select CONCAT('^', format, '$') into @artu_fmt
from patient_identifier_type
where patient_identifier_type_id=2;

call data_export_hiv(_site, NULL);

ALTER TABLE `de_final` ADD INDEX ( paperf_no );

-- get the maximum paper file number
select RIGHT(max(paperf_no), 5) into @de_final_size
from de_final where paperf_no LIKE CONCAT(_site, '%');

-- generate a list of sequential IDs
call gen_seq_paperf_no(_site, @de_final_size);

-- filter out ids that are voided because they were transferred or duplicated
/*
transfer = transferred out to another PIH clinic
duplicate = patient was duplicated and then merged
hivneg = hiv negative and erroneously entered into system
nofile = no paper file found
lostb4 = patient has a ppf, but was lost before ppf system in place and not entered
deadb4 = patient has a ppf, but was dead before ppf system in place and not entered
*/

DROP TABLE IF EXISTS `gspn_filtered`;
CREATE TEMPORARY TABLE `gspn_filtered`
as
select paperf_no_seq
from gen_seq_paperf_no_tmp as gspn
left join patient_identifier as pi on pi.identifier=gspn.paperf_no_seq and pi.voided=1 and pi.void_reason in ('transfer', 'duplicate', 'hivneg', 'nofile', 'lostb4', 'deadb4')
where pi.patient_identifier_id is null;


select CAST(NOW() as date) into @now;

DROP TABLE IF EXISTS `dq_hiv_final`;
CREATE TEMPORARY TABLE `dq_hiv_final`
as
select patient_id, paperf_no_seq as paperf_no, artu_no
, age
, loc_id
, district, council, village, addr_hier_match, latitude, longitude
, paperf_no_loc
, state
, state_id
, state_startdate
, state_enddate
, state_active
, enrolldate
, completedate
, dead
, deathdate
, enc_firstdate
, enc_latestdate
, cd4_latestdate
, cd4_latest
, arv_latestdate
, arv_latest
, next_return_visit
, next_refill1
, next_refill2
, weight
, weightdate
, chw_gname
, chw_surname
, COALESCE(id_used_by_multi_pat, '') as id_used_by_multi_pat
, COALESCE(pat_has_multi_id, '') as pat_has_multi_id

-- age more than 95
, age > 95 and state_active=1 as e_age_gt
-- age less than 0
, age < 0 and state_active=1 as e_age_lt

-- latest weight is invalid
, state_id=2 and weight is null as e_weight_preart_null
, state_id=1 and weight is null as e_weight_art_null
, state_id=2 and ((weightdate is not null and enc_latestdate is not null and weightdate < enc_latestdate) or (weight is not null and weight = 0)) as e_weight_preart_missing
, state_id=1 and ((weightdate is not null and enc_latestdate is not null and weightdate < enc_latestdate) or (weight is not null and weight = 0)) as e_weight_art_missing

-- missing health center
, patient_id is not null and loc_id is null as e_loc_null
-- paper file identifer location doesn't match health center
, loc_id is not null and paperf_no_loc is not null and loc_id<>paperf_no_loc as e_loc_pfn_mm

-- identifiers
, paperf_no is null and state_active=1 as e_ident_pfn_null
, paperf_no is not null and paperf_no NOT REGEXP BINARY @paperf_fmt as e_ident_pfn_fmt_i
, artu_no is null and state_id in (1, 28, 40) and arv_latest is not null and arv_latest<>'AZT' as e_ident_aun_null -- ignore pmtct patients for now until the ministry officially mandates auns for pmtct
, artu_no is not null and artu_no NOT REGEXP BINARY @artu_fmt as e_ident_aun_fmt_i
, patient_id is null as e_ident_missing
, id_used_by_multi_pat IS NOT NULL as e_ident_multi_pat
, pat_has_multi_id IS NOT NULL as e_ident_multi_id

-- missing status (this handles state_startdate = null)
, patient_id is not null and (state is null or state_startdate is null) as e_prog_state_null
-- hivinfected error (we don't allow this state anymore)
, state_id=26 as e_prog_state_hivi
-- pmtct error
, state_id=27 and DATEDIFF(@now, state_startdate) > 12*28 as e_prog_state_pmtct
-- patient activity after inactive or intermediate state error
, (state_active=0 or state_id in (28, 40)) and ((enc_latestdate is not null and enc_latestdate > state_startdate) or (arv_latestdate is not null and arv_latestdate > state_startdate)) as e_prog_state_needupd
-- state end date for the latest state should never be set
, state_enddate is not null as e_prog_state_enddate

-- complete date set and in an active status or vice versa
, completedate is not null and state_active=1 as e_prog_cdate_set
-- complete date set and in an active status or vice versa
, completedate is null and not state_active=1 as e_prog_cdate_null
-- missing enroll date
, patient_id is not null and enrolldate is null as e_prog_edate_null

-- complete date before last encounter or ARV pickup
, completedate is not null and ((enc_latestdate is not null and completedate < enc_latestdate) or (arv_latestdate is not null and completedate < arv_latestdate)) as e_prog_cdate_encdate
-- start date after first encounter or ARV pickup
, enrolldate is not null and ((enc_firstdate is not null and enrolldate > enc_firstdate) or (arv_firstdate is not null and enrolldate > arv_firstdate)) as e_prog_edate_encdate

-- birthdate after enroll date
, birthdate is not null and enrolldate is not null and enrolldate < birthdate as e_birth_enr_date
-- birthdate after first encounter or ARV pickup
, birthdate is not null and ((enc_firstdate is not null and enc_firstdate < birthdate) or (arv_firstdate is not null and arv_firstdate < birthdate)) as e_birth_enc_date

-- deathdate not equal to completion date
, deathdate is not null and completedate is not null and deathdate <> completedate as e_death_dd_cdate
-- death date not equal to state start date
, deathdate is not null and dead=1 and state_id=3 and deathdate <> state_startdate as e_death_dd_edate

-- marked as dead, but no deathdate or vice versa
-- marked as dead, but not in dead state or vice versa
, dead=1 and deathdate is null as e_death_dd_null
, dead=0 and deathdate is not null as e_death_dd_set
, dead=1 and state_id<>3 as e_death_state_mm
, dead=0 and state_id=3 as e_death_state_set

-- cd4 is older than 7 months (only for those older than 5)
, state_id=2 and age > 5 and cd4_latestdate is not null and DATEDIFF(@now, cd4_latestdate) > 7*28 as e_cd4_fup_preart_old
, state_id=1 and age > 5 and cd4_latestdate is not null and DATEDIFF(@now, cd4_latestdate) > 7*28 as e_cd4_fup_art_old

-- no baseline CD4 in 4 months for pre-ART since they entered the program (only for those older than 5)
, state_id=2 and age > 5 and cd4_latestdate is null and enrolldate is not null and DATEDIFF(@now, enrolldate) > 4*28 as e_cd4_bsl_preart_null
-- no baseline CD4 in 2 months for ART since they entered the program (only for those older than 5)
, state_id=1 and age > 5 and cd4_latestdate is null and enrolldate is not null and DATEDIFF(@now, enrolldate) > 2*28 as e_cd4_bsl_art_null
-- low cd4 not on ART > after 3 weeks
, state_id=2 and (cd4_latest is not null and cd4_latest < 350 and DATEDIFF(@now, cd4_latestdate) > 21) and (enc_latestdate is not null and cd4_latestdate < enc_latestdate) as e_cd4_low_preart

-- referred for tracking for more than 60 days
, state_id=28 and DATEDIFF(@now, state_startdate) > 60 as e_reft_old
-- referred for hospital for more than 180 days
, state_id=40 and DATEDIFF(@now, state_startdate) > 180 as e_refh_old

-- return visit is older than 14 days
, state_id=2 and (next_return_visit is null or DATEDIFF(@now, next_return_visit) > 14) as e_retvisit_preart_old
, state_id=1 and (next_return_visit is null or DATEDIFF(@now, next_return_visit) > 14) as e_retvisit_art_old

-- pickup is older than 2 months
, state_id=1 and (arv_latestdate is null or DATEDIFF(@now, arv_latestdate) > 2*28) as e_pickup_old

-- refill date is old
, state_id=1 and (next_refill1 is null or DATEDIFF(@now, next_refill1) > 3*28) as e_retrefill1_old
, state_id=1 and (next_refill2 is null or DATEDIFF(@now, next_refill2) > 2*28) as e_retrefill2_old

-- drugs dispensed correctly
, state_id=1 and weight is not null and weight > 25 and arv_latest is not null and arv_latest REGEXP '^[4-5S]' as e_arv_child_mm
, state_id=1 and age < 15 and weight is not null and weight <=25 and arv_latest is not null and arv_latest REGEXP '^[1-2]' as e_arv_adult_mm

-- gis stuff:
-- preferred addresses
, state_active=1 and paddr_occ is not null and paddr_occ>1 as e_paddr_multi
, state_active=1 and paddr_occ is null as e_paddr_none

-- missing gps coords or hierarchy
-- , state_active=1 and addr_hier_match=1 and (latitude is null or longitude is null) as e_gis_gps_missing
-- , state_active=1 and addr_hier_match=0 as e_gis_no_match
-- commenting out till we roll out gis
, 0 as e_gis_gps_missing
, 0 as e_gis_no_match

-- chw name filled out
-- , state_active=1 and chw_gname is null as e_chw_gname_null
-- , state_active=1 and chw_surname is null as e_chw_surname_null
-- commenting out until we roll out new CHW
, 0 as e_chw_gname_null
, 0 as e_chw_surname_null

from de_final as de
right join gspn_filtered as gspnf on gspnf.paperf_no_seq=de.paperf_no
-- check for ID being used by multiple patients
left join (
  select identifier as id_used_by_multi_pat from (
    select identifier, count(*) as occ
    from patient_identifier
    where voided=0 and identifier_type in (2, 6)
    group by identifier) as a
  where occ > 1) as id_check on id_check.id_used_by_multi_pat=paperf_no
                                or id_check.id_used_by_multi_pat=artu_no
-- check for a patient having multiple IDs
left join (
  select patient_id as pat_id, name as pat_has_multi_id from (
    select patient_id, identifier_type, count(*) as occ
    from patient_identifier
    where voided=0 and identifier_type in (2, 6)
    group by identifier_type, patient_id) as a
  left join patient_identifier_type as pit on a.identifier_type=pit.patient_identifier_type_id
  where occ > 1) as pat_check on pat_check.pat_id=patient_id

-- check for a patient having multiple preferred addresses
left join (
  select person_id, count(*) as paddr_occ
  from person_address
  where voided=0 and preferred=1
  group by person_id) as addr_check on addr_check.person_id=patient_id

order by state_active DESC, paperf_no ASC;

IF _export_dir IS NULL THEN

  -- output to the caller
  select *
    -- use coalesce in case any of the errors are null
    --  since the BIRT report filters on this sum
      -- e.g. when there is no state
  , COALESCE(e_age_gt
    + e_age_lt
    + e_weight_preart_null
    + e_weight_art_null
    + e_weight_preart_missing
    + e_weight_art_missing
    + e_loc_null
    + e_loc_pfn_mm
    + e_ident_pfn_null
    + e_ident_pfn_fmt_i
    + e_ident_aun_null
    + e_ident_aun_fmt_i
    + e_ident_missing
    + e_ident_multi_pat
    + e_ident_multi_id
    + e_prog_state_null
    + e_prog_state_hivi
    + e_prog_state_pmtct
    + e_prog_state_needupd
    + e_prog_state_enddate
    + e_prog_cdate_set
    + e_prog_cdate_null
    + e_prog_edate_null
    + e_prog_cdate_encdate
    + e_prog_edate_encdate
    + e_birth_enr_date
    + e_birth_enc_date
    + e_death_dd_cdate
    + e_death_dd_edate
    + e_death_dd_null
    + e_death_dd_set
    + e_death_state_mm
    + e_death_state_set
    + e_cd4_fup_preart_old
    + e_cd4_fup_art_old
    + e_cd4_bsl_preart_null
    + e_cd4_bsl_art_null
    + e_cd4_low_preart
    + e_reft_old
    + e_refh_old
    + e_retvisit_preart_old
    + e_retvisit_art_old
    + e_pickup_old
--    +  e_retrefill1_old
--    +  e_retrefill2_old
    + e_arv_child_mm
    + e_arv_adult_mm
    + e_paddr_multi
    + e_paddr_none
    + e_gis_gps_missing
    + e_gis_no_match
    + e_chw_gname_null
    + e_chw_surname_null
    , 1) as e_sum
  , e_weight_preart_null
    + e_weight_art_null
    + e_weight_preart_missing
    + e_weight_art_missing
    + e_cd4_fup_preart_old
    + e_cd4_fup_art_old
    + e_cd4_bsl_preart_null
    + e_cd4_bsl_art_null
    + e_cd4_low_preart
    + e_reft_old
    + e_refh_old
--    +  e_retvisit_preart_old
--    +  e_retvisit_art_old
--    +  e_pickup_old
--    +  e_retrefill1_old
--    +  e_retrefill2_old
    + e_arv_child_mm
    + e_arv_adult_mm
      as e_clin_sum
 from dq_hiv_final;

ELSE

  SELECT concat("
  select 'patient_id', 'paperf_no', 'artu_no'
  , 'age'
  , 'loc_id', 'paperf_no_loc'
  , 'district', 'council', 'village', 'addr_hier_match', 'latitude', 'longitude'
  , 'state', 'state_id', 'state_startdate', 'state_enddate', 'state_active'
  , 'enrolldate', 'completedate'
  , 'dead', 'deathdate'
  , 'enc_firstdate', 'enc_latestdate'
  , 'cd4_latestdate', 'cd4_latest'
  , 'arv_latestdate', 'arv_latest'
  , 'next_return_visit', 'next_refill1', 'next_refill2'
  , 'weight'
  , 'id_used_by_multi_pat'
  , 'pat_has_multi_id'
  , 'e_age_gt'
  , 'e_age_lt'
  , 'e_weight_preart_null'
  , 'e_weight_art_null'
  , 'e_weight_preart_missing'
  , 'e_weight_art_missing'
  , 'e_loc_null'
  , 'e_loc_pfn_mm'
  , 'e_ident_pfn_null'
  , 'e_ident_pfn_fmt_i'
  , 'e_ident_aun_null'
  , 'e_ident_aun_fmt_i'
  , 'e_ident_missing'
  , 'e_ident_multi_pat'
  , 'e_ident_multi_id'
  , 'e_prog_state_null'
  , 'e_prog_state_hivi'
  , 'e_prog_state_pmtct'
  , 'e_prog_state_needupd'
  , 'e_prog_state_enddate'
  , 'e_prog_cdate_set'
  , 'e_prog_cdate_null'
  , 'e_prog_edate_null'
  , 'e_prog_cdate_encdate'
  , 'e_prog_edate_encdate'
  , 'e_birth_enr_date'
  , 'e_birth_enc_date'
  , 'e_death_dd_cdate'
  , 'e_death_dd_edate'
  , 'e_death_dd_null'
  , 'e_death_dd_set'
  , 'e_death_state_mm'
  , 'e_death_state_set'
  , 'e_cd4_fup_preart_old'
  , 'e_cd4_fup_art_old'
  , 'e_cd4_bsl_preart_null'
  , 'e_cd4_bsl_art_null'
  , 'e_cd4_low_preart'
  , 'e_reft_old'
  , 'e_refh_old'
  , 'e_retvisit_preart_old'
  , 'e_retvisit_art_old'
  , 'e_pickup_old'
--  , 'e_retrefill1_old'
--  , 'e_retrefill2_old'
  , 'e_arv_child_mm'
  , 'e_arv_adult_mm'
  , 'e_paddr_multi'
  , 'e_paddr_none'
  , 'e_gis_gps_missing'
  , 'e_gis_no_match'
  , 'e_chw_gname_null'
  , 'e_chw_surname_null'
  , 'e_sum'
  , 'e_clin_sum'
  UNION
  select patient_id
  , coalesce(paperf_no, '')
  , coalesce(artu_no, '')
  , coalesce(age, '')
  , coalesce(loc_id, '')
  , coalesce(paperf_no_loc, '')
  , coalesce(district, '')
  , coalesce(council, '')
  , coalesce(village, '')
  , coalesce(addr_hier_match, '')
  , coalesce(latitude, '')
  , coalesce(longitude, '')
  , coalesce(state, '')
  , coalesce(state_id, '')
  , coalesce(state_startdate, '')
  , coalesce(state_enddate, '')
  , coalesce(state_active, '')
  , coalesce(enrolldate, '')
  , coalesce(completedate, '')
  , coalesce(dead, '')
  , coalesce(deathdate, '')
  , coalesce(enc_firstdate, '')
  , coalesce(enc_latestdate, '')
  , coalesce(cd4_latestdate, '')
  , coalesce(cd4_latest, '')
  , coalesce(arv_latestdate, '')
  , coalesce(arv_latest, '')
  , coalesce(next_return_visit, '')
  , coalesce(next_refill1, '')
  , coalesce(next_refill2, '')
  , coalesce(weight, '')
  , coalesce(id_used_by_multi_pat, '')
  , coalesce(pat_has_multi_id, '')
  , coalesce(e_age_gt, '')
  , coalesce(e_age_lt, '')
  , coalesce(e_weight_preart_null, '')
  , coalesce(e_weight_art_null, '')
  , coalesce(e_weight_preart_missing, '')
  , coalesce(e_weight_art_missing, '')
  , coalesce(e_loc_null, '')
  , coalesce(e_loc_pfn_mm, '')
  , coalesce(e_ident_pfn_null, '')
  , coalesce(e_ident_pfn_fmt_i, '')
  , coalesce(e_ident_aun_null, '')
  , coalesce(e_ident_aun_fmt_i, '')
  , coalesce(e_ident_missing, '')
  , coalesce(e_ident_multi_pat, '')
  , coalesce(e_ident_multi_id, '')
  , coalesce(e_prog_state_null, '')
  , coalesce(e_prog_state_hivi, '')
  , coalesce(e_prog_state_pmtct, '')
  , coalesce(e_prog_state_needupd, '')
  , coalesce(e_prog_state_enddate, '')
  , coalesce(e_prog_cdate_set, '')
  , coalesce(e_prog_cdate_null, '')
  , coalesce(e_prog_edate_null, '')
  , coalesce(e_prog_cdate_encdate, '')
  , coalesce(e_prog_edate_encdate, '')
  , coalesce(e_birth_enr_date, '')
  , coalesce(e_birth_enc_date, '')
  , coalesce(e_death_dd_cdate, '')
  , coalesce(e_death_dd_edate, '')
  , coalesce(e_death_dd_null, '')
  , coalesce(e_death_dd_set, '')
  , coalesce(e_death_state_mm, '')
  , coalesce(e_death_state_set, '')
  , coalesce(e_cd4_fup_preart_old, '')
  , coalesce(e_cd4_fup_art_old, '')
  , coalesce(e_cd4_bsl_preart_null, '')
  , coalesce(e_cd4_bsl_art_null, '')
  , coalesce(e_cd4_low_preart, '')
  , coalesce(e_reft_old, '')
  , coalesce(e_refh_old, '')
  , coalesce(e_retvisit_preart_old, '')
  , coalesce(e_retvisit_art_old, '')
  , coalesce(e_pickup_old, '')
--  , coalesce(e_retrefill1_old, '')
--  , coalesce(e_retrefill2_old, '')
  , coalesce(e_arv_child_mm, '')
  , coalesce(e_arv_adult_mm, '')
  , coalesce(e_paddr_multi, '')
  , coalesce(e_paddr_none, '')
  , coalesce(e_gis_gps_missing, '')
  , coalesce(e_gis_no_match, '')
  , coalesce(e_chw_gname_null, '')
  , coalesce(e_chw_surname_null, '')
  , COALESCE(e_age_gt
    + e_age_lt
    + e_weight_preart_null
    + e_weight_art_null
    + e_weight_preart_missing
    + e_weight_art_missing
    + e_loc_null
    + e_loc_pfn_mm
    + e_ident_pfn_null
    + e_ident_pfn_fmt_i
    + e_ident_aun_null
    + e_ident_aun_fmt_i
    + e_ident_missing
    + e_ident_multi_pat
    + e_ident_multi_id
    + e_prog_state_null
    + e_prog_state_hivi
    + e_prog_state_pmtct
    + e_prog_state_needupd
    + e_prog_state_enddate
    + e_prog_cdate_set
    + e_prog_cdate_null
    + e_prog_edate_null
    + e_prog_cdate_encdate
    + e_prog_edate_encdate
    + e_birth_enr_date
    + e_birth_enc_date
    + e_death_dd_cdate
    + e_death_dd_edate
    + e_death_dd_null
    + e_death_dd_set
    + e_death_state_mm
    + e_death_state_set
    + e_cd4_fup_preart_old
    + e_cd4_fup_art_old
    + e_cd4_bsl_preart_null
    + e_cd4_bsl_art_null
    + e_cd4_low_preart
    + e_reft_old
    + e_refh_old
    + e_retvisit_preart_old
    + e_retvisit_art_old
    + e_pickup_old
--    +  e_retrefill1_old
--    +  e_retrefill2_old
    + e_arv_child_mm
    + e_arv_adult_mm
    + e_paddr_multi
    + e_paddr_none
    + e_gis_gps_missing
    + e_gis_no_match
    + e_chw_gname_null
    + e_chw_surname_null
    , 1) as e_sum
  , e_weight_preart_null
    + e_weight_art_null
    + e_weight_preart_missing
    + e_weight_art_missing
    + e_cd4_fup_preart_old
    + e_cd4_fup_art_old
    + e_cd4_bsl_preart_null
    + e_cd4_bsl_art_null
    + e_cd4_low_preart
    + e_reft_old
    + e_refh_old
--    +  e_retvisit_preart_old
--    +  e_retvisit_art_old
--    +  e_pickup_old
--    +  e_retrefill1_old
--    +  e_retrefill2_old
    + e_arv_child_mm
    + e_arv_adult_mm as e_clin_sum
  from dq_hiv_final
  INTO OUTFILE '", _export_dir, "/data_quality_hiv.csv'
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '\"'
  LINES TERMINATED BY '\n';") INTO @output_cmd;

  PREPARE stmt FROM @output_cmd;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;

END IF;

END$$

DELIMITER ;