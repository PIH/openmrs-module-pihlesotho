-- --------------------------------------------------------------------------------
-- call gis_xref();
--   updates the patient_address table to associated gps values
--      when the address hierarchy matches
--      note that we use the country field to determine a hierarchy match
-- --------------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`gis_xref`$$
CREATE PROCEDURE `openmrs`.`gis_xref`()
BEGIN

-- clean out the hierarchy match flag, as well as lat,long
update person_address set country=0, latitude=null, longitude=null;

-- get the hierarchy so it is usable for left join
DROP TABLE IF EXISTS `gii_hierarchy`;
CREATE TEMPORARY TABLE `gii_hierarchy` as
select ahe1.name as district, ahe2.name as council, ahe3.name as village, ahe3.address_hierarchy_entry_id as id, ahe3.latitude as lat, ahe3.longitude as `long`
from address_hierarchy_entry as ahe1
left join address_hierarchy_entry as ahe2 on ahe2.parent_id=ahe1.address_hierarchy_entry_id
left join address_hierarchy_entry as ahe3 on ahe3.parent_id=ahe2.address_hierarchy_entry_id
where ahe1.parent_id is null;

-- update all person_addresses that match the hierarchy; copy the lat and long as needed
update person_address as pa
left join gii_hierarchy as gh on gh.district=pa.county_district AND gh.council=pa.neighborhood_cell AND gh.village=pa.city_village
set country=1, latitude=gh.lat, longitude=gh.long
where gh.id is not null and voided=0;

END$$

DELIMITER ;

