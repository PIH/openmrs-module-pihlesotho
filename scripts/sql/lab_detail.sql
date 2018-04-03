-- --------------------------------------------------------------------------------
-- call lab_detail(2012, 4, 12);
--   will provide lab details for a week ago from the date (YYYY, MM, DD)
--     as well as other information
--     for all sites
-- --------------------------------------------------------------------------------
DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`lab_detail`$$
CREATE PROCEDURE `openmrs`.`lab_detail`(
_year int,
_month int,
_date int
)
BEGIN

SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(_month AS CHAR), 2, '0'), '-', LPAD(CAST(_date AS CHAR), 2, '0')))
INTO @reportday;

SELECT @reportday INTO @start;

SELECT CAST(@reportday + INTERVAL 1 MONTH as date)
INTO @realend;

SELECT CAST(@realend - INTERVAL 1 day as date)
INTO @end;

SELECT 'Time period:' into @msg;

SELECT @msg, @start, @end;


-- get the latest lab result, but specifically the concept that indicates whether a result was obtained
DROP TABLE IF EXISTS `lab_detail_latest_response`;
create temporary table `lab_detail_latest_response`
as
select * from (
        select obs_id, obs_datetime, person_id, encounter_id, value_numeric, location_id
        from obs
        where concept_id=6111 and voided=0
        order by obs_datetime DESC) as a
group by person_id;

DROP TABLE IF EXISTS `lab_detail_reasons`;
CREATE temporary TABLE `lab_detail_reasons` (
  `concept_id` int(11) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO `lab_detail_reasons` (`concept_id`, `desc`) VALUES (6992, 'Specimen Quality - Old'),(6991, 'Specimen Quality - Clotted'),(6990, 'Specimen Quality - Hemolyzed'),(6113, 'Specimen Quality - Not enough'),(6987, 'Sender Error - No Label/Form'),(6988, 'Sender Error - Name Mismatch'),(6986, 'Lab - Machine Broken'),(6989, 'Lab - Machine gave no result');

-- for all samples that have a negative response, there should be reasons
-- for all samples that have a positive response, there should be a result
-- these checks can be avoided if we just added a UI check...but it is non-trivial custom js to implement
-- so... join this data, into one dataset
DROP TABLE IF EXISTS `lab_detail_latest_response_join`;
create temporary table `lab_detail_latest_response_join`
as
select ldlr.obs_id
, CAST(ldlr.obs_datetime as date) as recv_date
, ldlr.person_id
, o2.value_numeric as cd4
, (not ldlr.value_numeric) as rejected
, o1.value_coded as rejected_reason
, lab_detail_reasons.desc as rejected_reason_text
, CAST(o3.value_datetime as date) as draw_date
, location.description as loc
, CONCAT(given_name, ' ', family_name) as lab
from lab_detail_latest_response as ldlr
left join obs as o1 on o1.encounter_id=ldlr.encounter_id and o1.concept_id=6993 and o1.voided=0
left join obs as o2 on o2.encounter_id=ldlr.encounter_id and o2.concept_id=5497 and o2.voided=0
left join obs as o3 on o3.encounter_id=ldlr.encounter_id and o3.concept_id=6108 and o3.voided=0
left join location on ldlr.location_id=location.location_id and location.description <> 'TC'
left join lab_detail_reasons on o1.value_coded=lab_detail_reasons.concept_id
left join encounter on encounter.encounter_id=ldlr.encounter_id and encounter.voided=0
left join person_name on encounter.provider_id=person_name.person_id and person_name.voided=0
where location.location_id is not null
group by ldlr.obs_id
;


SELECT 'Lab Results Received (cd4 count):' as msg;
-- received samples
select loc as site
, SUM(IF(cd4 < 350,1,0)) as `< 350`
, SUM(IF(cd4 >= 350,1,0)) as `>=350`
, count(*) as `total`
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=0
group by loc
;

SELECT 'Lab Results Received (turnaround):' as msg;
-- received samples
select loc as site
, SUM(IF(DATEDIFF(recv_date, draw_date) <= 7,1,0)) as `<=1 wk`
, SUM(IF((DATEDIFF(recv_date, draw_date) > 7 AND DATEDIFF(recv_date, draw_date) <= 14),1,0)) as `<=2 wks`
, SUM(IF(DATEDIFF(recv_date, draw_date) > 14 AND DATEDIFF(recv_date, draw_date) <= 21,1,0)) as `<=3 wks`
, SUM(IF(DATEDIFF(recv_date, draw_date) > 21,1,0)) as `> 3 wks`
, count(*) as `total`
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=0
group by loc
;

SELECT 'Lab Results Received (cd4 count):' as msg;
-- received samples
select lab
, SUM(IF(loc='BB',1,0)) as BB
, SUM(IF(loc='LK',1,0)) as LK
, SUM(IF(loc='MG',1,0)) as MG
, SUM(IF(loc='NH',1,0)) as NH
, SUM(IF(loc='NK',1,0)) as NK
, SUM(IF(loc='RA',1,0)) as RA
, SUM(IF(loc='TY',1,0)) as TY
, count(*) as total
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=0
group by lab
;


SELECT 'Lab Results Rejected:' as msg;
-- rejected samples that were received during the prior week
-- break down of rejections by site
select rejected_reason_text as reason
, SUM(IF(loc='BB',1,0)) as BB
, SUM(IF(loc='LK',1,0)) as LK
, SUM(IF(loc='MG',1,0)) as MG
, SUM(IF(loc='NH',1,0)) as NH
, SUM(IF(loc='NK',1,0)) as NK
, SUM(IF(loc='RA',1,0)) as RA
, SUM(IF(loc='TY',1,0)) as TY
, count(*) as total
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=1
group by rejected_reason_text;

select 'Summary:' into @msg;

select count(*) into @received
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=0;

select count(*) into @rejected
from lab_detail_latest_response_join
where draw_date >= @start and draw_date < @realend and rejected=1;

select count(*) into @errors
from lab_detail_latest_response_join
where (rejected=1 and (cd4 is not null or rejected_reason is null))
or (rejected=0 and (cd4 is null or rejected_reason is not null));

select @msg, @received, @rejected, @received+@rejected as total, @errors;

/*
SELECT 'Reasons for Active+Non-Active Patients with latest sample rejected:' as msg;
-- all patients that have their latest sample rejected
-- break down of rejections by site
select rejected_reason_text as reason
, SUM(IF(loc='BB',1,0)) as BB
, SUM(IF(loc='LK',1,0)) as LK
, SUM(IF(loc='MG',1,0)) as MG
, SUM(IF(loc='NH',1,0)) as NH
, SUM(IF(loc='NK',1,0)) as NK
, SUM(IF(loc='RA',1,0)) as RA
, SUM(IF(loc='TY',1,0)) as TY
, count(*) as total
from lab_detail_latest_response_join
where rejected=1
group by rejected_reason_text;
*/
-- overdue cd4s that haven't had a response in three months --> nothing being drawn

END$$

DELIMITER ;