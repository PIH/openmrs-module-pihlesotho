DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_providers_for_chw`()
BEGIN
DROP TEMPORARY TABLE IF EXISTS temp_provider_id;
	create temporary table temp_provider_id (
  		person_id INT not null primary key,
		identifier varchar(255)
	);

insert into temp_provider_id(person_id)
select distinct(person_a) from relationship where relationship=1 and voided=0
and person_a not in (select person_id from provider)
order by person_a;

update temp_provider_id temp
set temp.identifier = (select pi.identifier from patient_identifier pi
where pi.patient_id = temp.person_id and pi.identifier_type =7 and pi.voided=0);

insert into provider(person_id, identifier, creator, date_created, uuid, provider_role_id)
select person_id,
case when identifier is null then null
else CONCAT("CHW-", Coalesce(identifier,'')) end, 1, now(), uuid(),1 from temp_provider_id;
END$$
DELIMITER ;