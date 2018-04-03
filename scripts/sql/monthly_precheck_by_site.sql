DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`monthly_precheck_by_site`$$

CREATE PROCEDURE `openmrs`.`monthly_precheck_by_site`(
_site char(2),
_month int(2),
_year int(4)
)
BEGIN

SELECT DATE(CONCAT(CAST(_year AS CHAR), '-', LPAD(CAST(_month AS CHAR), 2, '0'), '-01'))
INTO @firstday;

SELECT LAST_DAY(@firstday)
INTO @lastday;

SELECT CAST(@firstday - INTERVAL 1 MONTH as date)
INTO @minpickup;

-- call data_export_hiv(_site, null);

select @firstday, @lastday, @minpickup;

Select count(enrolldate)
into @new_HIVenrollees  from de_final where enrolldate >= @firstday and enrolldate <=@lastday;

select count(arv_firstdate)
into @new_ARTenrollees from de_final where arv_firstdate >= @firstday and arv_firstdate <=@lastday;

Select count(state_id) into @refused from de_final
where state_id=37 and
state_startdate >= @firstday and
state_startdate <= @lastday and
arv_latestdate >= @minpickup and
arv_latestdate <= @lastday;

Select count(state_id) into @t_out from de_final
where state_id=5 and
state_startdate >= @firstday and
state_startdate <= @lastday and
arv_latestdate >= @minpickup and
arv_latestdate <= @lastday;

select @new_HIVEnrollees, @new_ARTenrollees, @refused as refused_and_did_not_pickup, @t_out as XferOut;

select arv_latest, count(*)
from de_final
where arv_latestdate >= @minpickup
and arv_latestdate <= @lastday
group by arv_latest
order by arv_latest asc;


select location_id into @site_id
from location where description=_site;

select arv_latest, count(*)
from (
select CAST(obs.value_text as char(8)) as arv_latest
from obs
where obs.concept_id=2876
and voided = 0
and obs_datetime >= @minpickup
and obs_datetime <= @lastday
and location_id = @site_id
group by person_id) as a
group by arv_latest;



END$$

DELIMITER ;
