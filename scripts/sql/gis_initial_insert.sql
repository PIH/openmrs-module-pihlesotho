-- --------------------------------------------------------------------------------
-- call gis_initial_insert();
--   updates the address_hierarchy_entry table with GPS data
--     currently the import from csv doesn't do this automatically
-- --------------------------------------------------------------------------------

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`gis_initial_insert`$$
CREATE PROCEDURE `openmrs`.`gis_initial_insert`()
BEGIN

-- get the hierarchy so it is easy for left join
DROP TABLE IF EXISTS `gii_hierarchy`;
CREATE TEMPORARY TABLE `gii_hierarchy` as
select ahe1.name as district, ahe2.name as council, ahe3.name as village, ahe3.address_hierarchy_entry_id as id
from address_hierarchy_entry as ahe1
left join address_hierarchy_entry as ahe2 on ahe2.parent_id=ahe1.address_hierarchy_entry_id
left join address_hierarchy_entry as ahe3 on ahe3.parent_id=ahe2.address_hierarchy_entry_id
where ahe1.parent_id is null;

ALTER TABLE gii_hierarchy ADD `lat` VARCHAR(50);
ALTER TABLE gii_hierarchy ADD `long` VARCHAR(50);

-- do the inserts into this table

START TRANSACTION;

-- generated from census_2006_village_list_edited_cleaned.xlsx!final
-- excel formula: =IF(K2<>"","update gii_hierarchy as gh set gh.lat='"&K2&"', gh.long='"&L2&"' where district='"&A2&"' and council='"&C2&"' and village='"&D2&"';", "")

update gii_hierarchy as gh set gh.lat='28.085492', gh.long='-29.092731' where district='BEREA' and council='Makeoana Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='28.095222', gh.long='-29.098142' where district='BEREA' and council='Makeoana Council' and village='Ha Nkunyana';

update gii_hierarchy as gh set gh.lat='28.092809', gh.long='-29.087084' where district='BEREA' and council='Makeoana Council' and village='Ha Seme';
update gii_hierarchy as gh set gh.lat='28.105926', gh.long='-29.104413' where district='BEREA' and council='Makeoana Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.101028', gh.long='-29.098223' where district='BEREA' and council='Makeoana Council' and village='Ha Mangoato';
update gii_hierarchy as gh set gh.lat='27.921078', gh.long='-29.106942' where district='BEREA' and council='Makeoana Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.097535', gh.long='-29.094266' where district='BEREA' and council='Makeoana Council' and village='Mankoeng';
update gii_hierarchy as gh set gh.lat='28.049211', gh.long='-29.141507' where district='BEREA' and council='Makeoana Council' and village='Sehlabeng';
update gii_hierarchy as gh set gh.lat='28.119684', gh.long='-29.096513' where district='BEREA' and council='Makeoana Council' and village='Thoteng (Ha Bela Besa)';
update gii_hierarchy as gh set gh.lat='28.110806', gh.long='-29.086715' where district='BEREA' and council='Makeoana Council' and village='Ha Lesibe';
update gii_hierarchy as gh set gh.lat='28.118878', gh.long='-29.088376' where district='BEREA' and council='Makeoana Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='28.127592', gh.long='-29.079901' where district='BEREA' and council='Makeoana Council' and village='Ha Matekane (Ha Kota)';
update gii_hierarchy as gh set gh.lat='28.123217', gh.long='-29.082581' where district='BEREA' and council='Makeoana Council' and village='Pokellong';
update gii_hierarchy as gh set gh.lat='28.135395', gh.long='-29.077449' where district='BEREA' and council='Makeoana Council' and village='Ha Taaso';
update gii_hierarchy as gh set gh.lat='28.139788', gh.long='-29.081124' where district='BEREA' and council='Makeoana Council' and village='Mafotholeng';
update gii_hierarchy as gh set gh.lat='28.14768', gh.long='-29.084101' where district='BEREA' and council='Makeoana Council' and village='Ha Boranta';
update gii_hierarchy as gh set gh.lat='28.179743', gh.long='-29.101044' where district='BEREA' and council='Makeoana Council' and village='Maholong';
update gii_hierarchy as gh set gh.lat='28.156016', gh.long='-29.106912' where district='BEREA' and council='Makeoana Council' and village='Ha Makoanyane';
update gii_hierarchy as gh set gh.lat='28.166117', gh.long='-29.121976' where district='BEREA' and council='Makeoana Council' and village='Ha Chakatsa';
update gii_hierarchy as gh set gh.lat='28.160952', gh.long='-29.11891' where district='BEREA' and council='Makeoana Council' and village='Ha Nonyana';
update gii_hierarchy as gh set gh.lat='28.145974', gh.long='-29.1151' where district='BEREA' and council='Makeoana Council' and village='Ha Khopo';
update gii_hierarchy as gh set gh.lat='28.141065', gh.long='-29.112737' where district='BEREA' and council='Makeoana Council' and village='Ha Molaoa';
update gii_hierarchy as gh set gh.lat='28.154021', gh.long='-29.118269' where district='BEREA' and council='Makeoana Council' and village='Ha Seana';
update gii_hierarchy as gh set gh.lat='28.124937', gh.long='-29.114155' where district='BEREA' and council='Makeoana Council' and village='Ha Molikuoa';
update gii_hierarchy as gh set gh.lat='28.128257', gh.long='-29.118242' where district='BEREA' and council='Makeoana Council' and village='Matemeng';
update gii_hierarchy as gh set gh.lat='28.120207', gh.long='-29.107286' where district='BEREA' and council='Makeoana Council' and village='Bophephetsa';
update gii_hierarchy as gh set gh.lat='28.116094', gh.long='-29.105957' where district='BEREA' and council='Makeoana Council' and village='Vukazenzele';
update gii_hierarchy as gh set gh.lat='28.102543', gh.long='-29.127292' where district='BEREA' and council='Makeoana Council' and village='Ha Nkutunyane (Tloaalang)';
update gii_hierarchy as gh set gh.lat='28.10126', gh.long='-29.118406' where district='BEREA' and council='Makeoana Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.085816', gh.long='-29.115028' where district='BEREA' and council='Makeoana Council' and village='Ha Maqotoane (Sebetia)';
update gii_hierarchy as gh set gh.lat='28.085091', gh.long='-29.102529' where district='BEREA' and council='Makeoana Council' and village='Motse Mocha (Qethane)';
update gii_hierarchy as gh set gh.lat='28.072747', gh.long='-29.107537' where district='BEREA' and council='Makeoana Council' and village='Nkhetheleng';
update gii_hierarchy as gh set gh.lat='28.077395', gh.long='-29.101028' where district='BEREA' and council='Makeoana Council' and village='Qethane';
update gii_hierarchy as gh set gh.lat='28.070165', gh.long='-29.113528' where district='BEREA' and council='Makeoana Council' and village='Ha Mokoena';
update gii_hierarchy as gh set gh.lat='28.071882', gh.long='-29.120487' where district='BEREA' and council='Makeoana Council' and village='Lihlolong';
update gii_hierarchy as gh set gh.lat='28.081515', gh.long='-29.128588' where district='BEREA' and council='Makeoana Council' and village='Ha Nkutu (Sebetia)';
update gii_hierarchy as gh set gh.lat='28.092013', gh.long='-29.129408' where district='BEREA' and council='Makeoana Council' and village='Ha Thebe (Sebetia)';
update gii_hierarchy as gh set gh.lat='28.107655', gh.long='-29.148166' where district='BEREA' and council='Makeoana Council' and village='Ha Kutsupa';
update gii_hierarchy as gh set gh.lat='28.092682', gh.long='-29.138875' where district='BEREA' and council='Makeoana Council' and village='Ha Thabo';
update gii_hierarchy as gh set gh.lat='28.126032', gh.long='-29.149093' where district='BEREA' and council='Makeoana Council' and village='Ha Mamatebele';
update gii_hierarchy as gh set gh.lat='28.151898', gh.long='-29.157555' where district='BEREA' and council='Makeoana Council' and village='Ha Khoarai';
update gii_hierarchy as gh set gh.lat='28.135723', gh.long='-29.154441' where district='BEREA' and council='Makeoana Council' and village='Ha Lebona';
update gii_hierarchy as gh set gh.lat='28.136452', gh.long='-29.150168' where district='BEREA' and council='Makeoana Council' and village='Ha Makomo';
update gii_hierarchy as gh set gh.lat='28.163182', gh.long='-29.169651' where district='BEREA' and council='Makeoana Council' and village='Ha Chetane (Ha Tau)';
update gii_hierarchy as gh set gh.lat='28.149691', gh.long='-29.165953' where district='BEREA' and council='Makeoana Council' and village='Ha Makhaola';
update gii_hierarchy as gh set gh.lat='28.165848', gh.long='-29.197296' where district='BEREA' and council='Makeoana Council' and village='Ha Monyai';
update gii_hierarchy as gh set gh.lat='28.162224', gh.long='-29.18493' where district='BEREA' and council='Makeoana Council' and village='Lehlakaneng';
update gii_hierarchy as gh set gh.lat='28.140515', gh.long='-29.179415' where district='BEREA' and council='Makeoana Council' and village='Ha Malibeng';
update gii_hierarchy as gh set gh.lat='28.150477', gh.long='-29.177658' where district='BEREA' and council='Makeoana Council' and village='Ha Pita';
update gii_hierarchy as gh set gh.lat='28.120216', gh.long='-29.165464' where district='BEREA' and council='Makeoana Council' and village='Ha Lejaha';
update gii_hierarchy as gh set gh.lat='28.111167', gh.long='-29.172878' where district='BEREA' and council='Makeoana Council' and village='Ha Puoane';
update gii_hierarchy as gh set gh.lat='28.136389', gh.long='-29.171593' where district='BEREA' and council='Makeoana Council' and village='Mokoallong';
update gii_hierarchy as gh set gh.lat='28.100628', gh.long='-29.164022' where district='BEREA' and council='Makeoana Council' and village='Ha Mokopotsa';
update gii_hierarchy as gh set gh.lat='28.106862', gh.long='-29.155643' where district='BEREA' and council='Makeoana Council' and village='Machalefose';
update gii_hierarchy as gh set gh.lat='28.085103', gh.long='-29.150331' where district='BEREA' and council='Makeoana Council' and village='Ha Mapa';
update gii_hierarchy as gh set gh.lat='28.092786', gh.long='-29.154823' where district='BEREA' and council='Makeoana Council' and village='Maluba Lube';
update gii_hierarchy as gh set gh.lat='28.087593', gh.long='-29.159767' where district='BEREA' and council='Makeoana Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='28.069848', gh.long='-29.137257' where district='BEREA' and council='Makeoana Council' and village='Ha Posholi';
update gii_hierarchy as gh set gh.lat='28.069926', gh.long='-29.143346' where district='BEREA' and council='Makeoana Council' and village='Maphatsoaneng';
update gii_hierarchy as gh set gh.lat='28.072256', gh.long='-29.149568' where district='BEREA' and council='Makeoana Council' and village='Matangoaneng';
update gii_hierarchy as gh set gh.lat='28.053135', gh.long='-29.171534' where district='BEREA' and council='Makeoana Council' and village='Khokhoba';
update gii_hierarchy as gh set gh.lat='28.055166', gh.long='-29.156211' where district='BEREA' and council='Makeoana Council' and village='Motsekuoa';
update gii_hierarchy as gh set gh.lat='28.046168', gh.long='-29.163291' where district='BEREA' and council='Makeoana Council' and village='Terai Hoek';
update gii_hierarchy as gh set gh.lat='28.063328', gh.long='-29.165499' where district='BEREA' and council='Makeoana Council' and village='Makhanfolehi';
update gii_hierarchy as gh set gh.lat='28.068165', gh.long='-29.169569' where district='BEREA' and council='Makeoana Council' and village='Tsipa';
update gii_hierarchy as gh set gh.lat='28.061595', gh.long='-29.185893' where district='BEREA' and council='Makeoana Council' and village='Ha Malekhase';
update gii_hierarchy as gh set gh.lat='27.814237', gh.long='-29.262728' where district='BEREA' and council='Makeoana Council' and village='Ha Pulumo';
update gii_hierarchy as gh set gh.lat='28.072964', gh.long='-29.189505' where district='BEREA' and council='Makeoana Council' and village='Ha Ramohobo';
update gii_hierarchy as gh set gh.lat='28.084236', gh.long='-29.181309' where district='BEREA' and council='Makeoana Council' and village='Khetha';
update gii_hierarchy as gh set gh.lat='28.084913', gh.long='-29.17464' where district='BEREA' and council='Makeoana Council' and village='Khoakhoeng';
update gii_hierarchy as gh set gh.lat='28.086047', gh.long='-29.188105' where district='BEREA' and council='Makeoana Council' and village='Ha Chabeli';
update gii_hierarchy as gh set gh.lat='28.088645', gh.long='-29.2018' where district='BEREA' and council='Makeoana Council' and village='Ha Lieta';
update gii_hierarchy as gh set gh.lat='28.102036', gh.long='-29.216603' where district='BEREA' and council='Makeoana Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='28.108602', gh.long='-29.204433' where district='BEREA' and council='Makeoana Council' and village='Ha Oetsi';
update gii_hierarchy as gh set gh.lat='28.135443', gh.long='-29.196167' where district='BEREA' and council='Makeoana Council' and village='Ha Matsa';
update gii_hierarchy as gh set gh.lat='28.079533', gh.long='-29.212322' where district='BEREA' and council='Makeoana Council' and village='Ha Matsoso';

update gii_hierarchy as gh set gh.lat='28.064806', gh.long='-29.208029' where district='BEREA' and council='Makeoana Council' and village='Ha Malepa';
update gii_hierarchy as gh set gh.lat='28.067231', gh.long='-29.204506' where district='BEREA' and council='Makeoana Council' and village='Ha Seraha Majoe';
update gii_hierarchy as gh set gh.lat='28.061358', gh.long='-29.197008' where district='BEREA' and council='Makeoana Council' and village='Phahameng';

update gii_hierarchy as gh set gh.lat='28.04716', gh.long='-29.196948' where district='BEREA' and council='Makeoana Council' and village='Ha Ntsane';
update gii_hierarchy as gh set gh.lat='28.044775', gh.long='-29.184595' where district='BEREA' and council='Makeoana Council' and village='Ha Tobolela';
update gii_hierarchy as gh set gh.lat='28.063283', gh.long='-29.220694' where district='BEREA' and council='Makeoana Council' and village='Ha Mangana';
update gii_hierarchy as gh set gh.lat='28.061611', gh.long='-29.233814' where district='BEREA' and council='Makeoana Council' and village='Ha Makaliso';
update gii_hierarchy as gh set gh.lat='28.051235', gh.long='-29.367516' where district='BEREA' and council='Makeoana Council' and village='Ha Letsie';
update gii_hierarchy as gh set gh.lat='28.22032', gh.long='-29.312376' where district='BEREA' and council='Makeoana Council' and village='Ha Maime';
update gii_hierarchy as gh set gh.lat='28.24075', gh.long='-29.284623' where district='BEREA' and council='Makeoana Council' and village='Ha Mothakathi';
update gii_hierarchy as gh set gh.lat='28.282941', gh.long='-29.258414' where district='BEREA' and council='Makeoana Council' and village='Ha Raletsae';
update gii_hierarchy as gh set gh.lat='28.226141', gh.long='-29.301262' where district='BEREA' and council='Makeoana Council' and village='Ha Mahana';
update gii_hierarchy as gh set gh.lat='28.106371', gh.long='-29.324734' where district='BEREA' and council='Makeoana Council' and village='Ha Masopha (Meeling)';

update gii_hierarchy as gh set gh.lat='28.090825', gh.long='-29.055096' where district='BEREA' and council='Mapoteng Council' and village='Ha Mafamolane';
update gii_hierarchy as gh set gh.lat='28.076602', gh.long='-29.067385' where district='BEREA' and council='Mapoteng Council' and village='Ha Sekhahlela';
update gii_hierarchy as gh set gh.lat='28.089572', gh.long='-29.06649' where district='BEREA' and council='Mapoteng Council' and village='Matlapeng (Ha Ntina)';
update gii_hierarchy as gh set gh.lat='28.085498', gh.long='-29.086123' where district='BEREA' and council='Mapoteng Council' and village='Borakapane';
update gii_hierarchy as gh set gh.lat='28.081751', gh.long='-29.076145' where district='BEREA' and council='Mapoteng Council' and village='Ha Lehomo';



update gii_hierarchy as gh set gh.lat='28.068691', gh.long='-29.076591' where district='BEREA' and council='Mapoteng Council' and village='Liphakoeng (Ha Ntina)';
update gii_hierarchy as gh set gh.lat='28.065834', gh.long='-29.079863' where district='BEREA' and council='Mapoteng Council' and village='Ha Pitso';

update gii_hierarchy as gh set gh.lat='28.01904', gh.long='-29.072657' where district='BEREA' and council='Mapoteng Council' and village='Ha Hlakolane';
update gii_hierarchy as gh set gh.lat='28.020375', gh.long='-29.062641' where district='BEREA' and council='Mapoteng Council' and village='Ha Matube';

update gii_hierarchy as gh set gh.lat='28.012494', gh.long='-29.061887' where district='BEREA' and council='Mapoteng Council' and village='Qelekeqe';
update gii_hierarchy as gh set gh.lat='28.011697', gh.long='-29.077541' where district='BEREA' and council='Mapoteng Council' and village='Mapolateng';

update gii_hierarchy as gh set gh.lat='27.968142', gh.long='-28.998523' where district='BEREA' and council='Mapoteng Council' and village='Paballong';
update gii_hierarchy as gh set gh.lat='28.029147', gh.long='-29.07507' where district='BEREA' and council='Mapoteng Council' and village='Tsatsa Le Moea';
update gii_hierarchy as gh set gh.lat='28.003615', gh.long='-29.069862' where district='BEREA' and council='Mapoteng Council' and village='Ha Nthoba';
update gii_hierarchy as gh set gh.lat='28.001601', gh.long='-29.060307' where district='BEREA' and council='Mapoteng Council' and village='Ha Phalima';
update gii_hierarchy as gh set gh.lat='27.996101', gh.long='-29.068914' where district='BEREA' and council='Mapoteng Council' and village='Ha Saba';
update gii_hierarchy as gh set gh.lat='27.517873', gh.long='-29.281281' where district='BEREA' and council='Mapoteng Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='27.984883', gh.long='-29.045816' where district='BEREA' and council='Mapoteng Council' and village='Ha Mohapi';
update gii_hierarchy as gh set gh.lat='27.989961', gh.long='-29.062022' where district='BEREA' and council='Mapoteng Council' and village='Ha Mokone';
update gii_hierarchy as gh set gh.lat='27.987548', gh.long='-29.054412' where district='BEREA' and council='Mapoteng Council' and village='Thaba Chitja';

update gii_hierarchy as gh set gh.lat='27.977488', gh.long='-29.057978' where district='BEREA' and council='Mapoteng Council' and village='Ha Potjo';
update gii_hierarchy as gh set gh.lat='27.982071', gh.long='-29.070415' where district='BEREA' and council='Mapoteng Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='27.969004', gh.long='-29.063503' where district='BEREA' and council='Mapoteng Council' and village='Phalole';
update gii_hierarchy as gh set gh.lat='27.962416', gh.long='-29.057766' where district='BEREA' and council='Mapoteng Council' and village='Thabana Tsoana';
update gii_hierarchy as gh set gh.lat='27.985422', gh.long='-29.071867' where district='BEREA' and council='Mapoteng Council' and village='Nyareleng';
update gii_hierarchy as gh set gh.lat='27.960063', gh.long='-29.076672' where district='BEREA' and council='Mapoteng Council' and village='Tsokung';
update gii_hierarchy as gh set gh.lat='27.957796', gh.long='-29.100221' where district='BEREA' and council='Mapoteng Council' and village='Popopo (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.965876', gh.long='-29.108641' where district='BEREA' and council='Mapoteng Council' and village='Ha Khotso (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.962775', gh.long='-29.11693' where district='BEREA' and council='Mapoteng Council' and village='Likoting (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.974601', gh.long='-29.121835' where district='BEREA' and council='Mapoteng Council' and village='Ha Maloela (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.972891', gh.long='-29.11106' where district='BEREA' and council='Mapoteng Council' and village='Ha Mphanya (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.978389', gh.long='-29.113967' where district='BEREA' and council='Mapoteng Council' and village='Ha Ramaema (Mapoteng)';

update gii_hierarchy as gh set gh.lat='27.984058', gh.long='-29.123131' where district='BEREA' and council='Mapoteng Council' and village='Taung (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.98097', gh.long='-29.118657' where district='BEREA' and council='Mapoteng Council' and village='Ha Molebo (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.98935', gh.long='-29.1112' where district='BEREA' and council='Mapoteng Council' and village='Ha Sekhomo (Mapoteng)';
update gii_hierarchy as gh set gh.lat='28.013351', gh.long='-29.097105' where district='BEREA' and council='Mapoteng Council' and village='Koma Koma';
update gii_hierarchy as gh set gh.lat='27.99235', gh.long='-29.08507' where district='BEREA' and council='Mapoteng Council' and village='Ha Makhobalo';
update gii_hierarchy as gh set gh.lat='28.023922', gh.long='-29.09313' where district='BEREA' and council='Mapoteng Council' and village='Botsoapa';
update gii_hierarchy as gh set gh.lat='28.032409', gh.long='-29.085929' where district='BEREA' and council='Mapoteng Council' and village='Ha Mokhachane';
update gii_hierarchy as gh set gh.lat='28.049211', gh.long='-29.141507' where district='BEREA' and council='Mapoteng Council' and village='Sehlabeng';
update gii_hierarchy as gh set gh.lat='28.046616', gh.long='-29.095406' where district='BEREA' and council='Mapoteng Council' and village='Ha Selebeli (Nokong)';

update gii_hierarchy as gh set gh.lat='28.059485', gh.long='-29.099223' where district='BEREA' and council='Mapoteng Council' and village='Ha Motjoli';



update gii_hierarchy as gh set gh.lat='28.045354', gh.long='-29.115632' where district='BEREA' and council='Mapoteng Council' and village='Mampating';
update gii_hierarchy as gh set gh.lat='28.036982', gh.long='-29.112879' where district='BEREA' and council='Mapoteng Council' and village='Masenkeng';
update gii_hierarchy as gh set gh.lat='28.02667', gh.long='-29.112781' where district='BEREA' and council='Mapoteng Council' and village='Phutha';
update gii_hierarchy as gh set gh.lat='28.014826', gh.long='-29.104164' where district='BEREA' and council='Mapoteng Council' and village='Ntsirele';
update gii_hierarchy as gh set gh.lat='28.005473', gh.long='-29.130295' where district='BEREA' and council='Mapoteng Council' and village='Ha Rachere';
update gii_hierarchy as gh set gh.lat='27.985625', gh.long='-29.132724' where district='BEREA' and council='Mapoteng Council' and village='Ha Macha (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.998738', gh.long='-29.14126' where district='BEREA' and council='Mapoteng Council' and village='Mokoallong (Mapoteng)';
update gii_hierarchy as gh set gh.lat='27.974848', gh.long='-29.1332' where district='BEREA' and council='Mapoteng Council' and village='Ha Arone';
update gii_hierarchy as gh set gh.lat='27.964776', gh.long='-29.142264' where district='BEREA' and council='Mapoteng Council' and village='Ha Ntsoso';
update gii_hierarchy as gh set gh.lat='27.984943', gh.long='-29.14653' where district='BEREA' and council='Mapoteng Council' and village='Ha Filoane';
update gii_hierarchy as gh set gh.lat='27.987652', gh.long='-29.163083' where district='BEREA' and council='Mapoteng Council' and village='Ha Mahlomola';
update gii_hierarchy as gh set gh.lat='27.980552', gh.long='-29.165403' where district='BEREA' and council='Mapoteng Council' and village='Ha Moshakha';
update gii_hierarchy as gh set gh.lat='27.99423', gh.long='-29.154806' where district='BEREA' and council='Mapoteng Council' and village='Ha Qhobosheane';
update gii_hierarchy as gh set gh.lat='28.011339', gh.long='-29.157339' where district='BEREA' and council='Mapoteng Council' and village='Thota Tsehla (Mapoteng)';
update gii_hierarchy as gh set gh.lat='28.013873', gh.long='-29.1507' where district='BEREA' and council='Mapoteng Council' and village='Ha Malima (Mapoteng)';
update gii_hierarchy as gh set gh.lat='28.010841', gh.long='-29.143815' where district='BEREA' and council='Mapoteng Council' and village='Thabong (Mapoteng)';
update gii_hierarchy as gh set gh.lat='28.038138', gh.long='-29.125948' where district='BEREA' and council='Mapoteng Council' and village='Ha Ramakoro';
update gii_hierarchy as gh set gh.lat='28.020404', gh.long='-29.142213' where district='BEREA' and council='Mapoteng Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='28.032259', gh.long='-29.130252' where district='BEREA' and council='Mapoteng Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.039107', gh.long='-29.150194' where district='BEREA' and council='Mapoteng Council' and village='Lifotholeng';
update gii_hierarchy as gh set gh.lat='28.02343', gh.long='-29.132422' where district='BEREA' and council='Mapoteng Council' and village='Makoabating';
update gii_hierarchy as gh set gh.lat='28.02791', gh.long='-29.144172' where district='BEREA' and council='Mapoteng Council' and village='Sekotjaneng';
update gii_hierarchy as gh set gh.lat='28.048236', gh.long='-29.130233' where district='BEREA' and council='Mapoteng Council' and village='Ha Morasenyane';
update gii_hierarchy as gh set gh.lat='28.058651', gh.long='-29.130936' where district='BEREA' and council='Mapoteng Council' and village='Ha Tebalete';
update gii_hierarchy as gh set gh.lat='28.057365', gh.long='-29.142662' where district='BEREA' and council='Mapoteng Council' and village='Leboteng (Ha Telebate)';

update gii_hierarchy as gh set gh.lat='28.032432', gh.long='-29.162917' where district='BEREA' and council='Mapoteng Council' and village='Ha Makhoroana';


update gii_hierarchy as gh set gh.lat='28.017527', gh.long='-29.163768' where district='BEREA' and council='Mapoteng Council' and village='Ha Ramohoete';
update gii_hierarchy as gh set gh.lat='28.01642', gh.long='-29.158951' where district='BEREA' and council='Mapoteng Council' and village='Machoaboleng';
update gii_hierarchy as gh set gh.lat='28.084236', gh.long='-29.181309' where district='BEREA' and council='Mapoteng Council' and village='Khetha';
update gii_hierarchy as gh set gh.lat='27.991885', gh.long='-29.177357' where district='BEREA' and council='Mapoteng Council' and village='Ha Mokhobokoane';
update gii_hierarchy as gh set gh.lat='27.997954', gh.long='-29.164077' where district='BEREA' and council='Mapoteng Council' and village='Ha Moqachela';
update gii_hierarchy as gh set gh.lat='28.002336', gh.long='-29.171257' where district='BEREA' and council='Mapoteng Council' and village='Ha Tsepe';
update gii_hierarchy as gh set gh.lat='28.012574', gh.long='-29.19274' where district='BEREA' and council='Mapoteng Council' and village='Ha Lebenya';
update gii_hierarchy as gh set gh.lat='28.030888', gh.long='-29.188745' where district='BEREA' and council='Mapoteng Council' and village='Ha Mpeshe';
update gii_hierarchy as gh set gh.lat='28.018958', gh.long='-29.183023' where district='BEREA' and council='Mapoteng Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='28.036195', gh.long='-29.17109' where district='BEREA' and council='Mapoteng Council' and village='Masetlaokong';
update gii_hierarchy as gh set gh.lat='28.031942', gh.long='-29.179192' where district='BEREA' and council='Mapoteng Council' and village='Sentelina';
update gii_hierarchy as gh set gh.lat='27.972829', gh.long='-28.967894' where district='BEREA' and council='Koeneng Council' and village='Mafotholeng';

update gii_hierarchy as gh set gh.lat='27.976391', gh.long='-28.965839' where district='BEREA' and council='Koeneng Council' and village='Ha Masasa';
update gii_hierarchy as gh set gh.lat='27.999024', gh.long='-28.961675' where district='BEREA' and council='Koeneng Council' and village='Ha Makotola';
update gii_hierarchy as gh set gh.lat='27.992732', gh.long='-28.975548' where district='BEREA' and council='Koeneng Council' and village='Ha Peete';
update gii_hierarchy as gh set gh.lat='27.974363', gh.long='-28.974021' where district='BEREA' and council='Koeneng Council' and village='Motsemocha (Mafotholeng)';
update gii_hierarchy as gh set gh.lat='27.970465', gh.long='-28.991742' where district='BEREA' and council='Koeneng Council' and village='Bakaneng';
update gii_hierarchy as gh set gh.lat='27.968142', gh.long='-28.998523' where district='BEREA' and council='Koeneng Council' and village='Paballong';
update gii_hierarchy as gh set gh.lat='27.959471', gh.long='-29.003336' where district='BEREA' and council='Koeneng Council' and village='Maphiring';
update gii_hierarchy as gh set gh.lat='27.950339', gh.long='-29.023307' where district='BEREA' and council='Koeneng Council' and village='Ha Lebentlele';
update gii_hierarchy as gh set gh.lat='27.955542', gh.long='-29.014958' where district='BEREA' and council='Koeneng Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='27.963031', gh.long='-29.018537' where district='BEREA' and council='Koeneng Council' and village='Ha Tlelaka';
update gii_hierarchy as gh set gh.lat='27.964281', gh.long='-29.008679' where district='BEREA' and council='Koeneng Council' and village='Baking';
update gii_hierarchy as gh set gh.lat='27.988062', gh.long='-29.01268' where district='BEREA' and council='Koeneng Council' and village='Mokomahatsi';
update gii_hierarchy as gh set gh.lat='28.003483', gh.long='-28.992311' where district='BEREA' and council='Koeneng Council' and village='Ha Leutsoa';
update gii_hierarchy as gh set gh.lat='28.014177', gh.long='-29.008061' where district='BEREA' and council='Koeneng Council' and village='Ha Matsoai';
update gii_hierarchy as gh set gh.lat='28.003498', gh.long='-29.000849' where district='BEREA' and council='Koeneng Council' and village='Ha Nteleki';
update gii_hierarchy as gh set gh.lat='27.999649', gh.long='-28.996659' where district='BEREA' and council='Koeneng Council' and village='Ha Qopana';
update gii_hierarchy as gh set gh.lat='28.012117', gh.long='-28.991585' where district='BEREA' and council='Koeneng Council' and village='Ha Letsoela';
update gii_hierarchy as gh set gh.lat='28.014856', gh.long='-28.962926' where district='BEREA' and council='Koeneng Council' and village='Ha Pelele (Lipeleseng)';
update gii_hierarchy as gh set gh.lat='28.029027', gh.long='-28.977618' where district='BEREA' and council='Koeneng Council' and village='Ha Thuhloane';
update gii_hierarchy as gh set gh.lat='28.058655', gh.long='-29.002624' where district='BEREA' and council='Koeneng Council' and village='Ha Tsepo (Kolojane)';

update gii_hierarchy as gh set gh.lat='28.040194', gh.long='-29.00298' where district='BEREA' and council='Koeneng Council' and village='Ha Seisa (Kolojane)';

update gii_hierarchy as gh set gh.lat='28.018092', gh.long='-28.999647' where district='BEREA' and council='Koeneng Council' and village='Ha Ntoro';


update gii_hierarchy as gh set gh.lat='28.058991', gh.long='-29.0216' where district='BEREA' and council='Koeneng Council' and village='Ha Khasane';
update gii_hierarchy as gh set gh.lat='28.072238', gh.long='-29.022246' where district='BEREA' and council='Koeneng Council' and village='Ha Khororo';
update gii_hierarchy as gh set gh.lat='28.055472', gh.long='-29.013285' where district='BEREA' and council='Koeneng Council' and village='Ha Moratoe';
update gii_hierarchy as gh set gh.lat='28.066441', gh.long='-29.022413' where district='BEREA' and council='Koeneng Council' and village='Moneaneng';
update gii_hierarchy as gh set gh.lat='28.09005', gh.long='-29.040363' where district='BEREA' and council='Koeneng Council' and village='Ha Ratomo';
update gii_hierarchy as gh set gh.lat='28.060735', gh.long='-29.026666' where district='BEREA' and council='Koeneng Council' and village='Ha Nkhekhe';
update gii_hierarchy as gh set gh.lat='28.065894', gh.long='-29.031701' where district='BEREA' and council='Koeneng Council' and village='Seforong';
update gii_hierarchy as gh set gh.lat='28.051449', gh.long='-29.03601' where district='BEREA' and council='Koeneng Council' and village='Thabana Ntlenyana';
update gii_hierarchy as gh set gh.lat='28.04402', gh.long='-29.053602' where district='BEREA' and council='Koeneng Council' and village='Ha Pakalitha';
update gii_hierarchy as gh set gh.lat='28.040205', gh.long='-29.046354' where district='BEREA' and council='Koeneng Council' and village='Likhutlong';
update gii_hierarchy as gh set gh.lat='28.031474', gh.long='-29.044161' where district='BEREA' and council='Koeneng Council' and village='Malebesana (Ha Nyaka)';
update gii_hierarchy as gh set gh.lat='28.039788', gh.long='-29.025594' where district='BEREA' and council='Koeneng Council' and village='Ha Kopi';
update gii_hierarchy as gh set gh.lat='28.023641', gh.long='-29.029852' where district='BEREA' and council='Koeneng Council' and village='Bela Bela (Moreneng)';
update gii_hierarchy as gh set gh.lat='28.02131', gh.long='-29.0343' where district='BEREA' and council='Koeneng Council' and village='Moeaneng (Bela Bela)';
update gii_hierarchy as gh set gh.lat='28.025165', gh.long='-29.036201' where district='BEREA' and council='Koeneng Council' and village='Morapamiseng (Bela Bela)';
update gii_hierarchy as gh set gh.lat='28.015959', gh.long='-29.026247' where district='BEREA' and council='Koeneng Council' and village='Bela Bela West';
update gii_hierarchy as gh set gh.lat='28.010314', gh.long='-29.024217' where district='BEREA' and council='Koeneng Council' and village='Ha Mahlabachana (Bela Bela)';
update gii_hierarchy as gh set gh.lat='28.005644', gh.long='-29.032236' where district='BEREA' and council='Koeneng Council' and village='Ha Makhetha';
update gii_hierarchy as gh set gh.lat='28.003557', gh.long='-29.039749' where district='BEREA' and council='Koeneng Council' and village='Ha Ntisa';
update gii_hierarchy as gh set gh.lat='28.000875', gh.long='-29.028837' where district='BEREA' and council='Koeneng Council' and village='Mechaling';
update gii_hierarchy as gh set gh.lat='27.999506', gh.long='-29.020422' where district='BEREA' and council='Koeneng Council' and village='Tuke';
update gii_hierarchy as gh set gh.lat='27.981633', gh.long='-29.024385' where district='BEREA' and council='Koeneng Council' and village='Ha Morathaba';
update gii_hierarchy as gh set gh.lat='27.98386', gh.long='-29.035972' where district='BEREA' and council='Koeneng Council' and village='Ha Lephallo';
update gii_hierarchy as gh set gh.lat='27.969528', gh.long='-29.033811' where district='BEREA' and council='Koeneng Council' and village='Ha Mashetla';
update gii_hierarchy as gh set gh.lat='27.969679', gh.long='-29.038978' where district='BEREA' and council='Koeneng Council' and village='Ha Monyatso';
update gii_hierarchy as gh set gh.lat='27.958232', gh.long='-29.030014' where district='BEREA' and council='Koeneng Council' and village='Ha Mashoai';
update gii_hierarchy as gh set gh.lat='27.990308', gh.long='-29.039571' where district='BEREA' and council='Koeneng Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='27.956319', gh.long='-29.036513' where district='BEREA' and council='Koeneng Council' and village='Ha Tsolo';
update gii_hierarchy as gh set gh.lat='27.955892', gh.long='-29.040388' where district='BEREA' and council='Koeneng Council' and village='Ha Ralekeke';
update gii_hierarchy as gh set gh.lat='27.939038', gh.long='-29.055691' where district='BEREA' and council='Koeneng Council' and village='Khotsis';
update gii_hierarchy as gh set gh.lat='27.960961', gh.long='-29.043728' where district='BEREA' and council='Koeneng Council' and village='Moetsuoa';
update gii_hierarchy as gh set gh.lat='27.933555', gh.long='-29.047403' where district='BEREA' and council='Koeneng Council' and village='Ha Malibeng';
update gii_hierarchy as gh set gh.lat='27.938027', gh.long='-29.0363' where district='BEREA' and council='Koeneng Council' and village='Ha Mosekeseke';
update gii_hierarchy as gh set gh.lat='27.937802', gh.long='-29.050062' where district='BEREA' and council='Koeneng Council' and village='Ha Rajone';
update gii_hierarchy as gh set gh.lat='27.934028', gh.long='-29.060176' where district='BEREA' and council='Koeneng Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.943948', gh.long='-29.070307' where district='BEREA' and council='Koeneng Council' and village='Mafika Lisiu (Masaleng)';
update gii_hierarchy as gh set gh.lat='27.92554', gh.long='-29.068663' where district='BEREA' and council='Koeneng Council' and village='Ha Hlajoane';
update gii_hierarchy as gh set gh.lat='27.934134', gh.long='-29.066527' where district='BEREA' and council='Koeneng Council' and village='Ha Raletsae';
update gii_hierarchy as gh set gh.lat='27.915907', gh.long='-29.073527' where district='BEREA' and council='Koeneng Council' and village='Ha Mpiti';
update gii_hierarchy as gh set gh.lat='27.815553', gh.long='-29.160897' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Lethokonyane';
update gii_hierarchy as gh set gh.lat='27.81639', gh.long='-29.172377' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Sello';

update gii_hierarchy as gh set gh.lat='27.826065', gh.long='-29.160891' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Matsipe';
update gii_hierarchy as gh set gh.lat='27.82789', gh.long='-29.168353' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mokolanyane';
update gii_hierarchy as gh set gh.lat='27.825929', gh.long='-29.185971' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Tsikoane';
update gii_hierarchy as gh set gh.lat='27.840795', gh.long='-29.165853' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Makhatseane';
update gii_hierarchy as gh set gh.lat='27.84368', gh.long='-29.169648' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mona';
update gii_hierarchy as gh set gh.lat='27.849623', gh.long='-29.173951' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Neko';
update gii_hierarchy as gh set gh.lat='27.83747', gh.long='-29.208782' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mohatlane';
update gii_hierarchy as gh set gh.lat='27.863182', gh.long='-29.188221' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Jane';
update gii_hierarchy as gh set gh.lat='27.860978', gh.long='-29.202496' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Johane';
update gii_hierarchy as gh set gh.lat='27.862571', gh.long='-29.179689' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Morake';
update gii_hierarchy as gh set gh.lat='27.877095', gh.long='-29.181954' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ntlama';

update gii_hierarchy as gh set gh.lat='27.879208', gh.long='-29.194424' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Lefoleri';
update gii_hierarchy as gh set gh.lat='27.868376', gh.long='-29.212545' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Monethi';
update gii_hierarchy as gh set gh.lat='27.869258', gh.long='-29.228711' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Matjotjo';
update gii_hierarchy as gh set gh.lat='27.867864', gh.long='-29.221936' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Moholobela';
update gii_hierarchy as gh set gh.lat='27.868254', gh.long='-29.231404' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Tsai';
update gii_hierarchy as gh set gh.lat='27.881713', gh.long='-29.23127' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Tsimatsi';
update gii_hierarchy as gh set gh.lat='27.88075', gh.long='-29.224876' where district='BEREA' and council='Tebe Tebe Council' and village='Liolong';
update gii_hierarchy as gh set gh.lat='27.896079', gh.long='-29.202747' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mapeshoane (Malimong)';

update gii_hierarchy as gh set gh.lat='27.932343', gh.long='-29.187467' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Moorosane';
update gii_hierarchy as gh set gh.lat='27.931633', gh.long='-29.19774' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ntsekhe';
update gii_hierarchy as gh set gh.lat='27.910756', gh.long='-29.204385' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mika';
update gii_hierarchy as gh set gh.lat='27.909078', gh.long='-29.209766' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='27.916004', gh.long='-29.207365' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ramaqele';
update gii_hierarchy as gh set gh.lat='27.905071', gh.long='-29.226321' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Matanki';
update gii_hierarchy as gh set gh.lat='27.921352', gh.long='-29.21285' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Naleli';
update gii_hierarchy as gh set gh.lat='27.921768', gh.long='-29.223151' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Majoro';
update gii_hierarchy as gh set gh.lat='27.922255', gh.long='-29.205061' where district='BEREA' and council='Tebe Tebe Council' and village='Lipohong';
update gii_hierarchy as gh set gh.lat='27.937363', gh.long='-29.199636' where district='BEREA' and council='Tebe Tebe Council' and village='Masuoeng';
update gii_hierarchy as gh set gh.lat='27.954242', gh.long='-29.195634' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Pii';
update gii_hierarchy as gh set gh.lat='27.962711', gh.long='-29.19754' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ramaema';
update gii_hierarchy as gh set gh.lat='27.97314', gh.long='-29.201294' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Selei';
update gii_hierarchy as gh set gh.lat='27.979427', gh.long='-29.200809' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Makhula';
update gii_hierarchy as gh set gh.lat='27.999626', gh.long='-29.2131' where district='BEREA' and council='Tebe Tebe Council' and village='Litooaneng';

update gii_hierarchy as gh set gh.lat='28.011908', gh.long='-29.228989' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Leutsoa';
update gii_hierarchy as gh set gh.lat='27.989904', gh.long='-29.236133' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Nkhahle';
update gii_hierarchy as gh set gh.lat='27.885205', gh.long='-29.241159' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Molahli';

update gii_hierarchy as gh set gh.lat='27.971383', gh.long='-29.213547' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Lereko';

update gii_hierarchy as gh set gh.lat='27.950086', gh.long='-29.216098' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Lenkoane';
update gii_hierarchy as gh set gh.lat='27.958432', gh.long='-29.215713' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ramosenyehi';
update gii_hierarchy as gh set gh.lat='27.928956', gh.long='-29.248631' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mokhameleli';
update gii_hierarchy as gh set gh.lat='27.970108', gh.long='-29.233198' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='27.955964', gh.long='-29.261797' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Lejone';
update gii_hierarchy as gh set gh.lat='27.968374', gh.long='-29.267151' where district='BEREA' and council='Tebe Tebe Council' and village='Ha Ramapaeane';
update gii_hierarchy as gh set gh.lat='27.776731', gh.long='-29.090784' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Tsekelo';
update gii_hierarchy as gh set gh.lat='27.785711', gh.long='-29.085436' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Motsoaole';
update gii_hierarchy as gh set gh.lat='27.78999', gh.long='-29.10339' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mosethe';
update gii_hierarchy as gh set gh.lat='27.785419', gh.long='-29.098899' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mosoeunyane';
update gii_hierarchy as gh set gh.lat='27.799669', gh.long='-29.109266' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mokhehle';

update gii_hierarchy as gh set gh.lat='27.800615', gh.long='-29.104278' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Rapopo';
update gii_hierarchy as gh set gh.lat='27.792368', gh.long='-29.127339' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Libenyane';
update gii_hierarchy as gh set gh.lat='27.78725', gh.long='-29.124066' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ramachine';
update gii_hierarchy as gh set gh.lat='27.812148', gh.long='-29.118716' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Chaba';
update gii_hierarchy as gh set gh.lat='27.805739', gh.long='-29.116929' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Phiri';
update gii_hierarchy as gh set gh.lat='27.80671', gh.long='-29.120955' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Tsoeunyane';
update gii_hierarchy as gh set gh.lat='27.80148', gh.long='-29.079541' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Lebina';
update gii_hierarchy as gh set gh.lat='28.07342', gh.long='-29.193528' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Phoofolo';
update gii_hierarchy as gh set gh.lat='27.970108', gh.long='-29.233198' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='27.82858', gh.long='-29.06006' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mosobela';
update gii_hierarchy as gh set gh.lat='27.83352', gh.long='-29.06886' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ramotete';
update gii_hierarchy as gh set gh.lat='27.836225', gh.long='-29.074271' where district='BEREA' and council='Phuthiatsana Council' and village='Lipatolong';
update gii_hierarchy as gh set gh.lat='27.836027', gh.long='-29.089289' where district='BEREA' and council='Phuthiatsana Council' and village='Sebala Bala';
update gii_hierarchy as gh set gh.lat='27.826927', gh.long='-29.096049' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Morolong';
update gii_hierarchy as gh set gh.lat='27.828761', gh.long='-29.101889' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ntebele';
update gii_hierarchy as gh set gh.lat='27.819507', gh.long='-29.105994' where district='BEREA' and council='Phuthiatsana Council' and village='Kolone';

update gii_hierarchy as gh set gh.lat='27.833987', gh.long='-29.109965' where district='BEREA' and council='Phuthiatsana Council' and village='Cana';

update gii_hierarchy as gh set gh.lat='27.822849', gh.long='-29.122432' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mamathe';
update gii_hierarchy as gh set gh.lat='27.849504', gh.long='-29.132619' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Lenea';


update gii_hierarchy as gh set gh.lat='27.83324', gh.long='-29.136745' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Malesela';

update gii_hierarchy as gh set gh.lat='27.842205', gh.long='-29.137497' where district='BEREA' and council='Phuthiatsana Council' and village='Khalahali';
update gii_hierarchy as gh set gh.lat='27.845107', gh.long='-29.142694' where district='BEREA' and council='Phuthiatsana Council' and village='Tilimaneng';
update gii_hierarchy as gh set gh.lat='27.854612', gh.long='-29.154403' where district='BEREA' and council='Phuthiatsana Council' and village='Thota Peli';
update gii_hierarchy as gh set gh.lat='27.863182', gh.long='-29.188221' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Jane';

update gii_hierarchy as gh set gh.lat='27.869214', gh.long='-29.144079' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Kholopane';
update gii_hierarchy as gh set gh.lat='27.873714', gh.long='-29.13796' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Phalatsane';
update gii_hierarchy as gh set gh.lat='27.886135', gh.long='-29.142808' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Rantung';
update gii_hierarchy as gh set gh.lat='27.857291', gh.long='-29.130648' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Hlaonyane';
update gii_hierarchy as gh set gh.lat='27.877248', gh.long='-29.119772' where district='BEREA' and council='Phuthiatsana Council' and village='Liphiring';
update gii_hierarchy as gh set gh.lat='27.857676', gh.long='-29.084461' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='27.876959', gh.long='-29.084912' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Korotsoane';
update gii_hierarchy as gh set gh.lat='27.872575', gh.long='-29.09517' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ntsabane';
update gii_hierarchy as gh set gh.lat='27.887271', gh.long='-29.089031' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Bose';

update gii_hierarchy as gh set gh.lat='27.903949', gh.long='-29.090896' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Thaka Mpholo';
update gii_hierarchy as gh set gh.lat='27.900749', gh.long='-29.105075' where district='BEREA' and council='Phuthiatsana Council' and village='Khafung';
update gii_hierarchy as gh set gh.lat='27.921078', gh.long='-29.106942' where district='BEREA' and council='Phuthiatsana Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='27.923434', gh.long='-29.092913' where district='BEREA' and council='Phuthiatsana Council' and village='Majaheng';
update gii_hierarchy as gh set gh.lat='27.935857', gh.long='-29.088842' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mokhathi';

update gii_hierarchy as gh set gh.lat='27.93601', gh.long='-29.116494' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Bulara';
update gii_hierarchy as gh set gh.lat='27.932881', gh.long='-29.123808' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Koone';
update gii_hierarchy as gh set gh.lat='27.941753', gh.long='-29.103757' where district='BEREA' and council='Phuthiatsana Council' and village='Mohlakeng';
update gii_hierarchy as gh set gh.lat='27.903618', gh.long='-29.115805' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Moepi';
update gii_hierarchy as gh set gh.lat='27.913209', gh.long='-29.114927' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Molala';
update gii_hierarchy as gh set gh.lat='27.907953', gh.long='-29.122069' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ntsang';
update gii_hierarchy as gh set gh.lat='27.907197', gh.long='-29.130738' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mphunyetsane';
update gii_hierarchy as gh set gh.lat='27.920711', gh.long='-29.13855' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Ntsenki';
update gii_hierarchy as gh set gh.lat='27.893297', gh.long='-29.145097' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Patso';

update gii_hierarchy as gh set gh.lat='27.902959', gh.long='-29.145868' where district='BEREA' and council='Phuthiatsana Council' and village='Masoeling';
update gii_hierarchy as gh set gh.lat='27.905466', gh.long='-29.166243' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Mahleke';
update gii_hierarchy as gh set gh.lat='27.892524', gh.long='-29.159946' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Seele';

update gii_hierarchy as gh set gh.lat='27.910145', gh.long='-29.153621' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Selone';
update gii_hierarchy as gh set gh.lat='27.915525', gh.long='-29.159452' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Tsepo';
update gii_hierarchy as gh set gh.lat='27.918001', gh.long='-29.148994' where district='BEREA' and council='Phuthiatsana Council' and village='Mahlanyeng';
update gii_hierarchy as gh set gh.lat='27.944139', gh.long='-29.123192' where district='BEREA' and council='Phuthiatsana Council' and village='Koti sephola';
update gii_hierarchy as gh set gh.lat='27.93376', gh.long='-29.137394' where district='BEREA' and council='Phuthiatsana Council' and village='Sefateng';
update gii_hierarchy as gh set gh.lat='27.958986', gh.long='-29.128428' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Sepiriti (Moterong)';
update gii_hierarchy as gh set gh.lat='27.949851', gh.long='-29.132887' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Tjobe';
update gii_hierarchy as gh set gh.lat='27.954193', gh.long='-29.144287' where district='BEREA' and council='Phuthiatsana Council' and village='Tsila Tsila';
update gii_hierarchy as gh set gh.lat='27.941328', gh.long='-29.172071' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='27.92685', gh.long='-29.168449' where district='BEREA' and council='Phuthiatsana Council' and village='Phuthing';

update gii_hierarchy as gh set gh.lat='27.954231', gh.long='-29.168356' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Lehana';
update gii_hierarchy as gh set gh.lat='27.950284', gh.long='-29.158315' where district='BEREA' and council='Phuthiatsana Council' and village='Malieleng';
update gii_hierarchy as gh set gh.lat='27.983045', gh.long='-29.192238' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Matelile';
update gii_hierarchy as gh set gh.lat='27.972118', gh.long='-29.184027' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Rankali';
update gii_hierarchy as gh set gh.lat='27.949855', gh.long='-29.169638' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Seutloali';
update gii_hierarchy as gh set gh.lat='27.960633', gh.long='-29.182652' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Thube';

update gii_hierarchy as gh set gh.lat='27.871448', gh.long='-29.140744' where district='BEREA' and council='Phuthiatsana Council' and village='Ha Rapalo';



update gii_hierarchy as gh set gh.lat='27.738703', gh.long='-29.154435' where district='BEREA' and council='Maluba lube Council' and village='Ha Mohapinyane';
update gii_hierarchy as gh set gh.lat='27.734773', gh.long='-29.137425' where district='BEREA' and council='Maluba lube Council' and village='Ha Mohlaetoa';
update gii_hierarchy as gh set gh.lat='27.74915', gh.long='-29.138433' where district='BEREA' and council='Maluba lube Council' and village='Ha Motjoka';
update gii_hierarchy as gh set gh.lat='27.742134', gh.long='-29.140632' where district='BEREA' and council='Maluba lube Council' and village='Korokoro';
update gii_hierarchy as gh set gh.lat='27.725475', gh.long='-29.137236' where district='BEREA' and council='Maluba lube Council' and village='Ha Motseremeli';
update gii_hierarchy as gh set gh.lat='27.718608', gh.long='-29.139444' where district='BEREA' and council='Maluba lube Council' and village='Khoaba Lea Bua';
update gii_hierarchy as gh set gh.lat='27.736028', gh.long='-29.129726' where district='BEREA' and council='Maluba lube Council' and village='Ha Kalaele';
update gii_hierarchy as gh set gh.lat='27.758778', gh.long='-29.108913' where district='BEREA' and council='Maluba lube Council' and village='Ha Mphele';
update gii_hierarchy as gh set gh.lat='27.74801', gh.long='-29.130566' where district='BEREA' and council='Maluba lube Council' and village='Ntsirele (Ha Motjoka)';
update gii_hierarchy as gh set gh.lat='27.756113', gh.long='-29.13188' where district='BEREA' and council='Maluba lube Council' and village='Ha Ntjabane';
update gii_hierarchy as gh set gh.lat='27.752216', gh.long='-29.14271' where district='BEREA' and council='Maluba lube Council' and village='Ha Ramonaheng';
update gii_hierarchy as gh set gh.lat='27.757477', gh.long='-29.148228' where district='BEREA' and council='Maluba lube Council' and village='Ha Ratsiu';

update gii_hierarchy as gh set gh.lat='27.760375', gh.long='-29.156196' where district='BEREA' and council='Maluba lube Council' and village='Lithabaneng';
update gii_hierarchy as gh set gh.lat='27.774125', gh.long='-29.157281' where district='BEREA' and council='Maluba lube Council' and village='Ha Kepi (Lithabaneng)';
update gii_hierarchy as gh set gh.lat='27.79524', gh.long='-29.135162' where district='BEREA' and council='Maluba lube Council' and village='Ha Mopeli';
update gii_hierarchy as gh set gh.lat='27.782213', gh.long='-29.171976' where district='BEREA' and council='Maluba lube Council' and village='Ha Tebeli';
update gii_hierarchy as gh set gh.lat='27.792768', gh.long='-29.18269' where district='BEREA' and council='Maluba lube Council' and village='Ha Lekhafola';
update gii_hierarchy as gh set gh.lat='27.796745', gh.long='-29.175754' where district='BEREA' and council='Maluba lube Council' and village='Ha Nkalimeng';
update gii_hierarchy as gh set gh.lat='27.804917', gh.long='-29.19227' where district='BEREA' and council='Maluba lube Council' and village='Ha Ramajoro';
update gii_hierarchy as gh set gh.lat='27.816903', gh.long='-29.200993' where district='BEREA' and council='Maluba lube Council' and village='Ha Bale';
update gii_hierarchy as gh set gh.lat='27.737221', gh.long='-29.184279' where district='BEREA' and council='Motanasela Council' and village='Ha Notsi';
update gii_hierarchy as gh set gh.lat='27.733103', gh.long='-29.170978' where district='BEREA' and council='Motanasela Council' and village='Ha Sebekele';
update gii_hierarchy as gh set gh.lat='27.747464', gh.long='-29.197328' where district='BEREA' and council='Motanasela Council' and village='Ha Ramonyaloe';
update gii_hierarchy as gh set gh.lat='27.765532', gh.long='-29.207606' where district='BEREA' and council='Motanasela Council' and village='Ha Koali';
update gii_hierarchy as gh set gh.lat='27.75566', gh.long='-29.207784' where district='BEREA' and council='Motanasela Council' and village='Ha Rankatlo';
update gii_hierarchy as gh set gh.lat='27.771281', gh.long='-29.189856' where district='BEREA' and council='Motanasela Council' and village='Ha Lephoi';
update gii_hierarchy as gh set gh.lat='27.782902', gh.long='-29.197165' where district='BEREA' and council='Motanasela Council' and village='Ha Litsebe';
update gii_hierarchy as gh set gh.lat='27.778907', gh.long='-29.212321' where district='BEREA' and council='Motanasela Council' and village='Ha Mothebesoane';
update gii_hierarchy as gh set gh.lat='27.782484', gh.long='-29.208897' where district='BEREA' and council='Motanasela Council' and village='Ha Rakoto';
update gii_hierarchy as gh set gh.lat='27.792714', gh.long='-29.202405' where district='BEREA' and council='Motanasela Council' and village='Ha Rakheleli';
update gii_hierarchy as gh set gh.lat='27.789273', gh.long='-29.212359' where district='BEREA' and council='Motanasela Council' and village='Furumela';
update gii_hierarchy as gh set gh.lat='27.798598', gh.long='-29.219795' where district='BEREA' and council='Motanasela Council' and village='Ha Ramothamo';
update gii_hierarchy as gh set gh.lat='27.810679', gh.long='-29.21215' where district='BEREA' and council='Motanasela Council' and village='Ha Keoamang';
update gii_hierarchy as gh set gh.lat='27.801987', gh.long='-29.210815' where district='BEREA' and council='Motanasela Council' and village='Ha Lerata';
update gii_hierarchy as gh set gh.lat='27.832787', gh.long='-29.216724' where district='BEREA' and council='Motanasela Council' and village='Ha Lerotholi';
update gii_hierarchy as gh set gh.lat='27.822957', gh.long='-29.213819' where district='BEREA' and council='Motanasela Council' and village='Ha Lillane';
update gii_hierarchy as gh set gh.lat='27.798195', gh.long='-29.250408' where district='BEREA' and council='Motanasela Council' and village='Ha Poqa';
update gii_hierarchy as gh set gh.lat='27.795238', gh.long='-29.252997' where district='BEREA' and council='Motanasela Council' and village='Ha Telukhunoana';

update gii_hierarchy as gh set gh.lat='27.80607', gh.long='-29.255654' where district='BEREA' and council='Motanasela Council' and village='Ha Moso';
update gii_hierarchy as gh set gh.lat='27.821674', gh.long='-29.245581' where district='BEREA' and council='Motanasela Council' and village='Ha Mpoba';
update gii_hierarchy as gh set gh.lat='27.832988', gh.long='-29.248764' where district='BEREA' and council='Motanasela Council' and village='Ha Libe';
update gii_hierarchy as gh set gh.lat='27.841573', gh.long='-29.246331' where district='BEREA' and council='Motanasela Council' and village='Ha Moeketsi';
update gii_hierarchy as gh set gh.lat='27.844846', gh.long='-29.252546' where district='BEREA' and council='Motanasela Council' and village='Ha Rakabaele';
update gii_hierarchy as gh set gh.lat='27.861123', gh.long='-29.259483' where district='BEREA' and council='Motanasela Council' and village='Ha Masheane';
update gii_hierarchy as gh set gh.lat='27.844544', gh.long='-29.27051' where district='BEREA' and council='Motanasela Council' and village='Ha Molangoanyane';
update gii_hierarchy as gh set gh.lat='27.86878', gh.long='-29.249341' where district='BEREA' and council='Motanasela Council' and village='Ha Kome';
update gii_hierarchy as gh set gh.lat='27.858823', gh.long='-29.240224' where district='BEREA' and council='Motanasela Council' and village='Ha Mateka';
update gii_hierarchy as gh set gh.lat='27.866816', gh.long='-29.237772' where district='BEREA' and council='Motanasela Council' and village='Ha Pateriki';
update gii_hierarchy as gh set gh.lat='27.809628', gh.long='-29.218244' where district='BEREA' and council='Motanasela Council' and village='Bothoba Pelo';
update gii_hierarchy as gh set gh.lat='27.815209', gh.long='-29.22478' where district='BEREA' and council='Motanasela Council' and village='Ha Maetsela';
update gii_hierarchy as gh set gh.lat='27.885205', gh.long='-29.241159' where district='BEREA' and council='Motanasela Council' and village='Ha Molahli';
update gii_hierarchy as gh set gh.lat='27.877713', gh.long='-29.256619' where district='BEREA' and council='Motanasela Council' and village='Ha Motseare';
update gii_hierarchy as gh set gh.lat='27.872661', gh.long='-29.260739' where district='BEREA' and council='Motanasela Council' and village='Makaung';
update gii_hierarchy as gh set gh.lat='27.89262', gh.long='-29.253284' where district='BEREA' and council='Motanasela Council' and village='Ha Khoale';

update gii_hierarchy as gh set gh.lat='27.906773', gh.long='-29.257725' where district='BEREA' and council='Motanasela Council' and village='Ha Moroke';
update gii_hierarchy as gh set gh.lat='27.917675', gh.long='-29.262747' where district='BEREA' and council='Motanasela Council' and village='Ha Mosili';
update gii_hierarchy as gh set gh.lat='27.912189', gh.long='-29.260339' where district='BEREA' and council='Motanasela Council' and village='Machoaboleng';
update gii_hierarchy as gh set gh.lat='27.930944', gh.long='-29.268424' where district='BEREA' and council='Motanasela Council' and village='Ha Mosiuoa';
update gii_hierarchy as gh set gh.lat='27.932377', gh.long='-29.284846' where district='BEREA' and council='Motanasela Council' and village='Ha Matlere';
update gii_hierarchy as gh set gh.lat='27.9176', gh.long='-29.280189' where district='BEREA' and council='Motanasela Council' and village='Ha Setulo';
update gii_hierarchy as gh set gh.lat='27.921736', gh.long='-29.287469' where district='BEREA' and council='Motanasela Council' and village='Hloahloeng';
update gii_hierarchy as gh set gh.lat='27.948663', gh.long='-29.281656' where district='BEREA' and council='Motanasela Council' and village='Ha Sebe';
update gii_hierarchy as gh set gh.lat='27.95348', gh.long='-29.291456' where district='BEREA' and council='Motanasela Council' and village='Ha Mantheki';

update gii_hierarchy as gh set gh.lat='27.927982', gh.long='-29.321808' where district='BEREA' and council='Motanasela Council' and village='Ha Mohlakolane';
update gii_hierarchy as gh set gh.lat='27.929199', gh.long='-29.314765' where district='BEREA' and council='Motanasela Council' and village='Ha Morui';

update gii_hierarchy as gh set gh.lat='27.917624', gh.long='-29.306411' where district='BEREA' and council='Motanasela Council' and village='Ha Hoohlo';
update gii_hierarchy as gh set gh.lat='27.907427', gh.long='-29.30522' where district='BEREA' and council='Motanasela Council' and village='Ha Kokolia';
update gii_hierarchy as gh set gh.lat='27.862771', gh.long='-29.26911' where district='BEREA' and council='Motanasela Council' and village='Ha Letele';
update gii_hierarchy as gh set gh.lat='27.862297', gh.long='-29.272006' where district='BEREA' and council='Motanasela Council' and village='Ha Sekhonyana';
update gii_hierarchy as gh set gh.lat='27.869643', gh.long='-29.297873' where district='BEREA' and council='Motanasela Council' and village='Ha Makoaela';

update gii_hierarchy as gh set gh.lat='27.857667', gh.long='-29.288356' where district='BEREA' and council='Motanasela Council' and village='Ha Mokonyana';
update gii_hierarchy as gh set gh.lat='27.853726', gh.long='-29.280238' where district='BEREA' and council='Motanasela Council' and village='Katlehong (Ha Mokonyana)';

update gii_hierarchy as gh set gh.lat='27.844545', gh.long='-29.303247' where district='BEREA' and council='Motanasela Council' and village='Ha Ramatlama';
update gii_hierarchy as gh set gh.lat='27.841606', gh.long='-29.295696' where district='BEREA' and council='Motanasela Council' and village='Ha Tsoaleli';
update gii_hierarchy as gh set gh.lat='27.854612', gh.long='-29.154403' where district='BEREA' and council='Motanasela Council' and village='Thota Peli';

update gii_hierarchy as gh set gh.lat='27.863815', gh.long='-29.329172' where district='BEREA' and council='Motanasela Council' and village='Soaing';





update gii_hierarchy as gh set gh.lat='27.899881', gh.long='-29.324868' where district='BEREA' and council='Motanasela Council' and village='Ha Moruthoane';
update gii_hierarchy as gh set gh.lat='27.896288', gh.long='-29.323837' where district='BEREA' and council='Motanasela Council' and village='Ha Samosamo';
update gii_hierarchy as gh set gh.lat='27.906542', gh.long='-29.328744' where district='BEREA' and council='Motanasela Council' and village='Ha Selomo';
update gii_hierarchy as gh set gh.lat='27.920847', gh.long='-29.335324' where district='BEREA' and council='Motanasela Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.667365', gh.long='-29.172941' where district='BEREA' and council='Senekane Council' and village='Ha Maritintsi';
update gii_hierarchy as gh set gh.lat='27.689868', gh.long='-29.165318' where district='BEREA' and council='Senekane Council' and village='Ha Mpopo';
update gii_hierarchy as gh set gh.lat='27.698243', gh.long='-29.16923' where district='BEREA' and council='Senekane Council' and village='Ha Saremone';
update gii_hierarchy as gh set gh.lat='27.677924', gh.long='-29.167776' where district='BEREA' and council='Senekane Council' and village='Romeng';
update gii_hierarchy as gh set gh.lat='27.716935', gh.long='-29.192069' where district='BEREA' and council='Senekane Council' and village='Ha Khophola';
update gii_hierarchy as gh set gh.lat='27.713029', gh.long='-29.187427' where district='BEREA' and council='Senekane Council' and village='Ha Rapholo';
update gii_hierarchy as gh set gh.lat='27.68472', gh.long='-29.188718' where district='BEREA' and council='Senekane Council' and village='Ha Kubere';
update gii_hierarchy as gh set gh.lat='27.920847', gh.long='-29.335324' where district='BEREA' and council='Senekane Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.679296', gh.long='-29.185503' where district='BEREA' and council='Senekane Council' and village='Mothating';
update gii_hierarchy as gh set gh.lat='27.673655', gh.long='-29.178443' where district='BEREA' and council='Senekane Council' and village='Papalala';
update gii_hierarchy as gh set gh.lat='27.655247', gh.long='-29.187916' where district='BEREA' and council='Senekane Council' and village='Ha Khothule';
update gii_hierarchy as gh set gh.lat='27.645988', gh.long='-29.182255' where district='BEREA' and council='Senekane Council' and village='Ha Lapisi';
update gii_hierarchy as gh set gh.lat='27.682834', gh.long='-29.202925' where district='BEREA' and council='Senekane Council' and village='Ha Macheli';
update gii_hierarchy as gh set gh.lat='27.662151', gh.long='-29.213688' where district='BEREA' and council='Senekane Council' and village='Ha Maqabane';
update gii_hierarchy as gh set gh.lat='27.673744', gh.long='-29.207774' where district='BEREA' and council='Senekane Council' and village='Ha Ranthiba';
update gii_hierarchy as gh set gh.lat='27.678266', gh.long='-29.194913' where district='BEREA' and council='Senekane Council' and village='Ha Tau';
update gii_hierarchy as gh set gh.lat='27.683601', gh.long='-29.21522' where district='BEREA' and council='Senekane Council' and village='Ha Mokuba';

update gii_hierarchy as gh set gh.lat='27.702938', gh.long='-29.201726' where district='BEREA' and council='Senekane Council' and village='Ha Polaki';
update gii_hierarchy as gh set gh.lat='27.702919', gh.long='-29.221692' where district='BEREA' and council='Senekane Council' and village='Litsilong';
update gii_hierarchy as gh set gh.lat='27.716033', gh.long='-29.198885' where district='BEREA' and council='Senekane Council' and village='Matheneng';

update gii_hierarchy as gh set gh.lat='27.724446', gh.long='-29.212006' where district='BEREA' and council='Senekane Council' and village='Ha Likotsi';
update gii_hierarchy as gh set gh.lat='27.731919', gh.long='-29.206795' where district='BEREA' and council='Senekane Council' and village='Ha Malimabe';
update gii_hierarchy as gh set gh.lat='27.734622', gh.long='-29.241241' where district='BEREA' and council='Senekane Council' and village='Ha Kete';
update gii_hierarchy as gh set gh.lat='27.73255', gh.long='-29.228073' where district='BEREA' and council='Senekane Council' and village='Ha Penya';
update gii_hierarchy as gh set gh.lat='27.755175', gh.long='-29.217283' where district='BEREA' and council='Senekane Council' and village='Ha Molungoa';
update gii_hierarchy as gh set gh.lat='27.745463', gh.long='-29.211834' where district='BEREA' and council='Senekane Council' and village='Ha Ramabele';
update gii_hierarchy as gh set gh.lat='27.940658', gh.long='-29.206753' where district='BEREA' and council='Senekane Council' and village='Ha Rantsane';
update gii_hierarchy as gh set gh.lat='27.764818', gh.long='-29.231209' where district='BEREA' and council='Senekane Council' and village='Ha Mafatle';
update gii_hierarchy as gh set gh.lat='27.768414', gh.long='-29.24181' where district='BEREA' and council='Senekane Council' and village='Ha Molibetsane';
update gii_hierarchy as gh set gh.lat='27.765263', gh.long='-29.225338' where district='BEREA' and council='Senekane Council' and village='Ha Selouoe';
update gii_hierarchy as gh set gh.lat='27.76281', gh.long='-29.248827' where district='BEREA' and council='Senekane Council' and village='Ha Letsipa';
update gii_hierarchy as gh set gh.lat='27.756128', gh.long='-29.257459' where district='BEREA' and council='Senekane Council' and village='Ha Hlekelele';
update gii_hierarchy as gh set gh.lat='27.726924', gh.long='-29.259401' where district='BEREA' and council='Senekane Council' and village='Ha Keahana';
update gii_hierarchy as gh set gh.lat='27.906773', gh.long='-29.257725' where district='BEREA' and council='Senekane Council' and village='Ha Moroke';
update gii_hierarchy as gh set gh.lat='27.735852', gh.long='-29.255214' where district='BEREA' and council='Senekane Council' and village='Ha Rakotsoane';

update gii_hierarchy as gh set gh.lat='27.724124', gh.long='-29.251985' where district='BEREA' and council='Senekane Council' and village='Ha Senekane';
update gii_hierarchy as gh set gh.lat='27.731369', gh.long='-29.265513' where district='BEREA' and council='Senekane Council' and village='Ha Metsing';
update gii_hierarchy as gh set gh.lat='27.721793', gh.long='-29.262732' where district='BEREA' and council='Senekane Council' and village='Ha Ramaqopetsa';
update gii_hierarchy as gh set gh.lat='27.703876', gh.long='-29.24037' where district='BEREA' and council='Senekane Council' and village='Ha Makhoebe';
update gii_hierarchy as gh set gh.lat='27.709404', gh.long='-29.246156' where district='BEREA' and council='Senekane Council' and village='Ha Ramotso';
update gii_hierarchy as gh set gh.lat='27.695147', gh.long='-29.24742' where district='BEREA' and council='Senekane Council' and village='Ha Sekete';
update gii_hierarchy as gh set gh.lat='27.699738', gh.long='-29.237077' where district='BEREA' and council='Senekane Council' and village='Sekhalabateng';
update gii_hierarchy as gh set gh.lat='27.664671', gh.long='-29.222966' where district='BEREA' and council='Senekane Council' and village='Ha Makatane';
update gii_hierarchy as gh set gh.lat='27.681754', gh.long='-29.219272' where district='BEREA' and council='Senekane Council' and village='Ha Rasunyane';
update gii_hierarchy as gh set gh.lat='27.655415', gh.long='-29.250228' where district='BEREA' and council='Senekane Council' and village='Qopo (Ha Majara)';
update gii_hierarchy as gh set gh.lat='27.671262', gh.long='-29.259907' where district='BEREA' and council='Senekane Council' and village='Ha Molefi';
update gii_hierarchy as gh set gh.lat='27.675468', gh.long='-29.247298' where district='BEREA' and council='Senekane Council' and village='Ha Paape';
update gii_hierarchy as gh set gh.lat='27.671491', gh.long='-29.267026' where district='BEREA' and council='Senekane Council' and village='Ha Hlapa';
update gii_hierarchy as gh set gh.lat='27.665986', gh.long='-29.277264' where district='BEREA' and council='Senekane Council' and village='Ha Rantsoku';
update gii_hierarchy as gh set gh.lat='27.683423', gh.long='-29.260417' where district='BEREA' and council='Senekane Council' and village='Ha Tumo';
update gii_hierarchy as gh set gh.lat='27.702635', gh.long='-29.265058' where district='BEREA' and council='Senekane Council' and village='Ha Nkoebele';
update gii_hierarchy as gh set gh.lat='27.699547', gh.long='-29.260061' where district='BEREA' and council='Senekane Council' and village='Ha Pampiri';
update gii_hierarchy as gh set gh.lat='28.135395', gh.long='-29.077449' where district='BEREA' and council='Senekane Council' and village='Ha Taaso';
update gii_hierarchy as gh set gh.lat='27.688359', gh.long='-29.282259' where district='BEREA' and council='Senekane Council' and village='Ha Tsitso';

update gii_hierarchy as gh set gh.lat='27.67554', gh.long='-29.289115' where district='BEREA' and council='Senekane Council' and village='Tsitsa';
update gii_hierarchy as gh set gh.lat='27.678928', gh.long='-29.297514' where district='BEREA' and council='Senekane Council' and village='Ha Ramoloi';

update gii_hierarchy as gh set gh.lat='27.696456', gh.long='-29.322789' where district='BEREA' and council='Senekane Council' and village='Ha Mokhehle';
update gii_hierarchy as gh set gh.lat='27.681', gh.long='-29.325643' where district='BEREA' and council='Senekane Council' and village='Ha Motsoari';
update gii_hierarchy as gh set gh.lat='27.691907', gh.long='-29.32712' where district='BEREA' and council='Senekane Council' and village='Ha Ramatseatsana';
update gii_hierarchy as gh set gh.lat='27.708308', gh.long='-29.33363' where district='BEREA' and council='Senekane Council' and village='Ha Nchela';
update gii_hierarchy as gh set gh.lat='27.733096', gh.long='-29.340459' where district='BEREA' and council='Senekane Council' and village='Ha Khabele';
update gii_hierarchy as gh set gh.lat='27.72397', gh.long='-29.339148' where district='BEREA' and council='Senekane Council' and village='Ha Makhomo';
update gii_hierarchy as gh set gh.lat='27.738628', gh.long='-29.329281' where district='BEREA' and council='Senekane Council' and village='Ha Selemo';
update gii_hierarchy as gh set gh.lat='27.700909', gh.long='-29.315801' where district='BEREA' and council='Senekane Council' and village='Ha Thafeng';
update gii_hierarchy as gh set gh.lat='27.719689', gh.long='-29.315267' where district='BEREA' and council='Senekane Council' and village='Ha Khohlooa';
update gii_hierarchy as gh set gh.lat='27.717271', gh.long='-29.304781' where district='BEREA' and council='Senekane Council' and village='Ha Liphoto';

update gii_hierarchy as gh set gh.lat='27.726779', gh.long='-29.301177' where district='BEREA' and council='Senekane Council' and village='Ha Matholoana';
update gii_hierarchy as gh set gh.lat='27.719517', gh.long='-29.290374' where district='BEREA' and council='Senekane Council' and village='Ha Fola';
update gii_hierarchy as gh set gh.lat='27.717376', gh.long='-29.293042' where district='BEREA' and council='Senekane Council' and village='Ha Moratha';
update gii_hierarchy as gh set gh.lat='27.726613', gh.long='-29.293354' where district='BEREA' and council='Senekane Council' and village='Ha Ramontsuoe';
update gii_hierarchy as gh set gh.lat='27.734697', gh.long='-29.286585' where district='BEREA' and council='Senekane Council' and village='Ha Likobo';
update gii_hierarchy as gh set gh.lat='27.732469', gh.long='-29.291266' where district='BEREA' and council='Senekane Council' and village='Ha Nqetho';
update gii_hierarchy as gh set gh.lat='27.759698', gh.long='-29.295993' where district='BEREA' and council='Senekane Council' and village='Ha Mpusi';
update gii_hierarchy as gh set gh.lat='27.781195', gh.long='-29.300397' where district='BEREA' and council='Senekane Council' and village='Ha Ntabejane';

update gii_hierarchy as gh set gh.lat='27.78082', gh.long='-29.276513' where district='BEREA' and council='Senekane Council' and village='Meholaneng';
update gii_hierarchy as gh set gh.lat='28.018958', gh.long='-29.183023' where district='BEREA' and council='Senekane Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.764336', gh.long='-29.26901' where district='BEREA' and council='Senekane Council' and village='Ha Hlasa';
update gii_hierarchy as gh set gh.lat='27.775737', gh.long='-29.266632' where district='BEREA' and council='Senekane Council' and village='Ha Ntsoeu';
update gii_hierarchy as gh set gh.lat='27.776046', gh.long='-29.270832' where district='BEREA' and council='Senekane Council' and village='Ha Pholoanyane';
update gii_hierarchy as gh set gh.lat='27.780422', gh.long='-29.260628' where district='BEREA' and council='Senekane Council' and village='Ha Mantai';
update gii_hierarchy as gh set gh.lat='27.794383', gh.long='-29.259585' where district='BEREA' and council='Senekane Council' and village='Ha Thotanyane';

update gii_hierarchy as gh set gh.lat='27.815236', gh.long='-29.303507' where district='BEREA' and council='Senekane Council' and village='Ha Letela';
update gii_hierarchy as gh set gh.lat='27.79814', gh.long='-29.291288' where district='BEREA' and council='Senekane Council' and village='Ha Maboeane';
update gii_hierarchy as gh set gh.lat='27.835674', gh.long='-29.297925' where district='BEREA' and council='Senekane Council' and village='Ha Monamoleli';
update gii_hierarchy as gh set gh.lat='27.826857', gh.long='-29.291105' where district='BEREA' and council='Senekane Council' and village='Qhotseng';

update gii_hierarchy as gh set gh.lat='27.82611', gh.long='-29.280427' where district='BEREA' and council='Senekane Council' and village='Konkotia';

update gii_hierarchy as gh set gh.lat='27.813636', gh.long='-29.271569' where district='BEREA' and council='Senekane Council' and village='Ha Mojela (Sefikeng)';
update gii_hierarchy as gh set gh.lat='27.838427', gh.long='-29.273174' where district='BEREA' and council='Senekane Council' and village='Ha Lebone';
update gii_hierarchy as gh set gh.lat='27.830663', gh.long='-29.265062' where district='BEREA' and council='Senekane Council' and village='Ha Salemane';
update gii_hierarchy as gh set gh.lat='27.832659', gh.long='-29.273271' where district='BEREA' and council='Senekane Council' and village='Ha Seboka';
update gii_hierarchy as gh set gh.lat='27.834338', gh.long='-29.260857' where district='BEREA' and council='Senekane Council' and village='Ha Sekepe';
update gii_hierarchy as gh set gh.lat='27.837667', gh.long='-29.282522' where district='BEREA' and council='Senekane Council' and village='Qhooeng';
update gii_hierarchy as gh set gh.lat='27.759095', gh.long='-29.276112' where district='BEREA' and council='Senekane Council' and village='Ha Janki (Masaleng)';
update gii_hierarchy as gh set gh.lat='27.74841', gh.long='-29.282502' where district='BEREA' and council='Senekane Council' and village='Ha Khalane';
update gii_hierarchy as gh set gh.lat='27.748589', gh.long='-29.278267' where district='BEREA' and council='Senekane Council' and village='Ha Popa';
update gii_hierarchy as gh set gh.lat='27.611666', gh.long='-29.2682' where district='BEREA' and council='Kanana Council' and village='Berea Mission';
update gii_hierarchy as gh set gh.lat='27.616503', gh.long='-29.260467' where district='BEREA' and council='Kanana Council' and village='Ha Mokhoele';
update gii_hierarchy as gh set gh.lat='27.622143', gh.long='-29.270636' where district='BEREA' and council='Kanana Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='27.633864', gh.long='-29.252799' where district='BEREA' and council='Kanana Council' and village='Ha Ramoseeka';
update gii_hierarchy as gh set gh.lat='27.622919', gh.long='-29.256131' where district='BEREA' and council='Kanana Council' and village='Matsitsing';
update gii_hierarchy as gh set gh.lat='27.63458', gh.long='-29.267389' where district='BEREA' and council='Kanana Council' and village='Tsoili Tsoili';
update gii_hierarchy as gh set gh.lat='27.912998', gh.long='-29.062114' where district='BEREA' and council='Kanana Council' and village='Lithakong';
update gii_hierarchy as gh set gh.lat='27.609615', gh.long='-29.248183' where district='BEREA' and council='Kanana Council' and village='Maqhaka';

update gii_hierarchy as gh set gh.lat='27.602793', gh.long='-29.228963' where district='BEREA' and council='Kanana Council' and village='Letsatseng (Ha Majara)';

update gii_hierarchy as gh set gh.lat='27.57799', gh.long='-29.222165' where district='BEREA' and council='Kanana Council' and village='Malumeng';
update gii_hierarchy as gh set gh.lat='27.572449', gh.long='-29.228319' where district='BEREA' and council='Kanana Council' and village='Ha Leluma';
update gii_hierarchy as gh set gh.lat='27.568154', gh.long='-29.244406' where district='BEREA' and council='Kanana Council' and village='Ha Malofosa';
update gii_hierarchy as gh set gh.lat='27.577166', gh.long='-29.254486' where district='BEREA' and council='Kanana Council' and village='Matseng';
update gii_hierarchy as gh set gh.lat='27.549059', gh.long='-29.235248' where district='BEREA' and council='Kanana Council' and village='Ha Mokhele';
update gii_hierarchy as gh set gh.lat='27.560074', gh.long='-29.231634' where district='BEREA' and council='Kanana Council' and village='Ha Sebolai';
update gii_hierarchy as gh set gh.lat='27.549797', gh.long='-29.230566' where district='BEREA' and council='Kanana Council' and village='Liboping';

update gii_hierarchy as gh set gh.lat='27.571285', gh.long='-29.195628' where district='BEREA' and council='Kanana Council' and village='Ha Sole';
update gii_hierarchy as gh set gh.lat='27.561348', gh.long='-29.202282' where district='BEREA' and council='Kanana Council' and village='Liphiring';
update gii_hierarchy as gh set gh.lat='27.620872', gh.long='-29.213842' where district='BEREA' and council='Kanana Council' and village='Ha Buasono';
update gii_hierarchy as gh set gh.lat='27.629959', gh.long='-29.214498' where district='BEREA' and council='Kanana Council' and village='Ha Mabekenyane';
update gii_hierarchy as gh set gh.lat='27.636473', gh.long='-29.221756' where district='BEREA' and council='Kanana Council' and village='Ha Shadrack';

update gii_hierarchy as gh set gh.lat='27.641878', gh.long='-29.211579' where district='BEREA' and council='Kanana Council' and village='Mafotholeng';
update gii_hierarchy as gh set gh.lat='27.626019', gh.long='-29.204387' where district='BEREA' and council='Kanana Council' and village='Ha Makoanyane';
update gii_hierarchy as gh set gh.lat='27.63284', gh.long='-29.198256' where district='BEREA' and council='Kanana Council' and village='Ha Marapo';
update gii_hierarchy as gh set gh.lat='27.616527', gh.long='-29.200497' where district='BEREA' and council='Kanana Council' and village='Ha Motsoene';
update gii_hierarchy as gh set gh.lat='27.591413', gh.long='-29.182015' where district='BEREA' and council='Kanana Council' and village='Ha Makebe';
update gii_hierarchy as gh set gh.lat='27.601482', gh.long='-29.17415' where district='BEREA' and council='Kanana Council' and village='Ha Moketetsa';
update gii_hierarchy as gh set gh.lat='27.610845', gh.long='-29.172351' where district='BEREA' and council='Kanana Council' and village='Ha Rakoloi';

update gii_hierarchy as gh set gh.lat='27.621339', gh.long='-29.179036' where district='BEREA' and council='Kanana Council' and village='Ha Lenkathebe';
update gii_hierarchy as gh set gh.lat='27.618969', gh.long='-29.185536' where district='BEREA' and council='Kanana Council' and village='Tsereoane (Sekolong)';
update gii_hierarchy as gh set gh.lat='27.657862', gh.long='-29.173216' where district='BEREA' and council='Kanana Council' and village='Ha Souru';
update gii_hierarchy as gh set gh.lat='27.644959', gh.long='-29.178238' where district='BEREA' and council='Kanana Council' and village='Senyotong';
update gii_hierarchy as gh set gh.lat='27.628918', gh.long='-29.1595' where district='BEREA' and council='Kanana Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='27.636375', gh.long='-29.132671' where district='BEREA' and council='Kanana Council' and village='Ha Fusi';
update gii_hierarchy as gh set gh.lat='27.645792', gh.long='-29.128516' where district='BEREA' and council='Kanana Council' and village='Ha Mapokotsa';
update gii_hierarchy as gh set gh.lat='27.649764', gh.long='-29.133811' where district='BEREA' and council='Kanana Council' and village='Ha Tau';

update gii_hierarchy as gh set gh.lat='27.655404', gh.long='-29.136554' where district='BEREA' and council='Kanana Council' and village='Ha Mohoang';
update gii_hierarchy as gh set gh.lat='27.660479', gh.long='-29.142286' where district='BEREA' and council='Kanana Council' and village='Ha Ntaja';




update gii_hierarchy as gh set gh.lat='27.683737', gh.long='-29.150535' where district='BEREA' and council='Kanana Council' and village='Ha Mokhenene (Lekokoaneng)';


update gii_hierarchy as gh set gh.lat='27.693689', gh.long='-29.149337' where district='BEREA' and council='Kanana Council' and village='Ha Makoatlane (Lekokoaneng)';

update gii_hierarchy as gh set gh.lat='27.694396', gh.long='-29.13496' where district='BEREA' and council='Kanana Council' and village='Ha Maope';
update gii_hierarchy as gh set gh.lat='27.692495', gh.long='-29.126346' where district='BEREA' and council='Kanana Council' and village='Ha Sakoane';
update gii_hierarchy as gh set gh.lat='27.674811', gh.long='-29.129949' where district='BEREA' and council='Kanana Council' and village='Ha Lehlohonolo';
update gii_hierarchy as gh set gh.lat='27.660192', gh.long='-29.125298' where district='BEREA' and council='Kanana Council' and village='Ha Lepamo';
update gii_hierarchy as gh set gh.lat='27.650116', gh.long='-29.116036' where district='BEREA' and council='Kanana Council' and village='Ha Motsikoane';
update gii_hierarchy as gh set gh.lat='27.665115', gh.long='-29.126822' where district='BEREA' and council='Kanana Council' and village='Ha Mpiko';
update gii_hierarchy as gh set gh.lat='27.657704', gh.long='-29.117899' where district='BEREA' and council='Kanana Council' and village='Ha Nepe';




update gii_hierarchy as gh set gh.lat='27.544327', gh.long='-29.293363' where district='BEREA' and council='Maseru Municipality' and village='Naleli';
update gii_hierarchy as gh set gh.lat='27.554434', gh.long='-29.296554' where district='BEREA' and council='Maseru Municipality' and village='Koalabata';

update gii_hierarchy as gh set gh.lat='27.557521', gh.long='-29.29051' where district='BEREA' and council='Maseru Municipality' and village='Kopanong (Koalabata)';

update gii_hierarchy as gh set gh.lat='27.552788', gh.long='-29.272498' where district='BEREA' and council='Maseru Municipality' and village='Sekamaneng';


update gii_hierarchy as gh set gh.lat='27.55486', gh.long='-29.318168' where district='BEREA' and council='Thuathe Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.543752', gh.long='-29.327173' where district='BEREA' and council='Thuathe Council' and village='Lipompong';
update gii_hierarchy as gh set gh.lat='27.561816', gh.long='-29.319498' where district='BEREA' and council='Thuathe Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.568768', gh.long='-29.325625' where district='BEREA' and council='Thuathe Council' and village='Parays';
update gii_hierarchy as gh set gh.lat='27.562815', gh.long='-29.315599' where district='BEREA' and council='Thuathe Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='27.579593', gh.long='-29.32191' where district='BEREA' and council='Thuathe Council' and village='Baruting';
update gii_hierarchy as gh set gh.lat='27.572475', gh.long='-29.321532' where district='BEREA' and council='Thuathe Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='27.556342', gh.long='-29.341172' where district='BEREA' and council='Thuathe Council' and village='Ha Mafaesa';
update gii_hierarchy as gh set gh.lat='27.582921', gh.long='-29.318165' where district='BEREA' and council='Thuathe Council' and village='Bethane';
update gii_hierarchy as gh set gh.lat='27.592586', gh.long='-29.336525' where district='BEREA' and council='Thuathe Council' and village='Ha Ralimo';
update gii_hierarchy as gh set gh.lat='27.585882', gh.long='-29.324178' where district='BEREA' and council='Thuathe Council' and village='Motsekuoa';
update gii_hierarchy as gh set gh.lat='27.59204', gh.long='-29.309419' where district='BEREA' and council='Thuathe Council' and village='Ha Mothuntsane';
update gii_hierarchy as gh set gh.lat='27.607361', gh.long='-29.31809' where district='BEREA' and council='Thuathe Council' and village='Ha Motumi';
update gii_hierarchy as gh set gh.lat='27.590138', gh.long='-29.314068' where district='BEREA' and council='Thuathe Council' and village='Phutha Lichaba';
update gii_hierarchy as gh set gh.lat='27.587075', gh.long='-29.299608' where district='BEREA' and council='Thuathe Council' and village='Khotong';
update gii_hierarchy as gh set gh.lat='27.597978', gh.long='-29.299013' where district='BEREA' and council='Thuathe Council' and village='Lefikeng';
update gii_hierarchy as gh set gh.lat='27.583768', gh.long='-29.293477' where district='BEREA' and council='Thuathe Council' and village='Lilatoleng';
update gii_hierarchy as gh set gh.lat='27.567549', gh.long='-29.276373' where district='BEREA' and council='Thuathe Council' and village='Ha Sepinare';
update gii_hierarchy as gh set gh.lat='27.56977', gh.long='-29.272171' where district='BEREA' and council='Thuathe Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='27.565705', gh.long='-29.268252' where district='BEREA' and council='Thuathe Council' and village='Ha Bobojane';
update gii_hierarchy as gh set gh.lat='27.57307', gh.long='-29.269199' where district='BEREA' and council='Thuathe Council' and village='Ha Foso';
update gii_hierarchy as gh set gh.lat='27.584713', gh.long='-29.272666' where district='BEREA' and council='Thuathe Council' and village='Ha Jesaea';
update gii_hierarchy as gh set gh.lat='27.594156', gh.long='-29.271239' where district='BEREA' and council='Thuathe Council' and village='Marabeng';


update gii_hierarchy as gh set gh.lat='28.040649', gh.long='-29.347067' where district='BEREA' and council='Thuathe Council' and village='Ha Tsolo';
update gii_hierarchy as gh set gh.lat='27.612706', gh.long='-29.273681' where district='BEREA' and council='Thuathe Council' and village='Qhooeng';
update gii_hierarchy as gh set gh.lat='27.634283', gh.long='-29.299529' where district='BEREA' and council='Thuathe Council' and village='Ha Makhokho';
update gii_hierarchy as gh set gh.lat='27.630946', gh.long='-29.276191' where district='BEREA' and council='Thuathe Council' and village='Ha Maqekoane';
update gii_hierarchy as gh set gh.lat='27.627775', gh.long='-29.279825' where district='BEREA' and council='Thuathe Council' and village='Matlakeng';
update gii_hierarchy as gh set gh.lat='27.618351', gh.long='-29.292911' where district='BEREA' and council='Thuathe Council' and village='Mosenekeng';
update gii_hierarchy as gh set gh.lat='27.650706', gh.long='-29.321915' where district='BEREA' and council='Thuathe Council' and village='Ha Motloang';
update gii_hierarchy as gh set gh.lat='27.659984', gh.long='-29.322657' where district='BEREA' and council='Thuathe Council' and village='Ha Mohotloane';
update gii_hierarchy as gh set gh.lat='27.674816', gh.long='-29.315103' where district='BEREA' and council='Thuathe Council' and village='Malaleng';
update gii_hierarchy as gh set gh.lat='27.643789', gh.long='-29.29206' where district='BEREA' and council='Thuathe Council' and village='Ha Makube';
update gii_hierarchy as gh set gh.lat='27.659738', gh.long='-29.284066' where district='BEREA' and council='Thuathe Council' and village='Ha Matolo';
update gii_hierarchy as gh set gh.lat='27.639571', gh.long='-29.285505' where district='BEREA' and council='Thuathe Council' and village='Majantlhaneng';
update gii_hierarchy as gh set gh.lat='27.649153', gh.long='-29.268597' where district='BEREA' and council='Thuathe Council' and village='Ha Malei';
update gii_hierarchy as gh set gh.lat='27.663383', gh.long='-29.27253' where district='BEREA' and council='Thuathe Council' and village='Ha Rammoroane';


update gii_hierarchy as gh set gh.lat='27.516158', gh.long='-29.288463' where district='BEREA' and council='Maseru Municipality' and village='Boinyatso';








update gii_hierarchy as gh set gh.lat='27.540998', gh.long='-29.272079' where district='BEREA' and council='Maseru Municipality' and village='Selakhapane';














update gii_hierarchy as gh set gh.lat='27.525425', gh.long='-29.308344' where district='BEREA' and council='Maseru Municipality' and village='Sebaboleng';
update gii_hierarchy as gh set gh.lat='27.522133', gh.long='-29.305309' where district='BEREA' and council='Maseru Municipality' and village='Lifelekoaneng';
update gii_hierarchy as gh set gh.lat='27.517161', gh.long='-29.3047' where district='BEREA' and council='Maseru Municipality' and village='Mookoli';
update gii_hierarchy as gh set gh.lat='28.405988', gh.long='-28.627104' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Masilo';
update gii_hierarchy as gh set gh.lat='28.406936', gh.long='-28.634284' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Ntereke';
update gii_hierarchy as gh set gh.lat='28.41289', gh.long='-28.629751' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Mokhujoaneng';


update gii_hierarchy as gh set gh.lat='28.422822', gh.long='-28.631036' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Phoku';
update gii_hierarchy as gh set gh.lat='28.45036', gh.long='-28.638576' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Tae (Thoteng)';
update gii_hierarchy as gh set gh.lat='28.451571', gh.long='-28.631646' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Mahlabatheng';
update gii_hierarchy as gh set gh.lat='28.446294', gh.long='-28.630344' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Motsapi';
update gii_hierarchy as gh set gh.lat='28.440918', gh.long='-28.628324' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ropa';
update gii_hierarchy as gh set gh.lat='28.45635', gh.long='-28.625054' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Makhunoane';
update gii_hierarchy as gh set gh.lat='28.462226', gh.long='-28.615063' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Benoni';
update gii_hierarchy as gh set gh.lat='28.482075', gh.long='-28.614439' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Seapi';
update gii_hierarchy as gh set gh.lat='28.478305', gh.long='-28.612769' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Thaka Banna';

update gii_hierarchy as gh set gh.lat='28.492233', gh.long='-28.610075' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Lekula';
update gii_hierarchy as gh set gh.lat='28.435823', gh.long='-28.62975' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Balimo';
update gii_hierarchy as gh set gh.lat='28.429707', gh.long='-28.649642' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Mafusing';

update gii_hierarchy as gh set gh.lat='28.432889', gh.long='-28.654514' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Ramatlung';

update gii_hierarchy as gh set gh.lat='28.419237', gh.long='-28.647954' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Mokoetlaneng';

update gii_hierarchy as gh set gh.lat='28.411728', gh.long='-28.663041' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Tholong';



update gii_hierarchy as gh set gh.lat='28.421306', gh.long='-28.672605' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Janki';
update gii_hierarchy as gh set gh.lat='28.417828', gh.long='-28.678109' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Mohloai';

update gii_hierarchy as gh set gh.lat='28.433958', gh.long='-28.678885' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Mphatsela';


update gii_hierarchy as gh set gh.lat='28.455737', gh.long='-28.649542' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Morake';
update gii_hierarchy as gh set gh.lat='28.450325', gh.long='-28.648211' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Poosho';
update gii_hierarchy as gh set gh.lat='28.458998', gh.long='-28.643429' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Potjo';

update gii_hierarchy as gh set gh.lat='28.462443', gh.long='-28.619156' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Lihlabeng';
update gii_hierarchy as gh set gh.lat='28.503315', gh.long='-28.626355' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Lepatoa';
update gii_hierarchy as gh set gh.lat='28.516589', gh.long='-28.62006' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Mou';
update gii_hierarchy as gh set gh.lat='28.516196', gh.long='-28.613622' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Jabavu';

update gii_hierarchy as gh set gh.lat='28.508555', gh.long='-28.625026' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Phamong';
update gii_hierarchy as gh set gh.lat='28.529957', gh.long='-28.615713' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Bochabela';
update gii_hierarchy as gh set gh.lat='28.535243', gh.long='-28.619938' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Boithero';
update gii_hierarchy as gh set gh.lat='28.520774', gh.long='-28.624564' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Kolone';
update gii_hierarchy as gh set gh.lat='28.523693', gh.long='-28.61564' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Mokotjela';
update gii_hierarchy as gh set gh.lat='28.540207', gh.long='-28.613528' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Ha Moruti';


update gii_hierarchy as gh set gh.lat='28.548447', gh.long='-28.615917' where district='BOTHA BOTHE' and council='Makhunoane Council' and village='Thabong';

update gii_hierarchy as gh set gh.lat='28.62778', gh.long='-28.595411' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Sefako';
update gii_hierarchy as gh set gh.lat='28.628556', gh.long='-28.58817' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Motheane';
update gii_hierarchy as gh set gh.lat='28.64213', gh.long='-28.581719' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Sekoati (Phahleng)';
update gii_hierarchy as gh set gh.lat='28.652443', gh.long='-28.579784' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Keletso (Mafika Lisiu)';
update gii_hierarchy as gh set gh.lat='28.648989', gh.long='-28.603442' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Mothae';
update gii_hierarchy as gh set gh.lat='28.657597', gh.long='-28.592344' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Mohau';

update gii_hierarchy as gh set gh.lat='28.674341', gh.long='-28.587729' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Molisana';

update gii_hierarchy as gh set gh.lat='28.650789', gh.long='-28.625656' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Jesi';

update gii_hierarchy as gh set gh.lat='28.617182', gh.long='-28.60038' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Saballa';
update gii_hierarchy as gh set gh.lat='28.611617', gh.long='-28.604068' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Mabitle';
update gii_hierarchy as gh set gh.lat='28.601764', gh.long='-28.616883' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Boiketsiso';
update gii_hierarchy as gh set gh.lat='28.508555', gh.long='-28.625026' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Phamong';
update gii_hierarchy as gh set gh.lat='28.576824', gh.long='-28.612564' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Ntoro';
update gii_hierarchy as gh set gh.lat='28.575389', gh.long='-28.622406' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Masetleng';

update gii_hierarchy as gh set gh.lat='28.565412', gh.long='-28.613207' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Motsoene';
update gii_hierarchy as gh set gh.lat='28.570829', gh.long='-28.62027' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Libono';


update gii_hierarchy as gh set gh.lat='28.581629', gh.long='-28.644821' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Manoeleng';
update gii_hierarchy as gh set gh.lat='28.622418', gh.long='-28.653558' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Makai';
update gii_hierarchy as gh set gh.lat='28.614106', gh.long='-28.633995' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Ntsoebe';
update gii_hierarchy as gh set gh.lat='28.609809', gh.long='-28.628288' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Maqokoeng';

update gii_hierarchy as gh set gh.lat='28.665498', gh.long='-28.640995' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Ha Nchoatla';
update gii_hierarchy as gh set gh.lat='28.643553', gh.long='-28.637725' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Kholokoe';

update gii_hierarchy as gh set gh.lat='28.653677', gh.long='-28.644008' where district='BOTHA BOTHE' and council='Liqobong Council' and village='Pitsaneng';
update gii_hierarchy as gh set gh.lat='28.481145', gh.long='-28.664374' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Ntsane';
update gii_hierarchy as gh set gh.lat='28.482185', gh.long='-28.673566' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Thibella';
update gii_hierarchy as gh set gh.lat='28.491267', gh.long='-28.659894' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Maama';
update gii_hierarchy as gh set gh.lat='28.491519', gh.long='-28.664581' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='28.629268', gh.long='-28.605777' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.511822', gh.long='-28.664792' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Kopialla';

update gii_hierarchy as gh set gh.lat='28.525545', gh.long='-28.670296' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Makhethe';
update gii_hierarchy as gh set gh.lat='28.25323', gh.long='-28.73397' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Moroko';
update gii_hierarchy as gh set gh.lat='28.501444', gh.long='-28.659416' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Puso';


update gii_hierarchy as gh set gh.lat='28.413232', gh.long='-28.776541' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='28.555535', gh.long='-28.68508' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Ratsele';
update gii_hierarchy as gh set gh.lat='28.538782', gh.long='-28.675731' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Mashaleng';
update gii_hierarchy as gh set gh.lat='28.548298', gh.long='-28.680889' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Taung';

update gii_hierarchy as gh set gh.lat='28.475716', gh.long='-28.687111' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='28.468085', gh.long='-28.677184' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Mantlobo';
update gii_hierarchy as gh set gh.lat='28.479057', gh.long='-28.682629' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Motsoane';
update gii_hierarchy as gh set gh.lat='28.470283', gh.long='-28.671349' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.475688', gh.long='-28.678106' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Mangoaboleng';
update gii_hierarchy as gh set gh.lat='28.448252', gh.long='-28.684598' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Konka';
update gii_hierarchy as gh set gh.lat='28.463226', gh.long='-28.685745' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Malehlakana';
update gii_hierarchy as gh set gh.lat='28.465404', gh.long='-28.713021' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Bulara';
update gii_hierarchy as gh set gh.lat='28.458307', gh.long='-28.7041' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Lepotisa';
update gii_hierarchy as gh set gh.lat='28.460767', gh.long='-28.708571' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Sera';
update gii_hierarchy as gh set gh.lat='28.472253', gh.long='-28.69796' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Nonyana';
update gii_hierarchy as gh set gh.lat='28.491067', gh.long='-28.70179' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Phasekalise (Bongalla)';
update gii_hierarchy as gh set gh.lat='28.481371', gh.long='-28.700336' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Matsela';
update gii_hierarchy as gh set gh.lat='28.500227', gh.long='-28.709367' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Matsekoane';
update gii_hierarchy as gh set gh.lat='28.508585', gh.long='-28.724606' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='28.513043', gh.long='-28.710149' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Jane';
update gii_hierarchy as gh set gh.lat='28.510271', gh.long='-28.704508' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Katsi';
update gii_hierarchy as gh set gh.lat='28.519878', gh.long='-28.710547' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Mashaeng';
update gii_hierarchy as gh set gh.lat='28.506226', gh.long='-28.709513' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Phallang';
update gii_hierarchy as gh set gh.lat='28.531058', gh.long='-28.713294' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='28.526563', gh.long='-28.706387' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Maraisane';
update gii_hierarchy as gh set gh.lat='28.541819', gh.long='-28.715815' where district='BOTHA BOTHE' and council='Ntelle Council' and village='Ha Mohapinyane';
update gii_hierarchy as gh set gh.lat='28.398547', gh.long='-28.649109' where district='BOTHA BOTHE' and council='Likila Council' and village='Sheeshe';
update gii_hierarchy as gh set gh.lat='28.388065', gh.long='-28.656342' where district='BOTHA BOTHE' and council='Likila Council' and village='Joala Boholo';
update gii_hierarchy as gh set gh.lat='28.39907', gh.long='-28.680367' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Paramente';
update gii_hierarchy as gh set gh.lat='28.378886', gh.long='-28.66174' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Bafokeng';
update gii_hierarchy as gh set gh.lat='28.385351', gh.long='-28.661272' where district='BOTHA BOTHE' and council='Likila Council' and village='Thaba Kholo';
update gii_hierarchy as gh set gh.lat='28.373119', gh.long='-28.677275' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Chaka';
update gii_hierarchy as gh set gh.lat='28.374113', gh.long='-28.666603' where district='BOTHA BOTHE' and council='Likila Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='28.383049', gh.long='-28.681782' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Maloi';
update gii_hierarchy as gh set gh.lat='28.376007', gh.long='-28.683342' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mashoba';
update gii_hierarchy as gh set gh.lat='28.38692', gh.long='-28.687217' where district='BOTHA BOTHE' and council='Likila Council' and village='Letobong';
update gii_hierarchy as gh set gh.lat='28.249176', gh.long='-28.744868' where district='BOTHA BOTHE' and council='Likila Council' and village='Paballong';
update gii_hierarchy as gh set gh.lat='28.402804', gh.long='-28.660616' where district='BOTHA BOTHE' and council='Likila Council' and village='Bohataneng';
update gii_hierarchy as gh set gh.lat='28.409206', gh.long='-28.680269' where district='BOTHA BOTHE' and council='Likila Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.399506', gh.long='-28.672324' where district='BOTHA BOTHE' and council='Likila Council' and village='Thabong';
update gii_hierarchy as gh set gh.lat='28.372708', gh.long='-28.690776' where district='BOTHA BOTHE' and council='Likila Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='28.356193', gh.long='-28.707154' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Marakabei';
update gii_hierarchy as gh set gh.lat='28.360425', gh.long='-28.717219' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Rasekila';
update gii_hierarchy as gh set gh.lat='28.361392', gh.long='-28.736183' where district='BOTHA BOTHE' and council='Likila Council' and village='Sekokong';
update gii_hierarchy as gh set gh.lat='28.364884', gh.long='-28.726365' where district='BOTHA BOTHE' and council='Likila Council' and village='Basieng';

update gii_hierarchy as gh set gh.lat='28.371931', gh.long='-28.724488' where district='BOTHA BOTHE' and council='Likila Council' and village='Marabeng';
update gii_hierarchy as gh set gh.lat='28.37122', gh.long='-28.731827' where district='BOTHA BOTHE' and council='Likila Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='28.387864', gh.long='-28.728036' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Lebetla';
update gii_hierarchy as gh set gh.lat='28.379452', gh.long='-28.727266' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Maseretse';
update gii_hierarchy as gh set gh.lat='28.381302', gh.long='-28.721182' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mosikela';

update gii_hierarchy as gh set gh.lat='28.394949', gh.long='-28.731038' where district='BOTHA BOTHE' and council='Likila Council' and village='Thaba Boqele';
update gii_hierarchy as gh set gh.lat='28.386505', gh.long='-28.740866' where district='BOTHA BOTHE' and council='Likila Council' and village='Phamistone';
update gii_hierarchy as gh set gh.lat='28.368123', gh.long='-28.741379' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Tabolane';
update gii_hierarchy as gh set gh.lat='28.378574', gh.long='-28.73817' where district='BOTHA BOTHE' and council='Likila Council' and village='Litaung';
update gii_hierarchy as gh set gh.lat='28.390511', gh.long='-28.757106' where district='BOTHA BOTHE' and council='Likila Council' and village='Bochabane';
update gii_hierarchy as gh set gh.lat='28.379685', gh.long='-28.768025' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Katamelo';
update gii_hierarchy as gh set gh.lat='28.39521', gh.long='-28.75852' where district='BOTHA BOTHE' and council='Likila Council' and village='Mochaoane';
update gii_hierarchy as gh set gh.lat='28.393771', gh.long='-28.74729' where district='BOTHA BOTHE' and council='Likila Council' and village='Boiketlo';
update gii_hierarchy as gh set gh.lat='28.410325', gh.long='-28.737821' where district='BOTHA BOTHE' and council='Likila Council' and village='Khukhune';
update gii_hierarchy as gh set gh.lat='28.40562', gh.long='-28.756413' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Bokoro';

update gii_hierarchy as gh set gh.lat='28.413237', gh.long='-28.750527' where district='BOTHA BOTHE' and council='Likila Council' and village='Maeneng';

update gii_hierarchy as gh set gh.lat='28.403576', gh.long='-28.751067' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mashopha';
update gii_hierarchy as gh set gh.lat='28.393776', gh.long='-28.764119' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Pataka';
update gii_hierarchy as gh set gh.lat='28.398181', gh.long='-28.771065' where district='BOTHA BOTHE' and council='Likila Council' and village='Senkhane';

update gii_hierarchy as gh set gh.lat='28.415852', gh.long='-28.785978' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Hlasoa (Tsime)';
update gii_hierarchy as gh set gh.lat='28.424314', gh.long='-28.771279' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mpepe';
update gii_hierarchy as gh set gh.lat='28.419621', gh.long='-28.796731' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Ranakeli (Tsime)';

update gii_hierarchy as gh set gh.lat='28.405618', gh.long='-28.789596' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Molibetsane';

update gii_hierarchy as gh set gh.lat='28.394378', gh.long='-28.681761' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Lefera';
update gii_hierarchy as gh set gh.lat='28.39554', gh.long='-28.688369' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Ramohapi';
update gii_hierarchy as gh set gh.lat='28.412261', gh.long='-28.701147' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Seboche';
update gii_hierarchy as gh set gh.lat='28.39474', gh.long='-28.71409' where district='BOTHA BOTHE' and council='Likila Council' and village='Mankising';


update gii_hierarchy as gh set gh.lat='28.410989', gh.long='-28.716803' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mphahlela';
update gii_hierarchy as gh set gh.lat='28.415082', gh.long='-28.721714' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Mpharoane';

update gii_hierarchy as gh set gh.lat='28.421333', gh.long='-28.700839' where district='BOTHA BOTHE' and council='Likila Council' and village='Liseleng';

update gii_hierarchy as gh set gh.lat='28.431503', gh.long='-28.697501' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Khabele';

update gii_hierarchy as gh set gh.lat='28.436808', gh.long='-28.692909' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Tumane';
update gii_hierarchy as gh set gh.lat='28.445331', gh.long='-28.701861' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Botilo';
update gii_hierarchy as gh set gh.lat='28.451952', gh.long='-28.706421' where district='BOTHA BOTHE' and council='Likila Council' and village='Makeneng';
update gii_hierarchy as gh set gh.lat='28.438555', gh.long='-28.711557' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Chaba';

update gii_hierarchy as gh set gh.lat='28.442239', gh.long='-28.723204' where district='BOTHA BOTHE' and council='Likila Council' and village='Ha Lekopa';

update gii_hierarchy as gh set gh.lat='28.454439', gh.long='-28.729516' where district='BOTHA BOTHE' and council='Likila Council' and village='Masere';
update gii_hierarchy as gh set gh.lat='28.427401', gh.long='-28.725153' where district='BOTHA BOTHE' and council='Likila Council' and village='Matsoapong';

update gii_hierarchy as gh set gh.lat='28.404628', gh.long='-28.724522' where district='BOTHA BOTHE' and council='Likila Council' and village='Mahlabatheng';
update gii_hierarchy as gh set gh.lat='28.506884', gh.long='-29.076766' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Tlholo';
update gii_hierarchy as gh set gh.lat='28.516061', gh.long='-29.069446' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Lesaoana';





update gii_hierarchy as gh set gh.lat='28.524416', gh.long='-29.034516' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Mahlekefane';


update gii_hierarchy as gh set gh.lat='28.542925', gh.long='-28.996294' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Tomo';
update gii_hierarchy as gh set gh.lat='28.538788', gh.long='-28.980931' where district='BOTHA BOTHE' and council='Kao Council' and village='Lehlakaneng';
update gii_hierarchy as gh set gh.lat='28.54783', gh.long='-29.014573' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Leketlane';
update gii_hierarchy as gh set gh.lat='28.567804', gh.long='-29.001295' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Maphale';
update gii_hierarchy as gh set gh.lat='28.550508', gh.long='-29.02671' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Rakotoane';
update gii_hierarchy as gh set gh.lat='28.564779', gh.long='-29.023454' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Sello';
update gii_hierarchy as gh set gh.lat='28.547098', gh.long='-29.037551' where district='BOTHA BOTHE' and council='Kao Council' and village='Masuoaneng';
update gii_hierarchy as gh set gh.lat='28.602541', gh.long='-29.03342' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Khokong';
update gii_hierarchy as gh set gh.lat='28.595356', gh.long='-29.037969' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Ralinko';
update gii_hierarchy as gh set gh.lat='28.610369', gh.long='-29.041412' where district='BOTHA BOTHE' and council='Kao Council' and village='Khatleng';
update gii_hierarchy as gh set gh.lat='28.578367', gh.long='-29.034032' where district='BOTHA BOTHE' and council='Kao Council' and village='Khutlo Seaja (Ha Molema)';

update gii_hierarchy as gh set gh.lat='28.627374', gh.long='-29.016222' where district='BOTHA BOTHE' and council='Kao Council' and village='Kao';
update gii_hierarchy as gh set gh.lat='28.461428', gh.long='-28.67878' where district='BOTHA BOTHE' and council='Kao Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.600212', gh.long='-29.010413' where district='BOTHA BOTHE' and council='Kao Council' and village='Ha Lephatsoana';
update gii_hierarchy as gh set gh.lat='28.637664', gh.long='-28.910375' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.643013', gh.long='-28.906912' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Setonong';


update gii_hierarchy as gh set gh.lat='28.546497', gh.long='-28.901839' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Liqalaneng';
update gii_hierarchy as gh set gh.lat='28.546243', gh.long='-28.929474' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Maoelaoela';
update gii_hierarchy as gh set gh.lat='28.557776', gh.long='-28.94851' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Ha Lehloare';


update gii_hierarchy as gh set gh.lat='28.621329', gh.long='-28.935707' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Kopanong';




update gii_hierarchy as gh set gh.lat='28.567804', gh.long='-29.001295' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Ha Maphale';
update gii_hierarchy as gh set gh.lat='28.575228', gh.long='-29.004684' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Maphepheng';

update gii_hierarchy as gh set gh.lat='28.597861', gh.long='-28.988407' where district='BOTHA BOTHE' and council='Sekhobe Council' and village='Liqhobong';
update gii_hierarchy as gh set gh.lat='28.431097', gh.long='-28.738878' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phohlane';
update gii_hierarchy as gh set gh.lat='28.431356', gh.long='-28.757122' where district='BOTHA BOTHE' and council='Moteng Council' and village='Khalikana';

update gii_hierarchy as gh set gh.lat='28.430243', gh.long='-28.751119' where district='BOTHA BOTHE' and council='Moteng Council' and village='Setlakalleng';

update gii_hierarchy as gh set gh.lat='28.436673', gh.long='-28.744983' where district='BOTHA BOTHE' and council='Moteng Council' and village='Nchekoane';
update gii_hierarchy as gh set gh.lat='28.442519', gh.long='-28.74924' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phahameng';

update gii_hierarchy as gh set gh.lat='28.447386', gh.long='-28.742894' where district='BOTHA BOTHE' and council='Moteng Council' and village='Nyakoaneng';
update gii_hierarchy as gh set gh.lat='28.467764', gh.long='-28.754026' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Lesiba';
update gii_hierarchy as gh set gh.lat='28.459934', gh.long='-28.743902' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Mokone';
update gii_hierarchy as gh set gh.lat='28.464138', gh.long='-28.745155' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Molapo';
update gii_hierarchy as gh set gh.lat='28.468518', gh.long='-28.742512' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Motapane';
update gii_hierarchy as gh set gh.lat='28.471378', gh.long='-28.747122' where district='BOTHA BOTHE' and council='Moteng Council' and village='Naleli';
update gii_hierarchy as gh set gh.lat='28.484528', gh.long='-28.742657' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Mpotla';
update gii_hierarchy as gh set gh.lat='28.478027', gh.long='-28.744855' where district='BOTHA BOTHE' and council='Moteng Council' and village='Masianokeng';
update gii_hierarchy as gh set gh.lat='28.502471', gh.long='-28.744996' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Hlakacha';
update gii_hierarchy as gh set gh.lat='28.477537', gh.long='-28.725824' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Matela';
update gii_hierarchy as gh set gh.lat='28.485006', gh.long='-28.734508' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Moiloa';

update gii_hierarchy as gh set gh.lat='28.511353', gh.long='-28.749948' where district='BOTHA BOTHE' and council='Moteng Council' and village='Masoleng';
update gii_hierarchy as gh set gh.lat='28.530412', gh.long='-28.749362' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Moteoli';


update gii_hierarchy as gh set gh.lat='28.541132', gh.long='-28.753775' where district='BOTHA BOTHE' and council='Moteng Council' and village='Qobella';

update gii_hierarchy as gh set gh.lat='28.520774', gh.long='-28.624564' where district='BOTHA BOTHE' and council='Moteng Council' and village='Kolone';
update gii_hierarchy as gh set gh.lat='28.52223', gh.long='-28.755739' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='28.578499', gh.long='-28.610044' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phatlalla';
update gii_hierarchy as gh set gh.lat='28.4995', gh.long='-28.760266' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phelandaba';
update gii_hierarchy as gh set gh.lat='28.490299', gh.long='-28.762316' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Tlebere';
update gii_hierarchy as gh set gh.lat='28.493169', gh.long='-28.752669' where district='BOTHA BOTHE' and council='Moteng Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='28.485203', gh.long='-28.758938' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Phakela';
update gii_hierarchy as gh set gh.lat='28.468717', gh.long='-28.763795' where district='BOTHA BOTHE' and council='Moteng Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.466919', gh.long='-28.767903' where district='BOTHA BOTHE' and council='Moteng Council' and village='Phahleng';

update gii_hierarchy as gh set gh.lat='28.439237', gh.long='-28.772108' where district='BOTHA BOTHE' and council='Moteng Council' and village='Palehong';
update gii_hierarchy as gh set gh.lat='28.45813', gh.long='-28.779184' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Taetsi';
update gii_hierarchy as gh set gh.lat='28.452447', gh.long='-28.776302' where district='BOTHA BOTHE' and council='Moteng Council' and village='Muela';
update gii_hierarchy as gh set gh.lat='28.428711', gh.long='-28.793543' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Maieane';

update gii_hierarchy as gh set gh.lat='28.629268', gh.long='-28.605777' where district='BOTHA BOTHE' and council='Moteng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.449632', gh.long='-28.806259' where district='BOTHA BOTHE' and council='Moteng Council' and village='Mathebe';


update gii_hierarchy as gh set gh.lat='28.457379', gh.long='-28.81907' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Potomane';
update gii_hierarchy as gh set gh.lat='28.610369', gh.long='-29.041412' where district='BOTHA BOTHE' and council='Moteng Council' and village='Khatleng';
update gii_hierarchy as gh set gh.lat='28.457092', gh.long='-28.808697' where district='BOTHA BOTHE' and council='Moteng Council' and village='Mashapi';
update gii_hierarchy as gh set gh.lat='28.466559', gh.long='-28.821776' where district='BOTHA BOTHE' and council='Moteng Council' and village='Mota Rifa';
update gii_hierarchy as gh set gh.lat='28.452139', gh.long='-28.796944' where district='BOTHA BOTHE' and council='Moteng Council' and village='Pote';
update gii_hierarchy as gh set gh.lat='28.464698', gh.long='-28.782164' where district='BOTHA BOTHE' and council='Moteng Council' and village='Boinyatso';
update gii_hierarchy as gh set gh.lat='28.46814', gh.long='-28.787056' where district='BOTHA BOTHE' and council='Moteng Council' and village='Bela Bela';
update gii_hierarchy as gh set gh.lat='28.476662', gh.long='-28.796082' where district='BOTHA BOTHE' and council='Moteng Council' and village='Sentelina';
update gii_hierarchy as gh set gh.lat='28.503315', gh.long='-28.772125' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Khanye';
update gii_hierarchy as gh set gh.lat='28.50511', gh.long='-28.779254' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ordendal';
update gii_hierarchy as gh set gh.lat='28.512078', gh.long='-28.771632' where district='BOTHA BOTHE' and council='Moteng Council' and village='Bokong (Khaphamali)';
update gii_hierarchy as gh set gh.lat='28.518385', gh.long='-28.784874' where district='BOTHA BOTHE' and council='Moteng Council' and village='Sebataolong';
update gii_hierarchy as gh set gh.lat='28.314949', gh.long='-28.77265' where district='BOTHA BOTHE' and council='Moteng Council' and village='Marabeng';
update gii_hierarchy as gh set gh.lat='28.514252', gh.long='-28.792396' where district='BOTHA BOTHE' and council='Moteng Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.487743', gh.long='-28.811381' where district='BOTHA BOTHE' and council='Moteng Council' and village='Ha Sekete (Paballong)';


update gii_hierarchy as gh set gh.lat='28.467211', gh.long='-28.829176' where district='BOTHA BOTHE' and council='Moteng Council' and village='Khorong';
update gii_hierarchy as gh set gh.lat='28.459307', gh.long='-28.842086' where district='BOTHA BOTHE' and council='Moteng Council' and village='Luma';

update gii_hierarchy as gh set gh.lat='28.458268', gh.long='-28.833264' where district='BOTHA BOTHE' and council='Moteng Council' and village='Marati';
update gii_hierarchy as gh set gh.lat='28.357755', gh.long='-28.780744' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha lesia';
update gii_hierarchy as gh set gh.lat='28.365055', gh.long='-28.784428' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha Mosala (Matlaong)';
update gii_hierarchy as gh set gh.lat='28.3731', gh.long='-28.785183' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha Mohalenyane';
update gii_hierarchy as gh set gh.lat='28.52223', gh.long='-28.755739' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='28.372875', gh.long='-28.799687' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Phothong';
update gii_hierarchy as gh set gh.lat='28.548447', gh.long='-28.615917' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Thabong';
update gii_hierarchy as gh set gh.lat='28.399245', gh.long='-28.806564' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha Leseli';
update gii_hierarchy as gh set gh.lat='28.394918', gh.long='-28.803452' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha Mothuntsane';
update gii_hierarchy as gh set gh.lat='28.403966', gh.long='-28.807127' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Ha Mpotso';
update gii_hierarchy as gh set gh.lat='28.408018', gh.long='-28.817657' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Khohloaneng';
update gii_hierarchy as gh set gh.lat='28.415006', gh.long='-28.819576' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Tamaseka';
update gii_hierarchy as gh set gh.lat='28.418083', gh.long='-28.824601' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='28.548298', gh.long='-28.680889' where district='BOTHA BOTHE' and council='Linakeng Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.308314', gh.long='-28.704945' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Likhahleng';

update gii_hierarchy as gh set gh.lat='28.311881', gh.long='-28.722586' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Pokane';
update gii_hierarchy as gh set gh.lat='28.314692', gh.long='-28.710326' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Makong';
update gii_hierarchy as gh set gh.lat='28.331338', gh.long='-28.705455' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Motsoari (Qalo)';
update gii_hierarchy as gh set gh.lat='28.337577', gh.long='-28.702419' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Qalo';
update gii_hierarchy as gh set gh.lat='28.346303', gh.long='-28.706001' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='28.332787', gh.long='-28.712624' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Mantloaneng';

update gii_hierarchy as gh set gh.lat='28.342642', gh.long='-28.728415' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Kotsonkoaneng';
update gii_hierarchy as gh set gh.lat='28.324192', gh.long='-28.725801' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Makuini';




update gii_hierarchy as gh set gh.lat='28.309467', gh.long='-28.731521' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Mokhatla (Manamela)';
update gii_hierarchy as gh set gh.lat='28.313703', gh.long='-28.740976' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Manamela';



update gii_hierarchy as gh set gh.lat='28.353013', gh.long='-28.737347' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Maloseng';
update gii_hierarchy as gh set gh.lat='28.362326', gh.long='-28.756939' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Sebophe';
update gii_hierarchy as gh set gh.lat='28.350533', gh.long='-28.749437' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='28.370885', gh.long='-28.771078' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Motjanyela';
update gii_hierarchy as gh set gh.lat='28.354191', gh.long='-28.764061' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Makhoahla';
update gii_hierarchy as gh set gh.lat='28.342248', gh.long='-28.774948' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Selomo';
update gii_hierarchy as gh set gh.lat='28.348677', gh.long='-28.779931' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Mamphaneng';
update gii_hierarchy as gh set gh.lat='28.349501', gh.long='-28.783621' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Mothae';
update gii_hierarchy as gh set gh.lat='28.332555', gh.long='-28.772668' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Matjeka';
update gii_hierarchy as gh set gh.lat='28.327632', gh.long='-28.771898' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Mohlanka';
update gii_hierarchy as gh set gh.lat='28.317977', gh.long='-28.765937' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Mantlakane';
update gii_hierarchy as gh set gh.lat='28.314949', gh.long='-28.77265' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Marabeng';
update gii_hierarchy as gh set gh.lat='28.315692', gh.long='-28.770964' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Sephokong';
update gii_hierarchy as gh set gh.lat='28.306041', gh.long='-28.781135' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Masite';
update gii_hierarchy as gh set gh.lat='28.309006', gh.long='-28.772901' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Sekubu Mission';
update gii_hierarchy as gh set gh.lat='28.312493', gh.long='-28.775319' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Thajaneng';
update gii_hierarchy as gh set gh.lat='28.565649', gh.long='-28.620267' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Lekanyane';
update gii_hierarchy as gh set gh.lat='28.297325', gh.long='-28.782617' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Letsika';
update gii_hierarchy as gh set gh.lat='28.548298', gh.long='-28.680889' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.327755', gh.long='-28.784722' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Biafa';
update gii_hierarchy as gh set gh.lat='28.325776', gh.long='-28.794554' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Makhotla';
update gii_hierarchy as gh set gh.lat='28.323082', gh.long='-28.78956' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Maleholo';

update gii_hierarchy as gh set gh.lat='28.317136', gh.long='-28.787837' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Mpaki';


update gii_hierarchy as gh set gh.lat='28.395159', gh.long='-28.739767' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Sekoting';

update gii_hierarchy as gh set gh.lat='28.353809', gh.long='-28.802973' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Malefane';
update gii_hierarchy as gh set gh.lat='28.344486', gh.long='-28.801594' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Ha Masekhou';

update gii_hierarchy as gh set gh.lat='28.495842', gh.long='-28.662811' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Maholong';

update gii_hierarchy as gh set gh.lat='28.363446', gh.long='-28.813048' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Malimong (Ha Leboea)';
update gii_hierarchy as gh set gh.lat='28.358824', gh.long='-28.801941' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Rolosela';
update gii_hierarchy as gh set gh.lat='28.377972', gh.long='-28.818873' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Liforong (Ha Leboea)';
update gii_hierarchy as gh set gh.lat='28.370334', gh.long='-28.815219' where district='BOTHA BOTHE' and council='Tsa le Moleka Council' and village='Tikathole (Ha Leboea)';
update gii_hierarchy as gh set gh.lat='28.235809', gh.long='-28.699789' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Mokhoka';
update gii_hierarchy as gh set gh.lat='28.233791', gh.long='-28.705327' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Sebeko';
update gii_hierarchy as gh set gh.lat='28.23964', gh.long='-28.70451' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Maletatso';
update gii_hierarchy as gh set gh.lat='28.239207', gh.long='-28.698663' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Makong';
update gii_hierarchy as gh set gh.lat='28.395159', gh.long='-28.739767' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Sekoting';

update gii_hierarchy as gh set gh.lat='28.251896', gh.long='-28.729724' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Majara';

update gii_hierarchy as gh set gh.lat='28.260733', gh.long='-28.713069' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Marallaneng';
update gii_hierarchy as gh set gh.lat='28.285639', gh.long='-28.723008' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Thabo (Liqalaneng)';
update gii_hierarchy as gh set gh.lat='28.270722', gh.long='-28.72918' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Morifi';
update gii_hierarchy as gh set gh.lat='28.279661', gh.long='-28.728699' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Liqalaneng';
update gii_hierarchy as gh set gh.lat='28.275938', gh.long='-28.725003' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Masheeng';
update gii_hierarchy as gh set gh.lat='28.289816', gh.long='-28.739231' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Ramokema';
update gii_hierarchy as gh set gh.lat='28.258755', gh.long='-28.731217' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Mothetsi';
update gii_hierarchy as gh set gh.lat='28.265272', gh.long='-28.743662' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Lekili';
update gii_hierarchy as gh set gh.lat='28.267027', gh.long='-28.749926' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Nqabeni';

update gii_hierarchy as gh set gh.lat='28.255421', gh.long='-28.754077' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Likileng';
update gii_hierarchy as gh set gh.lat='28.259431', gh.long='-28.752357' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='28.250561', gh.long='-28.751621' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Baroeng';

update gii_hierarchy as gh set gh.lat='28.248165', gh.long='-28.761839' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Botha Bothe Reserve';
update gii_hierarchy as gh set gh.lat='28.242061', gh.long='-28.768599' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Maoeng';
update gii_hierarchy as gh set gh.lat='28.244042', gh.long='-28.775058' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Lipelaneng';
update gii_hierarchy as gh set gh.lat='28.242585', gh.long='-28.782371' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Qaphaulane';
update gii_hierarchy as gh set gh.lat='28.338981', gh.long='-28.78035' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Kamoho';
update gii_hierarchy as gh set gh.lat='28.253052', gh.long='-28.773095' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Phaphama';


update gii_hierarchy as gh set gh.lat='28.256498', gh.long='-28.789825' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Sechele';
update gii_hierarchy as gh set gh.lat='28.263348', gh.long='-28.787359' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Serole';
update gii_hierarchy as gh set gh.lat='28.25638', gh.long='-28.768184' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Makopo';
update gii_hierarchy as gh set gh.lat='28.548447', gh.long='-28.615917' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Thabong';
update gii_hierarchy as gh set gh.lat='28.274769', gh.long='-28.757604' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='28.282948', gh.long='-28.759774' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Mopeli';
update gii_hierarchy as gh set gh.lat='28.268931', gh.long='-28.772247' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Thabana Mokhele';
update gii_hierarchy as gh set gh.lat='28.269409', gh.long='-28.782245' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='28.276375', gh.long='-28.79908' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Lithakong';

update gii_hierarchy as gh set gh.lat='28.282056', gh.long='-28.795326' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.277127', gh.long='-28.792468' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Mokhanthane';

update gii_hierarchy as gh set gh.lat='28.283311', gh.long='-28.790412' where district='BOTHA BOTHE' and council='Lipelaneng Council' and village='Ha Sepetla';

update gii_hierarchy as gh set gh.lat='28.498874', gh.long='-29.088259' where district='LERIBE' and council='Limamarela Council' and village='Ha Sebotha';
update gii_hierarchy as gh set gh.lat='28.461879', gh.long='-29.071002' where district='LERIBE' and council='Limamarela Council' and village='Lepaqoa';
update gii_hierarchy as gh set gh.lat='28.483799', gh.long='-29.087517' where district='LERIBE' and council='Limamarela Council' and village='Thoteng (Ha Sebotha)';
update gii_hierarchy as gh set gh.lat='28.489969', gh.long='-29.10892' where district='LERIBE' and council='Limamarela Council' and village='Ha Lejone';
update gii_hierarchy as gh set gh.lat='28.483917', gh.long='-29.122154' where district='LERIBE' and council='Limamarela Council' and village='Ha Lukase';


update gii_hierarchy as gh set gh.lat='28.48091', gh.long='-29.145066' where district='LERIBE' and council='Limamarela Council' and village='Mamohau';

update gii_hierarchy as gh set gh.lat='28.472007', gh.long='-29.182947' where district='LERIBE' and council='Limamarela Council' and village='Ha Sekhele';
update gii_hierarchy as gh set gh.lat='28.481031', gh.long='-29.167835' where district='LERIBE' and council='Limamarela Council' and village='Ha Thibeli';
update gii_hierarchy as gh set gh.lat='28.471111', gh.long='-29.192075' where district='LERIBE' and council='Limamarela Council' and village='Ha Rafanyane';
update gii_hierarchy as gh set gh.lat='28.466001', gh.long='-29.221438' where district='LERIBE' and council='Limamarela Council' and village='Kobong (Ha Mallane)';
update gii_hierarchy as gh set gh.lat='28.457405', gh.long='-29.23021' where district='LERIBE' and council='Limamarela Council' and village='Ha Thoora (Ha Mallane)';

update gii_hierarchy as gh set gh.lat='28.381023', gh.long='-29.265419' where district='LERIBE' and council='Limamarela Council' and village='Ha Joma';
update gii_hierarchy as gh set gh.lat='28.364253', gh.long='-29.218426' where district='LERIBE' and council='Limamarela Council' and village='Ha Matsoele';
update gii_hierarchy as gh set gh.lat='28.375761', gh.long='-29.250635' where district='LERIBE' and council='Limamarela Council' and village='Ha Noha';


update gii_hierarchy as gh set gh.lat='28.455483', gh.long='-29.267706' where district='LERIBE' and council='Limamarela Council' and village='Ha Semela';
update gii_hierarchy as gh set gh.lat='28.446621', gh.long='-29.251484' where district='LERIBE' and council='Limamarela Council' and village='Maphutseng';

update gii_hierarchy as gh set gh.lat='28.450161', gh.long='-29.290529' where district='LERIBE' and council='Limamarela Council' and village='Makhalong';

update gii_hierarchy as gh set gh.lat='28.421538', gh.long='-29.312341' where district='LERIBE' and council='Limamarela Council' and village='Ha Tsepo';
update gii_hierarchy as gh set gh.lat='28.40461', gh.long='-29.294518' where district='LERIBE' and council='Limamarela Council' and village='Lehlakaneng';
update gii_hierarchy as gh set gh.lat='28.437285', gh.long='-29.312143' where district='LERIBE' and council='Limamarela Council' and village='Ha Mpeli';

update gii_hierarchy as gh set gh.lat='28.472518', gh.long='-29.313791' where district='LERIBE' and council='Limamarela Council' and village='Ha Sepinare';







update gii_hierarchy as gh set gh.lat='28.51611', gh.long='-29.205465' where district='LERIBE' and council='Mphorosane Council' and village='Laitsoka';

update gii_hierarchy as gh set gh.lat='28.501751', gh.long='-29.186251' where district='LERIBE' and council='Mphorosane Council' and village='Ntsirele';



update gii_hierarchy as gh set gh.lat='28.515872', gh.long='-29.181338' where district='LERIBE' and council='Mphorosane Council' and village='Ha Maletairi';
update gii_hierarchy as gh set gh.lat='28.54929', gh.long='-29.188122' where district='LERIBE' and council='Mphorosane Council' and village='Ha Mofalali';
update gii_hierarchy as gh set gh.lat='28.543925', gh.long='-29.163021' where district='LERIBE' and council='Mphorosane Council' and village='Ha Mashapha';
update gii_hierarchy as gh set gh.lat='28.510623', gh.long='-29.159676' where district='LERIBE' and council='Mphorosane Council' and village='Ha Khauta';
update gii_hierarchy as gh set gh.lat='28.524962', gh.long='-29.157571' where district='LERIBE' and council='Mphorosane Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='28.512147', gh.long='-29.136336' where district='LERIBE' and council='Mphorosane Council' and village='Kolike';
update gii_hierarchy as gh set gh.lat='28.518046', gh.long='-29.139845' where district='LERIBE' and council='Mphorosane Council' and village='Lejoemotho';
update gii_hierarchy as gh set gh.lat='28.532283', gh.long='-29.146836' where district='LERIBE' and council='Mphorosane Council' and village='Ha Molotonyane';
update gii_hierarchy as gh set gh.lat='28.546596', gh.long='-29.144669' where district='LERIBE' and council='Mphorosane Council' and village='Ha Teko';

update gii_hierarchy as gh set gh.lat='28.512999', gh.long='-29.120725' where district='LERIBE' and council='Mphorosane Council' and village='Ha Nkisi';
update gii_hierarchy as gh set gh.lat='28.510848', gh.long='-29.108883' where district='LERIBE' and council='Mphorosane Council' and village='Ha Mosiuoa';
update gii_hierarchy as gh set gh.lat='28.5212', gh.long='-29.101729' where district='LERIBE' and council='Mphorosane Council' and village='Ha Taunyane';

update gii_hierarchy as gh set gh.lat='28.53245', gh.long='-29.11134' where district='LERIBE' and council='Mphorosane Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.556751', gh.long='-29.115102' where district='LERIBE' and council='Mphorosane Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='28.52409', gh.long='-29.089806' where district='LERIBE' and council='Mphorosane Council' and village='Cangela';
update gii_hierarchy as gh set gh.lat='28.531211', gh.long='-29.090862' where district='LERIBE' and council='Mphorosane Council' and village='Ha Manti';
update gii_hierarchy as gh set gh.lat='28.527723', gh.long='-29.076637' where district='LERIBE' and council='Mphorosane Council' and village='Mohlakeng';
update gii_hierarchy as gh set gh.lat='28.54499', gh.long='-29.061657' where district='LERIBE' and council='Mphorosane Council' and village='Kutung (Vuka Mosotho)';
update gii_hierarchy as gh set gh.lat='28.580791', gh.long='-29.098693' where district='LERIBE' and council='Mphorosane Council' and village='Ha Manamolela';
update gii_hierarchy as gh set gh.lat='28.579638', gh.long='-29.078518' where district='LERIBE' and council='Mphorosane Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.561252', gh.long='-29.050618' where district='LERIBE' and council='Mphorosane Council' and village='Holantu';
update gii_hierarchy as gh set gh.lat='28.53944', gh.long='-29.053544' where district='LERIBE' and council='Mphorosane Council' and village='Ha Leqolana';
update gii_hierarchy as gh set gh.lat='28.553238', gh.long='-29.057791' where district='LERIBE' and council='Mphorosane Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='28.537551', gh.long='-29.064309' where district='LERIBE' and council='Mphorosane Council' and village='Topa (Vuka Mosotho)';
update gii_hierarchy as gh set gh.lat='28.65772', gh.long='-29.147679' where district='LERIBE' and council='Seshote Council' and village='Ha Matete';
update gii_hierarchy as gh set gh.lat='28.671018', gh.long='-29.145889' where district='LERIBE' and council='Seshote Council' and village='Ha Nkunye';
update gii_hierarchy as gh set gh.lat='28.683338', gh.long='-29.122313' where district='LERIBE' and council='Seshote Council' and village='Linyokong';
update gii_hierarchy as gh set gh.lat='28.693626', gh.long='-29.118547' where district='LERIBE' and council='Seshote Council' and village='Mahateng';

update gii_hierarchy as gh set gh.lat='28.6293', gh.long='-29.164748' where district='LERIBE' and council='Seshote Council' and village='Khokhobe';
update gii_hierarchy as gh set gh.lat='28.590112', gh.long='-29.152704' where district='LERIBE' and council='Seshote Council' and village='Ha Lelingoana';
update gii_hierarchy as gh set gh.lat='28.591666', gh.long='-29.145414' where district='LERIBE' and council='Seshote Council' and village='Ha Mali';
update gii_hierarchy as gh set gh.lat='28.596871', gh.long='-29.159401' where district='LERIBE' and council='Seshote Council' and village='Ha Seemane';
update gii_hierarchy as gh set gh.lat='28.603976', gh.long='-29.154516' where district='LERIBE' and council='Seshote Council' and village='Phukheng';
update gii_hierarchy as gh set gh.lat='28.596832', gh.long='-29.170834' where district='LERIBE' and council='Seshote Council' and village='Ha Palama';
update gii_hierarchy as gh set gh.lat='28.615546', gh.long='-29.172129' where district='LERIBE' and council='Seshote Council' and village='Ha Ramoji';
update gii_hierarchy as gh set gh.lat='28.583515', gh.long='-29.176133' where district='LERIBE' and council='Seshote Council' and village='Patuoe';
update gii_hierarchy as gh set gh.lat='28.578097', gh.long='-29.18874' where district='LERIBE' and council='Seshote Council' and village='Ha Ralebese';

update gii_hierarchy as gh set gh.lat='28.561793', gh.long='-29.213984' where district='LERIBE' and council='Seshote Council' and village='Ha Majela';
update gii_hierarchy as gh set gh.lat='28.572087', gh.long='-29.205046' where district='LERIBE' and council='Seshote Council' and village='Ha Mpeako';
update gii_hierarchy as gh set gh.lat='28.553907', gh.long='-29.224228' where district='LERIBE' and council='Seshote Council' and village='Ha Makopela';
update gii_hierarchy as gh set gh.lat='28.548681', gh.long='-29.241614' where district='LERIBE' and council='Seshote Council' and village='Ha Tsehla';

update gii_hierarchy as gh set gh.lat='28.543503', gh.long='-29.251901' where district='LERIBE' and council='Seshote Council' and village='Ha Ntsooa';
update gii_hierarchy as gh set gh.lat='28.541816', gh.long='-29.294539' where district='LERIBE' and council='Seshote Council' and village='Ha Nkaobee';

update gii_hierarchy as gh set gh.lat='28.542213', gh.long='-29.272601' where district='LERIBE' and council='Seshote Council' and village='Ha Lesenya (Ha Seshote)';
update gii_hierarchy as gh set gh.lat='28.505491', gh.long='-29.287403' where district='LERIBE' and council='Seshote Council' and village='Mapeleng';
update gii_hierarchy as gh set gh.lat='28.495415', gh.long='-29.291816' where district='LERIBE' and council='Seshote Council' and village='Ha Chelane';
update gii_hierarchy as gh set gh.lat='28.506639', gh.long='-29.302331' where district='LERIBE' and council='Seshote Council' and village='Ha Kanono';
update gii_hierarchy as gh set gh.lat='28.507187', gh.long='-29.317089' where district='LERIBE' and council='Seshote Council' and village='Ha Theko';


update gii_hierarchy as gh set gh.lat='28.561427', gh.long='-29.297568' where district='LERIBE' and council='Seshote Council' and village='Ha Nang';
update gii_hierarchy as gh set gh.lat='28.554141', gh.long='-29.306729' where district='LERIBE' and council='Seshote Council' and village='Ha Sekutlu';


update gii_hierarchy as gh set gh.lat='28.533613', gh.long='-29.331991' where district='LERIBE' and council='Seshote Council' and village='Ha Ramanemane';
update gii_hierarchy as gh set gh.lat='28.585295', gh.long='-29.32927' where district='LERIBE' and council='Seshote Council' and village='Ha Kokoana';
update gii_hierarchy as gh set gh.lat='28.579229', gh.long='-29.322332' where district='LERIBE' and council='Seshote Council' and village='Ha Mathabela';
update gii_hierarchy as gh set gh.lat='28.289449', gh.long='-28.868581' where district='LERIBE' and council='Seshote Council' and village='Ha Leaooa';
update gii_hierarchy as gh set gh.lat='28.589767', gh.long='-29.350552' where district='LERIBE' and council='Seshote Council' and village='Ha Sekereu (Bochabela)';
update gii_hierarchy as gh set gh.lat='28.594526', gh.long='-29.343072' where district='LERIBE' and council='Seshote Council' and village='Seloloana (Khopung)';
update gii_hierarchy as gh set gh.lat='28.235845', gh.long='-28.959483' where district='LERIBE' and council='Matlameng Council' and village='Ha Liphapang';
update gii_hierarchy as gh set gh.lat='28.239119', gh.long='-28.978403' where district='LERIBE' and council='Matlameng Council' and village='Lekhoathakhoatha';
update gii_hierarchy as gh set gh.lat='28.248692', gh.long='-28.962793' where district='LERIBE' and council='Matlameng Council' and village='Ha Makibinyane';
update gii_hierarchy as gh set gh.lat='28.243336', gh.long='-28.95868' where district='LERIBE' and council='Matlameng Council' and village='Ha Mokoroane';
update gii_hierarchy as gh set gh.lat='28.256209', gh.long='-28.964108' where district='LERIBE' and council='Matlameng Council' and village='Ha Koebu';
update gii_hierarchy as gh set gh.lat='28.253362', gh.long='-28.9719' where district='LERIBE' and council='Matlameng Council' and village='Ha Rankhelepe';
update gii_hierarchy as gh set gh.lat='28.279485', gh.long='-28.976417' where district='LERIBE' and council='Matlameng Council' and village='Ha Sankoela';

update gii_hierarchy as gh set gh.lat='28.264046', gh.long='-28.980209' where district='LERIBE' and council='Matlameng Council' and village='Ha Moshoeshoe';
update gii_hierarchy as gh set gh.lat='28.28949', gh.long='-28.981421' where district='LERIBE' and council='Matlameng Council' and village='Ha Letsie';
update gii_hierarchy as gh set gh.lat='28.282482', gh.long='-28.972433' where district='LERIBE' and council='Matlameng Council' and village='Ha Mokopotsa';
update gii_hierarchy as gh set gh.lat='28.28735', gh.long='-28.976582' where district='LERIBE' and council='Matlameng Council' and village='Ha Motsatsa';

update gii_hierarchy as gh set gh.lat='28.304623', gh.long='-28.974689' where district='LERIBE' and council='Matlameng Council' and village='Ha Letele';
update gii_hierarchy as gh set gh.lat='28.294205', gh.long='-28.973477' where district='LERIBE' and council='Matlameng Council' and village='Ha Mokhubu';
update gii_hierarchy as gh set gh.lat='28.299408', gh.long='-28.97323' where district='LERIBE' and council='Matlameng Council' and village='Hata Butle';
update gii_hierarchy as gh set gh.lat='28.304689', gh.long='-28.967456' where district='LERIBE' and council='Matlameng Council' and village='Papalala';
update gii_hierarchy as gh set gh.lat='28.314983', gh.long='-28.961842' where district='LERIBE' and council='Matlameng Council' and village='Ha Sekhonyana';
update gii_hierarchy as gh set gh.lat='28.307766', gh.long='-28.958291' where district='LERIBE' and council='Matlameng Council' and village='Tsenola';
update gii_hierarchy as gh set gh.lat='28.32149', gh.long='-28.974284' where district='LERIBE' and council='Matlameng Council' and village='Ha Lelia';
update gii_hierarchy as gh set gh.lat='28.314833', gh.long='-28.972802' where district='LERIBE' and council='Matlameng Council' and village='Ha Mahlehle';
update gii_hierarchy as gh set gh.lat='28.324693', gh.long='-28.976522' where district='LERIBE' and council='Matlameng Council' and village='Maqalika';
update gii_hierarchy as gh set gh.lat='28.35449', gh.long='-28.985071' where district='LERIBE' and council='Matlameng Council' and village='Ha Koasa';
update gii_hierarchy as gh set gh.lat='28.331301', gh.long='-28.973432' where district='LERIBE' and council='Matlameng Council' and village='Ha Mashongoane';
update gii_hierarchy as gh set gh.lat='28.340121', gh.long='-28.974015' where district='LERIBE' and council='Matlameng Council' and village='Ha Mokemane';

update gii_hierarchy as gh set gh.lat='28.311902', gh.long='-29.001492' where district='LERIBE' and council='Matlameng Council' and village='Qophello';

update gii_hierarchy as gh set gh.lat='28.335461', gh.long='-29.006282' where district='LERIBE' and council='Matlameng Council' and village='Makhanfole (Nkoeng)';
update gii_hierarchy as gh set gh.lat='28.339448', gh.long='-29.007898' where district='LERIBE' and council='Matlameng Council' and village='Sebala Bala (Nkoeng)';


update gii_hierarchy as gh set gh.lat='28.236727', gh.long='-28.998132' where district='LERIBE' and council='Pitseng Council' and village='Ha Rampesa';
update gii_hierarchy as gh set gh.lat='28.267641', gh.long='-28.994145' where district='LERIBE' and council='Pitseng Council' and village='Ha Shekoe';
update gii_hierarchy as gh set gh.lat='28.27042', gh.long='-29.007189' where district='LERIBE' and council='Pitseng Council' and village='Sekoaing';
update gii_hierarchy as gh set gh.lat='28.218763', gh.long='-28.954549' where district='LERIBE' and council='Pitseng Council' and village='Ha Nchee';

update gii_hierarchy as gh set gh.lat='28.211032', gh.long='-28.983336' where district='LERIBE' and council='Pitseng Council' and village='Ha Mphenyeke';

update gii_hierarchy as gh set gh.lat='28.213183', gh.long='-28.975568' where district='LERIBE' and council='Pitseng Council' and village='Ha Raphoka';
update gii_hierarchy as gh set gh.lat='28.225221', gh.long='-28.995208' where district='LERIBE' and council='Pitseng Council' and village='Ha Lota';
update gii_hierarchy as gh set gh.lat='28.224197', gh.long='-28.985804' where district='LERIBE' and council='Pitseng Council' and village='Lipohong';
update gii_hierarchy as gh set gh.lat='28.211768', gh.long='-28.999442' where district='LERIBE' and council='Pitseng Council' and village='Ha Ntoere (Pitseng)';


update gii_hierarchy as gh set gh.lat='28.212699', gh.long='-29.007809' where district='LERIBE' and council='Pitseng Council' and village='Ha Makateng (Pitseng)';
update gii_hierarchy as gh set gh.lat='28.330665', gh.long='-29.049993' where district='LERIBE' and council='Pitseng Council' and village='Ha Botso';
update gii_hierarchy as gh set gh.lat='28.315748', gh.long='-29.043042' where district='LERIBE' and council='Pitseng Council' and village='Ha Tefo';
update gii_hierarchy as gh set gh.lat='28.307703', gh.long='-29.040752' where district='LERIBE' and council='Pitseng Council' and village='Ha Monate';
update gii_hierarchy as gh set gh.lat='28.294155', gh.long='-29.036495' where district='LERIBE' and council='Pitseng Council' and village='Ha Rantsala';
update gii_hierarchy as gh set gh.lat='28.579638', gh.long='-29.078518' where district='LERIBE' and council='Pitseng Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='28.28307', gh.long='-29.034809' where district='LERIBE' and council='Pitseng Council' and village='Hlokoa Le Monate';
update gii_hierarchy as gh set gh.lat='28.274082', gh.long='-29.02867' where district='LERIBE' and council='Pitseng Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.264711', gh.long='-29.034244' where district='LERIBE' and council='Pitseng Council' and village='Ha Mofoka (Masaleng)';
update gii_hierarchy as gh set gh.lat='28.267802', gh.long='-29.02635' where district='LERIBE' and council='Pitseng Council' and village='Ha Nkoana';
update gii_hierarchy as gh set gh.lat='28.272739', gh.long='-29.035284' where district='LERIBE' and council='Pitseng Council' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='28.252082', gh.long='-29.01501' where district='LERIBE' and council='Pitseng Council' and village='Ha Ntsebe';
update gii_hierarchy as gh set gh.lat='28.254692', gh.long='-29.040786' where district='LERIBE' and council='Pitseng Council' and village='Ha Senyokotho';
update gii_hierarchy as gh set gh.lat='28.245771', gh.long='-29.024462' where district='LERIBE' and council='Pitseng Council' and village='Ha Miro';
update gii_hierarchy as gh set gh.lat='28.239888', gh.long='-29.010253' where district='LERIBE' and council='Pitseng Council' and village='Ha Tjooeng';
update gii_hierarchy as gh set gh.lat='28.244959', gh.long='-29.016007' where district='LERIBE' and council='Pitseng Council' and village='Lilibaneng';
update gii_hierarchy as gh set gh.lat='28.230365', gh.long='-29.028557' where district='LERIBE' and council='Pitseng Council' and village='Ha Makhata';

update gii_hierarchy as gh set gh.lat='28.216628', gh.long='-29.022659' where district='LERIBE' and council='Pitseng Council' and village='Ha Mosebo';



update gii_hierarchy as gh set gh.lat='28.211672', gh.long='-29.05539' where district='LERIBE' and council='Pitseng Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='28.242879', gh.long='-29.042769' where district='LERIBE' and council='Pitseng Council' and village='Ha Mahloane';
update gii_hierarchy as gh set gh.lat='28.24604', gh.long='-29.05049' where district='LERIBE' and council='Pitseng Council' and village='Bolahla (Ha Mahloane)';
update gii_hierarchy as gh set gh.lat='28.247427', gh.long='-29.059496' where district='LERIBE' and council='Pitseng Council' and village='Ha Jorotane';
update gii_hierarchy as gh set gh.lat='28.243473', gh.long='-29.057149' where district='LERIBE' and council='Pitseng Council' and village='Ha Mohatonyane';
update gii_hierarchy as gh set gh.lat='28.254917', gh.long='-29.069153' where district='LERIBE' and council='Pitseng Council' and village='Ha Makena';
update gii_hierarchy as gh set gh.lat='28.258124', gh.long='-29.053145' where district='LERIBE' and council='Pitseng Council' and village='Ha Mamanka';
update gii_hierarchy as gh set gh.lat='28.213734', gh.long='-29.062606' where district='LERIBE' and council='Pitseng Council' and village='Ha Motingoe';
update gii_hierarchy as gh set gh.lat='28.219447', gh.long='-29.080003' where district='LERIBE' and council='Pitseng Council' and village='Ha Mphasa';
update gii_hierarchy as gh set gh.lat='28.544855', gh.long='-29.227698' where district='LERIBE' and council='Motati Council' and village='Ha Mako';
update gii_hierarchy as gh set gh.lat='28.080534', gh.long='-28.899385' where district='LERIBE' and council='Motati Council' and village='Letsatseng';


update gii_hierarchy as gh set gh.lat='28.103261', gh.long='-28.916507' where district='LERIBE' and council='Motati Council' and village='Ha Lekhanya';
update gii_hierarchy as gh set gh.lat='28.107534', gh.long='-28.927406' where district='LERIBE' and council='Motati Council' and village='Ha Pontso';
update gii_hierarchy as gh set gh.lat='28.113849', gh.long='-28.937208' where district='LERIBE' and council='Motati Council' and village='Ha Masamoele';
update gii_hierarchy as gh set gh.lat='28.109376', gh.long='-28.945151' where district='LERIBE' and council='Motati Council' and village='Ha Thabo';
update gii_hierarchy as gh set gh.lat='28.105457', gh.long='-28.962133' where district='LERIBE' and council='Motati Council' and village='Sekhokong';
update gii_hierarchy as gh set gh.lat='28.082593', gh.long='-28.94709' where district='LERIBE' and council='Motati Council' and village='Ha Maromaki';
update gii_hierarchy as gh set gh.lat='28.086655', gh.long='-28.957468' where district='LERIBE' and council='Motati Council' and village='Ha Mositi';
update gii_hierarchy as gh set gh.lat='28.081521', gh.long='-28.926008' where district='LERIBE' and council='Motati Council' and village='Ha Porobele';



update gii_hierarchy as gh set gh.lat='28.08888', gh.long='-28.971608' where district='LERIBE' and council='Motati Council' and village='Ha Lebona';
update gii_hierarchy as gh set gh.lat='28.089564', gh.long='-28.982942' where district='LERIBE' and council='Motati Council' and village='Ha Likatana';
update gii_hierarchy as gh set gh.lat='28.216628', gh.long='-29.022659' where district='LERIBE' and council='Motati Council' and village='Ha Mosebo';

update gii_hierarchy as gh set gh.lat='28.100145', gh.long='-29.008788' where district='LERIBE' and council='Motati Council' and village='Ha Tsiu';
update gii_hierarchy as gh set gh.lat='28.115579', gh.long='-28.995525' where district='LERIBE' and council='Motati Council' and village='Ha Meche';
update gii_hierarchy as gh set gh.lat='28.107284', gh.long='-29.00041' where district='LERIBE' and council='Motati Council' and village='Ha Ntsekhe';
update gii_hierarchy as gh set gh.lat='28.12036', gh.long='-29.002248' where district='LERIBE' and council='Motati Council' and village='Ha Tente';
update gii_hierarchy as gh set gh.lat='28.122872', gh.long='-28.98848' where district='LERIBE' and council='Motati Council' and village='Ha Ntoahae';
update gii_hierarchy as gh set gh.lat='28.115687', gh.long='-28.973135' where district='LERIBE' and council='Motati Council' and village='Ha Ramotho';
update gii_hierarchy as gh set gh.lat='28.114694', gh.long='-28.956769' where district='LERIBE' and council='Motati Council' and village='Ha Masena';
update gii_hierarchy as gh set gh.lat='28.121425', gh.long='-28.946691' where district='LERIBE' and council='Motati Council' and village='Ha Monotsi';
update gii_hierarchy as gh set gh.lat='28.11627', gh.long='-28.944592' where district='LERIBE' and council='Motati Council' and village='Ha Ramotinyane';



update gii_hierarchy as gh set gh.lat='28.140652', gh.long='-28.971327' where district='LERIBE' and council='Motati Council' and village='Ha Rantsane';


update gii_hierarchy as gh set gh.lat='28.136164', gh.long='-28.995371' where district='LERIBE' and council='Motati Council' and village='Jorotane';
update gii_hierarchy as gh set gh.lat='28.134616', gh.long='-28.990291' where district='LERIBE' and council='Motati Council' and village='Litsukulung';
update gii_hierarchy as gh set gh.lat='28.450161', gh.long='-29.290529' where district='LERIBE' and council='Motati Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.131046', gh.long='-28.985989' where district='LERIBE' and council='Motati Council' and village='Tarabane';
update gii_hierarchy as gh set gh.lat='28.131353', gh.long='-29.007426' where district='LERIBE' and council='Motati Council' and village='Ha Tobolela';
update gii_hierarchy as gh set gh.lat='28.125016', gh.long='-29.001619' where district='LERIBE' and council='Motati Council' and village='Liphokong';
update gii_hierarchy as gh set gh.lat='28.075638', gh.long='-28.997473' where district='LERIBE' and council='Fenyane Council' and village='Ha Nthathakane';
update gii_hierarchy as gh set gh.lat='28.065998', gh.long='-28.996234' where district='LERIBE' and council='Fenyane Council' and village='Ha Nyane';
update gii_hierarchy as gh set gh.lat='28.076075', gh.long='-29.008415' where district='LERIBE' and council='Fenyane Council' and village='Maphotong';
update gii_hierarchy as gh set gh.lat='28.081568', gh.long='-29.014228' where district='LERIBE' and council='Fenyane Council' and village='Thaba Lesoba';
update gii_hierarchy as gh set gh.lat='28.103919', gh.long='-29.021022' where district='LERIBE' and council='Fenyane Council' and village='Ha Mohlobolotso';
update gii_hierarchy as gh set gh.lat='28.08921', gh.long='-29.011383' where district='LERIBE' and council='Fenyane Council' and village='Ha Sekoala';
update gii_hierarchy as gh set gh.lat='28.092718', gh.long='-29.003563' where district='LERIBE' and council='Fenyane Council' and village='Mahlabatheng';
update gii_hierarchy as gh set gh.lat='28.089193', gh.long='-29.034705' where district='LERIBE' and council='Fenyane Council' and village='Ha Mamalo';
update gii_hierarchy as gh set gh.lat='28.082225', gh.long='-29.024255' where district='LERIBE' and council='Fenyane Council' and village='Ha Nena';
update gii_hierarchy as gh set gh.lat='28.096921', gh.long='-29.034863' where district='LERIBE' and council='Fenyane Council' and village='Ha Lefoleri';
update gii_hierarchy as gh set gh.lat='28.105798', gh.long='-29.048063' where district='LERIBE' and council='Fenyane Council' and village='Thota Khubelu (Lipetu)';

update gii_hierarchy as gh set gh.lat='28.097985', gh.long='-29.071578' where district='LERIBE' and council='Fenyane Council' and village='Ha Fako (Lipetu)';
update gii_hierarchy as gh set gh.lat='28.112588', gh.long='-29.046711' where district='LERIBE' and council='Fenyane Council' and village='Lipetu';
update gii_hierarchy as gh set gh.lat='28.132058', gh.long='-29.029817' where district='LERIBE' and council='Fenyane Council' and village='Ha Tsae';
update gii_hierarchy as gh set gh.lat='28.140136', gh.long='-29.043742' where district='LERIBE' and council='Fenyane Council' and village='Likhopeng';
update gii_hierarchy as gh set gh.lat='28.128933', gh.long='-29.067108' where district='LERIBE' and council='Fenyane Council' and village='Ha Ntasi';

update gii_hierarchy as gh set gh.lat='28.183462', gh.long='-29.092855' where district='LERIBE' and council='Fenyane Council' and village='Ha Chale';


update gii_hierarchy as gh set gh.lat='28.166079', gh.long='-29.090613' where district='LERIBE' and council='Fenyane Council' and village='Ha Teisi';
update gii_hierarchy as gh set gh.lat='28.159879', gh.long='-29.088272' where district='LERIBE' and council='Fenyane Council' and village='Thella Boy';
update gii_hierarchy as gh set gh.lat='28.212237', gh.long='-29.081824' where district='LERIBE' and council='Fenyane Council' and village='Ha Letseka';

update gii_hierarchy as gh set gh.lat='28.199163', gh.long='-29.065674' where district='LERIBE' and council='Fenyane Council' and village='Ha Matona';
update gii_hierarchy as gh set gh.lat='28.195084', gh.long='-29.05341' where district='LERIBE' and council='Fenyane Council' and village='Ha Maroala';
update gii_hierarchy as gh set gh.lat='28.193821', gh.long='-29.041666' where district='LERIBE' and council='Fenyane Council' and village='Ha Mokhachane';
update gii_hierarchy as gh set gh.lat='28.210898', gh.long='-28.81336' where district='LERIBE' and council='Fenyane Council' and village='Ha Makhobalo';


update gii_hierarchy as gh set gh.lat='28.180589', gh.long='-29.010243' where district='LERIBE' and council='Fenyane Council' and village='Ha Raliee';
update gii_hierarchy as gh set gh.lat='28.184454', gh.long='-29.012875' where district='LERIBE' and council='Fenyane Council' and village='Ha Ranthaele';

update gii_hierarchy as gh set gh.lat='28.155415', gh.long='-29.029046' where district='LERIBE' and council='Fenyane Council' and village='Ha Tsepe';

update gii_hierarchy as gh set gh.lat='28.16503', gh.long='-29.010435' where district='LERIBE' and council='Fenyane Council' and village='Likileng';
update gii_hierarchy as gh set gh.lat='28.176208', gh.long='-29.002757' where district='LERIBE' and council='Fenyane Council' and village='Ha Mahooana';
update gii_hierarchy as gh set gh.lat='28.168386', gh.long='-28.996641' where district='LERIBE' and council='Fenyane Council' and village='Ha Mathai';
update gii_hierarchy as gh set gh.lat='28.151083', gh.long='-28.986825' where district='LERIBE' and council='Fenyane Council' and village='Ha Ramapepe';

update gii_hierarchy as gh set gh.lat='28.138796', gh.long='-29.015988' where district='LERIBE' and council='Fenyane Council' and village='Ha Phelane';
update gii_hierarchy as gh set gh.lat='28.141937', gh.long='-29.019106' where district='LERIBE' and council='Fenyane Council' and village='Ha Matoli';
update gii_hierarchy as gh set gh.lat='28.288442', gh.long='-28.956275' where district='LERIBE' and council='Matlameng Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='28.192508', gh.long='-28.958479' where district='LERIBE' and council='Pitseng Council' and village='Ha Makape';
update gii_hierarchy as gh set gh.lat='28.184742', gh.long='-28.969285' where district='LERIBE' and council='Pitseng Council' and village='Litooaneng';

update gii_hierarchy as gh set gh.lat='28.192388', gh.long='-28.988044' where district='LERIBE' and council='Pitseng Council' and village='Ha Moepi';

update gii_hierarchy as gh set gh.lat='28.112829', gh.long='-28.922745' where district='LERIBE' and council='Serupane Council' and village='Ha Moseli';
update gii_hierarchy as gh set gh.lat='28.110756', gh.long='-28.91495' where district='LERIBE' and council='Serupane Council' and village='Ha Setene';
update gii_hierarchy as gh set gh.lat='28.128746', gh.long='-28.912778' where district='LERIBE' and council='Serupane Council' and village='Ha Thekoane';
update gii_hierarchy as gh set gh.lat='28.137255', gh.long='-28.907232' where district='LERIBE' and council='Serupane Council' and village='Ha Lobiane';




update gii_hierarchy as gh set gh.lat='28.154462', gh.long='-28.923761' where district='LERIBE' and council='Serupane Council' and village='Mohope';
update gii_hierarchy as gh set gh.lat='28.130059', gh.long='-28.9278' where district='LERIBE' and council='Serupane Council' and village='Ha Lesiamo';
update gii_hierarchy as gh set gh.lat='28.145024', gh.long='-28.940411' where district='LERIBE' and council='Serupane Council' and village='Ha Botilo (Mahobong)';
update gii_hierarchy as gh set gh.lat='28.149583', gh.long='-28.939011' where district='LERIBE' and council='Serupane Council' and village='Ha Mokausi (Mahobong)';
update gii_hierarchy as gh set gh.lat='28.136937', gh.long='-28.941524' where district='LERIBE' and council='Serupane Council' and village='Ha Seeiso (Mahobong)';
update gii_hierarchy as gh set gh.lat='28.156172', gh.long='-28.936115' where district='LERIBE' and council='Serupane Council' and village='Ha Tota (Mahobong)';

update gii_hierarchy as gh set gh.lat='28.184417', gh.long='-28.916386' where district='LERIBE' and council='Serupane Council' and village='Ha Mahala';
update gii_hierarchy as gh set gh.lat='28.172283', gh.long='-28.945622' where district='LERIBE' and council='Serupane Council' and village='Ha Mapeshoane (Mahobong)';
update gii_hierarchy as gh set gh.lat='28.169653', gh.long='-28.940214' where district='LERIBE' and council='Serupane Council' and village='Ha Joang (Mahobong)';
update gii_hierarchy as gh set gh.lat='28.158548', gh.long='-28.955553' where district='LERIBE' and council='Serupane Council' and village='Ha Khojane';
update gii_hierarchy as gh set gh.lat='28.169293', gh.long='-28.954518' where district='LERIBE' and council='Serupane Council' and village='Somololo';
update gii_hierarchy as gh set gh.lat='28.168606', gh.long='-28.958994' where district='LERIBE' and council='Serupane Council' and village='Ha Tlelase (Somololo)';


update gii_hierarchy as gh set gh.lat='28.171352', gh.long='-28.966552' where district='LERIBE' and council='Serupane Council' and village='Naleli';

update gii_hierarchy as gh set gh.lat='28.179812', gh.long='-28.986474' where district='LERIBE' and council='Serupane Council' and village='Makhoaneng';
update gii_hierarchy as gh set gh.lat='28.176976', gh.long='-28.901576' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Machobane';
update gii_hierarchy as gh set gh.lat='28.188562', gh.long='-28.894999' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Ramokoinihi';


update gii_hierarchy as gh set gh.lat='28.20177', gh.long='-28.9097' where district='LERIBE' and council='Malaoaneng Council' and village='Boiketlo (Ha Seetsa)';


update gii_hierarchy as gh set gh.lat='28.196324', gh.long='-28.926816' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Matsoso';
update gii_hierarchy as gh set gh.lat='28.202679', gh.long='-28.924679' where district='LERIBE' and council='Malaoaneng Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.23166', gh.long='-28.78949' where district='LERIBE' and council='Malaoaneng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.202426', gh.long='-28.917742' where district='LERIBE' and council='Malaoaneng Council' and village='Tutulung';
update gii_hierarchy as gh set gh.lat='28.223197', gh.long='-28.905163' where district='LERIBE' and council='Malaoaneng Council' and village='Betha Betha';
update gii_hierarchy as gh set gh.lat='28.217442', gh.long='-28.92325' where district='LERIBE' and council='Malaoaneng Council' and village='Komeng';

update gii_hierarchy as gh set gh.lat='28.226191', gh.long='-28.92778' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Ratulo';
update gii_hierarchy as gh set gh.lat='28.235516', gh.long='-28.934935' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Abiele';
update gii_hierarchy as gh set gh.lat='28.245437', gh.long='-28.936451' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Malefane';
update gii_hierarchy as gh set gh.lat='28.23775', gh.long='-28.939557' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Sepono';
update gii_hierarchy as gh set gh.lat='28.257039', gh.long='-28.943751' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Makhetloane';

update gii_hierarchy as gh set gh.lat='28.2617', gh.long='-28.935366' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Makuka';
update gii_hierarchy as gh set gh.lat='28.269766', gh.long='-28.926225' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Roelane';



update gii_hierarchy as gh set gh.lat='28.579638', gh.long='-29.078518' where district='LERIBE' and council='Malaoaneng Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='28.252026', gh.long='-28.886759' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Ntja';
update gii_hierarchy as gh set gh.lat='28.290906', gh.long='-28.926178' where district='LERIBE' and council='Malaoaneng Council' and village='Ha Chachole';

update gii_hierarchy as gh set gh.lat='28.282793', gh.long='-28.921048' where district='LERIBE' and council='Malaoaneng Council' and village='Shebang';
update gii_hierarchy as gh set gh.lat='28.277337', gh.long='-28.847758' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Hlatsoane';
update gii_hierarchy as gh set gh.lat='28.133192', gh.long='-28.974802' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Makhoa';
update gii_hierarchy as gh set gh.lat='28.282558', gh.long='-28.841057' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Montso';

update gii_hierarchy as gh set gh.lat='28.288719', gh.long='-28.839697' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Thella';
update gii_hierarchy as gh set gh.lat='28.33197', gh.long='-28.857677' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Bokoro';
update gii_hierarchy as gh set gh.lat='28.328065', gh.long='-28.85801' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Jethe';
update gii_hierarchy as gh set gh.lat='28.321043', gh.long='-28.852508' where district='LERIBE' and council='Menkhoaneng Council' and village='Mohlakeng';
update gii_hierarchy as gh set gh.lat='28.317017', gh.long='-28.851119' where district='LERIBE' and council='Menkhoaneng Council' and village='Tsitsa';

update gii_hierarchy as gh set gh.lat='28.307247', gh.long='-28.850052' where district='LERIBE' and council='Menkhoaneng Council' and village='Mokoallong';
update gii_hierarchy as gh set gh.lat='28.152127', gh.long='-29.025592' where district='LERIBE' and council='Menkhoaneng Council' and village='Thoteng';

update gii_hierarchy as gh set gh.lat='28.289449', gh.long='-28.868581' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Leaooa';
update gii_hierarchy as gh set gh.lat='28.294185', gh.long='-28.858259' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Ntsoakele';

update gii_hierarchy as gh set gh.lat='28.285446', gh.long='-28.850589' where district='LERIBE' and council='Menkhoaneng Council' and village='Konkotia';



update gii_hierarchy as gh set gh.lat='28.265154', gh.long='-28.855426' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Khabo';
update gii_hierarchy as gh set gh.lat='28.249236', gh.long='-28.850535' where district='LERIBE' and council='Menkhoaneng Council' and village='Karammele';
update gii_hierarchy as gh set gh.lat='28.232644', gh.long='-28.896898' where district='LERIBE' and council='Menkhoaneng Council' and village='Menkhoaneng';



update gii_hierarchy as gh set gh.lat='28.234314', gh.long='-28.886474' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Peete (Seqhobong)';
update gii_hierarchy as gh set gh.lat='28.245632', gh.long='-28.877732' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Qobete (Litsiphong)';
update gii_hierarchy as gh set gh.lat='28.237057', gh.long='-28.882021' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='28.2493', gh.long='-28.885705' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Letlaka';


update gii_hierarchy as gh set gh.lat='28.253656', gh.long='-28.881162' where district='LERIBE' and council='Menkhoaneng Council' and village='Botsaba';
update gii_hierarchy as gh set gh.lat='28.252026', gh.long='-28.886759' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Ntja';
update gii_hierarchy as gh set gh.lat='28.255659', gh.long='-28.893558' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Khanare';
update gii_hierarchy as gh set gh.lat='28.2753', gh.long='-28.894259' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Seqhoang';
update gii_hierarchy as gh set gh.lat='28.260907', gh.long='-28.880989' where district='LERIBE' and council='Menkhoaneng Council' and village='Hlokoa Le Monate';
update gii_hierarchy as gh set gh.lat='28.259972', gh.long='-28.862626' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Lehloba';

update gii_hierarchy as gh set gh.lat='28.26801', gh.long='-28.866544' where district='LERIBE' and council='Menkhoaneng Council' and village='Mafaleng';
update gii_hierarchy as gh set gh.lat='28.283936', gh.long='-28.865333' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Mamafofo';
update gii_hierarchy as gh set gh.lat='28.277698', gh.long='-28.860868' where district='LERIBE' and council='Menkhoaneng Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.27524', gh.long='-28.866759' where district='LERIBE' and council='Menkhoaneng Council' and village='Makong';
update gii_hierarchy as gh set gh.lat='28.296819', gh.long='-28.868801' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Bolao';
update gii_hierarchy as gh set gh.lat='28.287235', gh.long='-28.873281' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Khati';

update gii_hierarchy as gh set gh.lat='28.303961', gh.long='-28.882711' where district='LERIBE' and council='Menkhoaneng Council' and village='Likileng';

update gii_hierarchy as gh set gh.lat='28.299343', gh.long='-28.890176' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Motsarapane';
update gii_hierarchy as gh set gh.lat='28.311554', gh.long='-28.87978' where district='LERIBE' and council='Menkhoaneng Council' and village='Metolong';
update gii_hierarchy as gh set gh.lat='28.308329', gh.long='-28.875031' where district='LERIBE' and council='Menkhoaneng Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='28.092718', gh.long='-29.003563' where district='LERIBE' and council='Menkhoaneng Council' and village='Mahlabatheng';
update gii_hierarchy as gh set gh.lat='28.315325', gh.long='-28.883552' where district='LERIBE' and council='Menkhoaneng Council' and village='Sebolong';
update gii_hierarchy as gh set gh.lat='28.315726', gh.long='-28.872051' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Leqele';
update gii_hierarchy as gh set gh.lat='28.316401', gh.long='-28.864802' where district='LERIBE' and council='Menkhoaneng Council' and village='Libeleteng';
update gii_hierarchy as gh set gh.lat='28.24251', gh.long='-28.840788' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Loti';

update gii_hierarchy as gh set gh.lat='28.256936', gh.long='-28.829011' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='28.258654', gh.long='-28.843937' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='28.269941', gh.long='-28.826148' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Nkopa';
update gii_hierarchy as gh set gh.lat='28.255032', gh.long='-28.837217' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Sekere';
update gii_hierarchy as gh set gh.lat='28.381842', gh.long='-28.8702' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Pentsi';
update gii_hierarchy as gh set gh.lat='28.352077', gh.long='-28.870271' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Ramabele';
update gii_hierarchy as gh set gh.lat='28.361606', gh.long='-28.866672' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Sepenya';
update gii_hierarchy as gh set gh.lat='28.341375', gh.long='-28.869614' where district='LERIBE' and council='Menkhoaneng Council' and village='Maliba Matso';
update gii_hierarchy as gh set gh.lat='28.335299', gh.long='-28.854921' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Seturumane';
update gii_hierarchy as gh set gh.lat='28.335881', gh.long='-28.871756' where district='LERIBE' and council='Menkhoaneng Council' and village='Kholokoe';

update gii_hierarchy as gh set gh.lat='28.277031', gh.long='-28.877633' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='28.286482', gh.long='-28.885818' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Molotha';
update gii_hierarchy as gh set gh.lat='28.284029', gh.long='-28.879851' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Nkhasi';
update gii_hierarchy as gh set gh.lat='28.291533', gh.long='-28.889431' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Tjotji';
update gii_hierarchy as gh set gh.lat='28.338226', gh.long='-28.903515' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Lesala (Botsola)';
update gii_hierarchy as gh set gh.lat='28.334297', gh.long='-28.906494' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Sebaka (Botsola)';


update gii_hierarchy as gh set gh.lat='28.341134', gh.long='-28.907363' where district='LERIBE' and council='Menkhoaneng Council' and village='Makanyaneng';

update gii_hierarchy as gh set gh.lat='28.353519', gh.long='-28.906544' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Lekhoele';
update gii_hierarchy as gh set gh.lat='28.349252', gh.long='-28.91148' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Lika';
update gii_hierarchy as gh set gh.lat='28.347549', gh.long='-28.905495' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Moahloli';

update gii_hierarchy as gh set gh.lat='28.374525', gh.long='-28.904153' where district='LERIBE' and council='Menkhoaneng Council' and village='Masianokeng';

update gii_hierarchy as gh set gh.lat='28.34373', gh.long='-28.921786' where district='LERIBE' and council='Menkhoaneng Council' and village='Teraeshareng';
update gii_hierarchy as gh set gh.lat='28.361018', gh.long='-28.937493' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Makepe';
update gii_hierarchy as gh set gh.lat='28.393412', gh.long='-28.927531' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Mali';

update gii_hierarchy as gh set gh.lat='28.384196', gh.long='-28.923684' where district='LERIBE' and council='Menkhoaneng Council' and village='Thoteng (Ha Mali)';
update gii_hierarchy as gh set gh.lat='28.243934', gh.long='-28.742264' where district='LERIBE' and council='Lipelaneng Council' and village='Khapung';
update gii_hierarchy as gh set gh.lat='28.221445', gh.long='-28.747575' where district='LERIBE' and council='Lipelaneng Council' and village='Ha Qoati';
update gii_hierarchy as gh set gh.lat='28.232351', gh.long='-28.743481' where district='LERIBE' and council='Lipelaneng Council' and village='Masaleng';

update gii_hierarchy as gh set gh.lat='28.243274', gh.long='-28.754309' where district='LERIBE' and council='Lipelaneng Council' and village='Ha Koabeng (Mabothile)';
update gii_hierarchy as gh set gh.lat='28.241049', gh.long='-28.761043' where district='LERIBE' and council='Lipelaneng Council' and village='Mabothile';
update gii_hierarchy as gh set gh.lat='28.234159', gh.long='-28.769357' where district='LERIBE' and council='Lipelaneng Council' and village='Thoteng (Ha Shepeseli)';
update gii_hierarchy as gh set gh.lat='28.221482', gh.long='-28.758657' where district='LERIBE' and council='Lipelaneng Council' and village='Mamohololi';



update gii_hierarchy as gh set gh.lat='28.236632', gh.long='-28.777975' where district='LERIBE' and council='Lipelaneng Council' and village='Ha Mokete';

update gii_hierarchy as gh set gh.lat='28.230822', gh.long='-28.783315' where district='LERIBE' and council='Lipelaneng Council' and village='Ha Shepeseli';




update gii_hierarchy as gh set gh.lat='28.250347', gh.long='-28.800037' where district='LERIBE' and council='Lipelaneng Council' and village='Ha Mapape (Mekhotlong)';



update gii_hierarchy as gh set gh.lat='28.20273', gh.long='-28.717679' where district='LERIBE' and council='Maisa Phoka Council' and village='Futhong';
update gii_hierarchy as gh set gh.lat='28.208609', gh.long='-28.711917' where district='LERIBE' and council='Maisa Phoka Council' and village='Linokong';
update gii_hierarchy as gh set gh.lat='28.214028', gh.long='-28.730735' where district='LERIBE' and council='Maisa Phoka Council' and village='Thotaneng (Liphofung)';
update gii_hierarchy as gh set gh.lat='28.210764', gh.long='-28.726918' where district='LERIBE' and council='Maisa Phoka Council' and village='Letsoapong (Liphofung)';

update gii_hierarchy as gh set gh.lat='28.189584', gh.long='-28.79149' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Molapo';

update gii_hierarchy as gh set gh.lat='28.17228', gh.long='-28.73265' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Thaba';




update gii_hierarchy as gh set gh.lat='28.203478', gh.long='-28.752899' where district='LERIBE' and council='Maisa Phoka Council' and village='Matlakeng';
update gii_hierarchy as gh set gh.lat='28.188078', gh.long='-28.747021' where district='LERIBE' and council='Maisa Phoka Council' and village='Mohlanapeng';

update gii_hierarchy as gh set gh.lat='28.199929', gh.long='-28.74559' where district='LERIBE' and council='Maisa Phoka Council' and village='Kotope';
update gii_hierarchy as gh set gh.lat='28.2014', gh.long='-28.76111' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Totoloane';



update gii_hierarchy as gh set gh.lat='28.20649', gh.long='-28.791115' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Makakamela (Nkoeng)';

update gii_hierarchy as gh set gh.lat='28.195903', gh.long='-28.792756' where district='LERIBE' and council='Maisa Phoka Council' and village='Thotaneng';
update gii_hierarchy as gh set gh.lat='28.20101', gh.long='-28.794485' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Mokotjo';

update gii_hierarchy as gh set gh.lat='28.214843', gh.long='-28.794127' where district='LERIBE' and council='Maisa Phoka Council' and village='Taung (Ha Rampai)';

update gii_hierarchy as gh set gh.lat='28.212633', gh.long='-28.805717' where district='LERIBE' and council='Maisa Phoka Council' and village='Literapeng';

update gii_hierarchy as gh set gh.lat='28.229904', gh.long='-28.819966' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Libenyane';
update gii_hierarchy as gh set gh.lat='28.224904', gh.long='-28.824973' where district='LERIBE' and council='Maisa Phoka Council' and village='Makhasane';
update gii_hierarchy as gh set gh.lat='28.218328', gh.long='-28.824623' where district='LERIBE' and council='Maisa Phoka Council' and village='Metsoaneng';
update gii_hierarchy as gh set gh.lat='28.308329', gh.long='-28.875031' where district='LERIBE' and council='Maisa Phoka Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='28.213164', gh.long='-28.82901' where district='LERIBE' and council='Maisa Phoka Council' and village='Ha Motsoane';

update gii_hierarchy as gh set gh.lat='28.240297', gh.long='-28.851901' where district='LERIBE' and council='Maisa Phoka Council' and village='Maruatona';

update gii_hierarchy as gh set gh.lat='28.198176', gh.long='-28.86429' where district='LERIBE' and council='Menkhoaneng Council' and village='Lifoleing (Mabokong)';
update gii_hierarchy as gh set gh.lat='28.197789', gh.long='-28.847672' where district='LERIBE' and council='Menkhoaneng Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='28.203543', gh.long='-28.853335' where district='LERIBE' and council='Menkhoaneng Council' and village='Liphaleng';
update gii_hierarchy as gh set gh.lat='28.222977', gh.long='-28.866699' where district='LERIBE' and council='Menkhoaneng Council' and village='Hata Butle';

update gii_hierarchy as gh set gh.lat='28.209644', gh.long='-28.857648' where district='LERIBE' and council='Menkhoaneng Council' and village='Mabokong';
update gii_hierarchy as gh set gh.lat='28.220513', gh.long='-28.857319' where district='LERIBE' and council='Menkhoaneng Council' and village='Phelandaba';


update gii_hierarchy as gh set gh.lat='28.21136', gh.long='-28.866588' where district='LERIBE' and council='Menkhoaneng Council' and village='Ha Selebalo (Mate)';
update gii_hierarchy as gh set gh.lat='28.128957', gh.long='-28.75715' where district='LERIBE' and council='Sephokong Council' and village='Ha Setjeo (Pote)';
update gii_hierarchy as gh set gh.lat='28.136085', gh.long='-28.753309' where district='LERIBE' and council='Sephokong Council' and village='Tlokoeng (Nqechane)';
update gii_hierarchy as gh set gh.lat='28.145413', gh.long='-28.764075' where district='LERIBE' and council='Sephokong Council' and village='Ha Au';

update gii_hierarchy as gh set gh.lat='28.160465', gh.long='-28.747212' where district='LERIBE' and council='Sephokong Council' and village='Ha Mothibe';
update gii_hierarchy as gh set gh.lat='28.161757', gh.long='-28.737404' where district='LERIBE' and council='Sephokong Council' and village='Ha Phooko';





update gii_hierarchy as gh set gh.lat='28.163518', gh.long='-28.803744' where district='LERIBE' and council='Sephokong Council' and village='Levis Nek';

update gii_hierarchy as gh set gh.lat='28.141828', gh.long='-28.791674' where district='LERIBE' and council='Sephokong Council' and village='Ha Bolofo';
update gii_hierarchy as gh set gh.lat='28.145058', gh.long='-28.781087' where district='LERIBE' and council='Sephokong Council' and village='Molikaliko (Ha Mothetsi)';
update gii_hierarchy as gh set gh.lat='28.123687', gh.long='-28.768913' where district='LERIBE' and council='Sephokong Council' and village='Ha Lelahla';
update gii_hierarchy as gh set gh.lat='28.127614', gh.long='-28.776178' where district='LERIBE' and council='Sephokong Council' and village='Ha Mothetsi';
update gii_hierarchy as gh set gh.lat='28.124803', gh.long='-28.783866' where district='LERIBE' and council='Sephokong Council' and village='Ha Sera (Ha Mamanyatsa)';

update gii_hierarchy as gh set gh.lat='28.112497', gh.long='-28.783758' where district='LERIBE' and council='Sephokong Council' and village='Ha Topisi';



update gii_hierarchy as gh set gh.lat='28.125128', gh.long='-28.794097' where district='LERIBE' and council='Sephokong Council' and village='Maiseng';
update gii_hierarchy as gh set gh.lat='28.115592', gh.long='-28.792744' where district='LERIBE' and council='Sephokong Council' and village='Mohlomong';

update gii_hierarchy as gh set gh.lat='28.170298', gh.long='-28.816305' where district='LERIBE' and council='Sephokong Council' and village='Ha Nkhasi (Matsoaing)';
update gii_hierarchy as gh set gh.lat='28.178055', gh.long='-28.824992' where district='LERIBE' and council='Sephokong Council' and village='Mabuleng';
update gii_hierarchy as gh set gh.lat='28.199174', gh.long='-28.826887' where district='LERIBE' and council='Sephokong Council' and village='Boribeng';
update gii_hierarchy as gh set gh.lat='28.190842', gh.long='-28.81067' where district='LERIBE' and council='Sephokong Council' and village='Tale';
update gii_hierarchy as gh set gh.lat='28.194637', gh.long='-28.830091' where district='LERIBE' and council='Sephokong Council' and village='Ha Maraisane (Boribeng)';
update gii_hierarchy as gh set gh.lat='28.185267', gh.long='-28.833401' where district='LERIBE' and council='Sephokong Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='28.18071', gh.long='-28.839105' where district='LERIBE' and council='Sephokong Council' and village='Ha Thinyane';
update gii_hierarchy as gh set gh.lat='28.19766', gh.long='-28.833693' where district='LERIBE' and council='Sephokong Council' and village='Machoaboleng';

update gii_hierarchy as gh set gh.lat='28.145444', gh.long='-28.823726' where district='LERIBE' and council='Sephokong Council' and village='Chafo';
update gii_hierarchy as gh set gh.lat='28.165173', gh.long='-28.835933' where district='LERIBE' and council='Sephokong Council' and village='Ha Moshephe';
update gii_hierarchy as gh set gh.lat='28.119917', gh.long='-28.825101' where district='LERIBE' and council='Sephokong Council' and village='Ha Ramabanta (Moneseng)';
update gii_hierarchy as gh set gh.lat='28.11795', gh.long='-28.820835' where district='LERIBE' and council='Sephokong Council' and village='Ha Tlhako';
update gii_hierarchy as gh set gh.lat='28.116114', gh.long='-28.815818' where district='LERIBE' and council='Sephokong Council' and village='Phelandaba';
update gii_hierarchy as gh set gh.lat='28.092222', gh.long='-28.82159' where district='LERIBE' and council='Sephokong Council' and village='Ha Mosiuoa';
update gii_hierarchy as gh set gh.lat='28.079111', gh.long='-28.826658' where district='LERIBE' and council='Sephokong Council' and village='Ha Simone';


update gii_hierarchy as gh set gh.lat='28.034382', gh.long='-28.949101' where district='LERIBE' and council='Sephokong Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.099036', gh.long='-28.838727' where district='LERIBE' and council='Sephokong Council' and village='Ha Mohapi';
update gii_hierarchy as gh set gh.lat='28.109538', gh.long='-28.831118' where district='LERIBE' and council='Sephokong Council' and village='Ha Tota';
update gii_hierarchy as gh set gh.lat='28.118923', gh.long='-28.834743' where district='LERIBE' and council='Sephokong Council' and village='Ha Tsielala';
update gii_hierarchy as gh set gh.lat='28.125964', gh.long='-28.833247' where district='LERIBE' and council='Sephokong Council' and village='Ha Matau (Lithabaneng)';
update gii_hierarchy as gh set gh.lat='28.129631', gh.long='-28.846413' where district='LERIBE' and council='Sephokong Council' and village='Ha Lehlaha';
update gii_hierarchy as gh set gh.lat='28.128593', gh.long='-28.854244' where district='LERIBE' and council='Sephokong Council' and village='Ha Popa';
update gii_hierarchy as gh set gh.lat='28.119726', gh.long='-28.851345' where district='LERIBE' and council='Sephokong Council' and village='Ha Ralefepo';
update gii_hierarchy as gh set gh.lat='28.136619', gh.long='-28.855432' where district='LERIBE' and council='Sephokong Council' and village='Ha Letsola Thebe';

update gii_hierarchy as gh set gh.lat='28.193821', gh.long='-29.041666' where district='LERIBE' and council='Sephokong Council' and village='Ha Mokhachane';
update gii_hierarchy as gh set gh.lat='28.181799', gh.long='-28.854606' where district='LERIBE' and council='Sephokong Council' and village='Litlhokoaneng';

update gii_hierarchy as gh set gh.lat='28.184118', gh.long='-28.877305' where district='LERIBE' and council='Sephokong Council' and village='Ha Mokhosi (Papalala)';
update gii_hierarchy as gh set gh.lat='28.190173', gh.long='-28.858381' where district='LERIBE' and council='Sephokong Council' and village='Ha Mosisi';
update gii_hierarchy as gh set gh.lat='28.1735', gh.long='-28.871602' where district='LERIBE' and council='Sephokong Council' and village='Ha Motseki';

update gii_hierarchy as gh set gh.lat='28.069666', gh.long='-28.817564' where district='LERIBE' and council='Linare Council' and village='Ha Ntsutsu';
update gii_hierarchy as gh set gh.lat='28.05777', gh.long='-28.836127' where district='LERIBE' and council='Linare Council' and village='Ha Patlo';

update gii_hierarchy as gh set gh.lat='28.062921', gh.long='-28.841602' where district='LERIBE' and council='Linare Council' and village='Thabana Ea Matsa';
update gii_hierarchy as gh set gh.lat='28.056847', gh.long='-28.841807' where district='LERIBE' and council='Linare Council' and village='Ha Tsotelo';
update gii_hierarchy as gh set gh.lat='28.050007', gh.long='-28.849589' where district='LERIBE' and council='Linare Council' and village='Ha Molibeli';

update gii_hierarchy as gh set gh.lat='28.054186', gh.long='-28.858548' where district='LERIBE' and council='Linare Council' and village='Temong';

update gii_hierarchy as gh set gh.lat='28.077181', gh.long='-28.848334' where district='LERIBE' and council='Linare Council' and village='Ha Monki';
update gii_hierarchy as gh set gh.lat='28.099106', gh.long='-28.859433' where district='LERIBE' and council='Linare Council' and village='Ha Matata';
update gii_hierarchy as gh set gh.lat='28.555718', gh.long='-29.070889' where district='LERIBE' and council='Linare Council' and village='Masaleng';





update gii_hierarchy as gh set gh.lat='28.038566', gh.long='-28.867198' where district='LERIBE' and council='Linare Council' and village='Mankoaneng';

update gii_hierarchy as gh set gh.lat='28.072183', gh.long='-28.867018' where district='LERIBE' and council='Linare Council' and village='Ha Mphuthing (Sebothoane)';
update gii_hierarchy as gh set gh.lat='28.143907', gh.long='-28.885722' where district='LERIBE' and council='Linare Council' and village='Ha Molatoli (Khobotlong)';
update gii_hierarchy as gh set gh.lat='28.157457', gh.long='-28.884292' where district='LERIBE' and council='Linare Council' and village='Ha Setsumi';
update gii_hierarchy as gh set gh.lat='28.137907', gh.long='-28.879477' where district='LERIBE' and council='Linare Council' and village='Ha Tiela';
update gii_hierarchy as gh set gh.lat='28.17155', gh.long='-28.880097' where district='LERIBE' and council='Linare Council' and village='Ha Kheola';
update gii_hierarchy as gh set gh.lat='28.167341', gh.long='-28.885868' where district='LERIBE' and council='Linare Council' and village='Ha Lepoqo';
update gii_hierarchy as gh set gh.lat='28.13083', gh.long='-28.889238' where district='LERIBE' and council='Linare Council' and village='Ha Kampa';
update gii_hierarchy as gh set gh.lat='28.140983', gh.long='-28.895712' where district='LERIBE' and council='Linare Council' and village='Ha Khoarai';



update gii_hierarchy as gh set gh.lat='28.1264', gh.long='-28.874571' where district='LERIBE' and council='Linare Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='28.132237', gh.long='-28.872942' where district='LERIBE' and council='Linare Council' and village='Ha Sekota';

update gii_hierarchy as gh set gh.lat='28.093591', gh.long='-28.872156' where district='LERIBE' and council='Linare Council' and village='Fothane';
update gii_hierarchy as gh set gh.lat='28.104689', gh.long='-28.877242' where district='LERIBE' and council='Linare Council' and village='Khokhotsaneng (Khanyane)';
update gii_hierarchy as gh set gh.lat='28.109511', gh.long='-28.88825' where district='LERIBE' and council='Linare Council' and village='Borantisi (Khanyane)';


update gii_hierarchy as gh set gh.lat='28.102019', gh.long='-28.892138' where district='LERIBE' and council='Linare Council' and village='Ha Phephetho (Khanyane)';
update gii_hierarchy as gh set gh.lat='28.099625', gh.long='-28.885356' where district='LERIBE' and council='Linare Council' and village='Ha Moliboea (Khanyane)';

update gii_hierarchy as gh set gh.lat='28.099345', gh.long='-28.902985' where district='LERIBE' and council='Linare Council' and village='Ha Mokoko';
update gii_hierarchy as gh set gh.lat='28.084636', gh.long='-28.875335' where district='LERIBE' and council='Linare Council' and village='Konkotia (Khanyane)';
update gii_hierarchy as gh set gh.lat='28.105368', gh.long='-28.883414' where district='LERIBE' and council='Linare Council' and village='Ntloana Tsoana (Khanyane)';


update gii_hierarchy as gh set gh.lat='27.982667', gh.long='-28.944166' where district='LERIBE' and council='Litjotjela Council' and village='Ha Ntholi';
update gii_hierarchy as gh set gh.lat='27.976456', gh.long='-28.946572' where district='LERIBE' and council='Litjotjela Council' and village='Ha Setho (Muela)';
update gii_hierarchy as gh set gh.lat='27.994817', gh.long='-28.951171' where district='LERIBE' and council='Litjotjela Council' and village='Mankhololi';

update gii_hierarchy as gh set gh.lat='27.970559', gh.long='-28.946841' where district='LERIBE' and council='Litjotjela Council' and village='Ha Morolong (Muela)';
update gii_hierarchy as gh set gh.lat='27.970368', gh.long='-28.925389' where district='LERIBE' and council='Litjotjela Council' and village='Ha Pitere';



update gii_hierarchy as gh set gh.lat='27.981704', gh.long='-28.905432' where district='LERIBE' and council='Litjotjela Council' and village='Hloahloeng (Ha Poulo)';
update gii_hierarchy as gh set gh.lat='27.97113', gh.long='-28.89591' where district='LERIBE' and council='Litjotjela Council' and village='Ha Motetepa';
update gii_hierarchy as gh set gh.lat='27.974437', gh.long='-28.890963' where district='LERIBE' and council='Litjotjela Council' and village='Ha Lechesa';

update gii_hierarchy as gh set gh.lat='27.991798', gh.long='-28.895675' where district='LERIBE' and council='Litjotjela Council' and village='Tsikoane';
update gii_hierarchy as gh set gh.lat='27.991283', gh.long='-28.888349' where district='LERIBE' and council='Litjotjela Council' and village='Ha Potloane (Tsikoane)';
update gii_hierarchy as gh set gh.lat='28.008234', gh.long='-28.886261' where district='LERIBE' and council='Litjotjela Council' and village='Leralleng';
update gii_hierarchy as gh set gh.lat='28.000179', gh.long='-28.892294' where district='LERIBE' and council='Litjotjela Council' and village='Ha Nyarela (Tsikoane)';
update gii_hierarchy as gh set gh.lat='28.010225', gh.long='-28.895189' where district='LERIBE' and council='Litjotjela Council' and village='Leqhutsung (Moreneng)';
update gii_hierarchy as gh set gh.lat='28.092718', gh.long='-29.003563' where district='LERIBE' and council='Litjotjela Council' and village='Mahlabatheng';



update gii_hierarchy as gh set gh.lat='28.023136', gh.long='-28.907765' where district='LERIBE' and council='Litjotjela Council' and village='Ha Letuka (Matukeng)';
update gii_hierarchy as gh set gh.lat='27.998277', gh.long='-28.917104' where district='LERIBE' and council='Litjotjela Council' and village='Ha Nthako';
update gii_hierarchy as gh set gh.lat='28.004329', gh.long='-28.921644' where district='LERIBE' and council='Litjotjela Council' and village='Maebeng';
update gii_hierarchy as gh set gh.lat='28.021917', gh.long='-28.930006' where district='LERIBE' and council='Litjotjela Council' and village='Linotsing (Ha Mokokoana)';


update gii_hierarchy as gh set gh.lat='28.025272', gh.long='-28.923536' where district='LERIBE' and council='Litjotjela Council' and village='Ha Eti (Linotsing)';
update gii_hierarchy as gh set gh.lat='28.03074', gh.long='-28.916357' where district='LERIBE' and council='Litjotjela Council' and village='Ha Lesala';

update gii_hierarchy as gh set gh.lat='28.034382', gh.long='-28.949101' where district='LERIBE' and council='Litjotjela Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.06345', gh.long='-28.937251' where district='LERIBE' and council='Litjotjela Council' and village='Ha Mpopo';


update gii_hierarchy as gh set gh.lat='28.043616', gh.long='-28.906074' where district='LERIBE' and council='Litjotjela Council' and village='Ha Morolong (Likhakeng)';


update gii_hierarchy as gh set gh.lat='28.058059', gh.long='-28.88914' where district='LERIBE' and council='Litjotjela Council' and village='Ha Ranku (Mapheaneng)';
update gii_hierarchy as gh set gh.lat='28.065126', gh.long='-28.884408' where district='LERIBE' and council='Litjotjela Council' and village='Ha Potso (Lipelaneng)';
update gii_hierarchy as gh set gh.lat='28.073428', gh.long='-28.892543' where district='LERIBE' and council='Litjotjela Council' and village='Ha Jane (Boinyatso)';
update gii_hierarchy as gh set gh.lat='28.075545', gh.long='-28.883442' where district='LERIBE' and council='Litjotjela Council' and village='Ha Mohlolo (Ha Molupe)';

update gii_hierarchy as gh set gh.lat='28.050288', gh.long='-28.895352' where district='LERIBE' and council='Litjotjela Council' and village='Ha Leshoele';
update gii_hierarchy as gh set gh.lat='28.072197', gh.long='-28.922404' where district='LERIBE' and council='Litjotjela Council' and village='Bothoba Pelo';
update gii_hierarchy as gh set gh.lat='28.075554', gh.long='-28.935243' where district='LERIBE' and council='Litjotjela Council' and village='Ha Hoki';
update gii_hierarchy as gh set gh.lat='28.069783', gh.long='-28.931929' where district='LERIBE' and council='Litjotjela Council' and village='Ha Sebe';
update gii_hierarchy as gh set gh.lat='28.070597', gh.long='-28.938328' where district='LERIBE' and council='Litjotjela Council' and village='Ha Sekoto';

update gii_hierarchy as gh set gh.lat='28.074182', gh.long='-28.945332' where district='LERIBE' and council='Litjotjela Council' and village='Ha Libe';
update gii_hierarchy as gh set gh.lat='28.076685', gh.long='-28.953473' where district='LERIBE' and council='Litjotjela Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='28.065363', gh.long='-28.963118' where district='LERIBE' and council='Litjotjela Council' and village='Ha Qokolo';
update gii_hierarchy as gh set gh.lat='28.057067', gh.long='-28.962882' where district='LERIBE' and council='Litjotjela Council' and village='Ha Peete';
update gii_hierarchy as gh set gh.lat='28.217921', gh.long='-28.706428' where district='LERIBE' and council='Litjotjela Council' and village='Ha Mojapela';
update gii_hierarchy as gh set gh.lat='28.025588', gh.long='-28.961621' where district='LERIBE' and council='Litjotjela Council' and village='Ha Tsupane';

update gii_hierarchy as gh set gh.lat='27.891575', gh.long='-28.887674' where district='LERIBE' and council='Khomokhoana Council' and village='Khomo Lia Oela';
update gii_hierarchy as gh set gh.lat='27.901285', gh.long='-28.889636' where district='LERIBE' and council='Khomokhoana Council' and village='Maputsoe';

update gii_hierarchy as gh set gh.lat='27.9077', gh.long='-28.895511' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Chonapase';



update gii_hierarchy as gh set gh.lat='27.919434', gh.long='-28.902673' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Nyenye';

update gii_hierarchy as gh set gh.lat='27.899041', gh.long='-28.883006' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Moholisa';
update gii_hierarchy as gh set gh.lat='27.90665', gh.long='-28.886774' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Motlalehi';


update gii_hierarchy as gh set gh.lat='27.921087', gh.long='-28.883328' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Mathata';


update gii_hierarchy as gh set gh.lat='27.919747', gh.long='-28.868762' where district='LERIBE' and council='Khomokhoana Council' and village='Matikiring';
update gii_hierarchy as gh set gh.lat='27.923044', gh.long='-28.877776' where district='LERIBE' and council='Khomokhoana Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='27.930223', gh.long='-28.863054' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Chaka';
update gii_hierarchy as gh set gh.lat='27.950322', gh.long='-28.859531' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Kena';
update gii_hierarchy as gh set gh.lat='27.958291', gh.long='-28.865739' where district='LERIBE' and council='Khomokhoana Council' and village='Ha Matsoete';

update gii_hierarchy as gh set gh.lat='27.953897', gh.long='-28.890377' where district='LERIBE' and council='Khomokhoana Council' and village='Popopo';

update gii_hierarchy as gh set gh.lat='27.919434', gh.long='-28.902673' where district='LERIBE' and council='Hleoheng Council' and village='Ha Nyenye';


update gii_hierarchy as gh set gh.lat='27.913067', gh.long='-28.922757' where district='LERIBE' and council='Hleoheng Council' and village='Ha Maqele';

update gii_hierarchy as gh set gh.lat='27.955103', gh.long='-28.906633' where district='LERIBE' and council='Hleoheng Council' and village='Ha Barete (St Monicas)';


update gii_hierarchy as gh set gh.lat='27.963513', gh.long='-28.918283' where district='LERIBE' and council='Hleoheng Council' and village='Ha Jeremia (St Monicas)';
update gii_hierarchy as gh set gh.lat='27.96264', gh.long='-28.936914' where district='LERIBE' and council='Hleoheng Council' and village='Ha Lepamo';
update gii_hierarchy as gh set gh.lat='27.964071', gh.long='-28.927746' where district='LERIBE' and council='Hleoheng Council' and village='Ha Phatsoane';
update gii_hierarchy as gh set gh.lat='27.963827', gh.long='-28.950154' where district='LERIBE' and council='Hleoheng Council' and village='Ha Taemane';


update gii_hierarchy as gh set gh.lat='27.947949', gh.long='-28.954267' where district='LERIBE' and council='Hleoheng Council' and village='Ha Sethubatha';
update gii_hierarchy as gh set gh.lat='27.943766', gh.long='-28.949358' where district='LERIBE' and council='Hleoheng Council' and village='Qetsolane';



update gii_hierarchy as gh set gh.lat='27.914963', gh.long='-28.929816' where district='LERIBE' and council='Hleoheng Council' and village='Ha Polaki';
update gii_hierarchy as gh set gh.lat='27.896858', gh.long='-28.935984' where district='LERIBE' and council='Hleoheng Council' and village='Ha Ralikuku';

update gii_hierarchy as gh set gh.lat='27.85827', gh.long='-28.93133' where district='LERIBE' and council='Hleoheng Council' and village='Ntsirele (Hleoheng)';
update gii_hierarchy as gh set gh.lat='27.874682', gh.long='-28.940697' where district='LERIBE' and council='Hleoheng Council' and village='Likotjaneng (Hleoheng)';
update gii_hierarchy as gh set gh.lat='27.883719', gh.long='-28.960958' where district='LERIBE' and council='Hleoheng Council' and village='Mafika Lisiu';

update gii_hierarchy as gh set gh.lat='27.892212', gh.long='-28.962958' where district='LERIBE' and council='Hleoheng Council' and village='Ha Tumo';
update gii_hierarchy as gh set gh.lat='27.726556', gh.long='-29.089277' where district='LERIBE' and council='Hleoheng Council' and village='Ha Mokati';
update gii_hierarchy as gh set gh.lat='27.944397', gh.long='-28.956445' where district='LERIBE' and council='Hleoheng Council' and village='Ha Sepinare (Likhetlane)';
update gii_hierarchy as gh set gh.lat='27.950235', gh.long='-28.961371' where district='LERIBE' and council='Hleoheng Council' and village='Mahabalibaka';
update gii_hierarchy as gh set gh.lat='27.966189', gh.long='-28.957284' where district='LERIBE' and council='Hleoheng Council' and village='Ha Rapetlonyane';

update gii_hierarchy as gh set gh.lat='27.940671', gh.long='-28.965099' where district='LERIBE' and council='Hleoheng Council' and village='Ha Takalimane (Likhetlane)';

update gii_hierarchy as gh set gh.lat='27.938201', gh.long='-28.970722' where district='LERIBE' and council='Hleoheng Council' and village='Ha Ntebele (Likhetlane)';


update gii_hierarchy as gh set gh.lat='27.939592', gh.long='-28.990666' where district='LERIBE' and council='Hleoheng Council' and village='Tlapaneng';

update gii_hierarchy as gh set gh.lat='27.900366', gh.long='-28.985971' where district='LERIBE' and council='Hleoheng Council' and village='Ha Mothamahane';
update gii_hierarchy as gh set gh.lat='27.902566', gh.long='-28.997689' where district='LERIBE' and council='Hleoheng Council' and village='Ha Mongali';
update gii_hierarchy as gh set gh.lat='27.909121', gh.long='-29.02322' where district='LERIBE' and council='Hleoheng Council' and village='Ha Qamo';
update gii_hierarchy as gh set gh.lat='27.90587', gh.long='-29.030392' where district='LERIBE' and council='Hleoheng Council' and village='Ha Mathapolane';
update gii_hierarchy as gh set gh.lat='27.916543', gh.long='-29.033429' where district='LERIBE' and council='Hleoheng Council' and village='Ha Senei';
update gii_hierarchy as gh set gh.lat='27.923924', gh.long='-29.027487' where district='LERIBE' and council='Hleoheng Council' and village='Ha Mafata';
update gii_hierarchy as gh set gh.lat='27.931849', gh.long='-29.032758' where district='LERIBE' and council='Hleoheng Council' and village='Ha Matumo';
update gii_hierarchy as gh set gh.lat='27.927303', gh.long='-29.007789' where district='LERIBE' and council='Hleoheng Council' and village='Ha Akabe';
update gii_hierarchy as gh set gh.lat='27.937621', gh.long='-29.007581' where district='LERIBE' and council='Hleoheng Council' and village='Ha Matasane';
update gii_hierarchy as gh set gh.lat='27.920525', gh.long='-29.012966' where district='LERIBE' and council='Hleoheng Council' and village='Ha Ramoruti';
update gii_hierarchy as gh set gh.lat='27.732056', gh.long='-28.958365' where district='LERIBE' and council='Manka Council' and village='Ha Musi';


update gii_hierarchy as gh set gh.lat='27.755766', gh.long='-28.970223' where district='LERIBE' and council='Manka Council' and village='Ha Leburu (Peka)';
update gii_hierarchy as gh set gh.lat='27.762444', gh.long='-28.964863' where district='LERIBE' and council='Manka Council' and village='Masaleng (Peka)';
update gii_hierarchy as gh set gh.lat='27.768916', gh.long='-28.963565' where district='LERIBE' and council='Manka Council' and village='Motimposo (Peka)';

update gii_hierarchy as gh set gh.lat='27.974437', gh.long='-28.890963' where district='LERIBE' and council='Manka Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='27.777464', gh.long='-28.968281' where district='LERIBE' and council='Manka Council' and village='Ha Tjopa';

update gii_hierarchy as gh set gh.lat='27.779605', gh.long='-28.980699' where district='LERIBE' and council='Manka Council' and village='Ha Napo';
update gii_hierarchy as gh set gh.lat='27.768251', gh.long='-28.926348' where district='LERIBE' and council='Manka Council' and village='Ha Rantuba';
update gii_hierarchy as gh set gh.lat='27.771718', gh.long='-28.906729' where district='LERIBE' and council='Manka Council' and village='Ha Ramochana';
update gii_hierarchy as gh set gh.lat='27.797031', gh.long='-28.921076' where district='LERIBE' and council='Manka Council' and village='Ha Motlau';
update gii_hierarchy as gh set gh.lat='27.813588', gh.long='-28.923269' where district='LERIBE' and council='Manka Council' and village='Ha Masakale';
update gii_hierarchy as gh set gh.lat='27.80258', gh.long='-28.928818' where district='LERIBE' and council='Manka Council' and village='Ha Ramosalla';
update gii_hierarchy as gh set gh.lat='27.825606', gh.long='-28.936045' where district='LERIBE' and council='Manka Council' and village='Ha Lepholisa';
update gii_hierarchy as gh set gh.lat='27.829246', gh.long='-28.917728' where district='LERIBE' and council='Manka Council' and village='Ha Patsa';
update gii_hierarchy as gh set gh.lat='27.848665', gh.long='-28.934636' where district='LERIBE' and council='Manka Council' and village='Ha Kotola';
update gii_hierarchy as gh set gh.lat='27.845453', gh.long='-28.917899' where district='LERIBE' and council='Manka Council' and village='Ha Monyane';
update gii_hierarchy as gh set gh.lat='27.850538', gh.long='-28.942325' where district='LERIBE' and council='Manka Council' and village='Ha Keenya';
update gii_hierarchy as gh set gh.lat='27.853519', gh.long='-28.949243' where district='LERIBE' and council='Manka Council' and village='Ha Makoae (Liphakoeng)';
update gii_hierarchy as gh set gh.lat='27.846013', gh.long='-28.956405' where district='LERIBE' and council='Manka Council' and village='Ha Monnanyane';
update gii_hierarchy as gh set gh.lat='27.877997', gh.long='-28.96994' where district='LERIBE' and council='Manka Council' and village='Ha Mabote';
update gii_hierarchy as gh set gh.lat='28.070198', gh.long='-28.859115' where district='LERIBE' and council='Manka Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='27.891257', gh.long='-28.974864' where district='LERIBE' and council='Manka Council' and village='Ha Hlaname';
update gii_hierarchy as gh set gh.lat='27.888305', gh.long='-28.995039' where district='LERIBE' and council='Manka Council' and village='Ha Mosamo';
update gii_hierarchy as gh set gh.lat='27.887337', gh.long='-28.986639' where district='LERIBE' and council='Manka Council' and village='Ha Ramohapi';
update gii_hierarchy as gh set gh.lat='27.890403', gh.long='-29.009427' where district='LERIBE' and council='Manka Council' and village='Ha Malebo';
update gii_hierarchy as gh set gh.lat='27.89573', gh.long='-29.000846' where district='LERIBE' and council='Manka Council' and village='Ha Ralebona';
update gii_hierarchy as gh set gh.lat='27.866794', gh.long='-28.978788' where district='LERIBE' and council='Manka Council' and village='Ha Mokhoro';



update gii_hierarchy as gh set gh.lat='28.288442', gh.long='-28.956275' where district='LERIBE' and council='Manka Council' and village='Ha Fako';

update gii_hierarchy as gh set gh.lat='27.830087', gh.long='-28.974703' where district='LERIBE' and council='Manka Council' and village='Ha Marana';
update gii_hierarchy as gh set gh.lat='27.830041', gh.long='-28.980348' where district='LERIBE' and council='Manka Council' and village='Ha Tsiea';
update gii_hierarchy as gh set gh.lat='27.819617', gh.long='-28.985178' where district='LERIBE' and council='Manka Council' and village='Ha Foka';
update gii_hierarchy as gh set gh.lat='27.832496', gh.long='-29.000343' where district='LERIBE' and council='Manka Council' and village='Ha Liteboho';
update gii_hierarchy as gh set gh.lat='27.846929', gh.long='-28.988163' where district='LERIBE' and council='Manka Council' and village='Ha Rantho';
update gii_hierarchy as gh set gh.lat='27.810131', gh.long='-28.999849' where district='LERIBE' and council='Manka Council' and village='Ha Mpeke';
update gii_hierarchy as gh set gh.lat='27.797501', gh.long='-28.998915' where district='LERIBE' and council='Manka Council' and village='Ha Thipane';
update gii_hierarchy as gh set gh.lat='27.816245', gh.long='-29.00549' where district='LERIBE' and council='Manka Council' and village='Ha Letsika';
update gii_hierarchy as gh set gh.lat='27.821276', gh.long='-29.007391' where district='LERIBE' and council='Manka Council' and village='Ha Ralikariki';
update gii_hierarchy as gh set gh.lat='27.83494', gh.long='-29.011268' where district='LERIBE' and council='Manka Council' and village='Ha Ntahli';
update gii_hierarchy as gh set gh.lat='27.864188', gh.long='-29.013893' where district='LERIBE' and council='Manka Council' and village='Ha Ramaboella';
update gii_hierarchy as gh set gh.lat='27.857017', gh.long='-29.021469' where district='LERIBE' and council='Manka Council' and village='Ha Mashape';
update gii_hierarchy as gh set gh.lat='27.901374', gh.long='-29.036614' where district='LERIBE' and council='Manka Council' and village='Molumong';
update gii_hierarchy as gh set gh.lat='28.192329', gh.long='-28.907663' where district='LERIBE' and council='Manka Council' and village='Ha Seetsa';
update gii_hierarchy as gh set gh.lat='27.837038', gh.long='-29.028348' where district='LERIBE' and council='Manka Council' and village='Nkanyane';


update gii_hierarchy as gh set gh.lat='27.876079', gh.long='-29.048691' where district='LERIBE' and council='Manka Council' and village='Ha Tumo (Fobane)';
update gii_hierarchy as gh set gh.lat='27.863264', gh.long='-29.069849' where district='LERIBE' and council='Manka Council' and village='Ha Mosae';
update gii_hierarchy as gh set gh.lat='27.868514', gh.long='-29.066707' where district='LERIBE' and council='Manka Council' and village='Ha Qhomane';
update gii_hierarchy as gh set gh.lat='27.907859', gh.long='-29.059623' where district='LERIBE' and council='Manka Council' and village='Ha Ramohai';
update gii_hierarchy as gh set gh.lat='27.719166', gh.long='-28.984897' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Leboea';
update gii_hierarchy as gh set gh.lat='27.723495', gh.long='-28.97772' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Lepapa';
update gii_hierarchy as gh set gh.lat='27.725993', gh.long='-28.993563' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Senyeke';
update gii_hierarchy as gh set gh.lat='27.727254', gh.long='-28.997565' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Masimole';
update gii_hierarchy as gh set gh.lat='27.720839', gh.long='-29.000412' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Moqathinyane';

update gii_hierarchy as gh set gh.lat='27.704355', gh.long='-29.024702' where district='LERIBE' and council='Tsoili tsoili Council' and village='Likatseng';
update gii_hierarchy as gh set gh.lat='27.730058', gh.long='-29.036101' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Mohai';
update gii_hierarchy as gh set gh.lat='27.737744', gh.long='-29.033799' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Molipa';
update gii_hierarchy as gh set gh.lat='27.779807', gh.long='-29.014089' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Makhula';
update gii_hierarchy as gh set gh.lat='27.792033', gh.long='-29.012043' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Ralehlatsa';
update gii_hierarchy as gh set gh.lat='27.78799', gh.long='-29.026224' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='27.80823', gh.long='-29.033361' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Lintsa';
update gii_hierarchy as gh set gh.lat='27.775627', gh.long='-29.021733' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Tumo';
update gii_hierarchy as gh set gh.lat='27.756141', gh.long='-29.004089' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Makhaketsa';
update gii_hierarchy as gh set gh.lat='27.763038', gh.long='-29.012593' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Motlokoa';
update gii_hierarchy as gh set gh.lat='27.765659', gh.long='-29.019147' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Tokoto';
update gii_hierarchy as gh set gh.lat='27.765334', gh.long='-29.024313' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Polisa';
update gii_hierarchy as gh set gh.lat='27.774938', gh.long='-29.04131' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Rampa (Manganeng)';
update gii_hierarchy as gh set gh.lat='27.774141', gh.long='-29.030292' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Thokoa';
update gii_hierarchy as gh set gh.lat='27.785302', gh.long='-29.03527' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Ntseke';
update gii_hierarchy as gh set gh.lat='27.779979', gh.long='-29.037494' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Rafelile (Manganeng)';
update gii_hierarchy as gh set gh.lat='27.813483', gh.long='-29.040581' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Noko';
update gii_hierarchy as gh set gh.lat='27.824428', gh.long='-29.039613' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Ntsekele';
update gii_hierarchy as gh set gh.lat='27.775402', gh.long='-29.046795' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Maphomane (Manganeng)';
update gii_hierarchy as gh set gh.lat='27.767717', gh.long='-29.060444' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Mofeli';
update gii_hierarchy as gh set gh.lat='27.750097', gh.long='-29.059721' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Polile';

update gii_hierarchy as gh set gh.lat='27.722459', gh.long='-29.056832' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Manama';
update gii_hierarchy as gh set gh.lat='27.713325', gh.long='-29.067594' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Setsabi';
update gii_hierarchy as gh set gh.lat='27.704158', gh.long='-29.076892' where district='LERIBE' and council='Tsoili tsoili Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='27.718117', gh.long='-29.077068' where district='LERIBE' and council='Tsoili tsoili Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.693812', gh.long='-29.069535' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Tlalinyane';
update gii_hierarchy as gh set gh.lat='27.68768', gh.long='-29.070077' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Nkhabu';
update gii_hierarchy as gh set gh.lat='27.680535', gh.long='-29.082325' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Rakobeli';
update gii_hierarchy as gh set gh.lat='27.66194', gh.long='-29.092494' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Rakolo';
update gii_hierarchy as gh set gh.lat='27.67166', gh.long='-29.094786' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Ratsita';
update gii_hierarchy as gh set gh.lat='27.695257', gh.long='-29.083438' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Botsane';
update gii_hierarchy as gh set gh.lat='27.726556', gh.long='-29.089277' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Mokati';
update gii_hierarchy as gh set gh.lat='27.725226', gh.long='-29.080304' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Moramang';
update gii_hierarchy as gh set gh.lat='27.673086', gh.long='-29.054108' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Molelle';
update gii_hierarchy as gh set gh.lat='27.684194', gh.long='-29.032062' where district='LERIBE' and council='Tsoili tsoili Council' and village='Ha Matala';
update gii_hierarchy as gh set gh.lat='27.676782', gh.long='-29.749295' where district='MAFETENG' and council='Monyake Council' and village='Fuleng';
update gii_hierarchy as gh set gh.lat='27.683748', gh.long='-29.743405' where district='MAFETENG' and council='Monyake Council' and village='Ha Machakela';
update gii_hierarchy as gh set gh.lat='27.665939', gh.long='-29.755002' where district='MAFETENG' and council='Monyake Council' and village='Ha Sepitla';
update gii_hierarchy as gh set gh.lat='27.071721', gh.long='-29.610818' where district='MAFETENG' and council='Monyake Council' and village='Koung';


update gii_hierarchy as gh set gh.lat='27.273021', gh.long='-29.548953' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Thoahlane';
update gii_hierarchy as gh set gh.lat='27.284863', gh.long='-29.536841' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Chele';
update gii_hierarchy as gh set gh.lat='27.303005', gh.long='-29.537203' where district='MAFETENG' and council='Metsi Matso Council' and village='Likhetleng';
update gii_hierarchy as gh set gh.lat='27.305985', gh.long='-29.555754' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Matetoane';
update gii_hierarchy as gh set gh.lat='27.298861', gh.long='-29.571183' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mochekoane';

update gii_hierarchy as gh set gh.lat='27.28131', gh.long='-29.569915' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ntaote';
update gii_hierarchy as gh set gh.lat='27.4267', gh.long='-29.937148' where district='MAFETENG' and council='Metsi Matso Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.253478', gh.long='-29.572848' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Rantai';
update gii_hierarchy as gh set gh.lat='27.256384', gh.long='-29.582046' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Bakhomi';
update gii_hierarchy as gh set gh.lat='27.259417', gh.long='-29.589577' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Thulo';
update gii_hierarchy as gh set gh.lat='27.285124', gh.long='-29.603242' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Lenonyane';
update gii_hierarchy as gh set gh.lat='27.284392', gh.long='-29.609955' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mosotho';

update gii_hierarchy as gh set gh.lat='27.25874', gh.long='-29.608604' where district='MAFETENG' and council='Metsi Matso Council' and village='Thabana Ntsonyana';
update gii_hierarchy as gh set gh.lat='27.23968', gh.long='-29.567591' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ranko';
update gii_hierarchy as gh set gh.lat='27.212218', gh.long='-29.570822' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mofota';
update gii_hierarchy as gh set gh.lat='27.179537', gh.long='-29.5983' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ramotoho';
update gii_hierarchy as gh set gh.lat='27.201112', gh.long='-29.593427' where district='MAFETENG' and council='Metsi Matso Council' and village='Matlatseng';
update gii_hierarchy as gh set gh.lat='27.212576', gh.long='-29.58322' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mokhasi';


update gii_hierarchy as gh set gh.lat='27.217675', gh.long='-29.610482' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Moeletsi';


update gii_hierarchy as gh set gh.lat='27.194104', gh.long='-29.61625' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Matlokotsi';
update gii_hierarchy as gh set gh.lat='27.214289', gh.long='-29.619989' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mokhisa';


update gii_hierarchy as gh set gh.lat='27.166367', gh.long='-29.61214' where district='MAFETENG' and council='Metsi Matso Council' and village='Makhanyeng';


update gii_hierarchy as gh set gh.lat='27.370427', gh.long='-29.786143' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mohapi';

update gii_hierarchy as gh set gh.lat='27.196399', gh.long='-29.635847' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mutsoe';
update gii_hierarchy as gh set gh.lat='27.163887', gh.long='-29.631253' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Phechela';
update gii_hierarchy as gh set gh.lat='27.403483', gh.long='-29.662536' where district='MAFETENG' and council='Metsi Matso Council' and village='Malimong';

update gii_hierarchy as gh set gh.lat='27.124518', gh.long='-29.600366' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Khetsi';
update gii_hierarchy as gh set gh.lat='27.128869', gh.long='-29.5964' where district='MAFETENG' and council='Metsi Matso Council' and village='Malumeng';
update gii_hierarchy as gh set gh.lat='27.107494', gh.long='-29.615536' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ratoeba';


update gii_hierarchy as gh set gh.lat='27.107939', gh.long='-29.610184' where district='MAFETENG' and council='Metsi Matso Council' and village='Mamphaneng';
update gii_hierarchy as gh set gh.lat='27.458787', gh.long='-30.033398' where district='MAFETENG' and council='Metsi Matso Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.105987', gh.long='-29.622124' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Hlelesoa';

update gii_hierarchy as gh set gh.lat='27.119103', gh.long='-29.63751' where district='MAFETENG' and council='Metsi Matso Council' and village='Makhemeng';
update gii_hierarchy as gh set gh.lat='27.125745', gh.long='-29.646796' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Rakhoboko';
update gii_hierarchy as gh set gh.lat='27.160149', gh.long='-29.649743' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mojela';

update gii_hierarchy as gh set gh.lat='27.16429', gh.long='-29.636205' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Motsoari';
update gii_hierarchy as gh set gh.lat='27.193645', gh.long='-29.649541' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Keketsi';
update gii_hierarchy as gh set gh.lat='27.181191', gh.long='-29.647063' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Khame';
update gii_hierarchy as gh set gh.lat='27.204228', gh.long='-29.659903' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Lijane';
update gii_hierarchy as gh set gh.lat='27.188532', gh.long='-29.664778' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Tjobase';

update gii_hierarchy as gh set gh.lat='27.217226', gh.long='-29.666537' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Tang';

update gii_hierarchy as gh set gh.lat='27.228361', gh.long='-29.696523' where district='MAFETENG' and council='Metsi Matso Council' and village='Bongalla';
update gii_hierarchy as gh set gh.lat='27.224534', gh.long='-29.67723' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mpeli';


update gii_hierarchy as gh set gh.lat='27.190527', gh.long='-29.695621' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Nkete';
update gii_hierarchy as gh set gh.lat='27.206172', gh.long='-29.688399' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Letsoara';


update gii_hierarchy as gh set gh.lat='27.184789', gh.long='-29.670438' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Polaki';
update gii_hierarchy as gh set gh.lat='27.173309', gh.long='-29.667293' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Rammoko';
update gii_hierarchy as gh set gh.lat='27.171624', gh.long='-29.660887' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Tankiso';
update gii_hierarchy as gh set gh.lat='27.167996', gh.long='-29.644493' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Fako';


update gii_hierarchy as gh set gh.lat='27.116713', gh.long='-29.665043' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Leteketa';
update gii_hierarchy as gh set gh.lat='27.108256', gh.long='-29.657887' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Morakanyane';
update gii_hierarchy as gh set gh.lat='27.340923', gh.long='-29.553695' where district='MAFETENG' and council='Metsi Matso Council' and village='Marakong';

update gii_hierarchy as gh set gh.lat='27.108099', gh.long='-29.673588' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ramosiuoane';
update gii_hierarchy as gh set gh.lat='27.076093', gh.long='-29.656173' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Moqhosha';
update gii_hierarchy as gh set gh.lat='27.099706', gh.long='-29.636376' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Rakherere';
update gii_hierarchy as gh set gh.lat='27.073734', gh.long='-29.644685' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Rapata';
update gii_hierarchy as gh set gh.lat='27.087348', gh.long='-29.617401' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mphulenyane';
update gii_hierarchy as gh set gh.lat='27.072776', gh.long='-29.624201' where district='MAFETENG' and council='Metsi Matso Council' and village='Khotsoaneng';
update gii_hierarchy as gh set gh.lat='27.071721', gh.long='-29.610818' where district='MAFETENG' and council='Metsi Matso Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='27.064166', gh.long='-29.643064' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Mabotse';
update gii_hierarchy as gh set gh.lat='27.061461', gh.long='-29.652921' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Masoli';


update gii_hierarchy as gh set gh.lat='27.042018', gh.long='-29.639057' where district='MAFETENG' and council='Metsi Matso Council' and village='Ha Ramohapi';
update gii_hierarchy as gh set gh.lat='27.037642', gh.long='-29.635622' where district='MAFETENG' and council='Metsi Matso Council' and village='Sekakeng';
update gii_hierarchy as gh set gh.lat='27.218678', gh.long='-29.871797' where district='MAFETENG' and council='Metsi Matso Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='27.332626', gh.long='-29.556595' where district='MAFETENG' and council='Mamantso Council' and village='Ha Matlali';
update gii_hierarchy as gh set gh.lat='27.340923', gh.long='-29.553695' where district='MAFETENG' and council='Mamantso Council' and village='Marakong';
update gii_hierarchy as gh set gh.lat='27.353062', gh.long='-29.543664' where district='MAFETENG' and council='Mamantso Council' and village='Ha Cheche';
update gii_hierarchy as gh set gh.lat='27.348295', gh.long='-29.554459' where district='MAFETENG' and council='Mamantso Council' and village='Ha Khirisone';
update gii_hierarchy as gh set gh.lat='27.360188', gh.long='-29.559429' where district='MAFETENG' and council='Mamantso Council' and village='Ha Ratsoeu';
update gii_hierarchy as gh set gh.lat='27.344463', gh.long='-29.543327' where district='MAFETENG' and council='Mamantso Council' and village='Ha Sekoai';


update gii_hierarchy as gh set gh.lat='27.344261', gh.long='-29.578313' where district='MAFETENG' and council='Mamantso Council' and village='Ha Ntsie';
update gii_hierarchy as gh set gh.lat='27.335734', gh.long='-29.582947' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mofo';
update gii_hierarchy as gh set gh.lat='27.322113', gh.long='-29.584049' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mohlalefi';


update gii_hierarchy as gh set gh.lat='27.373222', gh.long='-29.621785' where district='MAFETENG' and council='Mamantso Council' and village='Ha Lekeba';
update gii_hierarchy as gh set gh.lat='27.379338', gh.long='-29.605569' where district='MAFETENG' and council='Mamantso Council' and village='Ha Motlokoa';
update gii_hierarchy as gh set gh.lat='27.34148', gh.long='-29.611893' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mahlasane';



update gii_hierarchy as gh set gh.lat='27.335656', gh.long='-29.622919' where district='MAFETENG' and council='Mamantso Council' and village='Ha Nkhabu';
update gii_hierarchy as gh set gh.lat='27.319043', gh.long='-29.620293' where district='MAFETENG' and council='Mamantso Council' and village='Ha Petlane';
update gii_hierarchy as gh set gh.lat='27.273534', gh.long='-29.629919' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mphaololi';
update gii_hierarchy as gh set gh.lat='27.257472', gh.long='-29.636319' where district='MAFETENG' and council='Mamantso Council' and village='Ha Makintane';
update gii_hierarchy as gh set gh.lat='27.25676', gh.long='-29.632137' where district='MAFETENG' and council='Mamantso Council' and village='Ha Molise';
update gii_hierarchy as gh set gh.lat='27.24733', gh.long='-29.647179' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mikia';
update gii_hierarchy as gh set gh.lat='27.242672', gh.long='-29.642205' where district='MAFETENG' and council='Mamantso Council' and village='Ha Rabuka';
update gii_hierarchy as gh set gh.lat='27.25012', gh.long='-29.651035' where district='MAFETENG' and council='Mamantso Council' and village='Ha Taemane';
update gii_hierarchy as gh set gh.lat='27.275975', gh.long='-29.646028' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mpalami';

update gii_hierarchy as gh set gh.lat='27.265388', gh.long='-29.658974' where district='MAFETENG' and council='Mamantso Council' and village='Ha Rabeleng';

update gii_hierarchy as gh set gh.lat='27.254045', gh.long='-29.668686' where district='MAFETENG' and council='Mamantso Council' and village='Ha Tokonye';
update gii_hierarchy as gh set gh.lat='27.2376', gh.long='-29.680874' where district='MAFETENG' and council='Mamantso Council' and village='Ha Majake';
update gii_hierarchy as gh set gh.lat='27.242275', gh.long='-29.673399' where district='MAFETENG' and council='Mamantso Council' and village='Ha Tlai Tlai';
update gii_hierarchy as gh set gh.lat='27.259108', gh.long='-29.70451' where district='MAFETENG' and council='Mamantso Council' and village='Ha Nooana';

update gii_hierarchy as gh set gh.lat='27.267984', gh.long='-29.68619' where district='MAFETENG' and council='Mamantso Council' and village='Matsoseng';
update gii_hierarchy as gh set gh.lat='27.280799', gh.long='-29.683382' where district='MAFETENG' and council='Mamantso Council' and village='Tebang';
update gii_hierarchy as gh set gh.lat='27.288733', gh.long='-29.69075' where district='MAFETENG' and council='Mamantso Council' and village='Ha Hlaheng';
update gii_hierarchy as gh set gh.lat='27.280814', gh.long='-29.700934' where district='MAFETENG' and council='Mamantso Council' and village='Ha Notsi';
update gii_hierarchy as gh set gh.lat='27.272955', gh.long='-29.70448' where district='MAFETENG' and council='Mamantso Council' and village='Koi Boot';
update gii_hierarchy as gh set gh.lat='27.293346', gh.long='-29.69641' where district='MAFETENG' and council='Mamantso Council' and village='Ha Motumi';
update gii_hierarchy as gh set gh.lat='27.306274', gh.long='-29.700843' where district='MAFETENG' and council='Mamantso Council' and village='Ha Semoli';
update gii_hierarchy as gh set gh.lat='27.306372', gh.long='-29.671736' where district='MAFETENG' and council='Mamantso Council' and village='Ha Khola';
update gii_hierarchy as gh set gh.lat='27.320015', gh.long='-29.673717' where district='MAFETENG' and council='Mamantso Council' and village='Ha Moeketsane';
update gii_hierarchy as gh set gh.lat='27.307683', gh.long='-29.687049' where district='MAFETENG' and council='Mamantso Council' and village='Ha Tlaliatsana';
update gii_hierarchy as gh set gh.lat='27.323551', gh.long='-29.653329' where district='MAFETENG' and council='Mamantso Council' and village='Ha Khapetsi';

update gii_hierarchy as gh set gh.lat='27.318698', gh.long='-29.657426' where district='MAFETENG' and council='Mamantso Council' and village='Ha Khoele';
update gii_hierarchy as gh set gh.lat='27.338893', gh.long='-29.638493' where district='MAFETENG' and council='Mamantso Council' and village='Ha Challa';
update gii_hierarchy as gh set gh.lat='27.334954', gh.long='-29.652849' where district='MAFETENG' and council='Mamantso Council' and village='Malaleng';



update gii_hierarchy as gh set gh.lat='27.391929', gh.long='-29.633745' where district='MAFETENG' and council='Mamantso Council' and village='Ha Monkhe';


update gii_hierarchy as gh set gh.lat='27.403483', gh.long='-29.662536' where district='MAFETENG' and council='Mamantso Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='27.384774', gh.long='-29.65264' where district='MAFETENG' and council='Mamantso Council' and village='Tibeleng';
update gii_hierarchy as gh set gh.lat='27.351412', gh.long='-29.658132' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mphamo';
update gii_hierarchy as gh set gh.lat='27.361191', gh.long='-29.661825' where district='MAFETENG' and council='Mamantso Council' and village='Ha Ramothabeng';
update gii_hierarchy as gh set gh.lat='27.273673', gh.long='-29.55897' where district='MAFETENG' and council='Mamantso Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.359807', gh.long='-29.693159' where district='MAFETENG' and council='Mamantso Council' and village='Ha Damane';
update gii_hierarchy as gh set gh.lat='27.352222', gh.long='-29.679534' where district='MAFETENG' and council='Mamantso Council' and village='Ha Ralitabo';
update gii_hierarchy as gh set gh.lat='27.298861', gh.long='-29.571183' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mochekoane';
update gii_hierarchy as gh set gh.lat='27.375919', gh.long='-29.68295' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mphasa';
update gii_hierarchy as gh set gh.lat='27.407029', gh.long='-29.678658' where district='MAFETENG' and council='Mamantso Council' and village='Ha Moiphepi';
update gii_hierarchy as gh set gh.lat='27.393779', gh.long='-29.679438' where district='MAFETENG' and council='Mamantso Council' and village='Marutlhoaneng';
update gii_hierarchy as gh set gh.lat='27.414129', gh.long='-29.697944' where district='MAFETENG' and council='Mamantso Council' and village='Ha Molokoe';
update gii_hierarchy as gh set gh.lat='27.675034', gh.long='-29.86155' where district='MAFETENG' and council='Mamantso Council' and village='Motsekuoa';
update gii_hierarchy as gh set gh.lat='27.6404', gh.long='-29.762628' where district='MAFETENG' and council='Mamantso Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='27.396732', gh.long='-29.711705' where district='MAFETENG' and council='Mamantso Council' and village='Ha Maholi';
update gii_hierarchy as gh set gh.lat='27.384936', gh.long='-29.698936' where district='MAFETENG' and council='Mamantso Council' and village='Ha Seobi';
update gii_hierarchy as gh set gh.lat='27.362407', gh.long='-29.697965' where district='MAFETENG' and council='Mamantso Council' and village='Ha Mahlehle';
update gii_hierarchy as gh set gh.lat='27.370279', gh.long='-29.704322' where district='MAFETENG' and council='Mamantso Council' and village='Ha Ralenkoane';
update gii_hierarchy as gh set gh.lat='27.378299', gh.long='-29.709928' where district='MAFETENG' and council='Mamantso Council' and village='Ha Tanka';


update gii_hierarchy as gh set gh.lat='27.411904', gh.long='-29.712261' where district='MAFETENG' and council='Mamantso Council' and village='Ha Raputsoe';
update gii_hierarchy as gh set gh.lat='27.433871', gh.long='-29.700828' where district='MAFETENG' and council='Mamantso Council' and village='Ha Bele (Motsekuoa)';

update gii_hierarchy as gh set gh.lat='27.459399', gh.long='-29.701366' where district='MAFETENG' and council='Mathula Council' and village='Ha Serobo';
update gii_hierarchy as gh set gh.lat='27.140154', gh.long='-29.69556' where district='MAFETENG' and council='Mathula Council' and village='Sekantsing';


update gii_hierarchy as gh set gh.lat='27.480607', gh.long='-29.713338' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramatseliso';
update gii_hierarchy as gh set gh.lat='27.477352', gh.long='-29.717991' where district='MAFETENG' and council='Mathula Council' and village='Ha Bereng';

update gii_hierarchy as gh set gh.lat='27.487781', gh.long='-29.73376' where district='MAFETENG' and council='Mathula Council' and village='Ha Salemone';

update gii_hierarchy as gh set gh.lat='27.498425', gh.long='-29.732168' where district='MAFETENG' and council='Mathula Council' and village='Takalatsa';
update gii_hierarchy as gh set gh.lat='27.504213', gh.long='-29.736987' where district='MAFETENG' and council='Mathula Council' and village='Top Centre';
update gii_hierarchy as gh set gh.lat='27.488758', gh.long='-29.761735' where district='MAFETENG' and council='Mathula Council' and village='Ha Rannakoe';
update gii_hierarchy as gh set gh.lat='27.506135', gh.long='-29.753045' where district='MAFETENG' and council='Mathula Council' and village='Tsoaing';
update gii_hierarchy as gh set gh.lat='27.448761', gh.long='-29.751462' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramokhele';
update gii_hierarchy as gh set gh.lat='27.466136', gh.long='-29.738815' where district='MAFETENG' and council='Mathula Council' and village='Ha Tsiu';
update gii_hierarchy as gh set gh.lat='27.46225', gh.long='-29.745148' where district='MAFETENG' and council='Mathula Council' and village='Letseng';
update gii_hierarchy as gh set gh.lat='27.449932', gh.long='-29.71448' where district='MAFETENG' and council='Mathula Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='27.465232', gh.long='-29.719542' where district='MAFETENG' and council='Mathula Council' and village='Ha Mabula';
update gii_hierarchy as gh set gh.lat='27.443155', gh.long='-29.721567' where district='MAFETENG' and council='Mathula Council' and village='Ha Khabo';
update gii_hierarchy as gh set gh.lat='27.454165', gh.long='-29.730495' where district='MAFETENG' and council='Mathula Council' and village='Ha Lenake';
update gii_hierarchy as gh set gh.lat='27.421499', gh.long='-29.750967' where district='MAFETENG' and council='Mathula Council' and village='Ha Thahanyane';
update gii_hierarchy as gh set gh.lat='27.425099', gh.long='-29.743957' where district='MAFETENG' and council='Mathula Council' and village='Makeoane';
update gii_hierarchy as gh set gh.lat='27.435543', gh.long='-29.745687' where district='MAFETENG' and council='Mathula Council' and village='Thabaneng';

update gii_hierarchy as gh set gh.lat='27.395672', gh.long='-29.741866' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramosiee';


update gii_hierarchy as gh set gh.lat='27.368791', gh.long='-29.732948' where district='MAFETENG' and council='Mathula Council' and village='Ha Rabolilana';
update gii_hierarchy as gh set gh.lat='27.384735', gh.long='-29.755264' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramabilikoe';
update gii_hierarchy as gh set gh.lat='27.403729', gh.long='-29.757253' where district='MAFETENG' and council='Mathula Council' and village='Ha Moseli';
update gii_hierarchy as gh set gh.lat='27.417907', gh.long='-29.732075' where district='MAFETENG' and council='Mathula Council' and village='Makokotoaneng';

update gii_hierarchy as gh set gh.lat='27.38959', gh.long='-29.800776' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramosoeunyane';
update gii_hierarchy as gh set gh.lat='27.382581', gh.long='-29.805955' where district='MAFETENG' and council='Mathula Council' and village='Ha Shale';
update gii_hierarchy as gh set gh.lat='27.377386', gh.long='-29.777788' where district='MAFETENG' and council='Mathula Council' and village='Lihlookong';
update gii_hierarchy as gh set gh.lat='27.417191', gh.long='-29.77999' where district='MAFETENG' and council='Mathula Council' and village='Boiketlo';
update gii_hierarchy as gh set gh.lat='27.424713', gh.long='-29.790797' where district='MAFETENG' and council='Mathula Council' and village='Boithatelo';
update gii_hierarchy as gh set gh.lat='27.40155', gh.long='-29.788415' where district='MAFETENG' and council='Mathula Council' and village='Ha Raletooane';
update gii_hierarchy as gh set gh.lat='27.405018', gh.long='-29.781476' where district='MAFETENG' and council='Mathula Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='27.410818', gh.long='-29.785104' where district='MAFETENG' and council='Mathula Council' and village='Thaba Tsoeu Ha Mafa';
update gii_hierarchy as gh set gh.lat='27.447474', gh.long='-29.779064' where district='MAFETENG' and council='Mathula Council' and village='Ha Senatla';
update gii_hierarchy as gh set gh.lat='27.439422', gh.long='-29.782766' where district='MAFETENG' and council='Mathula Council' and village='Maholokoane';
update gii_hierarchy as gh set gh.lat='27.46426', gh.long='-29.780359' where district='MAFETENG' and council='Mathula Council' and village='Ha Majoro';
update gii_hierarchy as gh set gh.lat='27.46163', gh.long='-29.774978' where district='MAFETENG' and council='Mathula Council' and village='Ha Nkheche';
update gii_hierarchy as gh set gh.lat='27.462097', gh.long='-29.79487' where district='MAFETENG' and council='Mathula Council' and village='Ha Paki';
update gii_hierarchy as gh set gh.lat='27.492494', gh.long='-29.787033' where district='MAFETENG' and council='Mathula Council' and village='Ha Mphatle';
update gii_hierarchy as gh set gh.lat='27.486384', gh.long='-29.776484' where district='MAFETENG' and council='Mathula Council' and village='Ha Raletebele';
update gii_hierarchy as gh set gh.lat='27.507942', gh.long='-29.780739' where district='MAFETENG' and council='Mathula Council' and village='Ha Sekheke';
update gii_hierarchy as gh set gh.lat='27.495541', gh.long='-29.777383' where district='MAFETENG' and council='Mathula Council' and village='Nkoaneng';

update gii_hierarchy as gh set gh.lat='27.471981', gh.long='-29.81214' where district='MAFETENG' and council='Mathula Council' and village='Ha Ramoreki';
update gii_hierarchy as gh set gh.lat='27.460646', gh.long='-29.806437' where district='MAFETENG' and council='Mathula Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.471271', gh.long='-29.82955' where district='MAFETENG' and council='Mathula Council' and village='Ha Masupha (Lipatolong)';
update gii_hierarchy as gh set gh.lat='27.48977', gh.long='-29.84159' where district='MAFETENG' and council='Mathula Council' and village='Ha Phatsane';
update gii_hierarchy as gh set gh.lat='27.477465', gh.long='-29.838696' where district='MAFETENG' and council='Mathula Council' and village='Ha Tsoeute';
update gii_hierarchy as gh set gh.lat='27.508503', gh.long='-29.809657' where district='MAFETENG' and council='Mathula Council' and village='Ha Seeiso';



update gii_hierarchy as gh set gh.lat='27.518291', gh.long='-29.791544' where district='MAFETENG' and council='Mathula Council' and village='Ha Lesoma';

update gii_hierarchy as gh set gh.lat='27.535483', gh.long='-29.811787' where district='MAFETENG' and council='Mathula Council' and village='Ha Matsa';
update gii_hierarchy as gh set gh.lat='27.530189', gh.long='-29.817088' where district='MAFETENG' and council='Mathula Council' and village='Mohau Oa Pelo';

update gii_hierarchy as gh set gh.lat='27.50493', gh.long='-29.844355' where district='MAFETENG' and council='Mathula Council' and village='Ha Thamae';

update gii_hierarchy as gh set gh.lat='27.535456', gh.long='-29.836518' where district='MAFETENG' and council='Mathula Council' and village='Ha Mokhothu';
update gii_hierarchy as gh set gh.lat='27.532718', gh.long='-29.830313' where district='MAFETENG' and council='Mathula Council' and village='Morunyaneng';
update gii_hierarchy as gh set gh.lat='27.541421', gh.long='-29.854391' where district='MAFETENG' and council='Mathula Council' and village='Ha Sekhaupane';
update gii_hierarchy as gh set gh.lat='27.627925', gh.long='-29.700443' where district='MAFETENG' and council='Monyake Council' and village='Ha Ramochele';
update gii_hierarchy as gh set gh.lat='27.600575', gh.long='-29.713765' where district='MAFETENG' and council='Monyake Council' and village='Letaeng';
update gii_hierarchy as gh set gh.lat='27.600933', gh.long='-29.734951' where district='MAFETENG' and council='Monyake Council' and village='Ha Mpalipali';

update gii_hierarchy as gh set gh.lat='27.624148', gh.long='-29.718211' where district='MAFETENG' and council='Monyake Council' and village='Ha Monyake';
update gii_hierarchy as gh set gh.lat='27.659531', gh.long='-29.718385' where district='MAFETENG' and council='Monyake Council' and village='Ha Ralebona';
update gii_hierarchy as gh set gh.lat='27.655168', gh.long='-29.727736' where district='MAFETENG' and council='Monyake Council' and village='Ha Sekake';
update gii_hierarchy as gh set gh.lat='27.655841', gh.long='-29.72296' where district='MAFETENG' and council='Monyake Council' and village='Tsukutsoana';
update gii_hierarchy as gh set gh.lat='27.627797', gh.long='-29.729402' where district='MAFETENG' and council='Monyake Council' and village='Ha Ntsibane';

update gii_hierarchy as gh set gh.lat='27.627857', gh.long='-29.734869' where district='MAFETENG' and council='Monyake Council' and village='Sekokoaneng';

update gii_hierarchy as gh set gh.lat='27.589125', gh.long='-29.754162' where district='MAFETENG' and council='Monyake Council' and village='Ha Kubutu';
update gii_hierarchy as gh set gh.lat='27.608907', gh.long='-29.749922' where district='MAFETENG' and council='Monyake Council' and village='Ha Matjeka';
update gii_hierarchy as gh set gh.lat='27.563682', gh.long='-29.727037' where district='MAFETENG' and council='Monyake Council' and village='Ha Mosala';
update gii_hierarchy as gh set gh.lat='27.583959', gh.long='-29.747953' where district='MAFETENG' and council='Monyake Council' and village='Ha Sekhobe';
update gii_hierarchy as gh set gh.lat='27.580953', gh.long='-29.7286' where district='MAFETENG' and council='Monyake Council' and village='Koti Sekhutsoane';
update gii_hierarchy as gh set gh.lat='27.563011', gh.long='-29.752483' where district='MAFETENG' and council='Monyake Council' and village='Ha Lentsoe';

update gii_hierarchy as gh set gh.lat='27.555321', gh.long='-29.748336' where district='MAFETENG' and council='Monyake Council' and village='Ha Ramoshabe';
update gii_hierarchy as gh set gh.lat='27.542771', gh.long='-29.758691' where district='MAFETENG' and council='Monyake Council' and village='Ha Makhakhe';
update gii_hierarchy as gh set gh.lat='27.555103', gh.long='-29.756348' where district='MAFETENG' and council='Monyake Council' and village='Ha Motjatji';
update gii_hierarchy as gh set gh.lat='27.553788', gh.long='-29.75389' where district='MAFETENG' and council='Monyake Council' and village='Ha Thabo';

update gii_hierarchy as gh set gh.lat='27.636618', gh.long='-29.756885' where district='MAFETENG' and council='Monyake Council' and village='Ha Soko';
update gii_hierarchy as gh set gh.lat='27.622433', gh.long='-29.769065' where district='MAFETENG' and council='Monyake Council' and village='Ha Tjale';
update gii_hierarchy as gh set gh.lat='27.6404', gh.long='-29.762628' where district='MAFETENG' and council='Monyake Council' and village='Pontseng';

update gii_hierarchy as gh set gh.lat='27.654345', gh.long='-29.775963' where district='MAFETENG' and council='Monyake Council' and village='Ha Manosa';

update gii_hierarchy as gh set gh.lat='27.650708', gh.long='-29.772196' where district='MAFETENG' and council='Monyake Council' and village='Ha Moqulo';
update gii_hierarchy as gh set gh.lat='27.644958', gh.long='-29.767659' where district='MAFETENG' and council='Monyake Council' and village='Ha Nthonyana';
update gii_hierarchy as gh set gh.lat='27.657547', gh.long='-29.76572' where district='MAFETENG' and council='Monyake Council' and village='Ha Shea';
update gii_hierarchy as gh set gh.lat='27.664192', gh.long='-29.789022' where district='MAFETENG' and council='Monyake Council' and village='Ha Mphatsi';
update gii_hierarchy as gh set gh.lat='27.657971', gh.long='-29.79341' where district='MAFETENG' and council='Monyake Council' and village='Ha Nkeo';
update gii_hierarchy as gh set gh.lat='27.641332', gh.long='-29.786442' where district='MAFETENG' and council='Monyake Council' and village='Ha Setimela';

update gii_hierarchy as gh set gh.lat='27.661632', gh.long='-29.782965' where district='MAFETENG' and council='Monyake Council' and village='Ha Motaba';


update gii_hierarchy as gh set gh.lat='27.679912', gh.long='-29.79888' where district='MAFETENG' and council='Monyake Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='27.677579', gh.long='-29.806149' where district='MAFETENG' and council='Monyake Council' and village='Ha Phafoli';
update gii_hierarchy as gh set gh.lat='27.700789', gh.long='-29.813532' where district='MAFETENG' and council='Monyake Council' and village='Ha Tlebete';

update gii_hierarchy as gh set gh.lat='27.545092', gh.long='-29.725235' where district='MAFETENG' and council='Monyake Council' and village='Moeaneng';


update gii_hierarchy as gh set gh.lat='27.634862', gh.long='-29.817314' where district='MAFETENG' and council='Monyake Council' and village='Ha Mohlakala';
update gii_hierarchy as gh set gh.lat='27.643162', gh.long='-29.80284' where district='MAFETENG' and council='Monyake Council' and village='Ha Mokete';


update gii_hierarchy as gh set gh.lat='27.657133', gh.long='-29.809207' where district='MAFETENG' and council='Monyake Council' and village='Ha Sehloho';
update gii_hierarchy as gh set gh.lat='27.664585', gh.long='-29.80243' where district='MAFETENG' and council='Monyake Council' and village='Ha Shekeshe';
update gii_hierarchy as gh set gh.lat='27.599383', gh.long='-29.803122' where district='MAFETENG' and council='Monyake Council' and village='Botsoela';
update gii_hierarchy as gh set gh.lat='27.570751', gh.long='-29.792494' where district='MAFETENG' and council='Monyake Council' and village='Ha Faba';
update gii_hierarchy as gh set gh.lat='27.566129', gh.long='-29.78456' where district='MAFETENG' and council='Monyake Council' and village='Ha Josia';
update gii_hierarchy as gh set gh.lat='27.592961', gh.long='-29.788418' where district='MAFETENG' and council='Monyake Council' and village='Ha Leata';

update gii_hierarchy as gh set gh.lat='27.579845', gh.long='-29.781429' where district='MAFETENG' and council='Monyake Council' and village='Khomojong';
update gii_hierarchy as gh set gh.lat='27.534502', gh.long='-29.780853' where district='MAFETENG' and council='Monyake Council' and village='Methinyeng';

update gii_hierarchy as gh set gh.lat='27.523761', gh.long='-29.773183' where district='MAFETENG' and council='Monyake Council' and village='Ha Sehlabo';
update gii_hierarchy as gh set gh.lat='27.516456', gh.long='-29.652735' where district='MAFETENG' and council='Tajane Council' and village='Ha Nkafane';
update gii_hierarchy as gh set gh.lat='27.49783', gh.long='-29.665757' where district='MAFETENG' and council='Tajane Council' and village='Ha Seqobela';
update gii_hierarchy as gh set gh.lat='27.503792', gh.long='-29.656359' where district='MAFETENG' and council='Tajane Council' and village='Ha Tsikela';
update gii_hierarchy as gh set gh.lat='27.530817', gh.long='-29.660634' where district='MAFETENG' and council='Tajane Council' and village='Ha Rakhoboso';
update gii_hierarchy as gh set gh.lat='27.506148', gh.long='-29.678347' where district='MAFETENG' and council='Tajane Council' and village='Kopanong';
update gii_hierarchy as gh set gh.lat='27.518713', gh.long='-29.668881' where district='MAFETENG' and council='Tajane Council' and village='Metlaeeng';


update gii_hierarchy as gh set gh.lat='27.484933', gh.long='-29.686915' where district='MAFETENG' and council='Tajane Council' and village='Ha Mantitana';
update gii_hierarchy as gh set gh.lat='27.49731', gh.long='-29.699895' where district='MAFETENG' and council='Tajane Council' and village='Ha Lesaoana';
update gii_hierarchy as gh set gh.lat='27.517304', gh.long='-29.713046' where district='MAFETENG' and council='Tajane Council' and village='Ha Ramahotetsa';
update gii_hierarchy as gh set gh.lat='27.545082', gh.long='-29.730255' where district='MAFETENG' and council='Tajane Council' and village='Ha Mahapela';

update gii_hierarchy as gh set gh.lat='27.551803', gh.long='-29.74248' where district='MAFETENG' and council='Tajane Council' and village='Ha Muso';
update gii_hierarchy as gh set gh.lat='27.536426', gh.long='-29.740175' where district='MAFETENG' and council='Tajane Council' and village='Ha Tapole';



update gii_hierarchy as gh set gh.lat='27.55797', gh.long='-29.728866' where district='MAFETENG' and council='Tajane Council' and village='Ha Machaha';


update gii_hierarchy as gh set gh.lat='27.558797', gh.long='-29.719388' where district='MAFETENG' and council='Tajane Council' and village='Ha Thobi';

update gii_hierarchy as gh set gh.lat='27.448197', gh.long='-29.726414' where district='MAFETENG' and council='Tajane Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.583598', gh.long='-29.719593' where district='MAFETENG' and council='Tajane Council' and village='Ha Mothebesoane';
update gii_hierarchy as gh set gh.lat='27.578337', gh.long='-29.72133' where district='MAFETENG' and council='Tajane Council' and village='Ha Mpapa';
update gii_hierarchy as gh set gh.lat='27.544052', gh.long='-29.711188' where district='MAFETENG' and council='Tajane Council' and village='Ha Kori';

update gii_hierarchy as gh set gh.lat='27.52244', gh.long='-29.690505' where district='MAFETENG' and council='Tajane Council' and village='Ha Shakhane';
update gii_hierarchy as gh set gh.lat='27.511476', gh.long='-29.688483' where district='MAFETENG' and council='Tajane Council' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='27.743103', gh.long='-29.863711' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Moluo luo';
update gii_hierarchy as gh set gh.lat='27.700096', gh.long='-29.855886' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Ratjopa';
update gii_hierarchy as gh set gh.lat='27.720772', gh.long='-29.858155' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Salae';
update gii_hierarchy as gh set gh.lat='27.707365', gh.long='-29.85172' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Seahle';
update gii_hierarchy as gh set gh.lat='27.738048', gh.long='-29.846601' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Sekhaila';
update gii_hierarchy as gh set gh.lat='27.754732', gh.long='-29.836477' where district='MAFETENG' and council='Ramoetsane Council' and village='Matebeleng';

update gii_hierarchy as gh set gh.lat='27.749167', gh.long='-29.880537' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Molati';
update gii_hierarchy as gh set gh.lat='27.721484', gh.long='-29.887105' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Sekhaoli';
update gii_hierarchy as gh set gh.lat='27.711271', gh.long='-29.868554' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Makoae';
update gii_hierarchy as gh set gh.lat='27.688328', gh.long='-29.855948' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mokena';

update gii_hierarchy as gh set gh.lat='27.273673', gh.long='-29.55897' where district='MAFETENG' and council='Ramoetsane Council' and village='Khubetsoana';


update gii_hierarchy as gh set gh.lat='27.70243', gh.long='-29.880391' where district='MAFETENG' and council='Ramoetsane Council' and village='Taboleng';
update gii_hierarchy as gh set gh.lat='27.681915', gh.long='-29.881574' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Beo';
update gii_hierarchy as gh set gh.lat='27.684126', gh.long='-29.856592' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Limo';
update gii_hierarchy as gh set gh.lat='27.678456', gh.long='-29.874675' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Majela';

update gii_hierarchy as gh set gh.lat='27.678087', gh.long='-29.878827' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Nketsi';
update gii_hierarchy as gh set gh.lat='27.68808', gh.long='-29.866435' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Nthota';
update gii_hierarchy as gh set gh.lat='27.682155', gh.long='-29.862299' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Seeiso';
update gii_hierarchy as gh set gh.lat='27.685141', gh.long='-29.882201' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Shekoe';
update gii_hierarchy as gh set gh.lat='27.675034', gh.long='-29.86155' where district='MAFETENG' and council='Ramoetsane Council' and village='Motsekuoa';

update gii_hierarchy as gh set gh.lat='27.668622', gh.long='-29.862166' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mabusetsa';
update gii_hierarchy as gh set gh.lat='27.656662', gh.long='-29.864762' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mateu';

update gii_hierarchy as gh set gh.lat='27.651644', gh.long='-29.865845' where district='MAFETENG' and council='Ramoetsane Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='27.644137', gh.long='-29.86563' where district='MAFETENG' and council='Ramoetsane Council' and village='Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='27.694868', gh.long='-29.879878' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Liholo';
update gii_hierarchy as gh set gh.lat='27.716175', gh.long='-29.896025' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Makhejane';
update gii_hierarchy as gh set gh.lat='27.667135', gh.long='-29.884963' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Monaheng';
update gii_hierarchy as gh set gh.lat='27.707176', gh.long='-29.900087' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mopeli';
update gii_hierarchy as gh set gh.lat='27.69388', gh.long='-29.891776' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Ndaemane';
update gii_hierarchy as gh set gh.lat='27.680319', gh.long='-29.896121' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Rammuso';
update gii_hierarchy as gh set gh.lat='27.678359', gh.long='-29.886832' where district='MAFETENG' and council='Ramoetsane Council' and village='Lihlabaneng';
update gii_hierarchy as gh set gh.lat='27.699999', gh.long='-29.883626' where district='MAFETENG' and council='Ramoetsane Council' and village='Maphonkoane';

update gii_hierarchy as gh set gh.lat='27.653461', gh.long='-29.895811' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Berente';
update gii_hierarchy as gh set gh.lat='27.635355', gh.long='-29.884757' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Bukana';

update gii_hierarchy as gh set gh.lat='27.632304', gh.long='-29.888722' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Lenka';
update gii_hierarchy as gh set gh.lat='27.655544', gh.long='-29.890089' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mokhethi';


update gii_hierarchy as gh set gh.lat='27.637014', gh.long='-29.891168' where district='MAFETENG' and council='Ramoetsane Council' and village='Kelepeng';
update gii_hierarchy as gh set gh.lat='27.630753', gh.long='-29.886684' where district='MAFETENG' and council='Ramoetsane Council' and village='Mankoaneng';
update gii_hierarchy as gh set gh.lat='27.621443', gh.long='-29.873467' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='27.627453', gh.long='-29.876683' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Motloang';
update gii_hierarchy as gh set gh.lat='27.631918', gh.long='-29.866011' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Ramoetsane';
update gii_hierarchy as gh set gh.lat='27.634061', gh.long='-29.878733' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Thaka Banna';
update gii_hierarchy as gh set gh.lat='27.615822', gh.long='-29.886484' where district='MAFETENG' and council='Ramoetsane Council' and village='Thaba Sekoka';
update gii_hierarchy as gh set gh.lat='27.618205', gh.long='-29.899439' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Letsema';

update gii_hierarchy as gh set gh.lat='27.636176', gh.long='-29.907027' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Ferete';

update gii_hierarchy as gh set gh.lat='27.646076', gh.long='-29.914164' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Motoai';



update gii_hierarchy as gh set gh.lat='27.648218', gh.long='-29.9082' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Seele';
update gii_hierarchy as gh set gh.lat='27.662195', gh.long='-29.922066' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Tsoene';
update gii_hierarchy as gh set gh.lat='27.654241', gh.long='-29.918982' where district='MAFETENG' and council='Ramoetsane Council' and village='Molleloa';
update gii_hierarchy as gh set gh.lat='27.716465', gh.long='-29.906263' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Jobo';

update gii_hierarchy as gh set gh.lat='27.705303', gh.long='-29.934752' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Maletlatsa';
update gii_hierarchy as gh set gh.lat='27.66828', gh.long='-29.920192' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Motsamai';

update gii_hierarchy as gh set gh.lat='27.667162', gh.long='-29.911568' where district='MAFETENG' and council='Ramoetsane Council' and village='Mahlatheng';

update gii_hierarchy as gh set gh.lat='27.679559', gh.long='-29.945901' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Leboto';
update gii_hierarchy as gh set gh.lat='27.67399', gh.long='-29.935489' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='27.682163', gh.long='-29.936633' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Moolisa';
update gii_hierarchy as gh set gh.lat='27.669023', gh.long='-29.930396' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mpheulane';
update gii_hierarchy as gh set gh.lat='27.671467', gh.long='-29.939374' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Thetso';
update gii_hierarchy as gh set gh.lat='27.663023', gh.long='-29.928486' where district='MAFETENG' and council='Ramoetsane Council' and village='Mokurutlung';
update gii_hierarchy as gh set gh.lat='27.657251', gh.long='-29.929929' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Matheka';
update gii_hierarchy as gh set gh.lat='27.641495', gh.long='-29.946163' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Nkhahle';
update gii_hierarchy as gh set gh.lat='27.665011', gh.long='-29.943039' where district='MAFETENG' and council='Ramoetsane Council' and village='Liqokoeng';

update gii_hierarchy as gh set gh.lat='27.458787', gh.long='-30.033398' where district='MAFETENG' and council='Ramoetsane Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='27.633916', gh.long='-29.934086' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Chechane';
update gii_hierarchy as gh set gh.lat='27.633165', gh.long='-29.938128' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Motumi';

update gii_hierarchy as gh set gh.lat='27.600578', gh.long='-29.722263' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Tsupane';

update gii_hierarchy as gh set gh.lat='27.623457', gh.long='-29.924871' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Hlasoa';
update gii_hierarchy as gh set gh.lat='27.617418', gh.long='-29.914379' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mothepu';
update gii_hierarchy as gh set gh.lat='27.642933', gh.long='-29.930497' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Sechaba';
update gii_hierarchy as gh set gh.lat='27.621686', gh.long='-29.947503' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Maama';
update gii_hierarchy as gh set gh.lat='27.629002', gh.long='-29.937184' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Nkieane';

update gii_hierarchy as gh set gh.lat='27.624556', gh.long='-29.931743' where district='MAFETENG' and council='Ramoetsane Council' and village='Liphiring';

update gii_hierarchy as gh set gh.lat='27.608423', gh.long='-29.910337' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Mathabang';



update gii_hierarchy as gh set gh.lat='27.577303', gh.long='-29.929743' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Matee';
update gii_hierarchy as gh set gh.lat='27.589997', gh.long='-29.92094' where district='MAFETENG' and council='Ramoetsane Council' and village='Lifajaneng';

update gii_hierarchy as gh set gh.lat='27.587722', gh.long='-29.940242' where district='MAFETENG' and council='Ramoetsane Council' and village='Ha Lekokosa';

update gii_hierarchy as gh set gh.lat='27.602967', gh.long='-29.956889' where district='MAFETENG' and council='Ramoetsane Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='27.594667', gh.long='-29.951764' where district='MAFETENG' and council='Ramoetsane Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='27.569857', gh.long='-29.820832' where district='MAFETENG' and council='Malakeng Council' and village='Makhoseng';
update gii_hierarchy as gh set gh.lat='27.558885', gh.long='-29.831608' where district='MAFETENG' and council='Malakeng Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.627616', gh.long='-29.82665' where district='MAFETENG' and council='Malakeng Council' and village='Ha Tsoinyane';

update gii_hierarchy as gh set gh.lat='27.609458', gh.long='-29.822507' where district='MAFETENG' and council='Malakeng Council' and village='Makhetheng';

update gii_hierarchy as gh set gh.lat='27.611565', gh.long='-29.844409' where district='MAFETENG' and council='Malakeng Council' and village='Ha Majane';
update gii_hierarchy as gh set gh.lat='27.620335', gh.long='-29.855173' where district='MAFETENG' and council='Malakeng Council' and village='Ha Phatela';


update gii_hierarchy as gh set gh.lat='27.618196', gh.long='-29.833592' where district='MAFETENG' and council='Malakeng Council' and village='Ha Tohlang';

update gii_hierarchy as gh set gh.lat='27.578679', gh.long='-29.826387' where district='MAFETENG' and council='Malakeng Council' and village='Lehlakaneng';
update gii_hierarchy as gh set gh.lat='27.580563', gh.long='-29.839349' where district='MAFETENG' and council='Malakeng Council' and village='Likhohloaneng';
update gii_hierarchy as gh set gh.lat='27.585751', gh.long='-29.837683' where district='MAFETENG' and council='Malakeng Council' and village='Lithabaneng';

update gii_hierarchy as gh set gh.lat='27.554497', gh.long='-29.852194' where district='MAFETENG' and council='Malakeng Council' and village='Ha Hlelesi';
update gii_hierarchy as gh set gh.lat='27.56107', gh.long='-29.847356' where district='MAFETENG' and council='Malakeng Council' and village='Ha Motau';
update gii_hierarchy as gh set gh.lat='27.557813', gh.long='-29.850208' where district='MAFETENG' and council='Malakeng Council' and village='Ha Tlhone';


update gii_hierarchy as gh set gh.lat='27.58458', gh.long='-29.847895' where district='MAFETENG' and council='Malakeng Council' and village='Pitseng';
update gii_hierarchy as gh set gh.lat='27.572546', gh.long='-29.864289' where district='MAFETENG' and council='Malakeng Council' and village='Ha Makhaooane';
update gii_hierarchy as gh set gh.lat='27.560423', gh.long='-29.870756' where district='MAFETENG' and council='Malakeng Council' and village='Ha Qaba';
update gii_hierarchy as gh set gh.lat='27.598896', gh.long='-29.893746' where district='MAFETENG' and council='Malakeng Council' and village='Ha Jase';
update gii_hierarchy as gh set gh.lat='27.582659', gh.long='-29.875075' where district='MAFETENG' and council='Malakeng Council' and village='Ha Likhama';
update gii_hierarchy as gh set gh.lat='27.607157', gh.long='-29.866865' where district='MAFETENG' and council='Malakeng Council' and village='Ha Makoanyane';
update gii_hierarchy as gh set gh.lat='27.601199', gh.long='-29.90245' where district='MAFETENG' and council='Malakeng Council' and village='Ha Ntele';
update gii_hierarchy as gh set gh.lat='27.585436', gh.long='-29.87081' where district='MAFETENG' and council='Malakeng Council' and village='Malere';
update gii_hierarchy as gh set gh.lat='27.595419', gh.long='-29.868116' where district='MAFETENG' and council='Malakeng Council' and village='Sekiring';

update gii_hierarchy as gh set gh.lat='27.561808', gh.long='-29.897068' where district='MAFETENG' and council='Malakeng Council' and village='Ha Kholoanyane';

update gii_hierarchy as gh set gh.lat='27.573109', gh.long='-29.894247' where district='MAFETENG' and council='Malakeng Council' and village='Ha Setlakotlako';

update gii_hierarchy as gh set gh.lat='27.551064', gh.long='-29.912242' where district='MAFETENG' and council='Malakeng Council' and village='Ha Motsi';
update gii_hierarchy as gh set gh.lat='27.540718', gh.long='-29.933271' where district='MAFETENG' and council='Malakeng Council' and village='Ha Rantho';
update gii_hierarchy as gh set gh.lat='27.550174', gh.long='-29.92023' where district='MAFETENG' and council='Malakeng Council' and village='Ha Shololo';
update gii_hierarchy as gh set gh.lat='27.534421', gh.long='-29.913801' where district='MAFETENG' and council='Malakeng Council' and village='Ha Kanono';
update gii_hierarchy as gh set gh.lat='27.512351', gh.long='-29.917914' where district='MAFETENG' and council='Malakeng Council' and village='Ha Lemonomono';
update gii_hierarchy as gh set gh.lat='27.537928', gh.long='-29.921891' where district='MAFETENG' and council='Malakeng Council' and village='Ha Maliehe';
update gii_hierarchy as gh set gh.lat='27.517903', gh.long='-29.922707' where district='MAFETENG' and council='Malakeng Council' and village='Ha Rabele';
update gii_hierarchy as gh set gh.lat='27.377977', gh.long='-29.660947' where district='MAFETENG' and council='Malakeng Council' and village='Ha Ralipoli';
update gii_hierarchy as gh set gh.lat='27.524331', gh.long='-29.908435' where district='MAFETENG' and council='Malakeng Council' and village='Ha Ramosoeu';
update gii_hierarchy as gh set gh.lat='27.514776', gh.long='-29.912492' where district='MAFETENG' and council='Malakeng Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='27.528097', gh.long='-29.884553' where district='MAFETENG' and council='Malakeng Council' and village='Ha Rapokane';

update gii_hierarchy as gh set gh.lat='27.521499', gh.long='-29.893569' where district='MAFETENG' and council='Malakeng Council' and village='Metsohlong';
update gii_hierarchy as gh set gh.lat='27.54565', gh.long='-29.878563' where district='MAFETENG' and council='Malakeng Council' and village='Ha Tebelo';

update gii_hierarchy as gh set gh.lat='27.507705', gh.long='-29.859455' where district='MAFETENG' and council='Malakeng Council' and village='Ha Makhasane';
update gii_hierarchy as gh set gh.lat='27.502658', gh.long='-29.869125' where district='MAFETENG' and council='Malakeng Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='27.508011', gh.long='-29.878997' where district='MAFETENG' and council='Malakeng Council' and village='Ha Ralehoabali';
update gii_hierarchy as gh set gh.lat='27.398222', gh.long='-29.818405' where district='MAFETENG' and council='Malumeng Council' and village='Ha Ratheepe';
update gii_hierarchy as gh set gh.lat='27.384654', gh.long='-29.819116' where district='MAFETENG' and council='Malumeng Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='27.374934', gh.long='-29.820677' where district='MAFETENG' and council='Malumeng Council' and village='Liptjemptjeteng';
update gii_hierarchy as gh set gh.lat='27.401941', gh.long='-29.811039' where district='MAFETENG' and council='Malumeng Council' and village='Matebeng';
update gii_hierarchy as gh set gh.lat='27.407682', gh.long='-29.801784' where district='MAFETENG' and council='Malumeng Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.403911', gh.long='-29.83961' where district='MAFETENG' and council='Malumeng Council' and village='Ha Marite';
update gii_hierarchy as gh set gh.lat='27.401407', gh.long='-29.852964' where district='MAFETENG' and council='Malumeng Council' and village='Ha Molete';
update gii_hierarchy as gh set gh.lat='27.414264', gh.long='-29.845939' where district='MAFETENG' and council='Malumeng Council' and village='Ha Pitso';

update gii_hierarchy as gh set gh.lat='27.39948', gh.long='-29.830571' where district='MAFETENG' and council='Malumeng Council' and village='Libopeng';
update gii_hierarchy as gh set gh.lat='27.448197', gh.long='-29.726414' where district='MAFETENG' and council='Malumeng Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.445897', gh.long='-29.81711' where district='MAFETENG' and council='Malumeng Council' and village='Ha Motamolane';
update gii_hierarchy as gh set gh.lat='27.422568', gh.long='-29.828678' where district='MAFETENG' and council='Malumeng Council' and village='Marabeng';


update gii_hierarchy as gh set gh.lat='27.440136', gh.long='-29.845571' where district='MAFETENG' and council='Malumeng Council' and village='Malumeng';
update gii_hierarchy as gh set gh.lat='27.439766', gh.long='-29.854354' where district='MAFETENG' and council='Malumeng Council' and village='Ha Heri';
update gii_hierarchy as gh set gh.lat='27.430997', gh.long='-29.85737' where district='MAFETENG' and council='Malumeng Council' and village='Ha Mahooana';

update gii_hierarchy as gh set gh.lat='27.406837', gh.long='-29.86031' where district='MAFETENG' and council='Malumeng Council' and village='Ha Tobi';
update gii_hierarchy as gh set gh.lat='27.423388', gh.long='-29.86665' where district='MAFETENG' and council='Malumeng Council' and village='Limapong';
update gii_hierarchy as gh set gh.lat='27.417662', gh.long='-29.860499' where district='MAFETENG' and council='Malumeng Council' and village='Thibella';
update gii_hierarchy as gh set gh.lat='27.213959', gh.long='-29.839006' where district='MAFETENG' and council='Malumeng Council' and village='Ha Mothokho';
update gii_hierarchy as gh set gh.lat='27.47827', gh.long='-29.870231' where district='MAFETENG' and council='Malumeng Council' and village='Ha Mabatla';
update gii_hierarchy as gh set gh.lat='27.441521', gh.long='-29.869207' where district='MAFETENG' and council='Malumeng Council' and village='Ha Moqanyane';
update gii_hierarchy as gh set gh.lat='27.470588', gh.long='-29.870836' where district='MAFETENG' and council='Malumeng Council' and village='Ha Sebatli';
update gii_hierarchy as gh set gh.lat='27.459349', gh.long='-29.887282' where district='MAFETENG' and council='Malumeng Council' and village='Ha Monyane';
update gii_hierarchy as gh set gh.lat='27.493056', gh.long='-29.900941' where district='MAFETENG' and council='Malumeng Council' and village='Ha Majara';

update gii_hierarchy as gh set gh.lat='27.474865', gh.long='-29.90472' where district='MAFETENG' and council='Malumeng Council' and village='Ha Ramathaleha';
update gii_hierarchy as gh set gh.lat='27.482825', gh.long='-29.912149' where district='MAFETENG' and council='Malumeng Council' and village='Qibing';
update gii_hierarchy as gh set gh.lat='27.442698', gh.long='-29.921578' where district='MAFETENG' and council='Malumeng Council' and village='Ha Manthama';

update gii_hierarchy as gh set gh.lat='27.464678', gh.long='-29.919245' where district='MAFETENG' and council='Malumeng Council' and village='Ha Sebaki';
update gii_hierarchy as gh set gh.lat='27.497435', gh.long='-29.926015' where district='MAFETENG' and council='Malumeng Council' and village='Ha Monono';
update gii_hierarchy as gh set gh.lat='27.522659', gh.long='-29.93685' where district='MAFETENG' and council='Malumeng Council' and village='Ha Raseboko';
update gii_hierarchy as gh set gh.lat='27.496544', gh.long='-29.915639' where district='MAFETENG' and council='Malumeng Council' and village='Manganeng';

update gii_hierarchy as gh set gh.lat='27.516784', gh.long='-29.962835' where district='MAFETENG' and council='Malumeng Council' and village='Ha Seatile';
update gii_hierarchy as gh set gh.lat='27.512793', gh.long='-29.937073' where district='MAFETENG' and council='Malumeng Council' and village='Ha Sekhonyana';
update gii_hierarchy as gh set gh.lat='27.482685', gh.long='-29.93382' where district='MAFETENG' and council='Malumeng Council' and village='Ha Kubelle';
update gii_hierarchy as gh set gh.lat='27.473902', gh.long='-29.949236' where district='MAFETENG' and council='Malumeng Council' and village='Ha Maisane';
update gii_hierarchy as gh set gh.lat='27.491108', gh.long='-29.948458' where district='MAFETENG' and council='Malumeng Council' and village='Ha Ramathaha';
update gii_hierarchy as gh set gh.lat='27.495695', gh.long='-29.950445' where district='MAFETENG' and council='Malumeng Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='27.488911', gh.long='-29.936268' where district='MAFETENG' and council='Malumeng Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='27.442051', gh.long='-29.939588' where district='MAFETENG' and council='Malumeng Council' and village='Ha Sekhele';
update gii_hierarchy as gh set gh.lat='27.441847', gh.long='-29.945535' where district='MAFETENG' and council='Malumeng Council' and village='Ha Tjoobe';

update gii_hierarchy as gh set gh.lat='27.451635', gh.long='-29.973431' where district='MAFETENG' and council='Malumeng Council' and village='Ha Leboto';
update gii_hierarchy as gh set gh.lat='27.440934', gh.long='-29.971328' where district='MAFETENG' and council='Malumeng Council' and village='Ha Masia';
update gii_hierarchy as gh set gh.lat='27.481705', gh.long='-29.96391' where district='MAFETENG' and council='Malumeng Council' and village='Ha Ramatima';
update gii_hierarchy as gh set gh.lat='27.35438', gh.long='-29.772143' where district='MAFETENG' and council='Malumeng Council' and village='Ha Isaka';
update gii_hierarchy as gh set gh.lat='27.485823', gh.long='-29.98205' where district='MAFETENG' and council='Malumeng Council' and village='Ha Lebamang';
update gii_hierarchy as gh set gh.lat='27.488712', gh.long='-29.975561' where district='MAFETENG' and council='Malumeng Council' and village='Ha Mashaile';
update gii_hierarchy as gh set gh.lat='27.498309', gh.long='-29.967378' where district='MAFETENG' and council='Malumeng Council' and village='Ha Rantaba';
update gii_hierarchy as gh set gh.lat='27.509017', gh.long='-29.977064' where district='MAFETENG' and council='Malumeng Council' and village='Ha Seshemane';
update gii_hierarchy as gh set gh.lat='27.494039', gh.long='-29.964095' where district='MAFETENG' and council='Malumeng Council' and village='Sehlabaneng';


update gii_hierarchy as gh set gh.lat='27.394004', gh.long='-29.891766' where district='MAFETENG' and council='Koti se phola Council' and village='Foreisetata';
update gii_hierarchy as gh set gh.lat='27.401411', gh.long='-29.891872' where district='MAFETENG' and council='Koti se phola Council' and village='Makhetheng';


update gii_hierarchy as gh set gh.lat='27.414108', gh.long='-29.890034' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Sethabela';
update gii_hierarchy as gh set gh.lat='27.42721', gh.long='-29.90996' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Lekoatsa';
update gii_hierarchy as gh set gh.lat='27.431795', gh.long='-29.92313' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Bofihla';
update gii_hierarchy as gh set gh.lat='27.382227', gh.long='-29.923268' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Lengolo';
update gii_hierarchy as gh set gh.lat='27.368066', gh.long='-29.924146' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Panta';
update gii_hierarchy as gh set gh.lat='27.372189', gh.long='-29.942906' where district='MAFETENG' and council='Koti se phola Council' and village='Maralleng';
update gii_hierarchy as gh set gh.lat='27.427631', gh.long='-29.931155' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Konote';



update gii_hierarchy as gh set gh.lat='27.381078', gh.long='-29.978275' where district='MAFETENG' and council='Koti se phola Council' and village='Maserung';
update gii_hierarchy as gh set gh.lat='27.38009', gh.long='-29.99129' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Khoete';
update gii_hierarchy as gh set gh.lat='27.401102', gh.long='-29.99776' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Mofoka';
update gii_hierarchy as gh set gh.lat='27.430275', gh.long='-29.977832' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Ngoae';
update gii_hierarchy as gh set gh.lat='27.446153', gh.long='-30.002026' where district='MAFETENG' and council='Koti se phola Council' and village='Makoabating';
update gii_hierarchy as gh set gh.lat='27.463544', gh.long='-29.987238' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Khalimane';
update gii_hierarchy as gh set gh.lat='27.468105', gh.long='-29.982675' where district='MAFETENG' and council='Koti se phola Council' and village='Ntsekalle';
update gii_hierarchy as gh set gh.lat='27.472806', gh.long='-30.008326' where district='MAFETENG' and council='Koti se phola Council' and village='Maholong';
update gii_hierarchy as gh set gh.lat='27.449689', gh.long='-30.013576' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Lehana';
update gii_hierarchy as gh set gh.lat='27.459752', gh.long='-30.02367' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Thakhalle';

update gii_hierarchy as gh set gh.lat='27.465072', gh.long='-30.038263' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Bera';
update gii_hierarchy as gh set gh.lat='27.454205', gh.long='-30.018695' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Thakanyane';
update gii_hierarchy as gh set gh.lat='27.458787', gh.long='-30.033398' where district='MAFETENG' and council='Koti se phola Council' and village='Motse mocha';




update gii_hierarchy as gh set gh.lat='27.420297', gh.long='-30.023586' where district='MAFETENG' and council='Koti se phola Council' and village='Ha Sechaba';
update gii_hierarchy as gh set gh.lat='27.41216', gh.long='-30.030711' where district='MAFETENG' and council='Koti se phola Council' and village='Maqhatseng';
update gii_hierarchy as gh set gh.lat='27.323155', gh.long='-29.700503' where district='MAFETENG' and council='Makholane Council' and village='Ha Makopela';
update gii_hierarchy as gh set gh.lat='27.341241', gh.long='-29.692307' where district='MAFETENG' and council='Makholane Council' and village='Ha Mafeto';

update gii_hierarchy as gh set gh.lat='27.335104', gh.long='-29.738442' where district='MAFETENG' and council='Makholane Council' and village='Ha Koranta';
update gii_hierarchy as gh set gh.lat='27.346222', gh.long='-29.753043' where district='MAFETENG' and council='Makholane Council' and village='Ha Ntlhakeng';
update gii_hierarchy as gh set gh.lat='27.348986', gh.long='-29.748374' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramokoatsi';
update gii_hierarchy as gh set gh.lat='27.356393', gh.long='-29.729807' where district='MAFETENG' and council='Makholane Council' and village='Litsahaneng';
update gii_hierarchy as gh set gh.lat='27.318346', gh.long='-29.714751' where district='MAFETENG' and council='Makholane Council' and village='Ha Khati';
update gii_hierarchy as gh set gh.lat='27.32013', gh.long='-29.719732' where district='MAFETENG' and council='Makholane Council' and village='Ha Nthinya';

update gii_hierarchy as gh set gh.lat='27.33034', gh.long='-29.730762' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramontsoe';




update gii_hierarchy as gh set gh.lat='27.312228', gh.long='-29.711953' where district='MAFETENG' and council='Makholane Council' and village='Semakaleng';
update gii_hierarchy as gh set gh.lat='27.240521', gh.long='-29.718155' where district='MAFETENG' and council='Makholane Council' and village='Mapolateng';






update gii_hierarchy as gh set gh.lat='27.289207', gh.long='-29.733412' where district='MAFETENG' and council='Makholane Council' and village='Ha Sephula';
update gii_hierarchy as gh set gh.lat='27.26126', gh.long='-29.736872' where district='MAFETENG' and council='Makholane Council' and village='Ha Khalienyane';



update gii_hierarchy as gh set gh.lat='27.239683', gh.long='-29.743034' where district='MAFETENG' and council='Makholane Council' and village='Ha Oni';
update gii_hierarchy as gh set gh.lat='27.265589', gh.long='-29.747675' where district='MAFETENG' and council='Makholane Council' and village='Ha Motlohi';
update gii_hierarchy as gh set gh.lat='27.255245', gh.long='-29.758485' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramaleshoane';
update gii_hierarchy as gh set gh.lat='27.215548', gh.long='-29.789144' where district='MAFETENG' and council='Makholane Council' and village='Ha Sekoati';


update gii_hierarchy as gh set gh.lat='27.253446', gh.long='-29.795198' where district='MAFETENG' and council='Makholane Council' and village='Ha Raborane';



update gii_hierarchy as gh set gh.lat='27.042018', gh.long='-29.639057' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramohapi';

update gii_hierarchy as gh set gh.lat='27.28807', gh.long='-29.764205' where district='MAFETENG' and council='Makholane Council' and village='Ha Likupa';
update gii_hierarchy as gh set gh.lat='27.303026', gh.long='-29.76909' where district='MAFETENG' and council='Makholane Council' and village='Ha Lumisi';

update gii_hierarchy as gh set gh.lat='27.308317', gh.long='-29.759593' where district='MAFETENG' and council='Makholane Council' and village='Ha Chopho';



update gii_hierarchy as gh set gh.lat='27.325282', gh.long='-29.74535' where district='MAFETENG' and council='Makholane Council' and village='Noka Ntso';
update gii_hierarchy as gh set gh.lat='27.35438', gh.long='-29.772143' where district='MAFETENG' and council='Makholane Council' and village='Ha Isaka';
update gii_hierarchy as gh set gh.lat='27.345142', gh.long='-29.762862' where district='MAFETENG' and council='Makholane Council' and village='Ha Lebeta';
update gii_hierarchy as gh set gh.lat='27.323013', gh.long='-29.789396' where district='MAFETENG' and council='Makholane Council' and village='Ha Raliemere';





update gii_hierarchy as gh set gh.lat='27.284333', gh.long='-29.823098' where district='MAFETENG' and council='Makholane Council' and village='Ha Qobete';

update gii_hierarchy as gh set gh.lat='27.448197', gh.long='-29.726414' where district='MAFETENG' and council='Makholane Council' and village='Thoteng';



update gii_hierarchy as gh set gh.lat='27.301468', gh.long='-29.831204' where district='MAFETENG' and council='Makholane Council' and village='Khatleng';

update gii_hierarchy as gh set gh.lat='27.311778', gh.long='-29.820866' where district='MAFETENG' and council='Makholane Council' and village='Makeneng';

update gii_hierarchy as gh set gh.lat='27.348108', gh.long='-29.806422' where district='MAFETENG' and council='Makholane Council' and village='Tieleng';

update gii_hierarchy as gh set gh.lat='27.365002', gh.long='-29.796442' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramatheko';
update gii_hierarchy as gh set gh.lat='27.458787', gh.long='-30.033398' where district='MAFETENG' and council='Makholane Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.479635', gh.long='-29.750618' where district='MAFETENG' and council='Makholane Council' and village='Thotaneng';

update gii_hierarchy as gh set gh.lat='27.370427', gh.long='-29.786143' where district='MAFETENG' and council='Makholane Council' and village='Ha Mohapi';
update gii_hierarchy as gh set gh.lat='27.396732', gh.long='-29.711705' where district='MAFETENG' and council='Makholane Council' and village='Ha Maholi';

update gii_hierarchy as gh set gh.lat='27.356513', gh.long='-29.833489' where district='MAFETENG' and council='Makholane Council' and village='Ha Matsaba';
update gii_hierarchy as gh set gh.lat='27.363378', gh.long='-29.845169' where district='MAFETENG' and council='Makholane Council' and village='Ha Mpeli';
update gii_hierarchy as gh set gh.lat='27.34237', gh.long='-29.845011' where district='MAFETENG' and council='Makholane Council' and village='Ha Mahosi';
update gii_hierarchy as gh set gh.lat='27.343866', gh.long='-29.829145' where district='MAFETENG' and council='Makholane Council' and village='Ha Libete';
update gii_hierarchy as gh set gh.lat='27.320495', gh.long='-29.833754' where district='MAFETENG' and council='Makholane Council' and village='Ha Mahali';
update gii_hierarchy as gh set gh.lat='27.309197', gh.long='-29.830629' where district='MAFETENG' and council='Makholane Council' and village='Ha Rankapu';
update gii_hierarchy as gh set gh.lat='27.314611', gh.long='-29.836411' where district='MAFETENG' and council='Makholane Council' and village='Ha Sebusi';
update gii_hierarchy as gh set gh.lat='27.274197', gh.long='-29.847496' where district='MAFETENG' and council='Makholane Council' and village='Ha Matsepe';
update gii_hierarchy as gh set gh.lat='27.282512', gh.long='-29.8484' where district='MAFETENG' and council='Makholane Council' and village='Ha Pelesa';
update gii_hierarchy as gh set gh.lat='27.280188', gh.long='-29.867684' where district='MAFETENG' and council='Makholane Council' and village='Ha Phokojoe';

update gii_hierarchy as gh set gh.lat='27.299037', gh.long='-29.860367' where district='MAFETENG' and council='Makholane Council' and village='Ha Khalala';
update gii_hierarchy as gh set gh.lat='27.305136', gh.long='-29.857807' where district='MAFETENG' and council='Makholane Council' and village='Ha Matsie';
update gii_hierarchy as gh set gh.lat='27.301511', gh.long='-29.861758' where district='MAFETENG' and council='Makholane Council' and village='Tsaeng';
update gii_hierarchy as gh set gh.lat='27.323788', gh.long='-29.858641' where district='MAFETENG' and council='Makholane Council' and village='Ha Makhathe';
update gii_hierarchy as gh set gh.lat='27.319316', gh.long='-29.85061' where district='MAFETENG' and council='Makholane Council' and village='Ha Malilimetsa';

update gii_hierarchy as gh set gh.lat='27.331115', gh.long='-29.883365' where district='MAFETENG' and council='Makholane Council' and village='Ha Manehella';

update gii_hierarchy as gh set gh.lat='27.303382', gh.long='-29.885064' where district='MAFETENG' and council='Makholane Council' and village='Ha Ramporoane';
update gii_hierarchy as gh set gh.lat='27.315451', gh.long='-29.881431' where district='MAFETENG' and council='Makholane Council' and village='Ha Tauhali';
update gii_hierarchy as gh set gh.lat='27.268729', gh.long='-29.90677' where district='MAFETENG' and council='Makholane Council' and village='Ha Kotoane';
update gii_hierarchy as gh set gh.lat='27.289364', gh.long='-29.87894' where district='MAFETENG' and council='Makholane Council' and village='Ha Lesia';

update gii_hierarchy as gh set gh.lat='27.273555', gh.long='-29.896452' where district='MAFETENG' and council='Makholane Council' and village='Matsooeng';
update gii_hierarchy as gh set gh.lat='27.03681', gh.long='-29.66347' where district='MAFETENG' and council='Qibing Council' and village='Ha Seeiso';


update gii_hierarchy as gh set gh.lat='27.067645', gh.long='-29.667' where district='MAFETENG' and council='Qibing Council' and village='Ha Fokase';
update gii_hierarchy as gh set gh.lat='27.079946', gh.long='-29.675701' where district='MAFETENG' and council='Qibing Council' and village='Ha Tanyele';
update gii_hierarchy as gh set gh.lat='27.068627', gh.long='-29.689728' where district='MAFETENG' and council='Qibing Council' and village='Ha Mashapha';

update gii_hierarchy as gh set gh.lat='27.178411', gh.long='-29.762808' where district='MAFETENG' and council='Qibing Council' and village='Ha Molapo';
update gii_hierarchy as gh set gh.lat='27.102637', gh.long='-29.683422' where district='MAFETENG' and council='Qibing Council' and village='Ha Mphobe';


update gii_hierarchy as gh set gh.lat='27.127551', gh.long='-29.69239' where district='MAFETENG' and council='Qibing Council' and village='Ha Ratomo';
update gii_hierarchy as gh set gh.lat='27.140154', gh.long='-29.69556' where district='MAFETENG' and council='Qibing Council' and village='Sekantsing';

update gii_hierarchy as gh set gh.lat='27.132218', gh.long='-29.730601' where district='MAFETENG' and council='Qibing Council' and village='Ha Nkalimeng';
update gii_hierarchy as gh set gh.lat='27.147266', gh.long='-29.711381' where district='MAFETENG' and council='Qibing Council' and village='Ha Khasapane';
update gii_hierarchy as gh set gh.lat='27.141059', gh.long='-29.700941' where district='MAFETENG' and council='Qibing Council' and village='Ha Montoeli';


update gii_hierarchy as gh set gh.lat='27.179036', gh.long='-29.703622' where district='MAFETENG' and council='Qibing Council' and village='Ha Ralebese';

update gii_hierarchy as gh set gh.lat='27.180419', gh.long='-29.715756' where district='MAFETENG' and council='Qibing Council' and village='Boluma Tau';
update gii_hierarchy as gh set gh.lat='27.149491', gh.long='-29.741371' where district='MAFETENG' and council='Qibing Council' and village='Ha Patsa';



update gii_hierarchy as gh set gh.lat='27.613077', gh.long='-29.699962' where district='MAFETENG' and council='Qibing Council' and village='Ha Ralintsi';


update gii_hierarchy as gh set gh.lat='27.111738', gh.long='-29.758804' where district='MAFETENG' and council='Qibing Council' and village='Ha Tebatso';
update gii_hierarchy as gh set gh.lat='27.124636', gh.long='-29.76802' where district='MAFETENG' and council='Qibing Council' and village='Ha Sepelemane';

update gii_hierarchy as gh set gh.lat='27.138591', gh.long='-29.794246' where district='MAFETENG' and council='Qibing Council' and village='Ha Khojane';

update gii_hierarchy as gh set gh.lat='27.140045', gh.long='-29.777968' where district='MAFETENG' and council='Qibing Council' and village='Ha Ramatsabane';

update gii_hierarchy as gh set gh.lat='27.168153', gh.long='-29.756665' where district='MAFETENG' and council='Qibing Council' and village='Ha Ramahlape';
update gii_hierarchy as gh set gh.lat='27.190445', gh.long='-29.729225' where district='MAFETENG' and council='Qibing Council' and village='Ha Maretlane';
update gii_hierarchy as gh set gh.lat='27.1953', gh.long='-29.719922' where district='MAFETENG' and council='Qibing Council' and village='Ha Monyalotsa';

update gii_hierarchy as gh set gh.lat='27.208572', gh.long='-29.736809' where district='MAFETENG' and council='Qibing Council' and village='Ha Mohlehli';
update gii_hierarchy as gh set gh.lat='27.623889', gh.long='-29.852677' where district='MAFETENG' and council='Qibing Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='27.187384', gh.long='-29.763389' where district='MAFETENG' and council='Qibing Council' and village='Ha Taelo';
update gii_hierarchy as gh set gh.lat='27.594667', gh.long='-29.951764' where district='MAFETENG' and council='Qibing Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='27.166599', gh.long='-29.785379' where district='MAFETENG' and council='Qibing Council' and village='Hlakoaneng';
update gii_hierarchy as gh set gh.lat='27.153843', gh.long='-29.810278' where district='MAFETENG' and council='Qibing Council' and village='Ha Lepolesa';
update gii_hierarchy as gh set gh.lat='27.138621', gh.long='-29.80541' where district='MAFETENG' and council='Qibing Council' and village='Marua';
update gii_hierarchy as gh set gh.lat='27.156166', gh.long='-29.821707' where district='MAFETENG' and council='Qibing Council' and village='Likokong';




update gii_hierarchy as gh set gh.lat='27.191397', gh.long='-29.815988' where district='MAFETENG' and council='Qibing Council' and village='Ha Motanyane';

update gii_hierarchy as gh set gh.lat='27.190108', gh.long='-29.832291' where district='MAFETENG' and council='Qibing Council' and village='Ha Masiu';
update gii_hierarchy as gh set gh.lat='27.200956', gh.long='-29.847228' where district='MAFETENG' and council='Qibing Council' and village='Ha Lekhari';
update gii_hierarchy as gh set gh.lat='27.207457', gh.long='-29.837828' where district='MAFETENG' and council='Qibing Council' and village='Ha Phepheng';


update gii_hierarchy as gh set gh.lat='27.174841', gh.long='-29.841111' where district='MAFETENG' and council='Qibing Council' and village='Ha Ralerupa';

update gii_hierarchy as gh set gh.lat='27.617461', gh.long='-29.818162' where district='MAFETENG' and council='Qibing Council' and village='Letlapeng';


update gii_hierarchy as gh set gh.lat='27.164097', gh.long='-29.854505' where district='MAFETENG' and council='Qibing Council' and village='Ha Rakhapu';
update gii_hierarchy as gh set gh.lat='27.18784', gh.long='-29.875784' where district='MAFETENG' and council='Qibing Council' and village='Ha Aujong';
update gii_hierarchy as gh set gh.lat='27.181846', gh.long='-29.869074' where district='MAFETENG' and council='Qibing Council' and village='Ha Mamothibeli';
update gii_hierarchy as gh set gh.lat='27.188578', gh.long='-29.896889' where district='MAFETENG' and council='Qibing Council' and village='Ha Ralipere';
update gii_hierarchy as gh set gh.lat='27.187229', gh.long='-29.854986' where district='MAFETENG' and council='Qibing Council' and village='Mahlakung';
update gii_hierarchy as gh set gh.lat='27.176733', gh.long='-29.893675' where district='MAFETENG' and council='Qibing Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='27.219762', gh.long='-29.808934' where district='MAFETENG' and council='Makaota Council' and village='Matholeng';
update gii_hierarchy as gh set gh.lat='27.223448', gh.long='-29.800664' where district='MAFETENG' and council='Makaota Council' and village='Lifelekoaneng';
update gii_hierarchy as gh set gh.lat='27.273673', gh.long='-29.55897' where district='MAFETENG' and council='Makaota Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.241168', gh.long='-29.813311' where district='MAFETENG' and council='Makaota Council' and village='Hospital Area';


update gii_hierarchy as gh set gh.lat='27.255751', gh.long='-29.807579' where district='MAFETENG' and council='Makaota Council' and village='Leloaleng';
update gii_hierarchy as gh set gh.lat='27.257936', gh.long='-29.801039' where district='MAFETENG' and council='Makaota Council' and village='Borokhong';
update gii_hierarchy as gh set gh.lat='27.256253', gh.long='-29.818095' where district='MAFETENG' and council='Makaota Council' and village='Paballong';


update gii_hierarchy as gh set gh.lat='27.22508', gh.long='-29.82165' where district='MAFETENG' and council='Makaota Council' and village='Ha Motlere';
update gii_hierarchy as gh set gh.lat='27.219006', gh.long='-29.818133' where district='MAFETENG' and council='Makaota Council' and village='Likoung';
update gii_hierarchy as gh set gh.lat='27.226699', gh.long='-29.826593' where district='MAFETENG' and council='Makaota Council' and village='Matsaneng';
update gii_hierarchy as gh set gh.lat='27.231049', gh.long='-29.828934' where district='MAFETENG' and council='Makaota Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='27.213959', gh.long='-29.839006' where district='MAFETENG' and council='Makaota Council' and village='Ha Mothokho';


update gii_hierarchy as gh set gh.lat='27.24243', gh.long='-29.825446' where district='MAFETENG' and council='Makaota Council' and village='Ha Ramokhele';

update gii_hierarchy as gh set gh.lat='27.252365', gh.long='-29.829091' where district='MAFETENG' and council='Makaota Council' and village='Tjorosing';
update gii_hierarchy as gh set gh.lat='27.257502', gh.long='-29.828785' where district='MAFETENG' and council='Makaota Council' and village='Motse mocha (Ha Matsepe)';
update gii_hierarchy as gh set gh.lat='27.259262', gh.long='-29.841065' where district='MAFETENG' and council='Makaota Council' and village='Matheneng';

update gii_hierarchy as gh set gh.lat='27.235869', gh.long='-29.855989' where district='MAFETENG' and council='Makaota Council' and village='Ha Lebenkele';
update gii_hierarchy as gh set gh.lat='27.246362', gh.long='-29.873589' where district='MAFETENG' and council='Makaota Council' and village='Ha Mei';
update gii_hierarchy as gh set gh.lat='27.261854', gh.long='-29.877932' where district='MAFETENG' and council='Makaota Council' and village='Ha Ranteme';
update gii_hierarchy as gh set gh.lat='27.274524', gh.long='-29.882261' where district='MAFETENG' and council='Makaota Council' and village='Ha Souru';
update gii_hierarchy as gh set gh.lat='27.246854', gh.long='-29.881401' where district='MAFETENG' and council='Makaota Council' and village='Matsatseng';


update gii_hierarchy as gh set gh.lat='27.210421', gh.long='-29.884671' where district='MAFETENG' and council='Makaota Council' and village='Ha Kotoanyane';
update gii_hierarchy as gh set gh.lat='27.212931', gh.long='-29.862946' where district='MAFETENG' and council='Makaota Council' and village='Ha Mpholle';
update gii_hierarchy as gh set gh.lat='27.200858', gh.long='-29.870837' where district='MAFETENG' and council='Makaota Council' and village='Ha Tsele';

update gii_hierarchy as gh set gh.lat='27.239998', gh.long='-29.888144' where district='MAFETENG' and council='Makaota Council' and village='Ha Ramokoena';
update gii_hierarchy as gh set gh.lat='27.248212', gh.long='-29.894758' where district='MAFETENG' and council='Makaota Council' and village='Ha Tseleng';

update gii_hierarchy as gh set gh.lat='27.236526', gh.long='-29.903845' where district='MAFETENG' and council='Makaota Council' and village='Ha Mofalali';
update gii_hierarchy as gh set gh.lat='27.226942', gh.long='-29.902192' where district='MAFETENG' and council='Makaota Council' and village='Ha Mphatsoane';
update gii_hierarchy as gh set gh.lat='27.242637', gh.long='-29.894748' where district='MAFETENG' and council='Makaota Council' and village='Khalahali';


update gii_hierarchy as gh set gh.lat='27.543664', gh.long='-29.31118' where district='MASERU' and council='Maseru Municipality' and village='Ha Tsosane';
update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Maseru Municipality' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='27.541075', gh.long='-29.322364' where district='MASERU' and council='Maseru Municipality' and village='Majoe a Litsoene';


update gii_hierarchy as gh set gh.lat='27.488257', gh.long='-29.305912' where district='MASERU' and council='Maseru Municipality' and village='Fokothi';
update gii_hierarchy as gh set gh.lat='27.494409', gh.long='-29.307249' where district='MASERU' and council='Maseru Municipality' and village='Sea Point';
update gii_hierarchy as gh set gh.lat='27.496564', gh.long='-29.299907' where district='MASERU' and council='Maseru Municipality' and village='Moshoeshoe II';
update gii_hierarchy as gh set gh.lat='27.503624', gh.long='-29.291578' where district='MASERU' and council='Maseru Municipality' and village='Temong';
update gii_hierarchy as gh set gh.lat='27.504897', gh.long='-29.310142' where district='MASERU' and council='Maseru Municipality' and village='Maseru East';
update gii_hierarchy as gh set gh.lat='27.499571', gh.long='-29.311784' where district='MASERU' and council='Maseru Municipality' and village='Stadium Area';
update gii_hierarchy as gh set gh.lat='28.14993', gh.long='-29.635958' where district='MASERU' and council='Maseru Municipality' and village='Thibella';
update gii_hierarchy as gh set gh.lat='27.511989', gh.long='-29.32074' where district='MASERU' and council='Maseru Municipality' and village='Lower Thamae';
update gii_hierarchy as gh set gh.lat='27.506832', gh.long='-29.315016' where district='MASERU' and council='Maseru Municipality' and village='Mohalalitoe';
update gii_hierarchy as gh set gh.lat='27.495948', gh.long='-29.316295' where district='MASERU' and council='Maseru Municipality' and village='Cathedral Area';





update gii_hierarchy as gh set gh.lat='27.507366', gh.long='-29.325509' where district='MASERU' and council='Maseru Municipality' and village='Ntsirele (Lower Thamae)';
update gii_hierarchy as gh set gh.lat='27.505346', gh.long='-29.320874' where district='MASERU' and council='Maseru Municipality' and village='Nttc';

update gii_hierarchy as gh set gh.lat='27.512463', gh.long='-29.32955' where district='MASERU' and council='Maseru Municipality' and village='Upper Thamae';
update gii_hierarchy as gh set gh.lat='27.507108', gh.long='-29.32966' where district='MASERU' and council='Maseru Municipality' and village='Thabong';
update gii_hierarchy as gh set gh.lat='27.459132', gh.long='-29.352618' where district='MASERU' and council='Maseru Municipality' and village='Ha Tsolo';
update gii_hierarchy as gh set gh.lat='27.461523', gh.long='-29.303427' where district='MASERU' and council='Maseru Municipality' and village='Florida';
update gii_hierarchy as gh set gh.lat='27.462404', gh.long='-29.300451' where district='MASERU' and council='Maseru Municipality' and village='Ha Hoohlo';

update gii_hierarchy as gh set gh.lat='27.475363', gh.long='-29.304769' where district='MASERU' and council='Maseru Municipality' and village='Maseru West';
update gii_hierarchy as gh set gh.lat='27.483417', gh.long='-29.306993' where district='MASERU' and council='Maseru Municipality' and village='Matsoatlareng';

update gii_hierarchy as gh set gh.lat='27.481568', gh.long='-29.311845' where district='MASERU' and council='Maseru Municipality' and village='Maseru Central';

update gii_hierarchy as gh set gh.lat='27.476789', gh.long='-29.325128' where district='MASERU' and council='Maseru Municipality' and village='Hills View';
update gii_hierarchy as gh set gh.lat='27.486902', gh.long='-29.320925' where district='MASERU' and council='Maseru Municipality' and village='New Europa';
update gii_hierarchy as gh set gh.lat='27.488543', gh.long='-29.330561' where district='MASERU' and council='Maseru Municipality' and village='Katlehong';
update gii_hierarchy as gh set gh.lat='27.487015', gh.long='-29.326494' where district='MASERU' and council='Maseru Municipality' and village='White City';
update gii_hierarchy as gh set gh.lat='27.487874', gh.long='-29.336704' where district='MASERU' and council='Maseru Municipality' and village='Race Course';

update gii_hierarchy as gh set gh.lat='27.469843', gh.long='-29.33798' where district='MASERU' and council='Maseru Municipality' and village='Lekhalong (Ha Thetsane)';
update gii_hierarchy as gh set gh.lat='27.471507', gh.long='-29.334001' where district='MASERU' and council='Maseru Municipality' and village='Lower Thetsane';

update gii_hierarchy as gh set gh.lat='27.459865', gh.long='-29.330141' where district='MASERU' and council='Maseru Municipality' and village='Ha Ratjomose';
update gii_hierarchy as gh set gh.lat='27.454774', gh.long='-29.333946' where district='MASERU' and council='Maseru Municipality' and village='Matamong (Ha Thetsane)';
update gii_hierarchy as gh set gh.lat='27.44297', gh.long='-29.335526' where district='MASERU' and council='Maseru Municipality' and village='Ha Lesia';
update gii_hierarchy as gh set gh.lat='27.450073', gh.long='-29.342763' where district='MASERU' and council='Maseru Municipality' and village='Thetsane West';
update gii_hierarchy as gh set gh.lat='27.463923', gh.long='-29.337081' where district='MASERU' and council='Maseru Municipality' and village='Seqhobong (Ha Thetsane)';
update gii_hierarchy as gh set gh.lat='27.471172', gh.long='-29.340963' where district='MASERU' and council='Maseru Municipality' and village='Mankoaneng (Ha Thetsane)';
update gii_hierarchy as gh set gh.lat='27.443569', gh.long='-29.348882' where district='MASERU' and council='Maseru Municipality' and village='Bashanyaneng (Ha Tsolo)';




update gii_hierarchy as gh set gh.lat='27.501726', gh.long='-29.329526' where district='MASERU' and council='Maseru Municipality' and village='Ha Tsautse';

update gii_hierarchy as gh set gh.lat='27.498515', gh.long='-29.335067' where district='MASERU' and council='Maseru Municipality' and village='Matsoareng';
update gii_hierarchy as gh set gh.lat='27.505433', gh.long='-29.335312' where district='MASERU' and council='Maseru Municipality' and village='Lekhaloaneng';

update gii_hierarchy as gh set gh.lat='27.505365', gh.long='-29.338524' where district='MASERU' and council='Maseru Municipality' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='27.506082', gh.long='-29.341447' where district='MASERU' and council='Maseru Municipality' and village='Botleng';

update gii_hierarchy as gh set gh.lat='27.511771', gh.long='-29.341194' where district='MASERU' and council='Maseru Municipality' and village='Borokhoaneng';
update gii_hierarchy as gh set gh.lat='27.51339', gh.long='-29.358199' where district='MASERU' and council='Maseru Municipality' and village='Lower Seoli';


update gii_hierarchy as gh set gh.lat='27.507093', gh.long='-29.349999' where district='MASERU' and council='Maseru Municipality' and village='Ha Seoli';

update gii_hierarchy as gh set gh.lat='27.49662', gh.long='-29.360353' where district='MASERU' and council='Maseru Municipality' and village='Tsoapo Le Bolila';



update gii_hierarchy as gh set gh.lat='27.485819', gh.long='-29.358967' where district='MASERU' and council='Maseru Municipality' and village='Ha Ratsoana';
update gii_hierarchy as gh set gh.lat='27.473654', gh.long='-29.361052' where district='MASERU' and council='Maseru Municipality' and village='Ha Shelile';
update gii_hierarchy as gh set gh.lat='27.479659', gh.long='-29.357447' where district='MASERU' and council='Maseru Municipality' and village='Ha Chala';

update gii_hierarchy as gh set gh.lat='27.450936', gh.long='-29.364603' where district='MASERU' and council='Maseru Municipality' and village='Linakotseng';
update gii_hierarchy as gh set gh.lat='27.446587', gh.long='-29.378833' where district='MASERU' and council='Maseru Municipality' and village='Ha Ramakhetheng';
update gii_hierarchy as gh set gh.lat='27.44723', gh.long='-29.373866' where district='MASERU' and council='Maseru Municipality' and village='Ha Ramatsa';





update gii_hierarchy as gh set gh.lat='27.530048', gh.long='-29.368154' where district='MASERU' and council='Maseru Municipality' and village='Lebung';

update gii_hierarchy as gh set gh.lat='27.514206', gh.long='-29.36446' where district='MASERU' and council='Maseru Municipality' and village='Lithoteng';
update gii_hierarchy as gh set gh.lat='27.502184', gh.long='-29.360572' where district='MASERU' and council='Maseru Municipality' and village='Ha Rampeoane';
update gii_hierarchy as gh set gh.lat='27.50087', gh.long='-29.36499' where district='MASERU' and council='Maseru Municipality' and village='Mamenoaneng';


update gii_hierarchy as gh set gh.lat='27.520211', gh.long='-29.370416' where district='MASERU' and council='Maseru Municipality' and village='Ha Phakalasane';
update gii_hierarchy as gh set gh.lat='27.525761', gh.long='-29.371683' where district='MASERU' and council='Maseru Municipality' and village='Shalabeng';
update gii_hierarchy as gh set gh.lat='27.494051', gh.long='-29.369749' where district='MASERU' and council='Maseru Municipality' and village='Semphetenyane';
update gii_hierarchy as gh set gh.lat='27.517247', gh.long='-29.336039' where district='MASERU' and council='Maseru Municipality' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='27.522021', gh.long='-29.333375' where district='MASERU' and council='Maseru Municipality' and village='Mathokoane';
update gii_hierarchy as gh set gh.lat='27.521577', gh.long='-29.345886' where district='MASERU' and council='Maseru Municipality' and village='Lepereng';

update gii_hierarchy as gh set gh.lat='27.539453', gh.long='-29.34915' where district='MASERU' and council='Maseru Municipality' and village='Makoanyane';

update gii_hierarchy as gh set gh.lat='27.563449', gh.long='-29.353773' where district='MASERU' and council='Maseru Municipality' and village='Ha Khechane';


update gii_hierarchy as gh set gh.lat='27.560781', gh.long='-29.374314' where district='MASERU' and council='Maseru Municipality' and village='Ha Nelese';
update gii_hierarchy as gh set gh.lat='27.545444', gh.long='-29.370364' where district='MASERU' and council='Maseru Municipality' and village='Matala Phase Ii';

update gii_hierarchy as gh set gh.lat='27.547866', gh.long='-29.378418' where district='MASERU' and council='Maseru Municipality' and village='Matala Phase I';
update gii_hierarchy as gh set gh.lat='27.554388', gh.long='-29.382258' where district='MASERU' and council='Maseru Municipality' and village='Makhoakhoeng';
update gii_hierarchy as gh set gh.lat='27.534272', gh.long='-29.389507' where district='MASERU' and council='Maseru Municipality' and village='Ha Mapetla';
update gii_hierarchy as gh set gh.lat='28.048121', gh.long='-29.631272' where district='MASERU' and council='Maseru Municipality' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='27.52516', gh.long='-29.380442' where district='MASERU' and council='Maseru Municipality' and village='Khongoana Ntso';
update gii_hierarchy as gh set gh.lat='27.527421', gh.long='-29.377073' where district='MASERU' and council='Maseru Municipality' and village='Liraoeleng';
update gii_hierarchy as gh set gh.lat='27.521692', gh.long='-29.378261' where district='MASERU' and council='Maseru Municipality' and village='Mapeseleng';
update gii_hierarchy as gh set gh.lat='27.521466', gh.long='-29.384977' where district='MASERU' and council='Maseru Municipality' and village='Tsieng';
update gii_hierarchy as gh set gh.lat='27.517022', gh.long='-29.380968' where district='MASERU' and council='Maseru Municipality' and village='Ha Nkhahle';
update gii_hierarchy as gh set gh.lat='27.50952', gh.long='-29.381897' where district='MASERU' and council='Maseru Municipality' and village='Khubelu';
update gii_hierarchy as gh set gh.lat='27.519017', gh.long='-29.398437' where district='MASERU' and council='Maseru Municipality' and village='Ha Penapena';

update gii_hierarchy as gh set gh.lat='27.557746', gh.long='-29.39098' where district='MASERU' and council='Maseru Municipality' and village='Masianokeng';


update gii_hierarchy as gh set gh.lat='27.563025', gh.long='-29.368268' where district='MASERU' and council='Qiloane Council' and village='Mafikaneng (Ha Khechane)';
update gii_hierarchy as gh set gh.lat='27.564966', gh.long='-29.379648' where district='MASERU' and council='Qiloane Council' and village='Ha Bosofo';
update gii_hierarchy as gh set gh.lat='27.581438', gh.long='-29.385307' where district='MASERU' and council='Qiloane Council' and village='Ha Mpesi';
update gii_hierarchy as gh set gh.lat='27.582575', gh.long='-29.382153' where district='MASERU' and council='Qiloane Council' and village='Ha Rasenkisi';
update gii_hierarchy as gh set gh.lat='27.59055', gh.long='-29.375103' where district='MASERU' and council='Qiloane Council' and village='Ha Lenono';
update gii_hierarchy as gh set gh.lat='27.599005', gh.long='-29.376191' where district='MASERU' and council='Qiloane Council' and village='Ha Motsu';
update gii_hierarchy as gh set gh.lat='27.57257', gh.long='-29.35293' where district='MASERU' and council='Qiloane Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='27.610326', gh.long='-29.33314' where district='MASERU' and council='Qiloane Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='27.595228', gh.long='-29.355749' where district='MASERU' and council='Qiloane Council' and village='Ha Makhoathi';

update gii_hierarchy as gh set gh.lat='27.619847', gh.long='-29.333795' where district='MASERU' and council='Qiloane Council' and village='Ha Lephoi';
update gii_hierarchy as gh set gh.lat='27.629549', gh.long='-29.301173' where district='MASERU' and council='Qiloane Council' and village='Ha Teronko';
update gii_hierarchy as gh set gh.lat='27.614972', gh.long='-29.31462' where district='MASERU' and council='Qiloane Council' and village='Ha Tonki';
update gii_hierarchy as gh set gh.lat='27.631599', gh.long='-29.328425' where district='MASERU' and council='Qiloane Council' and village='Ha Sofonia';
update gii_hierarchy as gh set gh.lat='27.633979', gh.long='-29.335851' where district='MASERU' and council='Qiloane Council' and village='Ha Mohasoa';

update gii_hierarchy as gh set gh.lat='27.679672', gh.long='-29.351678' where district='MASERU' and council='Qiloane Council' and village='Ha Khoabane';
update gii_hierarchy as gh set gh.lat='27.683811', gh.long='-29.349193' where district='MASERU' and council='Qiloane Council' and village='Ha Mathula';
update gii_hierarchy as gh set gh.lat='27.697813', gh.long='-29.332169' where district='MASERU' and council='Qiloane Council' and village='Ha Qhali';
update gii_hierarchy as gh set gh.lat='27.594649', gh.long='-29.381816' where district='MASERU' and council='Qiloane Council' and village='Liphookoaneng';
update gii_hierarchy as gh set gh.lat='27.658892', gh.long='-29.358981' where district='MASERU' and council='Qiloane Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='27.668697', gh.long='-29.366041' where district='MASERU' and council='Qiloane Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.664171', gh.long='-29.348027' where district='MASERU' and council='Qiloane Council' and village='Ha Rafutho';
update gii_hierarchy as gh set gh.lat='27.664889', gh.long='-29.352546' where district='MASERU' and council='Qiloane Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='27.737256', gh.long='-29.573682' where district='MASERU' and council='Qiloane Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.671123', gh.long='-29.344925' where district='MASERU' and council='Qiloane Council' and village='Masekoeng';
update gii_hierarchy as gh set gh.lat='27.650966', gh.long='-29.357063' where district='MASERU' and council='Qiloane Council' and village='Lihaseng';
update gii_hierarchy as gh set gh.lat='27.638936', gh.long='-29.368252' where district='MASERU' and council='Qiloane Council' and village='Liolong';
update gii_hierarchy as gh set gh.lat='27.622764', gh.long='-29.362159' where district='MASERU' and council='Qiloane Council' and village='Sekantsing';
update gii_hierarchy as gh set gh.lat='27.628483', gh.long='-29.375455' where district='MASERU' and council='Qiloane Council' and village='Ha Mosalla';
update gii_hierarchy as gh set gh.lat='27.61132', gh.long='-29.385655' where district='MASERU' and council='Qiloane Council' and village='Ha Mohalanyane';
update gii_hierarchy as gh set gh.lat='27.624939', gh.long='-29.396996' where district='MASERU' and council='Qiloane Council' and village='Ha Ramoejane';
update gii_hierarchy as gh set gh.lat='27.618342', gh.long='-29.409474' where district='MASERU' and council='Qiloane Council' and village='Ha Makhalanyane';
update gii_hierarchy as gh set gh.lat='27.601432', gh.long='-29.405111' where district='MASERU' and council='Qiloane Council' and village='Ha Mothae';
update gii_hierarchy as gh set gh.lat='27.602928', gh.long='-29.394138' where district='MASERU' and council='Qiloane Council' and village='Ha Lesoiti';
update gii_hierarchy as gh set gh.lat='27.583249', gh.long='-29.407897' where district='MASERU' and council='Qiloane Council' and village='Ha Motloheloa';
update gii_hierarchy as gh set gh.lat='27.588471', gh.long='-29.418188' where district='MASERU' and council='Qiloane Council' and village='Ha Lekoro';
update gii_hierarchy as gh set gh.lat='27.601318', gh.long='-29.430858' where district='MASERU' and council='Qiloane Council' and village='Ha Nkhata';
update gii_hierarchy as gh set gh.lat='27.590154', gh.long='-29.433839' where district='MASERU' and council='Qiloane Council' and village='Ha Raphuthi';
update gii_hierarchy as gh set gh.lat='27.612008', gh.long='-29.42041' where district='MASERU' and council='Qiloane Council' and village='Ha Mamotho';
update gii_hierarchy as gh set gh.lat='27.59864', gh.long='-29.420225' where district='MASERU' and council='Qiloane Council' and village='Ha Rathoko';
update gii_hierarchy as gh set gh.lat='27.623102', gh.long='-29.413153' where district='MASERU' and council='Qiloane Council' and village='Ha Sekete';
update gii_hierarchy as gh set gh.lat='27.619077', gh.long='-29.422569' where district='MASERU' and council='Qiloane Council' and village='Monyakoana';
update gii_hierarchy as gh set gh.lat='27.628228', gh.long='-29.416321' where district='MASERU' and council='Qiloane Council' and village='Ha Maja';
update gii_hierarchy as gh set gh.lat='27.656825', gh.long='-29.397348' where district='MASERU' and council='Qiloane Council' and village='Khokhotsaneng';
update gii_hierarchy as gh set gh.lat='27.644708', gh.long='-29.414982' where district='MASERU' and council='Qiloane Council' and village='Mahlabatheng';
update gii_hierarchy as gh set gh.lat='27.632242', gh.long='-29.398347' where district='MASERU' and council='Qiloane Council' and village='Thaba Khupa';
update gii_hierarchy as gh set gh.lat='27.637629', gh.long='-29.405852' where district='MASERU' and council='Qiloane Council' and village='Ha Lithupa';



update gii_hierarchy as gh set gh.lat='27.663862', gh.long='-29.393284' where district='MASERU' and council='Qiloane Council' and village='Ha Ntlama';
update gii_hierarchy as gh set gh.lat='27.643693', gh.long='-29.399483' where district='MASERU' and council='Qiloane Council' and village='Ha Seeiso';
update gii_hierarchy as gh set gh.lat='27.69774', gh.long='-29.415784' where district='MASERU' and council='Qiloane Council' and village='Ha Rapheko';
update gii_hierarchy as gh set gh.lat='27.70083', gh.long='-29.393512' where district='MASERU' and council='Qiloane Council' and village='Ha Mohalenyane';
update gii_hierarchy as gh set gh.lat='27.691269', gh.long='-29.389138' where district='MASERU' and council='Qiloane Council' and village='Ha Ramakha';
update gii_hierarchy as gh set gh.lat='27.673957', gh.long='-29.379913' where district='MASERU' and council='Qiloane Council' and village='Ha Ntsane';
update gii_hierarchy as gh set gh.lat='27.790122', gh.long='-29.300983' where district='MASERU' and council='Ratau Council' and village='Ha Makopong';
update gii_hierarchy as gh set gh.lat='27.779956', gh.long='-29.311096' where district='MASERU' and council='Ratau Council' and village='Ha Mosoeu';
update gii_hierarchy as gh set gh.lat='27.744078', gh.long='-29.336363' where district='MASERU' and council='Ratau Council' and village='Ha Kapa';
update gii_hierarchy as gh set gh.lat='27.753855', gh.long='-29.321594' where district='MASERU' and council='Ratau Council' and village='Ha Kopano (Meeling)';

update gii_hierarchy as gh set gh.lat='27.794242', gh.long='-29.33563' where district='MASERU' and council='Ratau Council' and village='Ha Makotoko';
update gii_hierarchy as gh set gh.lat='27.754068', gh.long='-29.334868' where district='MASERU' and council='Ratau Council' and village='Ha Ramakabatane';
update gii_hierarchy as gh set gh.lat='27.762508', gh.long='-29.331537' where district='MASERU' and council='Ratau Council' and village='Ha Sekantsi';

update gii_hierarchy as gh set gh.lat='27.812921', gh.long='-29.321056' where district='MASERU' and council='Ratau Council' and village='Ha Masakale';






update gii_hierarchy as gh set gh.lat='27.824326', gh.long='-29.325916' where district='MASERU' and council='Ratau Council' and village='Ha Mosotho';
update gii_hierarchy as gh set gh.lat='27.812914', gh.long='-29.333615' where district='MASERU' and council='Ratau Council' and village='Ha Maimane';
update gii_hierarchy as gh set gh.lat='27.819344', gh.long='-29.330114' where district='MASERU' and council='Ratau Council' and village='Ha Matjeke';
update gii_hierarchy as gh set gh.lat='27.800546', gh.long='-29.330965' where district='MASERU' and council='Ratau Council' and village='Ha Ramakhaba';
update gii_hierarchy as gh set gh.lat='27.781782', gh.long='-29.342207' where district='MASERU' and council='Ratau Council' and village='Ha Makhale';
update gii_hierarchy as gh set gh.lat='27.774459', gh.long='-29.346241' where district='MASERU' and council='Ratau Council' and village='Ha Rachere';
update gii_hierarchy as gh set gh.lat='27.755925', gh.long='-29.351316' where district='MASERU' and council='Ratau Council' and village='Ha Nqosa';
update gii_hierarchy as gh set gh.lat='27.737372', gh.long='-29.366111' where district='MASERU' and council='Ratau Council' and village='Ha Ratau';


update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Ratau Council' and village='Motse mocha';

update gii_hierarchy as gh set gh.lat='27.703797', gh.long='-29.377398' where district='MASERU' and council='Ratau Council' and village='Ha Mothokho';
update gii_hierarchy as gh set gh.lat='27.70922', gh.long='-29.369503' where district='MASERU' and council='Ratau Council' and village='Ha Raanye';
update gii_hierarchy as gh set gh.lat='27.722366', gh.long='-29.397812' where district='MASERU' and council='Ratau Council' and village='Ha Mpao';
update gii_hierarchy as gh set gh.lat='27.721947', gh.long='-29.371872' where district='MASERU' and council='Ratau Council' and village='Ha Tjopa';
update gii_hierarchy as gh set gh.lat='27.706759', gh.long='-29.390733' where district='MASERU' and council='Ratau Council' and village='Ha Tumahole';
update gii_hierarchy as gh set gh.lat='27.718665', gh.long='-29.420364' where district='MASERU' and council='Ratau Council' and village='Ha Kubutu';
update gii_hierarchy as gh set gh.lat='27.703408', gh.long='-29.425024' where district='MASERU' and council='Ratau Council' and village='Ha Ralejoe';
update gii_hierarchy as gh set gh.lat='27.727758', gh.long='-29.422382' where district='MASERU' and council='Ratau Council' and village='Ha Phaloane';
update gii_hierarchy as gh set gh.lat='27.761162', gh.long='-29.375566' where district='MASERU' and council='Ratau Council' and village='Ha Matela';
update gii_hierarchy as gh set gh.lat='27.623102', gh.long='-29.413153' where district='MASERU' and council='Ratau Council' and village='Ha Sekete';
update gii_hierarchy as gh set gh.lat='27.749519', gh.long='-29.699542' where district='MASERU' and council='Ratau Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='27.665018', gh.long='-29.844' where district='MASERU' and council='Ratau Council' and village='Makatseng';
update gii_hierarchy as gh set gh.lat='27.765513', gh.long='-29.400185' where district='MASERU' and council='Ratau Council' and village='Ha Ntsi';
update gii_hierarchy as gh set gh.lat='27.764481', gh.long='-29.390309' where district='MASERU' and council='Ratau Council' and village='Ha Lekhutle';
update gii_hierarchy as gh set gh.lat='27.628396', gh.long='-29.36229' where district='MASERU' and council='Ratau Council' and village='Ha Majoro';
update gii_hierarchy as gh set gh.lat='27.784832', gh.long='-29.410362' where district='MASERU' and council='Ratau Council' and village='Ha Molengoane';

update gii_hierarchy as gh set gh.lat='27.770563', gh.long='-29.406961' where district='MASERU' and council='Ratau Council' and village='Ha Motleleng';
update gii_hierarchy as gh set gh.lat='27.764942', gh.long='-29.415097' where district='MASERU' and council='Ratau Council' and village='Ha Sechaba';

update gii_hierarchy as gh set gh.lat='27.714469', gh.long='-29.441253' where district='MASERU' and council='Ratau Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.769911', gh.long='-29.426085' where district='MASERU' and council='Ratau Council' and village='Ha Motjoka';
update gii_hierarchy as gh set gh.lat='27.793973', gh.long='-29.404085' where district='MASERU' and council='Ratau Council' and village='Thaha lia Tloka';
update gii_hierarchy as gh set gh.lat='27.80536', gh.long='-29.404755' where district='MASERU' and council='Ratau Council' and village='Toll Gate';
update gii_hierarchy as gh set gh.lat='27.781033', gh.long='-29.361392' where district='MASERU' and council='Ratau Council' and village='Ha Mpiti';
update gii_hierarchy as gh set gh.lat='27.831104', gh.long='-29.338855' where district='MASERU' and council='Ratau Council' and village='Ha Masupha';

update gii_hierarchy as gh set gh.lat='27.852082', gh.long='-29.348656' where district='MASERU' and council='Ratau Council' and village='Ha Rabotsoa';
update gii_hierarchy as gh set gh.lat='27.812941', gh.long='-29.3689' where district='MASERU' and council='Ratau Council' and village='Ha Lesaoana';
update gii_hierarchy as gh set gh.lat='27.798605', gh.long='-29.363989' where district='MASERU' and council='Ratau Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='27.803486', gh.long='-29.369361' where district='MASERU' and council='Ratau Council' and village='Ha Mofammere';


update gii_hierarchy as gh set gh.lat='27.800253', gh.long='-29.374152' where district='MASERU' and council='Ratau Council' and village='Ha Mapale';
update gii_hierarchy as gh set gh.lat='27.792366', gh.long='-29.371087' where district='MASERU' and council='Ratau Council' and village='Ha Moji';
update gii_hierarchy as gh set gh.lat='27.800764', gh.long='-29.391509' where district='MASERU' and council='Ratau Council' and village='Ha Rankota';
update gii_hierarchy as gh set gh.lat='27.620202', gh.long='-29.37617' where district='MASERU' and council='Ratau Council' and village='Ha Mosuoe';
update gii_hierarchy as gh set gh.lat='27.811106', gh.long='-29.384168' where district='MASERU' and council='Ratau Council' and village='Ha Mphuke';

update gii_hierarchy as gh set gh.lat='27.839978', gh.long='-29.397434' where district='MASERU' and council='Ratau Council' and village='Ha Lethena';
update gii_hierarchy as gh set gh.lat='27.836697', gh.long='-29.378031' where district='MASERU' and council='Ratau Council' and village='Ha Nkhema';
update gii_hierarchy as gh set gh.lat='27.874044', gh.long='-29.372571' where district='MASERU' and council='Ratau Council' and village='Ha Mokete';
update gii_hierarchy as gh set gh.lat='27.858954', gh.long='-29.379321' where district='MASERU' and council='Ratau Council' and village='Ha Sephoko';
update gii_hierarchy as gh set gh.lat='28.126334', gh.long='-29.645606' where district='MASERU' and council='Ratau Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.829589', gh.long='-29.403342' where district='MASERU' and council='Ratau Council' and village='Ha Seoehlana';
update gii_hierarchy as gh set gh.lat='27.816849', gh.long='-29.408493' where district='MASERU' and council='Ratau Council' and village='Ha Nqheku';


update gii_hierarchy as gh set gh.lat='27.806568', gh.long='-29.428452' where district='MASERU' and council='Ratau Council' and village='Ha Ramotsoane';
update gii_hierarchy as gh set gh.lat='27.796095', gh.long='-29.423833' where district='MASERU' and council='Ratau Council' and village='Ha Tsoili';

update gii_hierarchy as gh set gh.lat='27.779134', gh.long='-29.438319' where district='MASERU' and council='Ratau Council' and village='Malekokoana';
update gii_hierarchy as gh set gh.lat='27.770956', gh.long='-29.438196' where district='MASERU' and council='Ratau Council' and village='Mohlaka oa tuka';
update gii_hierarchy as gh set gh.lat='28.200712', gh.long='-29.339015' where district='MASERU' and council='Likalaneng Council' and village='Ha Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='28.190607', gh.long='-29.325263' where district='MASERU' and council='Likalaneng Council' and village='Monontsa';
update gii_hierarchy as gh set gh.lat='28.171406', gh.long='-29.360936' where district='MASERU' and council='Likalaneng Council' and village='Ha Lempe';
update gii_hierarchy as gh set gh.lat='28.177914', gh.long='-29.351244' where district='MASERU' and council='Likalaneng Council' and village='Ha Letele';
update gii_hierarchy as gh set gh.lat='27.714469', gh.long='-29.441253' where district='MASERU' and council='Likalaneng Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='28.048121', gh.long='-29.631272' where district='MASERU' and council='Likalaneng Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='28.118865', gh.long='-29.330346' where district='MASERU' and council='Likalaneng Council' and village='Ha Khojane';
update gii_hierarchy as gh set gh.lat='28.119965', gh.long='-29.348559' where district='MASERU' and council='Likalaneng Council' and village='Ha Pae pae';
update gii_hierarchy as gh set gh.lat='28.110869', gh.long='-29.356115' where district='MASERU' and council='Likalaneng Council' and village='Ha Moqobokoane';
update gii_hierarchy as gh set gh.lat='28.116721', gh.long='-29.372351' where district='MASERU' and council='Likalaneng Council' and village='Ha Sankong';
update gii_hierarchy as gh set gh.lat='28.123257', gh.long='-29.388995' where district='MASERU' and council='Likalaneng Council' and village='Ha Mokhathi';
update gii_hierarchy as gh set gh.lat='28.15357', gh.long='-29.37589' where district='MASERU' and council='Likalaneng Council' and village='Ha Raloti';

update gii_hierarchy as gh set gh.lat='28.099427', gh.long='-29.404086' where district='MASERU' and council='Likalaneng Council' and village='Ha Montsi';
update gii_hierarchy as gh set gh.lat='28.073347', gh.long='-29.396808' where district='MASERU' and council='Likalaneng Council' and village='Ha Nyakane';
update gii_hierarchy as gh set gh.lat='28.021265', gh.long='-29.34349' where district='MASERU' and council='Likalaneng Council' and village='Ha Soosa';
update gii_hierarchy as gh set gh.lat='28.005855', gh.long='-29.358833' where district='MASERU' and council='Likalaneng Council' and village='Leropong';
update gii_hierarchy as gh set gh.lat='28.026374', gh.long='-29.757587' where district='MASERU' and council='Likalaneng Council' and village='Letlapeng';


update gii_hierarchy as gh set gh.lat='27.459132', gh.long='-29.352618' where district='MASERU' and council='Likalaneng Council' and village='Ha Tsolo';
update gii_hierarchy as gh set gh.lat='28.044715', gh.long='-29.401127' where district='MASERU' and council='Likalaneng Council' and village='Ha Likomisi';

update gii_hierarchy as gh set gh.lat='28.020463', gh.long='-29.381951' where district='MASERU' and council='Likalaneng Council' and village='Sehlabaneng';
update gii_hierarchy as gh set gh.lat='28.014574', gh.long='-29.383582' where district='MASERU' and council='Likalaneng Council' and village='Tetebela';
update gii_hierarchy as gh set gh.lat='28.041204', gh.long='-29.41387' where district='MASERU' and council='Likalaneng Council' and village='Ha Makhobalo';
update gii_hierarchy as gh set gh.lat='28.036746', gh.long='-29.433868' where district='MASERU' and council='Likalaneng Council' and village='Ha Matsoai';
update gii_hierarchy as gh set gh.lat='28.037918', gh.long='-29.437637' where district='MASERU' and council='Likalaneng Council' and village='Ha Tholoana';
update gii_hierarchy as gh set gh.lat='28.049245', gh.long='-29.432765' where district='MASERU' and council='Likalaneng Council' and village='Ha Lebiletsa';
update gii_hierarchy as gh set gh.lat='28.044103', gh.long='-29.437149' where district='MASERU' and council='Likalaneng Council' and village='Ha Mphakho';
update gii_hierarchy as gh set gh.lat='28.061492', gh.long='-29.436855' where district='MASERU' and council='Likalaneng Council' and village='Ha Phomolo';
update gii_hierarchy as gh set gh.lat='28.004677', gh.long='-29.431578' where district='MASERU' and council='Likalaneng Council' and village='Ha Matlapu';
update gii_hierarchy as gh set gh.lat='28.096667', gh.long='-29.617871' where district='MASERU' and council='Likalaneng Council' and village='Matsiring';
update gii_hierarchy as gh set gh.lat='27.968682', gh.long='-29.431592' where district='MASERU' and council='Likalaneng Council' and village='Thaba Putsoa';

update gii_hierarchy as gh set gh.lat='28.02476', gh.long='-29.469616' where district='MASERU' and council='Likalaneng Council' and village='Khoshane';
update gii_hierarchy as gh set gh.lat='27.883396', gh.long='-29.429596' where district='MASERU' and council='Likalaneng Council' and village='Khubetsoana';




update gii_hierarchy as gh set gh.lat='28.036635', gh.long='-29.473244' where district='MASERU' and council='Likalaneng Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='28.032708', gh.long='-29.477575' where district='MASERU' and council='Likalaneng Council' and village='Mahooaneng';
update gii_hierarchy as gh set gh.lat='28.021675', gh.long='-29.486566' where district='MASERU' and council='Likalaneng Council' and village='Sethamana';
update gii_hierarchy as gh set gh.lat='28.059137', gh.long='-29.49367' where district='MASERU' and council='Likalaneng Council' and village='Ha Motloang';
update gii_hierarchy as gh set gh.lat='28.060913', gh.long='-29.484185' where district='MASERU' and council='Likalaneng Council' and village='Mafotholeng';
update gii_hierarchy as gh set gh.lat='28.074251', gh.long='-29.482226' where district='MASERU' and council='Likalaneng Council' and village='Boitsireletso';
update gii_hierarchy as gh set gh.lat='28.069735', gh.long='-29.485767' where district='MASERU' and council='Likalaneng Council' and village='Ha Mosito';
update gii_hierarchy as gh set gh.lat='28.0796', gh.long='-29.476038' where district='MASERU' and council='Likalaneng Council' and village='Ha Teri';
update gii_hierarchy as gh set gh.lat='28.088918', gh.long='-29.486953' where district='MASERU' and council='Likalaneng Council' and village='Ha Khama';
update gii_hierarchy as gh set gh.lat='28.094205', gh.long='-29.480747' where district='MASERU' and council='Likalaneng Council' and village='Ha Letapata';
update gii_hierarchy as gh set gh.lat='27.811075', gh.long='-29.687049' where district='MASERU' and council='Likalaneng Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.094548', gh.long='-29.515506' where district='MASERU' and council='Likalaneng Council' and village='Ha Seiboko';
update gii_hierarchy as gh set gh.lat='28.046713', gh.long='-29.559485' where district='MASERU' and council='Likalaneng Council' and village='Ha Mokebisa';
update gii_hierarchy as gh set gh.lat='28.075067', gh.long='-29.575731' where district='MASERU' and council='Likalaneng Council' and village='Ha Setala';
update gii_hierarchy as gh set gh.lat='28.111044', gh.long='-29.523446' where district='MASERU' and council='Likalaneng Council' and village='Ha Moalosi';
update gii_hierarchy as gh set gh.lat='28.11351', gh.long='-29.572719' where district='MASERU' and council='Likalaneng Council' and village='Ha Mokhanya';
update gii_hierarchy as gh set gh.lat='28.094182', gh.long='-29.574104' where district='MASERU' and council='Likalaneng Council' and village='Ha Rantelali';
update gii_hierarchy as gh set gh.lat='28.098081', gh.long='-29.565189' where district='MASERU' and council='Likalaneng Council' and village='Ha Rasepukunyane';
update gii_hierarchy as gh set gh.lat='28.101215', gh.long='-29.556954' where district='MASERU' and council='Likalaneng Council' and village='Ha Sefele';
update gii_hierarchy as gh set gh.lat='28.037938', gh.long='-29.577422' where district='MASERU' and council='Likalaneng Council' and village='Ha Mofubetsoana';
update gii_hierarchy as gh set gh.lat='28.066947', gh.long='-29.589225' where district='MASERU' and council='Likalaneng Council' and village='Makoaeleng';
update gii_hierarchy as gh set gh.lat='28.012255', gh.long='-29.624415' where district='MASERU' and council='Likalaneng Council' and village='Ha Matsabisa';
update gii_hierarchy as gh set gh.lat='28.046492', gh.long='-29.60208' where district='MASERU' and council='Likalaneng Council' and village='Ha Mochochoko';
update gii_hierarchy as gh set gh.lat='28.05315', gh.long='-29.610424' where district='MASERU' and council='Likalaneng Council' and village='Mangope matso';

update gii_hierarchy as gh set gh.lat='28.125037', gh.long='-29.556816' where district='MASERU' and council='Likalaneng Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='28.032389', gh.long='-29.628331' where district='MASERU' and council='Likalaneng Council' and village='Mokhoabong';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Likalaneng Council' and village='Aupolasi';

update gii_hierarchy as gh set gh.lat='28.137629', gh.long='-29.598734' where district='MASERU' and council='Likalaneng Council' and village='Ha Khosi';
update gii_hierarchy as gh set gh.lat='28.137727', gh.long='-29.582438' where district='MASERU' and council='Likalaneng Council' and village='Kolobere';
update gii_hierarchy as gh set gh.lat='28.151557', gh.long='-29.59065' where district='MASERU' and council='Likalaneng Council' and village='Lehlakeng';
update gii_hierarchy as gh set gh.lat='28.12918', gh.long='-29.582817' where district='MASERU' and council='Likalaneng Council' and village='Malerung';
update gii_hierarchy as gh set gh.lat='28.131944', gh.long='-29.579301' where district='MASERU' and council='Likalaneng Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.124103', gh.long='-29.605343' where district='MASERU' and council='Likalaneng Council' and village='Ha Maliehe';
update gii_hierarchy as gh set gh.lat='28.106075', gh.long='-29.591404' where district='MASERU' and council='Likalaneng Council' and village='Ha Tsitso';
update gii_hierarchy as gh set gh.lat='28.134349', gh.long='-29.612546' where district='MASERU' and council='Likalaneng Council' and village='Panteng';
update gii_hierarchy as gh set gh.lat='27.930338', gh.long='-29.421898' where district='MASERU' and council='Nyakosoba Council' and village='Ha Chalalisa';
update gii_hierarchy as gh set gh.lat='27.914367', gh.long='-29.420728' where district='MASERU' and council='Nyakosoba Council' and village='Ha Chere';
update gii_hierarchy as gh set gh.lat='27.91449', gh.long='-29.424142' where district='MASERU' and council='Nyakosoba Council' and village='Ha Jonase';

update gii_hierarchy as gh set gh.lat='27.893462', gh.long='-29.427957' where district='MASERU' and council='Nyakosoba Council' and village='Likoaring';

update gii_hierarchy as gh set gh.lat='27.88685', gh.long='-29.428163' where district='MASERU' and council='Nyakosoba Council' and village='Qiloane';
update gii_hierarchy as gh set gh.lat='27.899643', gh.long='-29.40834' where district='MASERU' and council='Nyakosoba Council' and village='Thota Peli';

update gii_hierarchy as gh set gh.lat='28.048121', gh.long='-29.631272' where district='MASERU' and council='Nyakosoba Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='27.877005', gh.long='-29.443395' where district='MASERU' and council='Nyakosoba Council' and village='Ha Kakae';

update gii_hierarchy as gh set gh.lat='27.881511', gh.long='-29.423148' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ralitseko';
update gii_hierarchy as gh set gh.lat='27.883396', gh.long='-29.429596' where district='MASERU' and council='Nyakosoba Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.881592', gh.long='-29.478186' where district='MASERU' and council='Nyakosoba Council' and village='Ha Leteba';
update gii_hierarchy as gh set gh.lat='27.882616', gh.long='-29.474665' where district='MASERU' and council='Nyakosoba Council' and village='Ha Nchakha';
update gii_hierarchy as gh set gh.lat='27.870094', gh.long='-29.471057' where district='MASERU' and council='Nyakosoba Council' and village='Litsaneng';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Nyakosoba Council' and village='Aupolasi';


update gii_hierarchy as gh set gh.lat='27.878118', gh.long='-29.489811' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mathibeli';
update gii_hierarchy as gh set gh.lat='27.854156', gh.long='-29.48912' where district='MASERU' and council='Nyakosoba Council' and village='Ha Motsie';
update gii_hierarchy as gh set gh.lat='27.865616', gh.long='-29.495595' where district='MASERU' and council='Nyakosoba Council' and village='Ha Sakia';
update gii_hierarchy as gh set gh.lat='27.888532', gh.long='-29.509142' where district='MASERU' and council='Nyakosoba Council' and village='Likolobeng';

update gii_hierarchy as gh set gh.lat='27.490555', gh.long='-29.350202' where district='MASERU' and council='Nyakosoba Council' and village='Ha Monyane';
update gii_hierarchy as gh set gh.lat='27.909692', gh.long='-29.497979' where district='MASERU' and council='Nyakosoba Council' and village='Ha Tseko';
update gii_hierarchy as gh set gh.lat='27.878868', gh.long='-29.517899' where district='MASERU' and council='Nyakosoba Council' and village='Ha Sebili';
update gii_hierarchy as gh set gh.lat='27.898016', gh.long='-29.425681' where district='MASERU' and council='Nyakosoba Council' and village='Ha Sempe';
update gii_hierarchy as gh set gh.lat='27.679909', gh.long='-29.679929' where district='MASERU' and council='Nyakosoba Council' and village='Mantsatlala';
update gii_hierarchy as gh set gh.lat='28.038752', gh.long='-29.639355' where district='MASERU' and council='Nyakosoba Council' and village='Terai Hoek';
update gii_hierarchy as gh set gh.lat='27.890773', gh.long='-29.548874' where district='MASERU' and council='Nyakosoba Council' and village='Ha Lekhooa';
update gii_hierarchy as gh set gh.lat='27.89143', gh.long='-29.541721' where district='MASERU' and council='Nyakosoba Council' and village='Ha Molibetsane';
update gii_hierarchy as gh set gh.lat='27.893458', gh.long='-29.550889' where district='MASERU' and council='Nyakosoba Council' and village='Koeneng';
update gii_hierarchy as gh set gh.lat='27.883865', gh.long='-29.532582' where district='MASERU' and council='Nyakosoba Council' and village='Ha Letebele';
update gii_hierarchy as gh set gh.lat='27.887216', gh.long='-29.549264' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mojela';
update gii_hierarchy as gh set gh.lat='27.881532', gh.long='-29.528333' where district='MASERU' and council='Nyakosoba Council' and village='Ha Sephali';
update gii_hierarchy as gh set gh.lat='27.886522', gh.long='-29.539649' where district='MASERU' and council='Nyakosoba Council' and village='Ha Thabo';
update gii_hierarchy as gh set gh.lat='27.866678', gh.long='-29.522829' where district='MASERU' and council='Nyakosoba Council' and village='Ha Qhomoqo';
update gii_hierarchy as gh set gh.lat='27.867976', gh.long='-29.513159' where district='MASERU' and council='Nyakosoba Council' and village='Maphakatlaling';
update gii_hierarchy as gh set gh.lat='27.793995', gh.long='-29.518101' where district='MASERU' and council='Nyakosoba Council' and village='Masaleng';


update gii_hierarchy as gh set gh.lat='27.835', gh.long='-29.501173' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mohlachane';
update gii_hierarchy as gh set gh.lat='27.830918', gh.long='-29.504747' where district='MASERU' and council='Nyakosoba Council' and village='Ha Suoane';
update gii_hierarchy as gh set gh.lat='27.858106', gh.long='-29.69703' where district='MASERU' and council='Nyakosoba Council' and village='Ha Moleko';



update gii_hierarchy as gh set gh.lat='27.80245', gh.long='-29.514116' where district='MASERU' and council='Nyakosoba Council' and village='Pheuoeng';
update gii_hierarchy as gh set gh.lat='27.775166', gh.long='-29.522006' where district='MASERU' and council='Nyakosoba Council' and village='Nyakosoba';
update gii_hierarchy as gh set gh.lat='27.783092', gh.long='-29.532466' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mabobola';
update gii_hierarchy as gh set gh.lat='27.774213', gh.long='-29.534156' where district='MASERU' and council='Nyakosoba Council' and village='Ha Masireletse';
update gii_hierarchy as gh set gh.lat='27.781461', gh.long='-29.537956' where district='MASERU' and council='Nyakosoba Council' and village='Kanana';
update gii_hierarchy as gh set gh.lat='27.802111', gh.long='-29.534917' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mofutisi';
update gii_hierarchy as gh set gh.lat='27.812226', gh.long='-29.545458' where district='MASERU' and council='Nyakosoba Council' and village='Ha Tsomo';
update gii_hierarchy as gh set gh.lat='27.777644', gh.long='-29.550455' where district='MASERU' and council='Nyakosoba Council' and village='Ha Macheli';
update gii_hierarchy as gh set gh.lat='27.770815', gh.long='-29.549511' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ngaka';
update gii_hierarchy as gh set gh.lat='27.772778', gh.long='-29.555116' where district='MASERU' and council='Nyakosoba Council' and village='Ngope Tsoeu';
update gii_hierarchy as gh set gh.lat='27.762806', gh.long='-29.564728' where district='MASERU' and council='Nyakosoba Council' and village='Ha Leronti';
update gii_hierarchy as gh set gh.lat='27.718665', gh.long='-29.420364' where district='MASERU' and council='Nyakosoba Council' and village='Ha Kubutu';
update gii_hierarchy as gh set gh.lat='27.801337', gh.long='-29.57973' where district='MASERU' and council='Nyakosoba Council' and village='Ha Makafane';
update gii_hierarchy as gh set gh.lat='27.822057', gh.long='-29.584777' where district='MASERU' and council='Nyakosoba Council' and village='Ha Rasemousu';
update gii_hierarchy as gh set gh.lat='27.85376', gh.long='-29.570491' where district='MASERU' and council='Nyakosoba Council' and village='Bolatella';
update gii_hierarchy as gh set gh.lat='27.858323', gh.long='-29.56499' where district='MASERU' and council='Nyakosoba Council' and village='Ha Maoela';
update gii_hierarchy as gh set gh.lat='27.86046', gh.long='-29.549231' where district='MASERU' and council='Nyakosoba Council' and village='Ha Moloi';
update gii_hierarchy as gh set gh.lat='27.852122', gh.long='-29.558273' where district='MASERU' and council='Nyakosoba Council' and village='Ha Nkoankoa';
update gii_hierarchy as gh set gh.lat='27.858673', gh.long='-29.57926' where district='MASERU' and council='Nyakosoba Council' and village='Likhutlong';
update gii_hierarchy as gh set gh.lat='27.869885', gh.long='-29.569103' where district='MASERU' and council='Nyakosoba Council' and village='Ha Khanyetsi';
update gii_hierarchy as gh set gh.lat='27.868675', gh.long='-29.576253' where district='MASERU' and council='Nyakosoba Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='27.880738', gh.long='-29.566006' where district='MASERU' and council='Nyakosoba Council' and village='Tsoeneng';
update gii_hierarchy as gh set gh.lat='27.886627', gh.long='-29.577054' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ntlale';
update gii_hierarchy as gh set gh.lat='27.896826', gh.long='-29.581044' where district='MASERU' and council='Nyakosoba Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='27.867038', gh.long='-29.591056' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ntahli';
update gii_hierarchy as gh set gh.lat='27.866157', gh.long='-29.605704' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ramothibeli';
update gii_hierarchy as gh set gh.lat='27.900307', gh.long='-29.57065' where district='MASERU' and council='Nyakosoba Council' and village='Ha Lekatanyane';
update gii_hierarchy as gh set gh.lat='27.936059', gh.long='-29.547749' where district='MASERU' and council='Nyakosoba Council' and village='Ha Penane';

update gii_hierarchy as gh set gh.lat='27.912759', gh.long='-29.578267' where district='MASERU' and council='Nyakosoba Council' and village='Ha Lepeli';
update gii_hierarchy as gh set gh.lat='27.931999', gh.long='-29.582639' where district='MASERU' and council='Nyakosoba Council' and village='Ha Mpota';
update gii_hierarchy as gh set gh.lat='27.902744', gh.long='-29.583641' where district='MASERU' and council='Nyakosoba Council' and village='Ha Ntai';
update gii_hierarchy as gh set gh.lat='27.906219', gh.long='-29.591999' where district='MASERU' and council='Nyakosoba Council' and village='Ha Thakeli';

update gii_hierarchy as gh set gh.lat='27.964805', gh.long='-29.603554' where district='MASERU' and council='Nyakosoba Council' and village='Hloahloeng';
update gii_hierarchy as gh set gh.lat='28.036635', gh.long='-29.473244' where district='MASERU' and council='Nyakosoba Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='27.960138', gh.long='-29.621636' where district='MASERU' and council='Nyakosoba Council' and village='Ha Choatlella';

update gii_hierarchy as gh set gh.lat='27.904198', gh.long='-29.5977' where district='MASERU' and council='Makheka Council' and village='Ha Andreas';
update gii_hierarchy as gh set gh.lat='27.889424', gh.long='-29.596376' where district='MASERU' and council='Makheka Council' and village='Ha Tabo';
update gii_hierarchy as gh set gh.lat='27.881854', gh.long='-29.604048' where district='MASERU' and council='Makheka Council' and village='Meritjaneng';

update gii_hierarchy as gh set gh.lat='27.943138', gh.long='-29.634922' where district='MASERU' and council='Makheka Council' and village='Ha Lerumonyane';
update gii_hierarchy as gh set gh.lat='27.907601', gh.long='-29.636508' where district='MASERU' and council='Makheka Council' and village='Ha Setenane';
update gii_hierarchy as gh set gh.lat='27.913682', gh.long='-29.621817' where district='MASERU' and council='Makheka Council' and village='Ha Tsese';
update gii_hierarchy as gh set gh.lat='27.913887', gh.long='-29.658769' where district='MASERU' and council='Makheka Council' and village='Ha Fochane';
update gii_hierarchy as gh set gh.lat='27.917865', gh.long='-29.645173' where district='MASERU' and council='Makheka Council' and village='Ha Mateu';
update gii_hierarchy as gh set gh.lat='27.884561', gh.long='-29.617395' where district='MASERU' and council='Makheka Council' and village='Ha Tsokotsa';
update gii_hierarchy as gh set gh.lat='27.843748', gh.long='-29.642187' where district='MASERU' and council='Makheka Council' and village='Ha Ramokone';
update gii_hierarchy as gh set gh.lat='27.862194', gh.long='-29.625884' where district='MASERU' and council='Makheka Council' and village='Likhameng';
update gii_hierarchy as gh set gh.lat='27.832674', gh.long='-29.650993' where district='MASERU' and council='Makheka Council' and village='Matsatseng';
update gii_hierarchy as gh set gh.lat='27.882899', gh.long='-29.630152' where district='MASERU' and council='Makheka Council' and village='Serutle';
update gii_hierarchy as gh set gh.lat='27.851364', gh.long='-29.655345' where district='MASERU' and council='Makheka Council' and village='Ha Chadwick';
update gii_hierarchy as gh set gh.lat='27.868784', gh.long='-29.650151' where district='MASERU' and council='Makheka Council' and village='Ha Tsepo';
update gii_hierarchy as gh set gh.lat='27.863839', gh.long='-29.658124' where district='MASERU' and council='Makheka Council' and village='Phootle';

update gii_hierarchy as gh set gh.lat='27.903918', gh.long='-29.65635' where district='MASERU' and council='Makheka Council' and village='Ha Malete';
update gii_hierarchy as gh set gh.lat='27.896538', gh.long='-29.656163' where district='MASERU' and council='Makheka Council' and village='Ha Totlelase';
update gii_hierarchy as gh set gh.lat='28.131944', gh.long='-29.579301' where district='MASERU' and council='Makheka Council' and village='Moeaneng';

update gii_hierarchy as gh set gh.lat='27.92739', gh.long='-29.677068' where district='MASERU' and council='Makheka Council' and village='Ha Makubeletsane';
update gii_hierarchy as gh set gh.lat='27.762508', gh.long='-29.331537' where district='MASERU' and council='Makheka Council' and village='Ha Sekantsi';
update gii_hierarchy as gh set gh.lat='27.854387', gh.long='-29.675233' where district='MASERU' and council='Makheka Council' and village='Ha Taole';
update gii_hierarchy as gh set gh.lat='27.881168', gh.long='-29.677331' where district='MASERU' and council='Makheka Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='27.935939', gh.long='-29.597648' where district='MASERU' and council='Makheka Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='27.882813', gh.long='-29.705489' where district='MASERU' and council='Makheka Council' and village='Ha Mphephe';
update gii_hierarchy as gh set gh.lat='27.891842', gh.long='-29.710233' where district='MASERU' and council='Makheka Council' and village='Ha Setofolo';
update gii_hierarchy as gh set gh.lat='27.846885', gh.long='-29.691626' where district='MASERU' and council='Makheka Council' and village='Ha Keleke';
update gii_hierarchy as gh set gh.lat='27.858106', gh.long='-29.69703' where district='MASERU' and council='Makheka Council' and village='Ha Moleko';
update gii_hierarchy as gh set gh.lat='27.834556', gh.long='-29.696695' where district='MASERU' and council='Makheka Council' and village='Ha Ramokhobo';
update gii_hierarchy as gh set gh.lat='27.831202', gh.long='-29.656897' where district='MASERU' and council='Makheka Council' and village='Ha Malebatsi';
update gii_hierarchy as gh set gh.lat='27.823733', gh.long='-29.648428' where district='MASERU' and council='Makheka Council' and village='Ha Mankata';
update gii_hierarchy as gh set gh.lat='27.83888', gh.long='-29.655424' where district='MASERU' and council='Makheka Council' and village='Ha Mantsa';
update gii_hierarchy as gh set gh.lat='27.832384', gh.long='-29.661295' where district='MASERU' and council='Makheka Council' and village='Ha Marai';

update gii_hierarchy as gh set gh.lat='27.820823', gh.long='-29.674518' where district='MASERU' and council='Makheka Council' and village='Ha Ramosebo';
update gii_hierarchy as gh set gh.lat='27.836922', gh.long='-29.6797' where district='MASERU' and council='Makheka Council' and village='Ha Setere';

update gii_hierarchy as gh set gh.lat='27.714469', gh.long='-29.441253' where district='MASERU' and council='Makheka Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.802772', gh.long='-29.693325' where district='MASERU' and council='Makheka Council' and village='Ha Elia';
update gii_hierarchy as gh set gh.lat='27.803346', gh.long='-29.682162' where district='MASERU' and council='Makheka Council' and village='Ha Mphafolane';
update gii_hierarchy as gh set gh.lat='27.81737', gh.long='-29.720642' where district='MASERU' and council='Makheka Council' and village='Ha Chechane';
update gii_hierarchy as gh set gh.lat='27.650129', gh.long='-29.844513' where district='MASERU' and council='Makheka Council' and village='Ha Molai';
update gii_hierarchy as gh set gh.lat='27.82151', gh.long='-29.697055' where district='MASERU' and council='Makheka Council' and village='Ha Molomo';

update gii_hierarchy as gh set gh.lat='27.786149', gh.long='-29.691118' where district='MASERU' and council='Makheka Council' and village='Ha Moseme';
update gii_hierarchy as gh set gh.lat='27.473655', gh.long='-29.528058' where district='MASERU' and council='Makheka Council' and village='Ha Sekoati';
update gii_hierarchy as gh set gh.lat='27.777571', gh.long='-29.712241' where district='MASERU' and council='Makheka Council' and village='Khubetsoana';

update gii_hierarchy as gh set gh.lat='27.684819', gh.long='-29.424959' where district='MASERU' and council='Manonyane Council' and village='Ha Machai';
update gii_hierarchy as gh set gh.lat='27.679677', gh.long='-29.429683' where district='MASERU' and council='Manonyane Council' and village='Ha Pasane';
update gii_hierarchy as gh set gh.lat='27.663481', gh.long='-29.433161' where district='MASERU' and council='Manonyane Council' and village='Ha Tseliso';



update gii_hierarchy as gh set gh.lat='27.680167', gh.long='-29.438884' where district='MASERU' and council='Manonyane Council' and village='Ha Makoili';



update gii_hierarchy as gh set gh.lat='27.718502', gh.long='-29.428536' where district='MASERU' and council='Manonyane Council' and village='Ha Soibilane';

update gii_hierarchy as gh set gh.lat='27.748126', gh.long='-29.442094' where district='MASERU' and council='Manonyane Council' and village='Ha Seqoma';

update gii_hierarchy as gh set gh.lat='27.727319', gh.long='-29.4502' where district='MASERU' and council='Manonyane Council' and village='Hata Butle';
update gii_hierarchy as gh set gh.lat='27.703867', gh.long='-29.438761' where district='MASERU' and council='Manonyane Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='27.702008', gh.long='-29.443061' where district='MASERU' and council='Manonyane Council' and village='Mahlanyeng';
update gii_hierarchy as gh set gh.lat='27.714469', gh.long='-29.441253' where district='MASERU' and council='Manonyane Council' and village='Thoteng';

update gii_hierarchy as gh set gh.lat='27.719456', gh.long='-29.453413' where district='MASERU' and council='Manonyane Council' and village='Mafikeng';




update gii_hierarchy as gh set gh.lat='27.706777', gh.long='-29.448569' where district='MASERU' and council='Manonyane Council' and village='Ha Lehloba';

update gii_hierarchy as gh set gh.lat='27.673286', gh.long='-29.46173' where district='MASERU' and council='Manonyane Council' and village='Ha Motanyane';
update gii_hierarchy as gh set gh.lat='27.681137', gh.long='-29.475625' where district='MASERU' and council='Manonyane Council' and village='Ha Meshaka';
update gii_hierarchy as gh set gh.lat='27.671261', gh.long='-29.469038' where district='MASERU' and council='Manonyane Council' and village='Ha Mokhohla';

update gii_hierarchy as gh set gh.lat='27.68542', gh.long='-29.462763' where district='MASERU' and council='Manonyane Council' and village='Ha Morabaki';


update gii_hierarchy as gh set gh.lat='27.694148', gh.long='-29.463644' where district='MASERU' and council='Manonyane Council' and village='Ha Maama';
update gii_hierarchy as gh set gh.lat='27.571028', gh.long='-29.604942' where district='MASERU' and council='Manonyane Council' and village='Ha Paanya';
update gii_hierarchy as gh set gh.lat='27.801337', gh.long='-29.57973' where district='MASERU' and council='Manonyane Council' and village='Ha Makafane';

update gii_hierarchy as gh set gh.lat='27.711772', gh.long='-29.459776' where district='MASERU' and council='Manonyane Council' and village='Ha Ntsibane';


update gii_hierarchy as gh set gh.lat='27.711723', gh.long='-29.61919' where district='MASERU' and council='Manonyane Council' and village='Ha Tlapana';



update gii_hierarchy as gh set gh.lat='27.75735', gh.long='-29.455458' where district='MASERU' and council='Manonyane Council' and village='Ha Shale';



update gii_hierarchy as gh set gh.lat='27.733274', gh.long='-29.465907' where district='MASERU' and council='Manonyane Council' and village='Ha Mafefooane';


update gii_hierarchy as gh set gh.lat='27.740269', gh.long='-29.477922' where district='MASERU' and council='Manonyane Council' and village='Maphotong';
update gii_hierarchy as gh set gh.lat='27.682302', gh.long='-29.496588' where district='MASERU' and council='Manonyane Council' and village='Ha Khoarai';
update gii_hierarchy as gh set gh.lat='27.687169', gh.long='-29.497952' where district='MASERU' and council='Manonyane Council' and village='Ha Maribenyane';
update gii_hierarchy as gh set gh.lat='27.727134', gh.long='-29.50761' where district='MASERU' and council='Manonyane Council' and village='Ha Motebele';
update gii_hierarchy as gh set gh.lat='27.720946', gh.long='-29.510633' where district='MASERU' and council='Manonyane Council' and village='Likhorong';
update gii_hierarchy as gh set gh.lat='28.160789', gh.long='-29.640153' where district='MASERU' and council='Manonyane Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='27.727671', gh.long='-29.49632' where district='MASERU' and council='Manonyane Council' and village='Ha Mabathoana';
update gii_hierarchy as gh set gh.lat='27.732908', gh.long='-29.491652' where district='MASERU' and council='Manonyane Council' and village='Ha Filipi';
update gii_hierarchy as gh set gh.lat='27.740533', gh.long='-29.483666' where district='MASERU' and council='Manonyane Council' and village='Ha Maese';

update gii_hierarchy as gh set gh.lat='27.751667', gh.long='-29.496443' where district='MASERU' and council='Manonyane Council' and village='Ha Morema';
update gii_hierarchy as gh set gh.lat='27.763714', gh.long='-29.483719' where district='MASERU' and council='Manonyane Council' and village='Fika le Motho';
update gii_hierarchy as gh set gh.lat='27.750349', gh.long='-29.48402' where district='MASERU' and council='Manonyane Council' and village='Ha Matiase';

update gii_hierarchy as gh set gh.lat='27.782016', gh.long='-29.478374' where district='MASERU' and council='Manonyane Council' and village='Ha Kholoko';
update gii_hierarchy as gh set gh.lat='27.883396', gh.long='-29.429596' where district='MASERU' and council='Manonyane Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.803409', gh.long='-29.507164' where district='MASERU' and council='Manonyane Council' and village='Ha Mokela';
update gii_hierarchy as gh set gh.lat='27.775139', gh.long='-29.505108' where district='MASERU' and council='Manonyane Council' and village='Ha Monyooe';
update gii_hierarchy as gh set gh.lat='27.764633', gh.long='-29.505927' where district='MASERU' and council='Manonyane Council' and village='Ha Tlapole';
update gii_hierarchy as gh set gh.lat='27.751333', gh.long='-29.505188' where district='MASERU' and council='Manonyane Council' and village='Ha Lebamang';


update gii_hierarchy as gh set gh.lat='27.747607', gh.long='-29.523304' where district='MASERU' and council='Manonyane Council' and village='Ha Patrick';

update gii_hierarchy as gh set gh.lat='27.583974', gh.long='-29.706014' where district='MASERU' and council='Manonyane Council' and village='Ha Tsehlo';
update gii_hierarchy as gh set gh.lat='27.574327', gh.long='-29.424894' where district='MASERU' and council='Mohlakeng Council' and village='Ha Nko';
update gii_hierarchy as gh set gh.lat='27.574703', gh.long='-29.431212' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lekopa';



update gii_hierarchy as gh set gh.lat='27.565543', gh.long='-29.441592' where district='MASERU' and council='Mohlakeng Council' and village='Ha Takalimane';
update gii_hierarchy as gh set gh.lat='27.566069', gh.long='-29.447281' where district='MASERU' and council='Mohlakeng Council' and village='Ha Luka';

update gii_hierarchy as gh set gh.lat='27.584053', gh.long='-29.477955' where district='MASERU' and council='Mohlakeng Council' and village='Ha Ramokotjo';
update gii_hierarchy as gh set gh.lat='27.569144', gh.long='-29.466265' where district='MASERU' and council='Mohlakeng Council' and village='Ha Sefuli';
update gii_hierarchy as gh set gh.lat='27.579353', gh.long='-29.452723' where district='MASERU' and council='Mohlakeng Council' and village='Ha Tlebere';
update gii_hierarchy as gh set gh.lat='27.598519', gh.long='-29.447084' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lihanela';
update gii_hierarchy as gh set gh.lat='27.598775', gh.long='-29.455883' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mohlakaso';
update gii_hierarchy as gh set gh.lat='27.591168', gh.long='-29.447095' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mphoto';

update gii_hierarchy as gh set gh.lat='27.641067', gh.long='-29.432893' where district='MASERU' and council='Mohlakeng Council' and village='Ha Liile';
update gii_hierarchy as gh set gh.lat='27.64852', gh.long='-29.447006' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lekete';
update gii_hierarchy as gh set gh.lat='27.602372', gh.long='-29.460879' where district='MASERU' and council='Mohlakeng Council' and village='Ha Katu';
update gii_hierarchy as gh set gh.lat='27.60387', gh.long='-29.454501' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mokoena';
update gii_hierarchy as gh set gh.lat='27.593633', gh.long='-29.46659' where district='MASERU' and council='Mohlakeng Council' and village='Ha Makhoba';
update gii_hierarchy as gh set gh.lat='27.578084', gh.long='-29.4923' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='27.582081', gh.long='-29.496179' where district='MASERU' and council='Mohlakeng Council' and village='Mokunutlung';
update gii_hierarchy as gh set gh.lat='27.601126', gh.long='-29.4768' where district='MASERU' and council='Mohlakeng Council' and village='Ha Ramohajane';
update gii_hierarchy as gh set gh.lat='27.632245', gh.long='-29.460128' where district='MASERU' and council='Mohlakeng Council' and village='Ha Foto';
update gii_hierarchy as gh set gh.lat='27.645184', gh.long='-29.464417' where district='MASERU' and council='Mohlakeng Council' and village='Koma Koma';
update gii_hierarchy as gh set gh.lat='27.659746', gh.long='-29.477491' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lebakae';
update gii_hierarchy as gh set gh.lat='27.517247', gh.long='-29.336039' where district='MASERU' and council='Mohlakeng Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='28.061889', gh.long='-29.505941' where district='MASERU' and council='Mohlakeng Council' and village='Ha Moholobela';
update gii_hierarchy as gh set gh.lat='27.71451', gh.long='-29.559118' where district='MASERU' and council='Mohlakeng Council' and village='Ha Rampoetsi';
update gii_hierarchy as gh set gh.lat='27.639917', gh.long='-29.486466' where district='MASERU' and council='Mohlakeng Council' and village='Ha Rantsetse';


update gii_hierarchy as gh set gh.lat='27.642038', gh.long='-29.499912' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mahlelebe';
update gii_hierarchy as gh set gh.lat='27.658207', gh.long='-29.496998' where district='MASERU' and council='Mohlakeng Council' and village='Falatsa';
update gii_hierarchy as gh set gh.lat='27.67074', gh.long='-29.499968' where district='MASERU' and council='Mohlakeng Council' and village='Ha Khoeli';

update gii_hierarchy as gh set gh.lat='27.674544', gh.long='-29.50075' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mosaeea';


update gii_hierarchy as gh set gh.lat='27.657081', gh.long='-29.529427' where district='MASERU' and council='Mohlakeng Council' and village='Ha Thabiso';
update gii_hierarchy as gh set gh.lat='27.639577', gh.long='-29.508336' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mapeshoane';

update gii_hierarchy as gh set gh.lat='28.066947', gh.long='-29.589225' where district='MASERU' and council='Mohlakeng Council' and village='Makoaeleng';

update gii_hierarchy as gh set gh.lat='27.590815', gh.long='-29.501744' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mofoka';


update gii_hierarchy as gh set gh.lat='27.751333', gh.long='-29.505188' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lebamang';
update gii_hierarchy as gh set gh.lat='27.577746', gh.long='-29.503147' where district='MASERU' and council='Mohlakeng Council' and village='Qhuqhu';


update gii_hierarchy as gh set gh.lat='27.854387', gh.long='-29.675233' where district='MASERU' and council='Mohlakeng Council' and village='Ha Taole';
update gii_hierarchy as gh set gh.lat='27.618679', gh.long='-29.55685' where district='MASERU' and council='Mohlakeng Council' and village='Meru Metso';
update gii_hierarchy as gh set gh.lat='27.636135', gh.long='-29.525621' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mokuoane';
update gii_hierarchy as gh set gh.lat='27.749519', gh.long='-29.699542' where district='MASERU' and council='Mohlakeng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='27.644923', gh.long='-29.523544' where district='MASERU' and council='Mohlakeng Council' and village='Tholang';
update gii_hierarchy as gh set gh.lat='27.681115', gh.long='-29.545381' where district='MASERU' and council='Mohlakeng Council' and village='Ha Seturumane';


update gii_hierarchy as gh set gh.lat='27.693077', gh.long='-29.518027' where district='MASERU' and council='Mohlakeng Council' and village='Ha Raboshabane';
update gii_hierarchy as gh set gh.lat='27.724997', gh.long='-29.551708' where district='MASERU' and council='Mohlakeng Council' and village='Ha Kobefu';
update gii_hierarchy as gh set gh.lat='27.705868', gh.long='-29.554848' where district='MASERU' and council='Mohlakeng Council' and village='Ha Ralisene';


update gii_hierarchy as gh set gh.lat='27.67424', gh.long='-29.550626' where district='MASERU' and council='Mohlakeng Council' and village='Ha Makhori';
update gii_hierarchy as gh set gh.lat='27.686276', gh.long='-29.543675' where district='MASERU' and council='Mohlakeng Council' and village='Ha Thakali';
update gii_hierarchy as gh set gh.lat='27.649306', gh.long='-29.548895' where district='MASERU' and council='Mohlakeng Council' and village='Ha Lesoli';
update gii_hierarchy as gh set gh.lat='27.63943', gh.long='-29.550833' where district='MASERU' and council='Mohlakeng Council' and village='Ha Limo';

update gii_hierarchy as gh set gh.lat='27.637806', gh.long='-29.540777' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mothibe';
update gii_hierarchy as gh set gh.lat='27.621156', gh.long='-29.572356' where district='MASERU' and council='Mohlakeng Council' and village='Mothating';
update gii_hierarchy as gh set gh.lat='27.645378', gh.long='-29.590538' where district='MASERU' and council='Mohlakeng Council' and village='Ha Motente';
update gii_hierarchy as gh set gh.lat='27.645559', gh.long='-29.60609' where district='MASERU' and council='Mohlakeng Council' and village='Ha Talinyana';
update gii_hierarchy as gh set gh.lat='27.650934', gh.long='-29.601045' where district='MASERU' and council='Mohlakeng Council' and village='Ha Tseana';
update gii_hierarchy as gh set gh.lat='27.697017', gh.long='-29.550022' where district='MASERU' and council='Mohlakeng Council' and village='Ha Motlepu';
update gii_hierarchy as gh set gh.lat='27.695451', gh.long='-29.561474' where district='MASERU' and council='Mohlakeng Council' and village='Ha Setoaba';
update gii_hierarchy as gh set gh.lat='27.679076', gh.long='-29.57423' where district='MASERU' and council='Mohlakeng Council' and village='Telle';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Mohlakeng Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='27.711181', gh.long='-29.572943' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mafisa';
update gii_hierarchy as gh set gh.lat='27.70243', gh.long='-29.586783' where district='MASERU' and council='Mohlakeng Council' and village='Ha Mohaka';

update gii_hierarchy as gh set gh.lat='27.449581', gh.long='-29.399788' where district='MASERU' and council='Mazenod Council' and village='Ha Ramorakane';
update gii_hierarchy as gh set gh.lat='27.427139', gh.long='-29.422268' where district='MASERU' and council='Mazenod Council' and village='Ha Matebesi';
update gii_hierarchy as gh set gh.lat='27.435848', gh.long='-29.40207' where district='MASERU' and council='Mazenod Council' and village='Ha Ntsane';
update gii_hierarchy as gh set gh.lat='27.430227', gh.long='-29.406034' where district='MASERU' and council='Mazenod Council' and village='Ha Setho';
update gii_hierarchy as gh set gh.lat='27.432938', gh.long='-29.428305' where district='MASERU' and council='Mazenod Council' and village='Ha Thokoa';

update gii_hierarchy as gh set gh.lat='28.025711', gh.long='-29.909261' where district='MASERU' and council='Mazenod Council' and village='Moriting';
update gii_hierarchy as gh set gh.lat='27.440467', gh.long='-29.405331' where district='MASERU' and council='Mazenod Council' and village='Ha Masenkane';

update gii_hierarchy as gh set gh.lat='27.472971', gh.long='-29.412801' where district='MASERU' and council='Mazenod Council' and village='Ha Teko';
update gii_hierarchy as gh set gh.lat='27.469441', gh.long='-29.423117' where district='MASERU' and council='Mazenod Council' and village='Matukeng';
update gii_hierarchy as gh set gh.lat='27.497533', gh.long='-29.4152' where district='MASERU' and council='Mazenod Council' and village='Ha Au';
update gii_hierarchy as gh set gh.lat='27.506075', gh.long='-29.411146' where district='MASERU' and council='Mazenod Council' and village='Ha Tseka';
update gii_hierarchy as gh set gh.lat='27.538779', gh.long='-29.406507' where district='MASERU' and council='Mazenod Council' and village='Ha Jimisi';




update gii_hierarchy as gh set gh.lat='27.546219', gh.long='-29.428681' where district='MASERU' and council='Mazenod Council' and village='Machekoaneng';
update gii_hierarchy as gh set gh.lat='27.522986', gh.long='-29.422992' where district='MASERU' and council='Mazenod Council' and village='Baloing';
update gii_hierarchy as gh set gh.lat='27.526629', gh.long='-29.417577' where district='MASERU' and council='Mazenod Council' and village='Ha Malefane';
update gii_hierarchy as gh set gh.lat='27.529845', gh.long='-29.434658' where district='MASERU' and council='Mazenod Council' and village='Ha Chaka';

update gii_hierarchy as gh set gh.lat='27.541748', gh.long='-29.444743' where district='MASERU' and council='Mazenod Council' and village='Ha Pomela';
update gii_hierarchy as gh set gh.lat='27.543021', gh.long='-29.45216' where district='MASERU' and council='Mazenod Council' and village='Ha Masana';
update gii_hierarchy as gh set gh.lat='27.550341', gh.long='-29.454621' where district='MASERU' and council='Mazenod Council' and village='Ha Josiase';


update gii_hierarchy as gh set gh.lat='27.561055', gh.long='-29.497509' where district='MASERU' and council='Mazenod Council' and village='Ha Khitione';
update gii_hierarchy as gh set gh.lat='27.566923', gh.long='-29.482547' where district='MASERU' and council='Mazenod Council' and village='Ha Seqhatsi';
update gii_hierarchy as gh set gh.lat='27.54676', gh.long='-29.503147' where district='MASERU' and council='Mazenod Council' and village='Ha Motemekoane';
update gii_hierarchy as gh set gh.lat='27.522045', gh.long='-29.487124' where district='MASERU' and council='Mazenod Council' and village='Ha Mantsebo';
update gii_hierarchy as gh set gh.lat='27.525624', gh.long='-29.521757' where district='MASERU' and council='Mazenod Council' and village='Ha Maphatsoe';
update gii_hierarchy as gh set gh.lat='27.52375', gh.long='-29.499896' where district='MASERU' and council='Mazenod Council' and village='Ha Pita';


update gii_hierarchy as gh set gh.lat='27.509965', gh.long='-29.511814' where district='MASERU' and council='Mazenod Council' and village='Ha Cheboko';

update gii_hierarchy as gh set gh.lat='28.111044', gh.long='-29.523446' where district='MASERU' and council='Mazenod Council' and village='Ha Moalosi';
update gii_hierarchy as gh set gh.lat='28.075438', gh.long='-29.597476' where district='MASERU' and council='Mazenod Council' and village='Ha Nkopane';

update gii_hierarchy as gh set gh.lat='27.513781', gh.long='-29.493383' where district='MASERU' and council='Mazenod Council' and village='Ha Pshatlella';

update gii_hierarchy as gh set gh.lat='27.509291', gh.long='-29.466366' where district='MASERU' and council='Mazenod Council' and village='Ha Mpo';
update gii_hierarchy as gh set gh.lat='27.488034', gh.long='-29.460103' where district='MASERU' and council='Mazenod Council' and village='Ha Motheo';
update gii_hierarchy as gh set gh.lat='27.497842', gh.long='-29.46287' where district='MASERU' and council='Mazenod Council' and village='Ha Selonyane';



update gii_hierarchy as gh set gh.lat='27.386492', gh.long='-29.448787' where district='MASERU' and council='Lilala Council' and village='Ha Mosamo';
update gii_hierarchy as gh set gh.lat='27.417618', gh.long='-29.443193' where district='MASERU' and council='Lilala Council' and village='Ha Mapholo';
update gii_hierarchy as gh set gh.lat='27.403951', gh.long='-29.444132' where district='MASERU' and council='Lilala Council' and village='Ha Rasekoja';
update gii_hierarchy as gh set gh.lat='27.427116', gh.long='-29.441297' where district='MASERU' and council='Lilala Council' and village='Ha Hlalele';
update gii_hierarchy as gh set gh.lat='27.52375', gh.long='-29.499896' where district='MASERU' and council='Lilala Council' and village='Ha Pita';


update gii_hierarchy as gh set gh.lat='27.471078', gh.long='-29.490159' where district='MASERU' and council='Lilala Council' and village='Ha Sankoe';
update gii_hierarchy as gh set gh.lat='27.450796', gh.long='-29.477883' where district='MASERU' and council='Lilala Council' and village='Ha Tjamela';
update gii_hierarchy as gh set gh.lat='28.026374', gh.long='-29.757587' where district='MASERU' and council='Lilala Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='27.384599', gh.long='-29.473773' where district='MASERU' and council='Lilala Council' and village='Ha Leboea';
update gii_hierarchy as gh set gh.lat='27.737372', gh.long='-29.366111' where district='MASERU' and council='Lilala Council' and village='Ha Ratau';
update gii_hierarchy as gh set gh.lat='27.375112', gh.long='-29.456638' where district='MASERU' and council='Lilala Council' and village='Ha Khotseng';
update gii_hierarchy as gh set gh.lat='28.160789', gh.long='-29.640153' where district='MASERU' and council='Lilala Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Lilala Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='27.386882', gh.long='-29.491433' where district='MASERU' and council='Lilala Council' and village='Ha Ntaote';
update gii_hierarchy as gh set gh.lat='28.106708', gh.long='-29.635755' where district='MASERU' and council='Lilala Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='27.314126', gh.long='-29.502416' where district='MASERU' and council='Lilala Council' and village='Ha Osteng';
update gii_hierarchy as gh set gh.lat='27.344884', gh.long='-29.503055' where district='MASERU' and council='Lilala Council' and village='Ha Rahlao';
update gii_hierarchy as gh set gh.lat='27.343376', gh.long='-29.495826' where district='MASERU' and council='Lilala Council' and village='Libataolong';
update gii_hierarchy as gh set gh.lat='27.329414', gh.long='-29.521872' where district='MASERU' and council='Lilala Council' and village='Ha Khabisi';
update gii_hierarchy as gh set gh.lat='27.322898', gh.long='-29.526076' where district='MASERU' and council='Lilala Council' and village='Ha Mosunkutu';
update gii_hierarchy as gh set gh.lat='27.323737', gh.long='-29.539081' where district='MASERU' and council='Lilala Council' and village='Ha Musi';

update gii_hierarchy as gh set gh.lat='27.365935', gh.long='-29.539735' where district='MASERU' and council='Lilala Council' and village='Ha Rasebonang';
update gii_hierarchy as gh set gh.lat='27.339169', gh.long='-29.531974' where district='MASERU' and council='Lilala Council' and village='Ha Sello';

update gii_hierarchy as gh set gh.lat='27.394219', gh.long='-29.529515' where district='MASERU' and council='Lilala Council' and village='Ha Morakanyane';
update gii_hierarchy as gh set gh.lat='27.376136', gh.long='-29.532537' where district='MASERU' and council='Lilala Council' and village='Liqoabing';
update gii_hierarchy as gh set gh.lat='27.368536', gh.long='-29.507367' where district='MASERU' and council='Lilala Council' and village='Ha Makhobotlela';
update gii_hierarchy as gh set gh.lat='27.382808', gh.long='-29.518051' where district='MASERU' and council='Lilala Council' and village='Ha Raphae';
update gii_hierarchy as gh set gh.lat='27.374854', gh.long='-29.500972' where district='MASERU' and council='Lilala Council' and village='Ha Hlao';

update gii_hierarchy as gh set gh.lat='27.403794', gh.long='-29.503797' where district='MASERU' and council='Lilala Council' and village='Ha Mosala';
update gii_hierarchy as gh set gh.lat='27.419831', gh.long='-29.501147' where district='MASERU' and council='Lilala Council' and village='Ha Thebesoa';
update gii_hierarchy as gh set gh.lat='27.393804', gh.long='-29.48888' where district='MASERU' and council='Lilala Council' and village='Topa';
update gii_hierarchy as gh set gh.lat='27.713683', gh.long='-29.609541' where district='MASERU' and council='Lilala Council' and village='Ha Pelei';
update gii_hierarchy as gh set gh.lat='27.453348', gh.long='-29.510394' where district='MASERU' and council='Lilala Council' and village='Ha Rantulela';
update gii_hierarchy as gh set gh.lat='27.474749', gh.long='-29.500831' where district='MASERU' and council='Lilala Council' and village='Ha Makae';
update gii_hierarchy as gh set gh.lat='27.474985', gh.long='-29.516388' where district='MASERU' and council='Lilala Council' and village='Ha Phakoane';
update gii_hierarchy as gh set gh.lat='27.46679', gh.long='-29.506438' where district='MASERU' and council='Lilala Council' and village='Ha Tamane';

update gii_hierarchy as gh set gh.lat='27.44666', gh.long='-29.525775' where district='MASERU' and council='Lilala Council' and village='Ha Tlelase';
update gii_hierarchy as gh set gh.lat='28.125037', gh.long='-29.556816' where district='MASERU' and council='Lilala Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='27.405991', gh.long='-29.516003' where district='MASERU' and council='Lilala Council' and village='Ha Lekhafola';
update gii_hierarchy as gh set gh.lat='27.420544', gh.long='-29.520071' where district='MASERU' and council='Lilala Council' and village='Mahuu';
update gii_hierarchy as gh set gh.lat='27.395856', gh.long='-29.540107' where district='MASERU' and council='Lilala Council' and village='Leralleng';
update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Lilala Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.390774', gh.long='-29.564731' where district='MASERU' and council='Lilala Council' and village='Ha Mokhele';
update gii_hierarchy as gh set gh.lat='27.455466', gh.long='-29.544477' where district='MASERU' and council='Lilala Council' and village='Ha Malelu';

update gii_hierarchy as gh set gh.lat='27.478905', gh.long='-29.534048' where district='MASERU' and council='Lilala Council' and village='Ha Moeti';



update gii_hierarchy as gh set gh.lat='27.517247', gh.long='-29.336039' where district='MASERU' and council='Lilala Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='28.044244', gh.long='-29.620489' where district='MASERU' and council='Lilala Council' and village='Thotaneng';

update gii_hierarchy as gh set gh.lat='27.455334', gh.long='-29.556561' where district='MASERU' and council='Lilala Council' and village='Rothe';





update gii_hierarchy as gh set gh.lat='27.408549', gh.long='-29.566015' where district='MASERU' and council='Lilala Council' and village='Ha Mareka';

update gii_hierarchy as gh set gh.lat='27.415786', gh.long='-29.594878' where district='MASERU' and council='Lilala Council' and village='Ha Ramokitimi';
update gii_hierarchy as gh set gh.lat='27.422715', gh.long='-29.609136' where district='MASERU' and council='Lilala Council' and village='Ha Ramaphiri';
update gii_hierarchy as gh set gh.lat='27.415858', gh.long='-29.611378' where district='MASERU' and council='Lilala Council' and village='Ha Rasekoai';
update gii_hierarchy as gh set gh.lat='27.430958', gh.long='-29.624906' where district='MASERU' and council='Lilala Council' and village='Ha Ramatekane';
update gii_hierarchy as gh set gh.lat='27.464162', gh.long='-29.615692' where district='MASERU' and council='Lilala Council' and village='Ha Molungoa';
update gii_hierarchy as gh set gh.lat='27.443174', gh.long='-29.627604' where district='MASERU' and council='Lilala Council' and village='Ha Ntsohi';

update gii_hierarchy as gh set gh.lat='27.470298', gh.long='-29.581582' where district='MASERU' and council='Lilala Council' and village='Ha Mohloai (Mokauli)';
update gii_hierarchy as gh set gh.lat='27.46882', gh.long='-29.59593' where district='MASERU' and council='Lilala Council' and village='Ha Tlhakanelo';
update gii_hierarchy as gh set gh.lat='27.48929', gh.long='-29.588509' where district='MASERU' and council='Lilala Council' and village='Masites Nek';
update gii_hierarchy as gh set gh.lat='27.495443', gh.long='-29.532323' where district='MASERU' and council='Makhoarane Council' and village='Mekateng';
update gii_hierarchy as gh set gh.lat='27.510524', gh.long='-29.530776' where district='MASERU' and council='Makhoarane Council' and village='Tsitsa';
update gii_hierarchy as gh set gh.lat='27.517386', gh.long='-29.535256' where district='MASERU' and council='Makhoarane Council' and village='Ha Leutsoa';

update gii_hierarchy as gh set gh.lat='27.512073', gh.long='-29.545327' where district='MASERU' and council='Makhoarane Council' and village='Ha Moruthoane';
update gii_hierarchy as gh set gh.lat='27.513856', gh.long='-29.559008' where district='MASERU' and council='Makhoarane Council' and village='Ha Phalole';




update gii_hierarchy as gh set gh.lat='27.584379', gh.long='-29.548139' where district='MASERU' and council='Makhoarane Council' and village='Mantsaneng';
update gii_hierarchy as gh set gh.lat='27.600168', gh.long='-29.547931' where district='MASERU' and council='Makhoarane Council' and village='Makhonofane';

update gii_hierarchy as gh set gh.lat='27.608143', gh.long='-29.570593' where district='MASERU' and council='Makhoarane Council' and village='Ha Makhetha';
update gii_hierarchy as gh set gh.lat='27.626943', gh.long='-29.593105' where district='MASERU' and council='Makhoarane Council' and village='Ha Sekhobe';
update gii_hierarchy as gh set gh.lat='27.610176', gh.long='-29.584578' where district='MASERU' and council='Makhoarane Council' and village='Ha Tsilo';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Makhoarane Council' and village='Aupolasi';



update gii_hierarchy as gh set gh.lat='27.552688', gh.long='-29.571071' where district='MASERU' and council='Makhoarane Council' and village='Ha Mafa';
update gii_hierarchy as gh set gh.lat='27.556549', gh.long='-29.583875' where district='MASERU' and council='Makhoarane Council' and village='Kholokoe';


update gii_hierarchy as gh set gh.lat='27.545677', gh.long='-29.575172' where district='MASERU' and council='Makhoarane Council' and village='Malekhalana';

update gii_hierarchy as gh set gh.lat='27.531276', gh.long='-29.589442' where district='MASERU' and council='Makhoarane Council' and village='Ha Palama';
update gii_hierarchy as gh set gh.lat='27.558736', gh.long='-29.599377' where district='MASERU' and council='Makhoarane Council' and village='Ha Ramabele';


update gii_hierarchy as gh set gh.lat='27.536396', gh.long='-29.606788' where district='MASERU' and council='Makhoarane Council' and village='Makeneng';
update gii_hierarchy as gh set gh.lat='27.500159', gh.long='-29.591704' where district='MASERU' and council='Makhoarane Council' and village='Ha Tsoene';
update gii_hierarchy as gh set gh.lat='27.719456', gh.long='-29.453413' where district='MASERU' and council='Makhoarane Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='27.505688', gh.long='-29.606089' where district='MASERU' and council='Makhoarane Council' and village='Ha Khoahla';






update gii_hierarchy as gh set gh.lat='27.553356', gh.long='-29.630683' where district='MASERU' and council='Makhoarane Council' and village='Ha Mphethi';
update gii_hierarchy as gh set gh.lat='27.588645', gh.long='-29.624589' where district='MASERU' and council='Makhoarane Council' and village='Ha Taele';
update gii_hierarchy as gh set gh.lat='27.589624', gh.long='-29.629156' where district='MASERU' and council='Makhoarane Council' and village='Ha Tsepe';

update gii_hierarchy as gh set gh.lat='27.5312', gh.long='-29.66833' where district='MASERU' and council='Makhoarane Council' and village='Ha Nkaka';
update gii_hierarchy as gh set gh.lat='27.542796', gh.long='-29.660138' where district='MASERU' and council='Makhoarane Council' and village='Ha Ramakhunong';
update gii_hierarchy as gh set gh.lat='27.524724', gh.long='-29.639619' where district='MASERU' and council='Makhoarane Council' and village='Ha Folene';
update gii_hierarchy as gh set gh.lat='27.761162', gh.long='-29.375566' where district='MASERU' and council='Makhoarane Council' and village='Ha Matela';




update gii_hierarchy as gh set gh.lat='27.487282', gh.long='-29.64092' where district='MASERU' and council='Makhoarane Council' and village='Ha Sekoala';
update gii_hierarchy as gh set gh.lat='28.026374', gh.long='-29.757587' where district='MASERU' and council='Makhoarane Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='27.47025', gh.long='-29.644223' where district='MASERU' and council='Makhoarane Council' and village='Ha Toloane';
update gii_hierarchy as gh set gh.lat='27.890773', gh.long='-29.548874' where district='MASERU' and council='Makhoarane Council' and village='Ha Lekhooa';
update gii_hierarchy as gh set gh.lat='28.038752', gh.long='-29.639355' where district='MASERU' and council='Makhoarane Council' and village='Terai Hoek';
update gii_hierarchy as gh set gh.lat='27.472394', gh.long='-29.656595' where district='MASERU' and council='Makhoarane Council' and village='Ha Batere';
update gii_hierarchy as gh set gh.lat='27.464981', gh.long='-29.665213' where district='MASERU' and council='Makhoarane Council' and village='Ha Sebete';
update gii_hierarchy as gh set gh.lat='27.479256', gh.long='-29.670473' where district='MASERU' and council='Makhoarane Council' and village='Ha Sekoai';

update gii_hierarchy as gh set gh.lat='27.449377', gh.long='-29.682346' where district='MASERU' and council='Makhoarane Council' and village='Ha Nkofi';
update gii_hierarchy as gh set gh.lat='27.45924', gh.long='-29.66816' where district='MASERU' and council='Makhoarane Council' and village='Ha Sehlokohlo';
update gii_hierarchy as gh set gh.lat='27.453203', gh.long='-29.672133' where district='MASERU' and council='Makhoarane Council' and village='Ha Thite';
update gii_hierarchy as gh set gh.lat='27.781461', gh.long='-29.537956' where district='MASERU' and council='Makhoarane Council' and village='Kanana';
update gii_hierarchy as gh set gh.lat='27.442708', gh.long='-29.687712' where district='MASERU' and council='Makhoarane Council' and village='Vukazensele';
update gii_hierarchy as gh set gh.lat='27.464881', gh.long='-29.67395' where district='MASERU' and council='Makhoarane Council' and village='Ha Maphathe';
update gii_hierarchy as gh set gh.lat='27.456861', gh.long='-29.688384' where district='MASERU' and council='Makhoarane Council' and village='Ha Seelane';
update gii_hierarchy as gh set gh.lat='27.467863', gh.long='-29.679974' where district='MASERU' and council='Makhoarane Council' and village='Ha Sonti';
update gii_hierarchy as gh set gh.lat='27.442222', gh.long='-29.67524' where district='MASERU' and council='Makhoarane Council' and village='Ha Tsilonyane';

update gii_hierarchy as gh set gh.lat='27.603273', gh.long='-29.598822' where district='MASERU' and council='Makhoarane Council' and village='Ha Taka';
update gii_hierarchy as gh set gh.lat='27.614734', gh.long='-29.626333' where district='MASERU' and council='Makhoarane Council' and village='Ha Bolese';
update gii_hierarchy as gh set gh.lat='27.599393', gh.long='-29.627408' where district='MASERU' and council='Makhoarane Council' and village='Ha Moorosi';
update gii_hierarchy as gh set gh.lat='27.606911', gh.long='-29.632593' where district='MASERU' and council='Makhoarane Council' and village='Ha Setipe';
update gii_hierarchy as gh set gh.lat='27.571028', gh.long='-29.604942' where district='MASERU' and council='Makhoarane Council' and village='Ha Paanya';
update gii_hierarchy as gh set gh.lat='27.574111', gh.long='-29.615124' where district='MASERU' and council='Makhoarane Council' and village='Makoabating';
update gii_hierarchy as gh set gh.lat='27.569289', gh.long='-29.61088' where district='MASERU' and council='Makhoarane Council' and village='Matsieng';

update gii_hierarchy as gh set gh.lat='27.584691', gh.long='-29.650185' where district='MASERU' and council='Makhoarane Council' and village='Ha Lepipi';
update gii_hierarchy as gh set gh.lat='27.887216', gh.long='-29.549264' where district='MASERU' and council='Makhoarane Council' and village='Ha Mojela';





update gii_hierarchy as gh set gh.lat='28.044244', gh.long='-29.620489' where district='MASERU' and council='Makhoarane Council' and village='Thotaneng';
update gii_hierarchy as gh set gh.lat='28.125725', gh.long='-29.678344' where district='MASERU' and council='Makhoarane Council' and village='Boreipala';
update gii_hierarchy as gh set gh.lat='27.622063', gh.long='-29.657027' where district='MASERU' and council='Makhoarane Council' and village='Fuleng';
update gii_hierarchy as gh set gh.lat='27.798605', gh.long='-29.363989' where district='MASERU' and council='Makhoarane Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='27.614248', gh.long='-29.654324' where district='MASERU' and council='Makhoarane Council' and village='Maetheng';
update gii_hierarchy as gh set gh.lat='27.625406', gh.long='-29.66579' where district='MASERU' and council='Makhoarane Council' and village='Ha Likhama';


update gii_hierarchy as gh set gh.lat='27.584962', gh.long='-29.675116' where district='MASERU' and council='Makhoarane Council' and village='Ha Sehlahla';
update gii_hierarchy as gh set gh.lat='27.614522', gh.long='-29.690849' where district='MASERU' and council='Makhoarane Council' and village='Ha Moima';


update gii_hierarchy as gh set gh.lat='27.886522', gh.long='-29.539649' where district='MASERU' and council='Makhoarane Council' and village='Ha Thabo';
update gii_hierarchy as gh set gh.lat='27.583974', gh.long='-29.706014' where district='MASERU' and council='Makhoarane Council' and village='Ha Tsehlo';
update gii_hierarchy as gh set gh.lat='27.53768', gh.long='-29.693273' where district='MASERU' and council='Makhoarane Council' and village='Ha Mofumotse';
update gii_hierarchy as gh set gh.lat='27.554199', gh.long='-29.710262' where district='MASERU' and council='Makhoarane Council' and village='Ha Moitheri';
update gii_hierarchy as gh set gh.lat='27.56585', gh.long='-29.695466' where district='MASERU' and council='Makhoarane Council' and village='Ha Raphoka';
update gii_hierarchy as gh set gh.lat='28.075067', gh.long='-29.575731' where district='MASERU' and council='Makhoarane Council' and village='Ha Setala';
update gii_hierarchy as gh set gh.lat='27.507108', gh.long='-29.32966' where district='MASERU' and council='Makhoarane Council' and village='Thabong';
update gii_hierarchy as gh set gh.lat='27.751555', gh.long='-29.542386' where district='MASERU' and council='Makhalaneng Council' and village='Ha Lekunutu';
update gii_hierarchy as gh set gh.lat='27.764326', gh.long='-29.552706' where district='MASERU' and council='Makhalaneng Council' and village='Ha Ntima';
update gii_hierarchy as gh set gh.lat='27.730056', gh.long='-29.562762' where district='MASERU' and council='Makhalaneng Council' and village='Borata';
update gii_hierarchy as gh set gh.lat='27.738402', gh.long='-29.552057' where district='MASERU' and council='Makhalaneng Council' and village='Ha Kelebone';

update gii_hierarchy as gh set gh.lat='27.743261', gh.long='-29.55805' where district='MASERU' and council='Makhalaneng Council' and village='Ha Mokhou';
update gii_hierarchy as gh set gh.lat='27.736795', gh.long='-29.568039' where district='MASERU' and council='Makhalaneng Council' and village='Ha Nako';

update gii_hierarchy as gh set gh.lat='27.722982', gh.long='-29.566878' where district='MASERU' and council='Makhalaneng Council' and village='Terae';
update gii_hierarchy as gh set gh.lat='27.719648', gh.long='-29.580264' where district='MASERU' and council='Makhalaneng Council' and village='Tholang';
update gii_hierarchy as gh set gh.lat='27.736477', gh.long='-29.585164' where district='MASERU' and council='Makhalaneng Council' and village='Bochabela';


update gii_hierarchy as gh set gh.lat='27.744305', gh.long='-29.576269' where district='MASERU' and council='Makhalaneng Council' and village='Ha Moitsupeli';
update gii_hierarchy as gh set gh.lat='27.72317', gh.long='-29.585814' where district='MASERU' and council='Makhalaneng Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='27.716693', gh.long='-29.604207' where district='MASERU' and council='Makhalaneng Council' and village='Ha Mojakopo';
update gii_hierarchy as gh set gh.lat='27.709867', gh.long='-29.599846' where district='MASERU' and council='Makhalaneng Council' and village='Ha Motsoafa';

update gii_hierarchy as gh set gh.lat='27.754217', gh.long='-29.590521' where district='MASERU' and council='Makhalaneng Council' and village='Ha Dinizulu';
update gii_hierarchy as gh set gh.lat='27.758254', gh.long='-29.607476' where district='MASERU' and council='Makhalaneng Council' and village='Ha Motjotji';
update gii_hierarchy as gh set gh.lat='27.763414', gh.long='-29.603967' where district='MASERU' and council='Makhalaneng Council' and village='Motse Mocha (Ha Lekunutu)';
update gii_hierarchy as gh set gh.lat='27.764591', gh.long='-29.580917' where district='MASERU' and council='Makhalaneng Council' and village='Ha Mokheseng';
update gii_hierarchy as gh set gh.lat='27.763756', gh.long='-29.588315' where district='MASERU' and council='Makhalaneng Council' and village='Ha Tsehla';

update gii_hierarchy as gh set gh.lat='27.820672', gh.long='-29.604682' where district='MASERU' and council='Makhalaneng Council' and village='Ha Molahloe';
update gii_hierarchy as gh set gh.lat='27.847169', gh.long='-29.624237' where district='MASERU' and council='Makhalaneng Council' and village='Ha Moora';
update gii_hierarchy as gh set gh.lat='27.831934', gh.long='-29.615096' where district='MASERU' and council='Makhalaneng Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='27.812333', gh.long='-29.629679' where district='MASERU' and council='Makhalaneng Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='27.809865', gh.long='-29.641728' where district='MASERU' and council='Makhalaneng Council' and village='Ha Maphoma';
update gii_hierarchy as gh set gh.lat='28.016', gh.long='-29.88663' where district='MASERU' and council='Makhalaneng Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='27.74503', gh.long='-29.627967' where district='MASERU' and council='Makhalaneng Council' and village='Ha Fane';
update gii_hierarchy as gh set gh.lat='27.763511', gh.long='-29.615487' where district='MASERU' and council='Makhalaneng Council' and village='Ha Potiane';
update gii_hierarchy as gh set gh.lat='27.757001', gh.long='-29.618293' where district='MASERU' and council='Makhalaneng Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='27.765421', gh.long='-29.625611' where district='MASERU' and council='Makhalaneng Council' and village='Ha Raboletsi';
update gii_hierarchy as gh set gh.lat='27.764397', gh.long='-29.641141' where district='MASERU' and council='Makhalaneng Council' and village='Ha Sematle';
update gii_hierarchy as gh set gh.lat='27.759671', gh.long='-29.643486' where district='MASERU' and council='Makhalaneng Council' and village='Ha Lefeko';
update gii_hierarchy as gh set gh.lat='27.762108', gh.long='-29.65562' where district='MASERU' and council='Makhalaneng Council' and village='Ha Matsaba';
update gii_hierarchy as gh set gh.lat='27.754192', gh.long='-29.666813' where district='MASERU' and council='Makhalaneng Council' and village='Ha Motale';
update gii_hierarchy as gh set gh.lat='27.744941', gh.long='-29.64885' where district='MASERU' and council='Makhalaneng Council' and village='Ha Lejaha';


update gii_hierarchy as gh set gh.lat='27.694615', gh.long='-29.635086' where district='MASERU' and council='Makhalaneng Council' and village='Ha Kou (Maliphokoana)';
update gii_hierarchy as gh set gh.lat='27.718861', gh.long='-29.63845' where district='MASERU' and council='Makhalaneng Council' and village='Ha Lekota';

update gii_hierarchy as gh set gh.lat='27.671258', gh.long='-29.513752' where district='MASERU' and council='Makhalaneng Council' and village='Maholong';

update gii_hierarchy as gh set gh.lat='27.715312', gh.long='-29.621395' where district='MASERU' and council='Makhalaneng Council' and village='Ha Matsoana';
update gii_hierarchy as gh set gh.lat='27.713683', gh.long='-29.609541' where district='MASERU' and council='Makhalaneng Council' and village='Ha Pelei';
update gii_hierarchy as gh set gh.lat='27.711723', gh.long='-29.61919' where district='MASERU' and council='Makhalaneng Council' and village='Ha Tlapana';
update gii_hierarchy as gh set gh.lat='27.677174', gh.long='-29.620631' where district='MASERU' and council='Makhalaneng Council' and village='Ha Makoae';
update gii_hierarchy as gh set gh.lat='27.683023', gh.long='-29.607294' where district='MASERU' and council='Makhalaneng Council' and village='Ha Mokola';
update gii_hierarchy as gh set gh.lat='27.674171', gh.long='-29.612228' where district='MASERU' and council='Makhalaneng Council' and village='Ha Pholo';
update gii_hierarchy as gh set gh.lat='27.670102', gh.long='-29.630255' where district='MASERU' and council='Makhalaneng Council' and village='Ha Fokoane';
update gii_hierarchy as gh set gh.lat='27.669822', gh.long='-29.636409' where district='MASERU' and council='Makhalaneng Council' and village='Ha Makhema';
update gii_hierarchy as gh set gh.lat='27.640934', gh.long='-29.662246' where district='MASERU' and council='Makhalaneng Council' and village='Ha Chake';

update gii_hierarchy as gh set gh.lat='27.625899', gh.long='-29.64143' where district='MASERU' and council='Makhalaneng Council' and village='Ha Maphephe';
update gii_hierarchy as gh set gh.lat='28.141734', gh.long='-29.649354' where district='MASERU' and council='Makhalaneng Council' and village='Ha Abele';
update gii_hierarchy as gh set gh.lat='27.659708', gh.long='-29.652671' where district='MASERU' and council='Makhalaneng Council' and village='Ha Kori';
update gii_hierarchy as gh set gh.lat='27.685183', gh.long='-29.639025' where district='MASERU' and council='Makhalaneng Council' and village='Ha Lithathane';
update gii_hierarchy as gh set gh.lat='27.682582', gh.long='-29.648561' where district='MASERU' and council='Makhalaneng Council' and village='Ha Nkabane';
update gii_hierarchy as gh set gh.lat='27.68313', gh.long='-29.657027' where district='MASERU' and council='Makhalaneng Council' and village='Ha Kali';


update gii_hierarchy as gh set gh.lat='27.663298', gh.long='-29.668854' where district='MASERU' and council='Makhalaneng Council' and village='Ha Ramosoeu';





update gii_hierarchy as gh set gh.lat='27.700552', gh.long='-29.676244' where district='MASERU' and council='Makhalaneng Council' and village='Ha Raleqheka';
update gii_hierarchy as gh set gh.lat='27.713577', gh.long='-29.674043' where district='MASERU' and council='Makhalaneng Council' and village='Ha Raqoane';
update gii_hierarchy as gh set gh.lat='27.699147', gh.long='-29.67065' where district='MASERU' and council='Makhalaneng Council' and village='Ha Serabele';
update gii_hierarchy as gh set gh.lat='27.708074', gh.long='-29.670764' where district='MASERU' and council='Makhalaneng Council' and village='Ha Tsuu';
update gii_hierarchy as gh set gh.lat='27.706272', gh.long='-29.661149' where district='MASERU' and council='Makhalaneng Council' and village='Likhoaleng';
update gii_hierarchy as gh set gh.lat='27.70665', gh.long='-29.692076' where district='MASERU' and council='Makhalaneng Council' and village='Ha Motlelepe';
update gii_hierarchy as gh set gh.lat='27.687356', gh.long='-29.689304' where district='MASERU' and council='Makhalaneng Council' and village='Motlejoa';
update gii_hierarchy as gh set gh.lat='27.917005', gh.long='-29.549065' where district='MASERU' and council='Makhalaneng Council' and village='Ha Moshe';
update gii_hierarchy as gh set gh.lat='27.687975', gh.long='-29.719899' where district='MASERU' and council='Makhalaneng Council' and village='Ha Mothibeli';
update gii_hierarchy as gh set gh.lat='27.705395', gh.long='-29.72708' where district='MASERU' and council='Makhalaneng Council' and village='Ha Rakhati';




update gii_hierarchy as gh set gh.lat='27.668227', gh.long='-29.699839' where district='MASERU' and council='Makhalaneng Council' and village='Ha Seoloana';
update gii_hierarchy as gh set gh.lat='27.649509', gh.long='-29.69189' where district='MASERU' and council='Makhalaneng Council' and village='Ha Shoaepane';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Makhalaneng Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='27.619555', gh.long='-29.68925' where district='MASERU' and council='Makhalaneng Council' and village='Ha Metsing';
update gii_hierarchy as gh set gh.lat='27.868675', gh.long='-29.576253' where district='MASERU' and council='Makhalaneng Council' and village='Koung';


update gii_hierarchy as gh set gh.lat='28.004076', gh.long='-29.835063' where district='MASERU' and council='Ribaneng Council' and village='Ha Ramabanta';
update gii_hierarchy as gh set gh.lat='27.883396', gh.long='-29.429596' where district='MASERU' and council='Ribaneng Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.703867', gh.long='-29.438761' where district='MASERU' and council='Ribaneng Council' and village='Liphakoeng';


update gii_hierarchy as gh set gh.lat='27.780834', gh.long='-29.682606' where district='MASERU' and council='Ribaneng Council' and village='Ha Thebe';
update gii_hierarchy as gh set gh.lat='27.777927', gh.long='-29.671268' where district='MASERU' and council='Ribaneng Council' and village='Maineng';
update gii_hierarchy as gh set gh.lat='27.757956', gh.long='-29.679057' where district='MASERU' and council='Ribaneng Council' and village='Mokotleng';
update gii_hierarchy as gh set gh.lat='27.738436', gh.long='-29.673939' where district='MASERU' and council='Ribaneng Council' and village='Ha Motsoetla';
update gii_hierarchy as gh set gh.lat='27.583974', gh.long='-29.706014' where district='MASERU' and council='Ribaneng Council' and village='Ha Tsehlo';

update gii_hierarchy as gh set gh.lat='27.729446', gh.long='-29.692448' where district='MASERU' and council='Ribaneng Council' and village='Ha Motlalehi';
update gii_hierarchy as gh set gh.lat='27.731662', gh.long='-29.695228' where district='MASERU' and council='Ribaneng Council' and village='Ha Motseki';
update gii_hierarchy as gh set gh.lat='27.728352', gh.long='-29.700608' where district='MASERU' and council='Ribaneng Council' and village='Paramenteng';
update gii_hierarchy as gh set gh.lat='27.743054', gh.long='-29.714019' where district='MASERU' and council='Ribaneng Council' and village='Ha Koenyama';
update gii_hierarchy as gh set gh.lat='27.759587', gh.long='-29.691451' where district='MASERU' and council='Ribaneng Council' and village='Ha Ramoseeka';
update gii_hierarchy as gh set gh.lat='27.745672', gh.long='-29.695659' where district='MASERU' and council='Ribaneng Council' and village='Ha Sebinane';
update gii_hierarchy as gh set gh.lat='27.749519', gh.long='-29.699542' where district='MASERU' and council='Ribaneng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='27.758556', gh.long='-29.711262' where district='MASERU' and council='Ribaneng Council' and village='Matlapaneng';
update gii_hierarchy as gh set gh.lat='27.719296', gh.long='-29.70512' where district='MASERU' and council='Ribaneng Council' and village='Ha Mashapha';


update gii_hierarchy as gh set gh.lat='27.867949', gh.long='-29.517541' where district='MASERU' and council='Ribaneng Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='27.720111', gh.long='-29.725382' where district='MASERU' and council='Ribaneng Council' and village='Polateng';
update gii_hierarchy as gh set gh.lat='27.722852', gh.long='-29.735096' where district='MASERU' and council='Ribaneng Council' and village='Ha Moreoa';
update gii_hierarchy as gh set gh.lat='27.673286', gh.long='-29.46173' where district='MASERU' and council='Ribaneng Council' and village='Ha Motanyane';
update gii_hierarchy as gh set gh.lat='28.042211', gh.long='-29.862392' where district='MASERU' and council='Ribaneng Council' and village='Thusong';

update gii_hierarchy as gh set gh.lat='27.748985', gh.long='-29.744933' where district='MASERU' and council='Ribaneng Council' and village='Ha Ramakhaleng';
update gii_hierarchy as gh set gh.lat='27.776901', gh.long='-29.729232' where district='MASERU' and council='Ribaneng Council' and village='Ha Sekonyela';

update gii_hierarchy as gh set gh.lat='27.556549', gh.long='-29.583875' where district='MASERU' and council='Ribaneng Council' and village='Kholokoe';


update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Ribaneng Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='28.106708', gh.long='-29.635755' where district='MASERU' and council='Ribaneng Council' and village='Taung';

update gii_hierarchy as gh set gh.lat='27.77236', gh.long='-29.762347' where district='MASERU' and council='Ribaneng Council' and village='Ha Josefa';


update gii_hierarchy as gh set gh.lat='27.735391', gh.long='-29.743146' where district='MASERU' and council='Ribaneng Council' and village='Kubake';
update gii_hierarchy as gh set gh.lat='28.027019', gh.long='-29.621667' where district='MASERU' and council='Ribaneng Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='27.722634', gh.long='-29.774288' where district='MASERU' and council='Ribaneng Council' and village='Ha Lengau';
update gii_hierarchy as gh set gh.lat='27.718973', gh.long='-29.762748' where district='MASERU' and council='Ribaneng Council' and village='Ha Mokhotho';
update gii_hierarchy as gh set gh.lat='27.722159', gh.long='-29.755078' where district='MASERU' and council='Ribaneng Council' and village='Ha Seetsa';
update gii_hierarchy as gh set gh.lat='27.702408', gh.long='-29.792396' where district='MASERU' and council='Ribaneng Council' and village='Ha Hlephe';
update gii_hierarchy as gh set gh.lat='27.691131', gh.long='-29.782595' where district='MASERU' and council='Ribaneng Council' and village='Ha Maketekete';
update gii_hierarchy as gh set gh.lat='27.686285', gh.long='-29.778384' where district='MASERU' and council='Ribaneng Council' and village='Ha Mphahama';
update gii_hierarchy as gh set gh.lat='27.702181', gh.long='-29.778782' where district='MASERU' and council='Ribaneng Council' and village='Ha Qhoesha';
update gii_hierarchy as gh set gh.lat='27.729351', gh.long='-29.796688' where district='MASERU' and council='Ribaneng Council' and village='Ha Mokoara';

update gii_hierarchy as gh set gh.lat='27.723266', gh.long='-29.798673' where district='MASERU' and council='Ribaneng Council' and village='Ha Molisenyane';
update gii_hierarchy as gh set gh.lat='28.138305', gh.long='-29.625192' where district='MASERU' and council='Ribaneng Council' and village='Ha Tau';
update gii_hierarchy as gh set gh.lat='27.738213', gh.long='-29.792425' where district='MASERU' and council='Ribaneng Council' and village='Ha Telu';
update gii_hierarchy as gh set gh.lat='27.803126', gh.long='-29.778363' where district='MASERU' and council='Ribaneng Council' and village='Mpobong';
update gii_hierarchy as gh set gh.lat='27.693845', gh.long='-29.84088' where district='MASERU' and council='Ribaneng Council' and village='Ha Lebona';
update gii_hierarchy as gh set gh.lat='27.756974', gh.long='-29.728904' where district='MASERU' and council='Ribaneng Council' and village='Ha Moseli';
update gii_hierarchy as gh set gh.lat='27.701481', gh.long='-29.8367' where district='MASERU' and council='Ribaneng Council' and village='Ha Ntsoeu';
update gii_hierarchy as gh set gh.lat='27.678825', gh.long='-29.850679' where district='MASERU' and council='Ribaneng Council' and village='Ha Rantsoetsa';
update gii_hierarchy as gh set gh.lat='27.691175', gh.long='-29.848434' where district='MASERU' and council='Ribaneng Council' and village='Lilongoaneng';

update gii_hierarchy as gh set gh.lat='28.036635', gh.long='-29.473244' where district='MASERU' and council='Ribaneng Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='27.684162', gh.long='-29.826808' where district='MASERU' and council='Ribaneng Council' and village='Ha Motlatsi';
update gii_hierarchy as gh set gh.lat='27.686736', gh.long='-29.829626' where district='MASERU' and council='Ribaneng Council' and village='Ha Raphole';
update gii_hierarchy as gh set gh.lat='27.881168', gh.long='-29.677331' where district='MASERU' and council='Ribaneng Council' and village='Khohlong';


update gii_hierarchy as gh set gh.lat='27.660085', gh.long='-29.839929' where district='MASERU' and council='Ribaneng Council' and village='Ha Mokotla';
update gii_hierarchy as gh set gh.lat='27.650129', gh.long='-29.844513' where district='MASERU' and council='Ribaneng Council' and village='Ha Molai';
update gii_hierarchy as gh set gh.lat='27.964805', gh.long='-29.603554' where district='MASERU' and council='Ribaneng Council' and village='Hloahloeng';
update gii_hierarchy as gh set gh.lat='27.665018', gh.long='-29.844' where district='MASERU' and council='Ribaneng Council' and village='Makatseng';
update gii_hierarchy as gh set gh.lat='28.048121', gh.long='-29.631272' where district='MASERU' and council='Ribaneng Council' and village='Ha Joele';

update gii_hierarchy as gh set gh.lat='27.65713', gh.long='-29.854747' where district='MASERU' and council='Ribaneng Council' and village='Ha Ntake';
update gii_hierarchy as gh set gh.lat='27.896826', gh.long='-29.581044' where district='MASERU' and council='Ribaneng Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='27.984622', gh.long='-29.781216' where district='MASERU' and council='Semonkong Council' and village='Ha Moqibi';
update gii_hierarchy as gh set gh.lat='28.015297', gh.long='-29.770549' where district='MASERU' and council='Semonkong Council' and village='Ha Phallang';
update gii_hierarchy as gh set gh.lat='28.022112', gh.long='-29.836647' where district='MASERU' and council='Semonkong Council' and village='Ha Lesala';

update gii_hierarchy as gh set gh.lat='27.828503', gh.long='-29.329443' where district='MASERU' and council='Semonkong Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.013106', gh.long='-29.84112' where district='MASERU' and council='Semonkong Council' and village='Ha Lesia';
update gii_hierarchy as gh set gh.lat='28.000517', gh.long='-29.852546' where district='MASERU' and council='Semonkong Council' and village='Ha Motsoane';
update gii_hierarchy as gh set gh.lat='28.004076', gh.long='-29.835063' where district='MASERU' and council='Semonkong Council' and village='Ha Ramabanta';
update gii_hierarchy as gh set gh.lat='28.0485', gh.long='-29.839302' where district='MASERU' and council='Semonkong Council' and village='Ha Lepae';
update gii_hierarchy as gh set gh.lat='28.056671', gh.long='-29.833686' where district='MASERU' and council='Semonkong Council' and village='Ha Leteketa';
update gii_hierarchy as gh set gh.lat='28.063286', gh.long='-29.843792' where district='MASERU' and council='Semonkong Council' and village='Ha Khonyeli';
update gii_hierarchy as gh set gh.lat='28.082897', gh.long='-29.852268' where district='MASERU' and council='Semonkong Council' and village='Ha Lentiti';
update gii_hierarchy as gh set gh.lat='28.106075', gh.long='-29.591404' where district='MASERU' and council='Semonkong Council' and village='Ha Tsitso';
update gii_hierarchy as gh set gh.lat='28.030114', gh.long='-29.85259' where district='MASERU' and council='Semonkong Council' and village='Ha Mateketa';

update gii_hierarchy as gh set gh.lat='28.037672', gh.long='-29.86665' where district='MASERU' and council='Semonkong Council' and village='Ha Moahloli';
update gii_hierarchy as gh set gh.lat='28.026374', gh.long='-29.757587' where district='MASERU' and council='Semonkong Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.026353', gh.long='-29.868054' where district='MASERU' and council='Semonkong Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Semonkong Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='28.126334', gh.long='-29.645606' where district='MASERU' and council='Semonkong Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.989333', gh.long='-29.887372' where district='MASERU' and council='Semonkong Council' and village='Ha Farelane';



update gii_hierarchy as gh set gh.lat='28.004161', gh.long='-29.897099' where district='MASERU' and council='Semonkong Council' and village='Ha Seqhoasho';



update gii_hierarchy as gh set gh.lat='28.05088', gh.long='-29.888168' where district='MASERU' and council='Semonkong Council' and village='Mosoang';
update gii_hierarchy as gh set gh.lat='28.04639', gh.long='-29.889155' where district='MASERU' and council='Semonkong Council' and village='Tsekana';


update gii_hierarchy as gh set gh.lat='28.042094', gh.long='-29.926317' where district='MASERU' and council='Semonkong Council' and village='Ha Rasefale';
update gii_hierarchy as gh set gh.lat='28.004071', gh.long='-29.919542' where district='MASERU' and council='Semonkong Council' and village='Letseng';
update gii_hierarchy as gh set gh.lat='28.025711', gh.long='-29.909261' where district='MASERU' and council='Semonkong Council' and village='Moriting';

update gii_hierarchy as gh set gh.lat='28.000517', gh.long='-29.852546' where district='MASERU' and council='Makolopetsane Council' and village='Ha Motsoane';
update gii_hierarchy as gh set gh.lat='28.101058', gh.long='-29.607068' where district='MASERU' and council='Makolopetsane Council' and village='Ha Mpeli';
update gii_hierarchy as gh set gh.lat='28.081987', gh.long='-29.613254' where district='MASERU' and council='Makolopetsane Council' and village='Ha Qamako';
update gii_hierarchy as gh set gh.lat='28.086169', gh.long='-29.604618' where district='MASERU' and council='Makolopetsane Council' and village='Ha Ralobisi';
update gii_hierarchy as gh set gh.lat='28.064814', gh.long='-29.623705' where district='MASERU' and council='Makolopetsane Council' and village='Letsatseng';
update gii_hierarchy as gh set gh.lat='28.102711', gh.long='-29.615081' where district='MASERU' and council='Makolopetsane Council' and village='Liotsanyaneng';

update gii_hierarchy as gh set gh.lat='28.048121', gh.long='-29.631272' where district='MASERU' and council='Makolopetsane Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='28.061446', gh.long='-29.628056' where district='MASERU' and council='Makolopetsane Council' and village='Ha Monakalali';
update gii_hierarchy as gh set gh.lat='28.027019', gh.long='-29.621667' where district='MASERU' and council='Makolopetsane Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.059168', gh.long='-29.633244' where district='MASERU' and council='Makolopetsane Council' and village='Liphokoaneng';
update gii_hierarchy as gh set gh.lat='27.457792', gh.long='-29.402303' where district='MASERU' and council='Makolopetsane Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.032389', gh.long='-29.628331' where district='MASERU' and council='Makolopetsane Council' and village='Mokhoabong';
update gii_hierarchy as gh set gh.lat='27.664607', gh.long='-29.818733' where district='MASERU' and council='Makolopetsane Council' and village='Terae Hoek';
update gii_hierarchy as gh set gh.lat='28.044244', gh.long='-29.620489' where district='MASERU' and council='Makolopetsane Council' and village='Thotaneng';
update gii_hierarchy as gh set gh.lat='28.057256', gh.long='-29.587565' where district='MASERU' and council='Makolopetsane Council' and village='Khatleng';
update gii_hierarchy as gh set gh.lat='28.096667', gh.long='-29.617871' where district='MASERU' and council='Makolopetsane Council' and village='Matsiring';

update gii_hierarchy as gh set gh.lat='28.106708', gh.long='-29.635755' where district='MASERU' and council='Makolopetsane Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.115343', gh.long='-29.644456' where district='MASERU' and council='Makolopetsane Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='28.133257', gh.long='-29.61899' where district='MASERU' and council='Makolopetsane Council' and village='Lehahaneng';

update gii_hierarchy as gh set gh.lat='28.150708', gh.long='-29.625517' where district='MASERU' and council='Makolopetsane Council' and village='Ha Hlabana';
update gii_hierarchy as gh set gh.lat='28.143922', gh.long='-29.627625' where district='MASERU' and council='Makolopetsane Council' and village='Ha Tsele';

update gii_hierarchy as gh set gh.lat='28.160789', gh.long='-29.640153' where district='MASERU' and council='Makolopetsane Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='28.14993', gh.long='-29.635958' where district='MASERU' and council='Makolopetsane Council' and village='Thibella';
update gii_hierarchy as gh set gh.lat='28.141734', gh.long='-29.649354' where district='MASERU' and council='Makolopetsane Council' and village='Ha Abele';
update gii_hierarchy as gh set gh.lat='28.134776', gh.long='-29.647158' where district='MASERU' and council='Makolopetsane Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.126334', gh.long='-29.645606' where district='MASERU' and council='Makolopetsane Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='28.181954', gh.long='-29.662258' where district='MASERU' and council='Makolopetsane Council' and village='Ha Lebitsa';
update gii_hierarchy as gh set gh.lat='28.132157', gh.long='-29.662885' where district='MASERU' and council='Makolopetsane Council' and village='Makokong';

update gii_hierarchy as gh set gh.lat='28.125725', gh.long='-29.678344' where district='MASERU' and council='Makolopetsane Council' and village='Boreipala';




update gii_hierarchy as gh set gh.lat='28.069663', gh.long='-29.662928' where district='MASERU' and council='Makolopetsane Council' and village='Nkoeng';


update gii_hierarchy as gh set gh.lat='28.127348', gh.long='-29.696914' where district='MASERU' and council='Makolopetsane Council' and village='Ha Peiso';
update gii_hierarchy as gh set gh.lat='28.126921', gh.long='-29.689639' where district='MASERU' and council='Makolopetsane Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.143988', gh.long='-29.68537' where district='MASERU' and council='Makolopetsane Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.161948', gh.long='-29.68645' where district='MASERU' and council='Makolopetsane Council' and village='Mpatana';
update gii_hierarchy as gh set gh.lat='28.162168', gh.long='-29.695938' where district='MASERU' and council='Makolopetsane Council' and village='Phatlalla';
update gii_hierarchy as gh set gh.lat='28.163662', gh.long='-29.700428' where district='MASERU' and council='Makolopetsane Council' and village='Phororong';
update gii_hierarchy as gh set gh.lat='28.155623', gh.long='-29.69096' where district='MASERU' and council='Makolopetsane Council' and village='Polateng';

update gii_hierarchy as gh set gh.lat='28.165236', gh.long='-29.740589' where district='MASERU' and council='Makolopetsane Council' and village='Ha Lekula';
update gii_hierarchy as gh set gh.lat='28.157151', gh.long='-29.717057' where district='MASERU' and council='Makolopetsane Council' and village='Ha Litokelo';
update gii_hierarchy as gh set gh.lat='28.04498', gh.long='-29.787842' where district='MASERU' and council='Makolopetsane Council' and village='Ha Makhele';


update gii_hierarchy as gh set gh.lat='28.178382', gh.long='-29.719112' where district='MASERU' and council='Makolopetsane Council' and village='Ha Nchemane';



update gii_hierarchy as gh set gh.lat='28.133328', gh.long='-29.705598' where district='MASERU' and council='Makolopetsane Council' and village='Khilibiting';

update gii_hierarchy as gh set gh.lat='28.133598', gh.long='-29.713684' where district='MASERU' and council='Makolopetsane Council' and village='Thabang';


update gii_hierarchy as gh set gh.lat='28.098073', gh.long='-29.703756' where district='MASERU' and council='Makolopetsane Council' and village='Ha Moroke';
update gii_hierarchy as gh set gh.lat='27.606911', gh.long='-29.632593' where district='MASERU' and council='Makolopetsane Council' and village='Ha Setipe';


update gii_hierarchy as gh set gh.lat='28.101903', gh.long='-29.746204' where district='MASERU' and council='Makolopetsane Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.12633', gh.long='-29.75266' where district='MASERU' and council='Makolopetsane Council' and village='Lebohang';
update gii_hierarchy as gh set gh.lat='28.134968', gh.long='-29.756333' where district='MASERU' and council='Makolopetsane Council' and village='Moeaneng (Ha Seng)';
update gii_hierarchy as gh set gh.lat='28.173009', gh.long='-29.771595' where district='MASERU' and council='Makolopetsane Council' and village='Ha Hlabathe';
update gii_hierarchy as gh set gh.lat='28.178587', gh.long='-29.757362' where district='MASERU' and council='Makolopetsane Council' and village='Ha Libete';
update gii_hierarchy as gh set gh.lat='28.160186', gh.long='-29.757889' where district='MASERU' and council='Makolopetsane Council' and village='Ha Matekoanyane';
update gii_hierarchy as gh set gh.lat='28.197665', gh.long='-29.759095' where district='MASERU' and council='Makolopetsane Council' and village='Ha Mohloka';

update gii_hierarchy as gh set gh.lat='28.192457', gh.long='-29.740258' where district='MASERU' and council='Makolopetsane Council' and village='Ha Ramahaheng';
update gii_hierarchy as gh set gh.lat='28.144487', gh.long='-29.771662' where district='MASERU' and council='Makolopetsane Council' and village='Ha Kobeli';
update gii_hierarchy as gh set gh.lat='28.120256', gh.long='-29.772107' where district='MASERU' and council='Makolopetsane Council' and village='Joala Bobe';
update gii_hierarchy as gh set gh.lat='28.144355', gh.long='-29.762395' where district='MASERU' and council='Makolopetsane Council' and village='Masianokeng';

update gii_hierarchy as gh set gh.lat='27.832674', gh.long='-29.650993' where district='MASERU' and council='Makolopetsane Council' and village='Matsatseng';

update gii_hierarchy as gh set gh.lat='28.105123', gh.long='-29.784656' where district='MASERU' and council='Makolopetsane Council' and village='Sebala Makhulo';
update gii_hierarchy as gh set gh.lat='28.148888', gh.long='-29.785399' where district='MASERU' and council='Makolopetsane Council' and village='Ha Sekhotsoa';

update gii_hierarchy as gh set gh.lat='28.140568', gh.long='-29.777521' where district='MASERU' and council='Makolopetsane Council' and village='Sethamahane';
update gii_hierarchy as gh set gh.lat='28.157197', gh.long='-29.776791' where district='MASERU' and council='Makolopetsane Council' and village='Songoanyane';
update gii_hierarchy as gh set gh.lat='28.177886', gh.long='-29.787125' where district='MASERU' and council='Makolopetsane Council' and village='Ha Khomo';


update gii_hierarchy as gh set gh.lat='28.188278', gh.long='-29.785693' where district='MASERU' and council='Makolopetsane Council' and village='Mokoallong';

update gii_hierarchy as gh set gh.lat='28.19417', gh.long='-29.779813' where district='MASERU' and council='Makolopetsane Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='28.062317', gh.long='-29.762105' where district='MASERU' and council='Telle Council' and village='Ha Masia';
update gii_hierarchy as gh set gh.lat='28.064446', gh.long='-29.772882' where district='MASERU' and council='Telle Council' and village='Ha Monaheng';

update gii_hierarchy as gh set gh.lat='28.04498', gh.long='-29.787842' where district='MASERU' and council='Telle Council' and village='Ha Makhele';
update gii_hierarchy as gh set gh.lat='28.039081', gh.long='-29.785757' where district='MASERU' and council='Telle Council' and village='Ha Sechache';
update gii_hierarchy as gh set gh.lat='27.457792', gh.long='-29.402303' where district='MASERU' and council='Telle Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.126334', gh.long='-29.645606' where district='MASERU' and council='Telle Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='27.644923', gh.long='-29.523544' where district='MASERU' and council='Telle Council' and village='Tholang';
update gii_hierarchy as gh set gh.lat='27.720111', gh.long='-29.725382' where district='MASERU' and council='Telle Council' and village='Polateng';
update gii_hierarchy as gh set gh.lat='27.578084', gh.long='-29.4923' where district='MASERU' and council='Telle Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='28.10331', gh.long='-29.832744' where district='MASERU' and council='Telle Council' and village='Ha Mapitsi';
update gii_hierarchy as gh set gh.lat='28.06239', gh.long='-29.797349' where district='MASERU' and council='Telle Council' and village='Ha Popa';
update gii_hierarchy as gh set gh.lat='28.09094', gh.long='-29.82978' where district='MASERU' and council='Telle Council' and village='Ha Talimo';


update gii_hierarchy as gh set gh.lat='28.131118', gh.long='-29.798519' where district='MASERU' and council='Telle Council' and village='Ha Ramafatsa';
update gii_hierarchy as gh set gh.lat='27.883396', gh.long='-29.429596' where district='MASERU' and council='Telle Council' and village='Khubetsoana';




update gii_hierarchy as gh set gh.lat='27.517247', gh.long='-29.336039' where district='MASERU' and council='Telle Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='28.036635', gh.long='-29.473244' where district='MASERU' and council='Telle Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.155322', gh.long='-29.831782' where district='MASERU' and council='Telle Council' and village='Ha Rampeo';
update gii_hierarchy as gh set gh.lat='27.594649', gh.long='-29.381816' where district='MASERU' and council='Telle Council' and village='Liphookoaneng';
update gii_hierarchy as gh set gh.lat='27.663298', gh.long='-29.668854' where district='MASERU' and council='Telle Council' and village='Ha Ramosoeu';
update gii_hierarchy as gh set gh.lat='27.680338', gh.long='-29.818918' where district='MASERU' and council='Telle Council' and village='Ha Salemone';

update gii_hierarchy as gh set gh.lat='28.213329', gh.long='-29.813413' where district='MASERU' and council='Telle Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='28.170565', gh.long='-29.798896' where district='MASERU' and council='Telle Council' and village='Mokotjana';
update gii_hierarchy as gh set gh.lat='28.221198', gh.long='-29.835162' where district='MASERU' and council='Telle Council' and village='Pheselema';
update gii_hierarchy as gh set gh.lat='28.189823', gh.long='-29.835072' where district='MASERU' and council='Telle Council' and village='Ha Morainyane';
update gii_hierarchy as gh set gh.lat='28.22091', gh.long='-29.846862' where district='MASERU' and council='Telle Council' and village='Ha Mapoho';
update gii_hierarchy as gh set gh.lat='28.190221', gh.long='-29.85283' where district='MASERU' and council='Telle Council' and village='Ha Maqisha';
update gii_hierarchy as gh set gh.lat='28.163699', gh.long='-29.839286' where district='MASERU' and council='Telle Council' and village='Ha Mashenephe';
update gii_hierarchy as gh set gh.lat='28.1489', gh.long='-29.847777' where district='MASERU' and council='Telle Council' and village='Ha Pakiso';
update gii_hierarchy as gh set gh.lat='28.14275', gh.long='-29.827016' where district='MASERU' and council='Telle Council' and village='Khohlong (Makoabating)';



update gii_hierarchy as gh set gh.lat='27.714469', gh.long='-29.441253' where district='MASERU' and council='Telle Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='28.2043', gh.long='-29.871597' where district='MASERU' and council='Telle Council' and village='Ha Lekola Ntso';
update gii_hierarchy as gh set gh.lat='28.183161', gh.long='-29.894775' where district='MASERU' and council='Telle Council' and village='Ha Rakuba';
update gii_hierarchy as gh set gh.lat='28.19808', gh.long='-29.869677' where district='MASERU' and council='Telle Council' and village='Ha Thotho';
update gii_hierarchy as gh set gh.lat='28.168926', gh.long='-29.903639' where district='MASERU' and council='Telle Council' and village='Ha Tlokotsi';
update gii_hierarchy as gh set gh.lat='28.226405', gh.long='-29.873129' where district='MASERU' and council='Telle Council' and village='Ha Khahlana';
update gii_hierarchy as gh set gh.lat='28.229341', gh.long='-29.869247' where district='MASERU' and council='Telle Council' and village='Ha Malesia';


update gii_hierarchy as gh set gh.lat='27.832674', gh.long='-29.650993' where district='MASERU' and council='Telle Council' and village='Matsatseng';
update gii_hierarchy as gh set gh.lat='27.398226', gh.long='-29.523094' where district='MASERU' and council='Telle Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='28.156596', gh.long='-29.892704' where district='MASERU' and council='Telle Council' and village='Ha Khopolo (Lithabaneng)';
update gii_hierarchy as gh set gh.lat='28.107283', gh.long='-29.73601' where district='MASERU' and council='Telle Council' and village='Motlaputseng';
update gii_hierarchy as gh set gh.lat='27.828503', gh.long='-29.329443' where district='MASERU' and council='Telle Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.095877', gh.long='-29.899636' where district='MASERU' and council='Telle Council' and village='Botsoela';
update gii_hierarchy as gh set gh.lat='28.117111', gh.long='-29.908762' where district='MASERU' and council='Telle Council' and village='Ha Ramokhorong';
update gii_hierarchy as gh set gh.lat='28.119205', gh.long='-29.891679' where district='MASERU' and council='Telle Council' and village='Ha Samuel';
update gii_hierarchy as gh set gh.lat='28.107852', gh.long='-29.887118' where district='MASERU' and council='Telle Council' and village='Ha Setoi';
update gii_hierarchy as gh set gh.lat='28.107678', gh.long='-29.891807' where district='MASERU' and council='Telle Council' and village='Ha Tollo';
update gii_hierarchy as gh set gh.lat='28.095276', gh.long='-29.891611' where district='MASERU' and council='Telle Council' and village='Ha Tsoeu';
update gii_hierarchy as gh set gh.lat='28.105234', gh.long='-29.904799' where district='MASERU' and council='Telle Council' and village='Tebeleng';
update gii_hierarchy as gh set gh.lat='28.078381', gh.long='-29.866429' where district='MASERU' and council='Telle Council' and village='Ha Machafela';
update gii_hierarchy as gh set gh.lat='28.098117', gh.long='-29.860364' where district='MASERU' and council='Telle Council' and village='Ha Phaphaneso';
update gii_hierarchy as gh set gh.lat='28.081904', gh.long='-29.861402' where district='MASERU' and council='Telle Council' and village='Ha Rateele';
update gii_hierarchy as gh set gh.lat='28.097406', gh.long='-29.873272' where district='MASERU' and council='Telle Council' and village='Ha Seleke';
update gii_hierarchy as gh set gh.lat='28.111811', gh.long='-29.866807' where district='MASERU' and council='Telle Council' and village='Ha Tsekiso';

update gii_hierarchy as gh set gh.lat='28.072309', gh.long='-29.868504' where district='MASERU' and council='Telle Council' and village='Ha Leloko';
update gii_hierarchy as gh set gh.lat='28.087272', gh.long='-29.879161' where district='MASERU' and council='Telle Council' and village='Ha Telekoa';

update gii_hierarchy as gh set gh.lat='28.089574', gh.long='-29.919243' where district='MASERU' and council='Telle Council' and village='Ha Leeba';
update gii_hierarchy as gh set gh.lat='28.104752', gh.long='-29.915018' where district='MASERU' and council='Telle Council' and village='Ha Tieho';
update gii_hierarchy as gh set gh.lat='27.66094', gh.long='-29.505033' where district='MASERU' and council='Telle Council' and village='Ha Tsoinyane';
update gii_hierarchy as gh set gh.lat='27.185966', gh.long='-29.905322' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Ramabele';
update gii_hierarchy as gh set gh.lat='27.194532', gh.long='-29.920249' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mokhothu';
update gii_hierarchy as gh set gh.lat='27.197844', gh.long='-29.912939' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Rajane';
update gii_hierarchy as gh set gh.lat='27.217153', gh.long='-29.9397' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Matsipa';
update gii_hierarchy as gh set gh.lat='27.215504', gh.long='-29.922707' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mokoroane';
update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Siloe Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.467711', gh.long='-30.159186' where district='MOHALES HOEK' and council='Siloe Council' and village='Thoteng';

update gii_hierarchy as gh set gh.lat='27.23175', gh.long='-29.906848' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Raphuthing';
update gii_hierarchy as gh set gh.lat='27.220857', gh.long='-29.912239' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Tiheli';
update gii_hierarchy as gh set gh.lat='27.236494', gh.long='-29.915081' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Kamela';

update gii_hierarchy as gh set gh.lat='27.247185', gh.long='-29.920358' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Montso';

update gii_hierarchy as gh set gh.lat='27.253894', gh.long='-29.913369' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mohapeloa';
update gii_hierarchy as gh set gh.lat='27.26389', gh.long='-29.928696' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Raselepe';
update gii_hierarchy as gh set gh.lat='27.293242', gh.long='-29.91847' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Hlapane';
update gii_hierarchy as gh set gh.lat='27.332969', gh.long='-29.904567' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mohohlo';
update gii_hierarchy as gh set gh.lat='27.305909', gh.long='-29.913105' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Salemone';
update gii_hierarchy as gh set gh.lat='27.362399', gh.long='-29.865346' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Kekeleng';
update gii_hierarchy as gh set gh.lat='27.342497', gh.long='-29.897139' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Chabeli';


update gii_hierarchy as gh set gh.lat='27.35338', gh.long='-29.901778' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Rakulubane (Matebeleng)';
update gii_hierarchy as gh set gh.lat='27.343977', gh.long='-29.883227' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Thulo';
update gii_hierarchy as gh set gh.lat='27.355531', gh.long='-29.892349' where district='MOHALES HOEK' and council='Siloe Council' and village='Ntsirele';
update gii_hierarchy as gh set gh.lat='27.31945', gh.long='-30.064904' where district='MOHALES HOEK' and council='Siloe Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='27.369946', gh.long='-29.88851' where district='MOHALES HOEK' and council='Siloe Council' and village='Setasi';
update gii_hierarchy as gh set gh.lat='27.300267', gh.long='-29.930414' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Moletsane';
update gii_hierarchy as gh set gh.lat='27.731153', gh.long='-30.296588' where district='MOHALES HOEK' and council='Siloe Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='27.281519', gh.long='-29.934784' where district='MOHALES HOEK' and council='Siloe Council' and village='Siloe (Ha Thulo)';
update gii_hierarchy as gh set gh.lat='27.265565', gh.long='-29.937829' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Malintja';
update gii_hierarchy as gh set gh.lat='27.253687', gh.long='-29.950678' where district='MOHALES HOEK' and council='Siloe Council' and village='Matsoareng';
update gii_hierarchy as gh set gh.lat='27.254993', gh.long='-29.938495' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Rantsie';
update gii_hierarchy as gh set gh.lat='27.234012', gh.long='-29.925354' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Maseli';
update gii_hierarchy as gh set gh.lat='27.228099', gh.long='-29.931793' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mokotane';

update gii_hierarchy as gh set gh.lat='27.19502', gh.long='-29.927897' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Khorola';
update gii_hierarchy as gh set gh.lat='27.205025', gh.long='-29.927437' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mahoete';
update gii_hierarchy as gh set gh.lat='27.213373', gh.long='-29.953473' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Sephapo';


update gii_hierarchy as gh set gh.lat='27.230469', gh.long='-29.958916' where district='MOHALES HOEK' and council='Siloe Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='27.248073', gh.long='-29.983282' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Lebele';

update gii_hierarchy as gh set gh.lat='27.239154', gh.long='-29.982477' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Ramotsoanyane';
update gii_hierarchy as gh set gh.lat='27.262017', gh.long='-29.978007' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Tsienyane';



update gii_hierarchy as gh set gh.lat='27.301447', gh.long='-29.967754' where district='MOHALES HOEK' and council='Siloe Council' and village='Lithotseleng';
update gii_hierarchy as gh set gh.lat='27.285448', gh.long='-29.949647' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Masunhloane';
update gii_hierarchy as gh set gh.lat='27.330135', gh.long='-29.953596' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Hamo';
update gii_hierarchy as gh set gh.lat='27.32807', gh.long='-29.947559' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Moko';
update gii_hierarchy as gh set gh.lat='27.352763', gh.long='-29.93511' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Popolosi';

update gii_hierarchy as gh set gh.lat='27.339731', gh.long='-29.977509' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Monyake';
update gii_hierarchy as gh set gh.lat='27.314503', gh.long='-29.976597' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mpopo';
update gii_hierarchy as gh set gh.lat='27.317008', gh.long='-29.984588' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Pii';
update gii_hierarchy as gh set gh.lat='27.308209', gh.long='-29.999617' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Koloti';
update gii_hierarchy as gh set gh.lat='27.28351', gh.long='-29.976951' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Loui';
update gii_hierarchy as gh set gh.lat='27.288294', gh.long='-29.990212' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Molatoli';
update gii_hierarchy as gh set gh.lat='27.290875', gh.long='-29.993456' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Raubi';
update gii_hierarchy as gh set gh.lat='27.284912', gh.long='-29.994621' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Seabo';


update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Siloe Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.260121', gh.long='-30.011365' where district='MOHALES HOEK' and council='Siloe Council' and village='Moreneng';
update gii_hierarchy as gh set gh.lat='27.255431', gh.long='-30.010206' where district='MOHALES HOEK' and council='Siloe Council' and village='Thotaneng';
update gii_hierarchy as gh set gh.lat='27.229805', gh.long='-29.993392' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Khamolane';


update gii_hierarchy as gh set gh.lat='27.29525', gh.long='-30.041458' where district='MOHALES HOEK' and council='Siloe Council' and village='Leribe';
update gii_hierarchy as gh set gh.lat='27.290803', gh.long='-30.010314' where district='MOHALES HOEK' and council='Siloe Council' and village='Linareng';
update gii_hierarchy as gh set gh.lat='27.290861', gh.long='-30.030751' where district='MOHALES HOEK' and council='Siloe Council' and village='Salang';
update gii_hierarchy as gh set gh.lat='27.291249', gh.long='-30.02462' where district='MOHALES HOEK' and council='Siloe Council' and village='Thabeng';
update gii_hierarchy as gh set gh.lat='27.319855', gh.long='-30.009136' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Majoale';
update gii_hierarchy as gh set gh.lat='27.319373', gh.long='-30.018544' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Ralikhalile';



update gii_hierarchy as gh set gh.lat='27.345504', gh.long='-29.99132' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Mahlehle';


update gii_hierarchy as gh set gh.lat='27.358682', gh.long='-30.018804' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Ramokhele';

update gii_hierarchy as gh set gh.lat='27.357946', gh.long='-30.012583' where district='MOHALES HOEK' and council='Siloe Council' and village='Tsoloane';
update gii_hierarchy as gh set gh.lat='27.328667', gh.long='-30.03117' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Ramonate';
update gii_hierarchy as gh set gh.lat='27.48269', gh.long='-30.216753' where district='MOHALES HOEK' and council='Siloe Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.325173', gh.long='-30.024586' where district='MOHALES HOEK' and council='Siloe Council' and village='Mosehlane';
update gii_hierarchy as gh set gh.lat='27.309422', gh.long='-30.036538' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Matsie';
update gii_hierarchy as gh set gh.lat='27.306761', gh.long='-30.03203' where district='MOHALES HOEK' and council='Siloe Council' and village='Sokase';


update gii_hierarchy as gh set gh.lat='27.33724', gh.long='-30.077673' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Raboko';
update gii_hierarchy as gh set gh.lat='27.934447', gh.long='-30.034615' where district='MOHALES HOEK' and council='Siloe Council' and village='Letsatseng';

update gii_hierarchy as gh set gh.lat='27.314845', gh.long='-30.105938' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Pitsi';
update gii_hierarchy as gh set gh.lat='27.318735', gh.long='-30.068863' where district='MOHALES HOEK' and council='Siloe Council' and village='Ha Rathamae';
update gii_hierarchy as gh set gh.lat='27.306784', gh.long='-30.083837' where district='MOHALES HOEK' and council='Siloe Council' and village='Theella';
update gii_hierarchy as gh set gh.lat='27.368972', gh.long='-30.026822' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Ralitlhokoe';
update gii_hierarchy as gh set gh.lat='27.679164', gh.long='-30.284401' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Marakong';
update gii_hierarchy as gh set gh.lat='27.388339', gh.long='-30.038024' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mahase';
update gii_hierarchy as gh set gh.lat='27.372111', gh.long='-30.03235' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mopooane';
update gii_hierarchy as gh set gh.lat='27.400438', gh.long='-30.046651' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Panta';

update gii_hierarchy as gh set gh.lat='27.363656', gh.long='-30.043574' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Letsoaing';

update gii_hierarchy as gh set gh.lat='27.845805', gh.long='-30.052963' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Matebeleng';

update gii_hierarchy as gh set gh.lat='27.415852', gh.long='-30.06144' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Makhate';
update gii_hierarchy as gh set gh.lat='27.423283', gh.long='-30.063745' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Raphiri';
update gii_hierarchy as gh set gh.lat='27.400865', gh.long='-30.070761' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Thekiso';

update gii_hierarchy as gh set gh.lat='27.420262', gh.long='-30.071076' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Lihojeng';
update gii_hierarchy as gh set gh.lat='27.451898', gh.long='-30.132615' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Matsatseng';
update gii_hierarchy as gh set gh.lat='27.390516', gh.long='-30.07637' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='28.394738', gh.long='-30.027767' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='27.260121', gh.long='-30.011365' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Moreneng';



update gii_hierarchy as gh set gh.lat='27.373815', gh.long='-30.076131' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Khuthong';
update gii_hierarchy as gh set gh.lat='27.367269', gh.long='-29.915949' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mokhethi';
update gii_hierarchy as gh set gh.lat='27.379882', gh.long='-30.092675' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Ramoitoi';
update gii_hierarchy as gh set gh.lat='27.351953', gh.long='-30.10425' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mokhatla';


update gii_hierarchy as gh set gh.lat='27.3432', gh.long='-30.105467' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Majoe Masoeu';
update gii_hierarchy as gh set gh.lat='27.340935', gh.long='-30.113254' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Matlapaneng';
update gii_hierarchy as gh set gh.lat='27.48269', gh.long='-30.216753' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.291249', gh.long='-30.02462' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Thabeng';
update gii_hierarchy as gh set gh.lat='27.368462', gh.long='-30.136006' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Lekhooe';
update gii_hierarchy as gh set gh.lat='27.370552', gh.long='-30.106768' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Boikano';
update gii_hierarchy as gh set gh.lat='27.366015', gh.long='-30.116074' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mokhesi';
update gii_hierarchy as gh set gh.lat='27.31945', gh.long='-30.064904' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.123507', gh.long='-29.993926' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Likhutloaneng';
update gii_hierarchy as gh set gh.lat='27.378302', gh.long='-30.135574' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Makhineng';
update gii_hierarchy as gh set gh.lat='27.740595', gh.long='-30.061643' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Majapereng';
update gii_hierarchy as gh set gh.lat='27.403867', gh.long='-30.109274' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Lipeleng';
update gii_hierarchy as gh set gh.lat='27.417878', gh.long='-30.090757' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Khitsane';
update gii_hierarchy as gh set gh.lat='27.412031', gh.long='-30.108569' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Keeke';

update gii_hierarchy as gh set gh.lat='27.429126', gh.long='-30.134193' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Malebanye';
update gii_hierarchy as gh set gh.lat='27.430651', gh.long='-30.126564' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Rakila';
update gii_hierarchy as gh set gh.lat='27.432792', gh.long='-30.119127' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Bolokoe';

update gii_hierarchy as gh set gh.lat='27.442557', gh.long='-30.102822' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Nchoba';
update gii_hierarchy as gh set gh.lat='27.45149', gh.long='-30.098122' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Maphohloane';
update gii_hierarchy as gh set gh.lat='27.450317', gh.long='-30.113307' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Mphaki';
update gii_hierarchy as gh set gh.lat='27.445158', gh.long='-30.118153' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Maqhena';
update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.464297', gh.long='-30.127971' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Lekhema';
update gii_hierarchy as gh set gh.lat='27.471333', gh.long='-30.102891' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Makhapetla';

update gii_hierarchy as gh set gh.lat='27.476747', gh.long='-30.105115' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Old Hoek';
update gii_hierarchy as gh set gh.lat='27.489467', gh.long='-30.103451' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Tsepo';

update gii_hierarchy as gh set gh.lat='27.517602', gh.long='-30.120875' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Lehloibi';
update gii_hierarchy as gh set gh.lat='27.516247', gh.long='-30.113824' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Thoriso';

update gii_hierarchy as gh set gh.lat='27.490312', gh.long='-30.132278' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Potsane';

update gii_hierarchy as gh set gh.lat='27.478726', gh.long='-30.127494' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Ralekhetla';
update gii_hierarchy as gh set gh.lat='27.470239', gh.long='-30.134089' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Qalakheng';



update gii_hierarchy as gh set gh.lat='27.512464', gh.long='-30.142951' where district='MOHALES HOEK' and council='Mashaleng Council' and village='Ha Tsolo';


update gii_hierarchy as gh set gh.lat='27.470239', gh.long='-30.134089' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Qalakheng';
update gii_hierarchy as gh set gh.lat='27.466407', gh.long='-30.146988' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Mahlakeng';
update gii_hierarchy as gh set gh.lat='27.477626', gh.long='-30.148051' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Tanka';
update gii_hierarchy as gh set gh.lat='27.483428', gh.long='-30.153788' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Likhutlong';
update gii_hierarchy as gh set gh.lat='27.338114', gh.long='-29.953004' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Thabaneng';
update gii_hierarchy as gh set gh.lat='28.505181', gh.long='-29.917261' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='27.467711', gh.long='-30.159186' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.462641', gh.long='-30.181744' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Tlali';


update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.44937', gh.long='-30.157179' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Kubake';
update gii_hierarchy as gh set gh.lat='27.435839', gh.long='-30.14589' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Sechele';
update gii_hierarchy as gh set gh.lat='27.446927', gh.long='-30.139943' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Ramarumo';
update gii_hierarchy as gh set gh.lat='27.4126', gh.long='-30.152359' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Kobo Tsoeu';
update gii_hierarchy as gh set gh.lat='27.40455', gh.long='-30.168196' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Sankatana';
update gii_hierarchy as gh set gh.lat='27.440543', gh.long='-30.170064' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Mapotsane';
update gii_hierarchy as gh set gh.lat='27.43864', gh.long='-30.177173' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Rabosiu';
update gii_hierarchy as gh set gh.lat='27.420922', gh.long='-30.185013' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Mesitsaneng';

update gii_hierarchy as gh set gh.lat='27.415593', gh.long='-30.200691' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='27.448914', gh.long='-30.194788' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Sekoati';
update gii_hierarchy as gh set gh.lat='27.436258', gh.long='-30.208004' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Ralineo';

update gii_hierarchy as gh set gh.lat='27.462058', gh.long='-30.199345' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Joang';
update gii_hierarchy as gh set gh.lat='27.476833', gh.long='-30.196738' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Makhosi';

update gii_hierarchy as gh set gh.lat='27.435873', gh.long='-30.22402' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Dingane';

update gii_hierarchy as gh set gh.lat='27.410692', gh.long='-30.21001' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Senekane';


update gii_hierarchy as gh set gh.lat='27.309422', gh.long='-30.036538' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Matsie';
update gii_hierarchy as gh set gh.lat='27.381681', gh.long='-30.228084' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Tumo';

update gii_hierarchy as gh set gh.lat='27.37932', gh.long='-30.223318' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Mateleng';
update gii_hierarchy as gh set gh.lat='27.399665', gh.long='-30.229734' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Kholokoe';
update gii_hierarchy as gh set gh.lat='27.48269', gh.long='-30.216753' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.382947', gh.long='-30.232648' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Malosong';
update gii_hierarchy as gh set gh.lat='27.425859', gh.long='-30.24119' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Hokoane';
update gii_hierarchy as gh set gh.lat='27.403439', gh.long='-30.242822' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Maphakela';
update gii_hierarchy as gh set gh.lat='27.423314', gh.long='-30.24584' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='27.434221', gh.long='-30.242353' where district='MOHALES HOEK' and council='Motlejoeng Council' and village='Ha Ntili (Braakfontein)';



update gii_hierarchy as gh set gh.lat='27.49209', gh.long='-30.341572' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='27.85285', gh.long='-30.057744' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Manyareleng';
update gii_hierarchy as gh set gh.lat='27.507926', gh.long='-30.194675' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mamajoro';
update gii_hierarchy as gh set gh.lat='27.492934', gh.long='-30.198111' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Seabela';
update gii_hierarchy as gh set gh.lat='27.500393', gh.long='-30.199389' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Waterfall';
update gii_hierarchy as gh set gh.lat='27.532459', gh.long='-30.212657' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Poqa';
update gii_hierarchy as gh set gh.lat='27.515444', gh.long='-30.206888' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Setanteng';

update gii_hierarchy as gh set gh.lat='27.388339', gh.long='-30.038024' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mahase';
update gii_hierarchy as gh set gh.lat='27.480148', gh.long='-30.222' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Seliba';

update gii_hierarchy as gh set gh.lat='27.48269', gh.long='-30.216753' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='27.507729', gh.long='-30.227307' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Ntabanyane';
update gii_hierarchy as gh set gh.lat='27.526116', gh.long='-30.221675' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makhube';
update gii_hierarchy as gh set gh.lat='27.546861', gh.long='-30.227263' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Kheisara';
update gii_hierarchy as gh set gh.lat='27.79646', gh.long='-30.182684' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Morabe';
update gii_hierarchy as gh set gh.lat='27.3432', gh.long='-30.105467' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Majoe Masoeu';
update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.728814', gh.long='-30.320354' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='27.723064', gh.long='-30.162871' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Tsoapo le bolila';
update gii_hierarchy as gh set gh.lat='27.565615', gh.long='-30.243981' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Bolometsa';


update gii_hierarchy as gh set gh.lat='27.845805', gh.long='-30.052963' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.498427', gh.long='-30.250056' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makoetlane';

update gii_hierarchy as gh set gh.lat='27.523396', gh.long='-30.253418' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='27.773', gh.long='-30.273532' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='27.453844', gh.long='-30.239303' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='27.464799', gh.long='-30.244147' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Morie';

update gii_hierarchy as gh set gh.lat='27.448395', gh.long='-30.246563' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Mpharane';
update gii_hierarchy as gh set gh.lat='27.41972', gh.long='-30.259122' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Thetso';
update gii_hierarchy as gh set gh.lat='27.440414', gh.long='-30.267256' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Sebetleng';
update gii_hierarchy as gh set gh.lat='27.394845', gh.long='-30.255126' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Peli';

update gii_hierarchy as gh set gh.lat='27.384658', gh.long='-30.271949' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Moiloa';


update gii_hierarchy as gh set gh.lat='27.39559', gh.long='-30.292566' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mane';
update gii_hierarchy as gh set gh.lat='27.405143', gh.long='-30.306035' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Rakoloi';
update gii_hierarchy as gh set gh.lat='27.407308', gh.long='-30.317319' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mokotso';
update gii_hierarchy as gh set gh.lat='27.535246', gh.long='-30.347834' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Marabeng';
update gii_hierarchy as gh set gh.lat='27.434798', gh.long='-30.315257' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Fako';
update gii_hierarchy as gh set gh.lat='27.432202', gh.long='-30.307129' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Robita';
update gii_hierarchy as gh set gh.lat='28.512277', gh.long='-29.901282' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='27.430814', gh.long='-30.289793' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makhisa';


update gii_hierarchy as gh set gh.lat='27.440006', gh.long='-30.283545' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Qoane';
update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.454865', gh.long='-30.266004' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Setotoma';
update gii_hierarchy as gh set gh.lat='27.448883', gh.long='-30.274873' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Sebetlaneng';
update gii_hierarchy as gh set gh.lat='27.468977', gh.long='-30.303422' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Maphutsaneng';
update gii_hierarchy as gh set gh.lat='27.473704', gh.long='-30.29327' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Bereng Matsoho';





update gii_hierarchy as gh set gh.lat='27.510397', gh.long='-30.269521' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makoanyane';

update gii_hierarchy as gh set gh.lat='27.503547', gh.long='-30.286361' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Meriting';
update gii_hierarchy as gh set gh.lat='27.338114', gh.long='-29.953004' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Thabaneng';
update gii_hierarchy as gh set gh.lat='27.514106', gh.long='-30.294264' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Thota Moli';
update gii_hierarchy as gh set gh.lat='27.539411', gh.long='-30.29576' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Nkhetheleng';
update gii_hierarchy as gh set gh.lat='27.530394', gh.long='-30.295878' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Tsehla';

update gii_hierarchy as gh set gh.lat='27.530537', gh.long='-30.271551' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Rashaba';
update gii_hierarchy as gh set gh.lat='27.638006', gh.long='-30.231648' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Makhaola';

update gii_hierarchy as gh set gh.lat='27.675007', gh.long='-30.294377' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Phuthing';

update gii_hierarchy as gh set gh.lat='27.60452', gh.long='-30.298305' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Motee';
update gii_hierarchy as gh set gh.lat='27.594001', gh.long='-30.300998' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Rankali';

update gii_hierarchy as gh set gh.lat='27.594688', gh.long='-30.30786' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Nthama';
update gii_hierarchy as gh set gh.lat='27.759708', gh.long='-30.128007' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Sello';

update gii_hierarchy as gh set gh.lat='27.578728', gh.long='-30.319292' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Likoaeng';




update gii_hierarchy as gh set gh.lat='27.540186', gh.long='-30.307435' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mothebesoane';
update gii_hierarchy as gh set gh.lat='27.537182', gh.long='-30.303199' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Nchocho';
update gii_hierarchy as gh set gh.lat='27.540071', gh.long='-30.316519' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Polateng';
update gii_hierarchy as gh set gh.lat='27.340935', gh.long='-30.113254' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Matlapaneng';



update gii_hierarchy as gh set gh.lat='27.504999', gh.long='-30.306883' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Mohlakana';
update gii_hierarchy as gh set gh.lat='27.497242', gh.long='-30.30235' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Tale';
update gii_hierarchy as gh set gh.lat='27.503094', gh.long='-30.304432' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Libataolong';
update gii_hierarchy as gh set gh.lat='27.504631', gh.long='-30.297181' where district='MOHALES HOEK' and council='Khoelenya Council' and village='White City';


update gii_hierarchy as gh set gh.lat='27.49343', gh.long='-30.294792' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Tolobanka';


update gii_hierarchy as gh set gh.lat='27.800884', gh.long='-30.179401' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Khohloaneng';

update gii_hierarchy as gh set gh.lat='27.484719', gh.long='-30.325273' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Masunyaneng';


update gii_hierarchy as gh set gh.lat='27.53645', gh.long='-30.324132' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Tsoating';
update gii_hierarchy as gh set gh.lat='27.524983', gh.long='-30.331236' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Rabele';




update gii_hierarchy as gh set gh.lat='27.56866', gh.long='-30.352564' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Kalele';
update gii_hierarchy as gh set gh.lat='27.558117', gh.long='-30.352201' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Moshe';






update gii_hierarchy as gh set gh.lat='27.485574', gh.long='-30.345928' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Sethaleng';


update gii_hierarchy as gh set gh.lat='27.510966', gh.long='-30.370861' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Nkau';


update gii_hierarchy as gh set gh.lat='27.528314', gh.long='-30.35641' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Souru';

update gii_hierarchy as gh set gh.lat='27.547256', gh.long='-30.360897' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Malatsa';
update gii_hierarchy as gh set gh.lat='28.505181', gh.long='-29.917261' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Moeaneng';


update gii_hierarchy as gh set gh.lat='27.558349', gh.long='-30.379274' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Phatlalla';
update gii_hierarchy as gh set gh.lat='27.549867', gh.long='-30.377205' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Sekatle';
update gii_hierarchy as gh set gh.lat='27.568909', gh.long='-30.403739' where district='MOHALES HOEK' and council='Khoelenya Council' and village='Ha Ramatlalla';

update gii_hierarchy as gh set gh.lat='27.635222', gh.long='-30.108113' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Salemane';




update gii_hierarchy as gh set gh.lat='27.489938', gh.long='-30.214568' where district='MOHALES HOEK' and council='Teke Council' and village='Sekolong';
update gii_hierarchy as gh set gh.lat='27.599098', gh.long='-30.120645' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Noto';
update gii_hierarchy as gh set gh.lat='27.595042', gh.long='-30.130673' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Teke';
update gii_hierarchy as gh set gh.lat='27.555855', gh.long='-30.126924' where district='MOHALES HOEK' and council='Teke Council' and village='Makhesuoeng';

update gii_hierarchy as gh set gh.lat='27.536812', gh.long='-30.138615' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Ralefatla';
update gii_hierarchy as gh set gh.lat='27.547709', gh.long='-30.155002' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Suoane';
update gii_hierarchy as gh set gh.lat='27.529565', gh.long='-30.156816' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Pekenene';
update gii_hierarchy as gh set gh.lat='27.51691', gh.long='-30.164025' where district='MOHALES HOEK' and council='Teke Council' and village='Thaba Phiri';
update gii_hierarchy as gh set gh.lat='27.423314', gh.long='-30.24584' where district='MOHALES HOEK' and council='Teke Council' and village='Manganeng';


update gii_hierarchy as gh set gh.lat='27.541378', gh.long='-30.177997' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Mafethe';

update gii_hierarchy as gh set gh.lat='27.551395', gh.long='-30.181644' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Selemo';

update gii_hierarchy as gh set gh.lat='27.567541', gh.long='-30.154488' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Nthantso';
update gii_hierarchy as gh set gh.lat='27.57384', gh.long='-30.16025' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Tloko';
update gii_hierarchy as gh set gh.lat='27.564497', gh.long='-30.144311' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Monehela';



update gii_hierarchy as gh set gh.lat='27.618295', gh.long='-30.168033' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Mokutu';

update gii_hierarchy as gh set gh.lat='27.609138', gh.long='-30.141061' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Nete';
update gii_hierarchy as gh set gh.lat='27.845805', gh.long='-30.052963' where district='MOHALES HOEK' and council='Teke Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.598306', gh.long='-30.155551' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Lecheche';

update gii_hierarchy as gh set gh.lat='27.587161', gh.long='-30.175375' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Ramonyatsi';
update gii_hierarchy as gh set gh.lat='27.596589', gh.long='-30.19421' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Sebatli';
update gii_hierarchy as gh set gh.lat='27.970686', gh.long='-29.924179' where district='MOHALES HOEK' and council='Teke Council' and village='Thepung';

update gii_hierarchy as gh set gh.lat='27.578867', gh.long='-30.185257' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Lelinyane';


update gii_hierarchy as gh set gh.lat='27.556893', gh.long='-30.195204' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Rankopane';

update gii_hierarchy as gh set gh.lat='27.54962', gh.long='-30.192267' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Talinyana';
update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Teke Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='27.545417', gh.long='-29.993936' where district='MOHALES HOEK' and council='Teke Council' and village='Tutulung';


update gii_hierarchy as gh set gh.lat='27.576979', gh.long='-30.24389' where district='MOHALES HOEK' and council='Teke Council' and village='Ha Thamahanyane';
update gii_hierarchy as gh set gh.lat='27.234257', gh.long='-29.975072' where district='MOHALES HOEK' and council='Teke Council' and village='Liphokoaneng';
update gii_hierarchy as gh set gh.lat='27.549745', gh.long='-30.21159' where district='MOHALES HOEK' and council='Teke Council' and village='Maqhatseng';
update gii_hierarchy as gh set gh.lat='27.644442', gh.long='-30.199043' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Matoli';
update gii_hierarchy as gh set gh.lat='27.631994', gh.long='-30.19296' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Ralikhomo';
update gii_hierarchy as gh set gh.lat='27.981801', gh.long='-29.8447' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='27.654142', gh.long='-30.184766' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Mamaqabe';








update gii_hierarchy as gh set gh.lat='27.654536', gh.long='-30.224874' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Sebothama';
update gii_hierarchy as gh set gh.lat='27.63092', gh.long='-30.226635' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Sentso';
update gii_hierarchy as gh set gh.lat='27.658548', gh.long='-30.228723' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Tsietsi';





update gii_hierarchy as gh set gh.lat='27.680655', gh.long='-30.237278' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Setulo';

update gii_hierarchy as gh set gh.lat='27.698167', gh.long='-30.223404' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Lengau';
update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='27.248073', gh.long='-29.983282' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Lebele';
update gii_hierarchy as gh set gh.lat='27.709365', gh.long='-30.205591' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Makhalanyane';
update gii_hierarchy as gh set gh.lat='27.767772', gh.long='-30.203728' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Mokoto';

update gii_hierarchy as gh set gh.lat='27.729555', gh.long='-30.21839' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Pholo';
update gii_hierarchy as gh set gh.lat='27.583228', gh.long='-30.29221' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Sethunya';
update gii_hierarchy as gh set gh.lat='27.778395', gh.long='-30.044534' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Liqaleng';
update gii_hierarchy as gh set gh.lat='27.744966', gh.long='-30.225714' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Nkieane';
update gii_hierarchy as gh set gh.lat='27.705616', gh.long='-30.341651' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Letlapeng';

update gii_hierarchy as gh set gh.lat='27.735199', gh.long='-30.234584' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Phoseng';
update gii_hierarchy as gh set gh.lat='27.728969', gh.long='-30.259369' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Shalane';
update gii_hierarchy as gh set gh.lat='27.717713', gh.long='-30.227588' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Lekhafola';

update gii_hierarchy as gh set gh.lat='27.728796', gh.long='-30.24155' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Tlokoeng';


update gii_hierarchy as gh set gh.lat='27.710645', gh.long='-30.273387' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Seliane';

update gii_hierarchy as gh set gh.lat='27.675007', gh.long='-30.294377' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Phuthing';
update gii_hierarchy as gh set gh.lat='27.77708', gh.long='-30.061602' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Sebataolong';
update gii_hierarchy as gh set gh.lat='27.704604', gh.long='-30.257861' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Borakapane';
update gii_hierarchy as gh set gh.lat='27.70295', gh.long='-30.26645' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Khokhotsaneng';
update gii_hierarchy as gh set gh.lat='27.710052', gh.long='-30.264223' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Makilanyaneng';
update gii_hierarchy as gh set gh.lat='28.38833', gh.long='-30.022842' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='27.695536', gh.long='-30.253754' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Sekoaing';

update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.665417', gh.long='-30.284212' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Mohlomi';
update gii_hierarchy as gh set gh.lat='27.679164', gh.long='-30.284401' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Marakong';
update gii_hierarchy as gh set gh.lat='27.49209', gh.long='-30.341572' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Khohlong';


update gii_hierarchy as gh set gh.lat='27.675747', gh.long='-30.33968' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Leketa';
update gii_hierarchy as gh set gh.lat='27.602358', gh.long='-30.334969' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Make';

update gii_hierarchy as gh set gh.lat='27.825791', gh.long='-29.864299' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='27.625004', gh.long='-30.330226' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Raisa';
update gii_hierarchy as gh set gh.lat='27.64628', gh.long='-30.336452' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Khoai';
update gii_hierarchy as gh set gh.lat='27.667332', gh.long='-30.335105' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Fika la Tsoene';
update gii_hierarchy as gh set gh.lat='27.660594', gh.long='-30.294034' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Malephane';


update gii_hierarchy as gh set gh.lat='27.665178', gh.long='-30.308169' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Raqoatha';
update gii_hierarchy as gh set gh.lat='27.817237', gh.long='-29.967918' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Mocheko';

update gii_hierarchy as gh set gh.lat='27.731153', gh.long='-30.296588' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='27.728814', gh.long='-30.320354' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='27.7046', gh.long='-30.295722' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Boritsa';
update gii_hierarchy as gh set gh.lat='27.340935', gh.long='-30.113254' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Matlapaneng';
update gii_hierarchy as gh set gh.lat='27.698093', gh.long='-30.314556' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Lithipeng';
update gii_hierarchy as gh set gh.lat='28.093637', gh.long='-30.031173' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Mothiba';
update gii_hierarchy as gh set gh.lat='27.701373', gh.long='-30.334489' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Thabo';
update gii_hierarchy as gh set gh.lat='27.685698', gh.long='-30.329294' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Matolong';
update gii_hierarchy as gh set gh.lat='27.685756', gh.long='-30.351936' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Mohlakaneng';
update gii_hierarchy as gh set gh.lat='27.704721', gh.long='-30.360235' where district='MOHALES HOEK' and council='Mootsinyane Council' and village='Ha Beka';
update gii_hierarchy as gh set gh.lat='27.690727', gh.long='-30.172767' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Meso';

update gii_hierarchy as gh set gh.lat='27.70004', gh.long='-30.159347' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Rachabana';
update gii_hierarchy as gh set gh.lat='27.721688', gh.long='-30.176295' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Ralekhaola';

update gii_hierarchy as gh set gh.lat='27.714099', gh.long='-30.176117' where district='MOHALES HOEK' and council='Phamong Council' and village='Sealuma';

update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Phamong Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='27.749553', gh.long='-30.189152' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Phalana';
update gii_hierarchy as gh set gh.lat='27.759127', gh.long='-30.203804' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Seteke';
update gii_hierarchy as gh set gh.lat='27.74285', gh.long='-30.197143' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Tlhong';
update gii_hierarchy as gh set gh.lat='27.467711', gh.long='-30.159186' where district='MOHALES HOEK' and council='Phamong Council' and village='Thoteng';





update gii_hierarchy as gh set gh.lat='27.764287', gh.long='-30.222176' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Kheleli';
update gii_hierarchy as gh set gh.lat='27.767772', gh.long='-30.203728' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Mokoto';
update gii_hierarchy as gh set gh.lat='27.754051', gh.long='-30.200718' where district='MOHALES HOEK' and council='Phamong Council' and village='Likhohloaneng';




update gii_hierarchy as gh set gh.lat='27.861447', gh.long='-30.216147' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Makhafola';

update gii_hierarchy as gh set gh.lat='27.798557', gh.long='-30.180923' where district='MOHALES HOEK' and council='Phamong Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.816693', gh.long='-30.209128' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Lipakela';

update gii_hierarchy as gh set gh.lat='28.020813', gh.long='-29.929545' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Makara';


update gii_hierarchy as gh set gh.lat='27.845427', gh.long='-30.202356' where district='MOHALES HOEK' and council='Phamong Council' and village='Liboti';

update gii_hierarchy as gh set gh.lat='27.558349', gh.long='-30.379274' where district='MOHALES HOEK' and council='Phamong Council' and village='Phatlalla';

update gii_hierarchy as gh set gh.lat='27.660594', gh.long='-30.294034' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Malephane';
update gii_hierarchy as gh set gh.lat='27.821919', gh.long='-30.203782' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Lempe';
update gii_hierarchy as gh set gh.lat='27.812966', gh.long='-30.219586' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Qacha';
update gii_hierarchy as gh set gh.lat='27.808595', gh.long='-30.225773' where district='MOHALES HOEK' and council='Phamong Council' and village='Matsetseng';
update gii_hierarchy as gh set gh.lat='27.777952', gh.long='-30.245597' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Khobo';
update gii_hierarchy as gh set gh.lat='27.77236', gh.long='-30.23892' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Ntoi';
update gii_hierarchy as gh set gh.lat='27.403867', gh.long='-30.109274' where district='MOHALES HOEK' and council='Phamong Council' and village='Lipeleng';
update gii_hierarchy as gh set gh.lat='27.970686', gh.long='-29.924179' where district='MOHALES HOEK' and council='Phamong Council' and village='Thepung';

update gii_hierarchy as gh set gh.lat='27.803085', gh.long='-30.231259' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Ntloana';

update gii_hierarchy as gh set gh.lat='27.845812', gh.long='-30.236797' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Qiqita';



update gii_hierarchy as gh set gh.lat='27.862822', gh.long='-30.233436' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Teboho';


update gii_hierarchy as gh set gh.lat='27.802128', gh.long='-30.247091' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Ramabutsoela';




update gii_hierarchy as gh set gh.lat='27.774455', gh.long='-30.251809' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Lehloenya';
update gii_hierarchy as gh set gh.lat='27.762889', gh.long='-30.252481' where district='MOHALES HOEK' and council='Phamong Council' and village='Ha Lethena';







update gii_hierarchy as gh set gh.lat='27.564979', gh.long='-29.937544' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Masita';
update gii_hierarchy as gh set gh.lat='27.571699', gh.long='-29.948203' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Pitseng';
update gii_hierarchy as gh set gh.lat='27.569292', gh.long='-29.936234' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Ralepei';
update gii_hierarchy as gh set gh.lat='27.573797', gh.long='-29.953253' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Thokoa';
update gii_hierarchy as gh set gh.lat='27.31945', gh.long='-30.064904' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Pontseng';


update gii_hierarchy as gh set gh.lat='27.538984', gh.long='-29.976892' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Belemane';
update gii_hierarchy as gh set gh.lat='27.547565', gh.long='-29.97618' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Maqeba';
update gii_hierarchy as gh set gh.lat='27.53733', gh.long='-29.963568' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Matseo';
update gii_hierarchy as gh set gh.lat='27.32524', gh.long='-29.976949' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Moeletsi';

update gii_hierarchy as gh set gh.lat='27.847441', gh.long='-30.243231' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Hloahloeng';




update gii_hierarchy as gh set gh.lat='27.52659', gh.long='-29.998404' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Bokoro';
update gii_hierarchy as gh set gh.lat='27.519833', gh.long='-30.000744' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Jimi';
update gii_hierarchy as gh set gh.lat='27.524269', gh.long='-29.995888' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mahlelebe';
update gii_hierarchy as gh set gh.lat='27.509549', gh.long='-29.999718' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mothe';
update gii_hierarchy as gh set gh.lat='27.51248', gh.long='-29.994735' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Ntepe';
update gii_hierarchy as gh set gh.lat='27.518395', gh.long='-30.016398' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Makutoaneng';

update gii_hierarchy as gh set gh.lat='27.56945', gh.long='-30.00035' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Kholoane';

update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.563218', gh.long='-29.991452' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Rasebolelo';
update gii_hierarchy as gh set gh.lat='27.559437', gh.long='-29.985139' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Soere';


update gii_hierarchy as gh set gh.lat='27.61119', gh.long='-29.967178' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Khanyane';
update gii_hierarchy as gh set gh.lat='27.529565', gh.long='-30.156816' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Pekenene';
update gii_hierarchy as gh set gh.lat='27.601034', gh.long='-29.967584' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Nomoroane';

update gii_hierarchy as gh set gh.lat='27.652712', gh.long='-29.977539' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Ramatlali';
update gii_hierarchy as gh set gh.lat='27.616668', gh.long='-29.969169' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Sekunyane';
update gii_hierarchy as gh set gh.lat='27.621983', gh.long='-29.962084' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Taele';


update gii_hierarchy as gh set gh.lat='27.648179', gh.long='-29.968502' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Tepa';
update gii_hierarchy as gh set gh.lat='27.390516', gh.long='-30.07637' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='27.399665', gh.long='-30.229734' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Kholokoe';
update gii_hierarchy as gh set gh.lat='27.639516', gh.long='-29.994166' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Phohlokong';
update gii_hierarchy as gh set gh.lat='27.621935', gh.long='-29.980065' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Ntsapi';




update gii_hierarchy as gh set gh.lat='27.590575', gh.long='-30.000087' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Phala';
update gii_hierarchy as gh set gh.lat='27.588043', gh.long='-30.005523' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Hohobeng';
update gii_hierarchy as gh set gh.lat='27.57223', gh.long='-30.017172' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Tsese';
update gii_hierarchy as gh set gh.lat='27.451898', gh.long='-30.132615' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Matsatseng';
update gii_hierarchy as gh set gh.lat='27.535607', gh.long='-30.024681' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Lisene';
update gii_hierarchy as gh set gh.lat='27.54279', gh.long='-30.050805' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Rampeli';
update gii_hierarchy as gh set gh.lat='27.540942', gh.long='-30.031965' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Kopialena';



update gii_hierarchy as gh set gh.lat='27.496711', gh.long='-30.05157' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mapuru';








update gii_hierarchy as gh set gh.lat='27.514097', gh.long='-30.053267' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Maboneng';

update gii_hierarchy as gh set gh.lat='27.530993', gh.long='-30.051376' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Maqoala';
update gii_hierarchy as gh set gh.lat='27.529705', gh.long='-30.058596' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Ranyakane';

update gii_hierarchy as gh set gh.lat='27.440006', gh.long='-30.283545' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Qoane';
update gii_hierarchy as gh set gh.lat='27.467711', gh.long='-30.159186' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.457503', gh.long='-30.050289' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Chefa';
update gii_hierarchy as gh set gh.lat='27.467814', gh.long='-30.059114' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Lithakaling';
update gii_hierarchy as gh set gh.lat='27.450649', gh.long='-30.064048' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mosotho';
update gii_hierarchy as gh set gh.lat='27.400584', gh.long='-30.214345' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Sehloho';
update gii_hierarchy as gh set gh.lat='27.467305', gh.long='-30.077308' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Matsekeng';
update gii_hierarchy as gh set gh.lat='27.459523', gh.long='-30.082204' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Nkoboto';

update gii_hierarchy as gh set gh.lat='27.488641', gh.long='-30.084312' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Khoale';
update gii_hierarchy as gh set gh.lat='27.477429', gh.long='-30.076693' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mokunyane';
update gii_hierarchy as gh set gh.lat='27.705616', gh.long='-30.341651' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Letlapeng';



update gii_hierarchy as gh set gh.lat='27.488348', gh.long='-30.096418' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Rakhenku';
update gii_hierarchy as gh set gh.lat='27.502149', gh.long='-30.101433' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Lefikeng';
update gii_hierarchy as gh set gh.lat='27.491', gh.long='-30.099473' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Matsaung';


update gii_hierarchy as gh set gh.lat='28.505042', gh.long='-29.940913' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mohale';

update gii_hierarchy as gh set gh.lat='27.533415', gh.long='-30.112102' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Rantsoeu';


update gii_hierarchy as gh set gh.lat='27.533678', gh.long='-30.104638' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Matsoapong';

update gii_hierarchy as gh set gh.lat='27.555806', gh.long='-30.088974' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Monakalali';
update gii_hierarchy as gh set gh.lat='27.545419', gh.long='-30.059577' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mothetho';

update gii_hierarchy as gh set gh.lat='27.548513', gh.long='-29.947669' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mako';
update gii_hierarchy as gh set gh.lat='27.560749', gh.long='-30.046517' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Moloche';
update gii_hierarchy as gh set gh.lat='27.574827', gh.long='-30.064119' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Moshabe';
update gii_hierarchy as gh set gh.lat='27.586613', gh.long='-30.068017' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mosika';
update gii_hierarchy as gh set gh.lat='27.557893', gh.long='-30.038036' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Thabaneng tsa Marole';
update gii_hierarchy as gh set gh.lat='27.574699', gh.long='-30.031017' where district='MOHALES HOEK' and council='Thaba Mokhele Council' and village='Ha Mabaka';

update gii_hierarchy as gh set gh.lat='27.849208', gh.long='-29.994094' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Lephoto';

update gii_hierarchy as gh set gh.lat='27.839917', gh.long='-29.966683' where district='MOHALES HOEK' and council='Qobong Council' and village='Khakhathane';
update gii_hierarchy as gh set gh.lat='27.762414', gh.long='-29.968485' where district='MOHALES HOEK' and council='Qobong Council' and village='Khorong';
update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Qobong Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.823949', gh.long='-29.994234' where district='MOHALES HOEK' and council='Qobong Council' and village='Thaba Lethu';

update gii_hierarchy as gh set gh.lat='27.870084', gh.long='-30.014297' where district='MOHALES HOEK' and council='Qobong Council' and village='Litsiloaneng';
update gii_hierarchy as gh set gh.lat='27.826978', gh.long='-30.048153' where district='MOHALES HOEK' and council='Qobong Council' and village='Mokeke';


update gii_hierarchy as gh set gh.lat='27.853247', gh.long='-30.053701' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Nohana';
update gii_hierarchy as gh set gh.lat='27.845805', gh.long='-30.052963' where district='MOHALES HOEK' and council='Qobong Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.856386', gh.long='-30.068797' where district='MOHALES HOEK' and council='Qobong Council' and village='Boiketlo';

update gii_hierarchy as gh set gh.lat='27.859888', gh.long='-30.07995' where district='MOHALES HOEK' and council='Qobong Council' and village='Lipereng';
update gii_hierarchy as gh set gh.lat='27.467711', gh.long='-30.159186' where district='MOHALES HOEK' and council='Qobong Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.843175', gh.long='-30.080192' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Maponyane';
update gii_hierarchy as gh set gh.lat='27.822244', gh.long='-30.069582' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Matebesi';
update gii_hierarchy as gh set gh.lat='27.812833', gh.long='-30.061258' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Tau';

update gii_hierarchy as gh set gh.lat='27.805998', gh.long='-30.07477' where district='MOHALES HOEK' and council='Qobong Council' and village='Tsoelike';
update gii_hierarchy as gh set gh.lat='27.810064', gh.long='-30.050792' where district='MOHALES HOEK' and council='Qobong Council' and village='Mafika Lisiu';

update gii_hierarchy as gh set gh.lat='27.801165', gh.long='-30.069448' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Challa';


update gii_hierarchy as gh set gh.lat='27.790206', gh.long='-30.041563' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Thaba';
update gii_hierarchy as gh set gh.lat='27.778395', gh.long='-30.044534' where district='MOHALES HOEK' and council='Qobong Council' and village='Liqaleng';

update gii_hierarchy as gh set gh.lat='28.549579', gh.long='-29.918468' where district='MOHALES HOEK' and council='Qobong Council' and village='Mokoallong';

update gii_hierarchy as gh set gh.lat='27.7046', gh.long='-30.295722' where district='MOHALES HOEK' and council='Qobong Council' and village='Boritsa';
update gii_hierarchy as gh set gh.lat='27.777517', gh.long='-30.050154' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Ranyali';
update gii_hierarchy as gh set gh.lat='27.748901', gh.long='-30.0339' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Seithati';


update gii_hierarchy as gh set gh.lat='27.730095', gh.long='-30.051736' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Lepeli';
update gii_hierarchy as gh set gh.lat='27.736577', gh.long='-30.058568' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Mokoenehi';
update gii_hierarchy as gh set gh.lat='27.760441', gh.long='-30.059516' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Sebili';
update gii_hierarchy as gh set gh.lat='27.734925', gh.long='-30.060755' where district='MOHALES HOEK' and council='Qobong Council' and village='Materentseng';

update gii_hierarchy as gh set gh.lat='27.697218', gh.long='-30.09409' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Beila';

update gii_hierarchy as gh set gh.lat='27.742432', gh.long='-30.107702' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Masia';
update gii_hierarchy as gh set gh.lat='27.737913', gh.long='-30.101889' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Mololi';
update gii_hierarchy as gh set gh.lat='27.742577', gh.long='-30.101573' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Senyane';
update gii_hierarchy as gh set gh.lat='27.727772', gh.long='-30.097134' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Tsuinyane';
update gii_hierarchy as gh set gh.lat='27.49209', gh.long='-30.341572' where district='MOHALES HOEK' and council='Qobong Council' and village='Khohlong';



update gii_hierarchy as gh set gh.lat='27.754827', gh.long='-30.083837' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Ntsokoane';
update gii_hierarchy as gh set gh.lat='27.794394', gh.long='-30.079994' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Mahaha';
update gii_hierarchy as gh set gh.lat='27.782767', gh.long='-30.107264' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Kori';
update gii_hierarchy as gh set gh.lat='27.43864', gh.long='-30.177173' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Rabosiu';

update gii_hierarchy as gh set gh.lat='27.765428', gh.long='-30.108943' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Nyape';



update gii_hierarchy as gh set gh.lat='27.758316', gh.long='-30.096295' where district='MOHALES HOEK' and council='Qobong Council' and village='Boitelo';

update gii_hierarchy as gh set gh.lat='27.639516', gh.long='-29.994166' where district='MOHALES HOEK' and council='Qobong Council' and village='Phohlokong';
update gii_hierarchy as gh set gh.lat='27.761103', gh.long='-30.176093' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Mokotjane';



update gii_hierarchy as gh set gh.lat='27.798557', gh.long='-30.180923' where district='MOHALES HOEK' and council='Qobong Council' and village='Khubetsoana';

update gii_hierarchy as gh set gh.lat='27.76812', gh.long='-30.165117' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Motumi';

update gii_hierarchy as gh set gh.lat='28.030292', gh.long='-30.025282' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Ntja';
update gii_hierarchy as gh set gh.lat='28.235322', gh.long='-29.905362' where district='MOHALES HOEK' and council='Qobong Council' and village='Lichecheng';

update gii_hierarchy as gh set gh.lat='27.812577', gh.long='-30.116778' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Raseboko';
update gii_hierarchy as gh set gh.lat='27.705616', gh.long='-30.341651' where district='MOHALES HOEK' and council='Qobong Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='27.808494', gh.long='-30.121' where district='MOHALES HOEK' and council='Qobong Council' and village='Sekokong';
update gii_hierarchy as gh set gh.lat='27.872294', gh.long='-30.121141' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Pokola';
update gii_hierarchy as gh set gh.lat='27.862944', gh.long='-30.116923' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Sebinane';
update gii_hierarchy as gh set gh.lat='27.841176', gh.long='-30.101105' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Sekhohola';
update gii_hierarchy as gh set gh.lat='27.858464', gh.long='-30.102921' where district='MOHALES HOEK' and council='Qobong Council' and village='Mateanong';
update gii_hierarchy as gh set gh.lat='27.855026', gh.long='-30.143213' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Tlhabeli';


update gii_hierarchy as gh set gh.lat='27.833157', gh.long='-30.157122' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Toko';






update gii_hierarchy as gh set gh.lat='27.861899', gh.long='-30.158539' where district='MOHALES HOEK' and council='Qobong Council' and village='Maloreng';
update gii_hierarchy as gh set gh.lat='27.861222', gh.long='-30.155285' where district='MOHALES HOEK' and council='Qobong Council' and village='Mankung';
update gii_hierarchy as gh set gh.lat='27.879325', gh.long='-30.166627' where district='MOHALES HOEK' and council='Qobong Council' and village='Seshaing';
update gii_hierarchy as gh set gh.lat='27.85378', gh.long='-30.183774' where district='MOHALES HOEK' and council='Qobong Council' and village='Ha Motopi';
update gii_hierarchy as gh set gh.lat='27.340935', gh.long='-30.113254' where district='MOHALES HOEK' and council='Qobong Council' and village='Matlapaneng';
update gii_hierarchy as gh set gh.lat='27.533678', gh.long='-30.104638' where district='MOHALES HOEK' and council='Qobong Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='27.849291', gh.long='-30.181597' where district='MOHALES HOEK' and council='Qobong Council' and village='Thibella';
update gii_hierarchy as gh set gh.lat='27.895803', gh.long='-29.837167' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Mothibi';









update gii_hierarchy as gh set gh.lat='27.740595', gh.long='-30.061643' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Majapereng';
update gii_hierarchy as gh set gh.lat='27.853298', gh.long='-29.848843' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Poriki';
update gii_hierarchy as gh set gh.lat='27.819173', gh.long='-29.895228' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Thaba Sekoka';
update gii_hierarchy as gh set gh.lat='27.868209', gh.long='-29.936108' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Ntjanyana';
update gii_hierarchy as gh set gh.lat='27.903416', gh.long='-29.897696' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Polile';
update gii_hierarchy as gh set gh.lat='27.878518', gh.long='-29.905395' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Sepolo';

update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.578728', gh.long='-30.319292' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Likoaeng';

update gii_hierarchy as gh set gh.lat='27.860675', gh.long='-29.94499' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Letsie';

update gii_hierarchy as gh set gh.lat='27.900389', gh.long='-29.983655' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Rantoetsi';

update gii_hierarchy as gh set gh.lat='27.85577', gh.long='-29.978963' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Koting sa Matsa';

update gii_hierarchy as gh set gh.lat='27.897925', gh.long='-30.022035' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Kotsoana';

update gii_hierarchy as gh set gh.lat='27.887677', gh.long='-30.02935' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Ralekhoasa';
update gii_hierarchy as gh set gh.lat='27.872857', gh.long='-30.00209' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Tau';
update gii_hierarchy as gh set gh.lat='27.898498', gh.long='-30.014518' where district='MOHALES HOEK' and council='Qhobeng Council' and village='Ha Teleki';






update gii_hierarchy as gh set gh.lat='27.705756', gh.long='-30.089707' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Hlalele';
update gii_hierarchy as gh set gh.lat='27.943222', gh.long='-29.880191' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Molobeli';
update gii_hierarchy as gh set gh.lat='28.200147', gh.long='-29.966675' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Motseki';
update gii_hierarchy as gh set gh.lat='27.798557', gh.long='-30.180923' where district='MOHALES HOEK' and council='Seroto Council' and village='Khubetsoana';

update gii_hierarchy as gh set gh.lat='27.929489', gh.long='-29.951911' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Ntsuku';
update gii_hierarchy as gh set gh.lat='27.464474', gh.long='-30.163316' where district='MOHALES HOEK' and council='Seroto Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='27.942702', gh.long='-29.917818' where district='MOHALES HOEK' and council='Seroto Council' and village='Motheoaneng';
update gii_hierarchy as gh set gh.lat='27.961505', gh.long='-29.907944' where district='MOHALES HOEK' and council='Seroto Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='27.942434', gh.long='-29.935163' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Bati';



update gii_hierarchy as gh set gh.lat='27.912256', gh.long='-29.927233' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Raseboto';



update gii_hierarchy as gh set gh.lat='27.96509', gh.long='-29.952154' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Ralimpe';
update gii_hierarchy as gh set gh.lat='27.954903', gh.long='-29.965593' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Salae';
update gii_hierarchy as gh set gh.lat='27.845805', gh.long='-30.052963' where district='MOHALES HOEK' and council='Seroto Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.989791', gh.long='-29.954973' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Pokola';
update gii_hierarchy as gh set gh.lat='27.986568', gh.long='-29.9346' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Ramosothoane';
update gii_hierarchy as gh set gh.lat='27.981347', gh.long='-29.95601' where district='MOHALES HOEK' and council='Seroto Council' and village='Matlakeng';


update gii_hierarchy as gh set gh.lat='28.005686', gh.long='-29.949012' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Makara';
update gii_hierarchy as gh set gh.lat='28.049596', gh.long='-29.975588' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Marame';



update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Seroto Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='28.058861', gh.long='-29.969726' where district='MOHALES HOEK' and council='Seroto Council' and village='Makhetheng';

update gii_hierarchy as gh set gh.lat='27.970686', gh.long='-29.924179' where district='MOHALES HOEK' and council='Seroto Council' and village='Thepung';
update gii_hierarchy as gh set gh.lat='28.01364', gh.long='-29.974266' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Seaka';
update gii_hierarchy as gh set gh.lat='28.01179', gh.long='-29.964885' where district='MOHALES HOEK' and council='Seroto Council' and village='Mechalleng';

update gii_hierarchy as gh set gh.lat='28.003145', gh.long='-30.00372' where district='MOHALES HOEK' and council='Seroto Council' and village='Lihlolong';
update gii_hierarchy as gh set gh.lat='28.006915', gh.long='-29.997126' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Bakhafi';

update gii_hierarchy as gh set gh.lat='27.673313', gh.long='-30.312847' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Meta';
update gii_hierarchy as gh set gh.lat='27.942568', gh.long='-29.976794' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Laene';
update gii_hierarchy as gh set gh.lat='27.909018', gh.long='-29.984702' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Mathibeli';



update gii_hierarchy as gh set gh.lat='27.907148', gh.long='-29.975914' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Qoboko';

update gii_hierarchy as gh set gh.lat='27.613652', gh.long='-30.157516' where district='MOHALES HOEK' and council='Seroto Council' and village='Tsoeneng';
update gii_hierarchy as gh set gh.lat='27.93826', gh.long='-29.987155' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Thabo Matete';
update gii_hierarchy as gh set gh.lat='27.524983', gh.long='-30.331236' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Rabele';
update gii_hierarchy as gh set gh.lat='27.912421', gh.long='-30.004783' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Sefehle';
update gii_hierarchy as gh set gh.lat='27.92358', gh.long='-30.022098' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Thetsinyane';

update gii_hierarchy as gh set gh.lat='27.947767', gh.long='-30.01771' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Motlohi';
update gii_hierarchy as gh set gh.lat='27.588043', gh.long='-30.005523' where district='MOHALES HOEK' and council='Seroto Council' and village='Hohobeng';

update gii_hierarchy as gh set gh.lat='27.225867', gh.long='-29.996514' where district='MOHALES HOEK' and council='Seroto Council' and village='Moru Motso';
update gii_hierarchy as gh set gh.lat='27.523396', gh.long='-30.253418' where district='MOHALES HOEK' and council='Seroto Council' and village='Thabana Tsooana';
update gii_hierarchy as gh set gh.lat='27.453844', gh.long='-30.239303' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Jobo';
update gii_hierarchy as gh set gh.lat='27.990058', gh.long='-30.024465' where district='MOHALES HOEK' and council='Seroto Council' and village='Malinakana';



update gii_hierarchy as gh set gh.lat='27.983445', gh.long='-30.058849' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Shoele';
update gii_hierarchy as gh set gh.lat='27.705616', gh.long='-30.341651' where district='MOHALES HOEK' and council='Seroto Council' and village='Letlapeng';

update gii_hierarchy as gh set gh.lat='27.948961', gh.long='-30.070709' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Ranti';
update gii_hierarchy as gh set gh.lat='27.932051', gh.long='-30.04288' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Shakhane';
update gii_hierarchy as gh set gh.lat='27.576979', gh.long='-30.24389' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Thamahanyane';
update gii_hierarchy as gh set gh.lat='27.338114', gh.long='-29.953004' where district='MOHALES HOEK' and council='Seroto Council' and village='Thabaneng';
update gii_hierarchy as gh set gh.lat='27.925158', gh.long='-30.061769' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Bolae';

update gii_hierarchy as gh set gh.lat='27.882655', gh.long='-30.076354' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Khoalinyane';
update gii_hierarchy as gh set gh.lat='27.877404', gh.long='-30.056957' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Ntsene';
update gii_hierarchy as gh set gh.lat='27.907496', gh.long='-30.085266' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Pata';
update gii_hierarchy as gh set gh.lat='27.51005', gh.long='-30.242533' where district='MOHALES HOEK' and council='Seroto Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='27.883115', gh.long='-30.103606' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Sephoko';
update gii_hierarchy as gh set gh.lat='27.869173', gh.long='-30.09548' where district='MOHALES HOEK' and council='Seroto Council' and village='Ha Seturumane';

update gii_hierarchy as gh set gh.lat='27.890159', gh.long='-30.120862' where district='MOHALES HOEK' and council='Seroto Council' and village='Lekokong';
update gii_hierarchy as gh set gh.lat='27.698093', gh.long='-30.314556' where district='MOHALES HOEK' and council='Seroto Council' and village='Lithipeng';
update gii_hierarchy as gh set gh.lat='27.902486', gh.long='-30.108938' where district='MOHALES HOEK' and council='Seroto Council' and village='Tsoeu ea penya';
update gii_hierarchy as gh set gh.lat='28.233408', gh.long='-29.891714' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Mpheulane';
update gii_hierarchy as gh set gh.lat='28.26113', gh.long='-29.923557' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Nkesi';
update gii_hierarchy as gh set gh.lat='28.244692', gh.long='-29.918914' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Ntsokolo';

update gii_hierarchy as gh set gh.lat='27.759708', gh.long='-30.128007' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Sello';
update gii_hierarchy as gh set gh.lat='28.227006', gh.long='-29.903128' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.253979', gh.long='-29.938223' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Malane';

update gii_hierarchy as gh set gh.lat='28.219952', gh.long='-29.9564' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Ngoana Ntloana';


update gii_hierarchy as gh set gh.lat='28.204791', gh.long='-29.912161' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Makepe';
update gii_hierarchy as gh set gh.lat='28.206038', gh.long='-29.92244' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Marathane';

update gii_hierarchy as gh set gh.lat='27.965643', gh.long='-30.051113' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Tsie';
update gii_hierarchy as gh set gh.lat='28.277797', gh.long='-29.951121' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Lithakong';

update gii_hierarchy as gh set gh.lat='28.171188', gh.long='-29.935384' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Maritinyane';


update gii_hierarchy as gh set gh.lat='28.140457', gh.long='-29.924251' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Lesuoa';
update gii_hierarchy as gh set gh.lat='28.131987', gh.long='-29.910206' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Ralemati';
update gii_hierarchy as gh set gh.lat='28.140906', gh.long='-29.913251' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Setene';
update gii_hierarchy as gh set gh.lat='27.423314', gh.long='-30.24584' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.075161', gh.long='-29.94224' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Kou';

update gii_hierarchy as gh set gh.lat='28.103487', gh.long='-29.939833' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Heising';
update gii_hierarchy as gh set gh.lat='28.117271', gh.long='-29.928451' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Makheka';
update gii_hierarchy as gh set gh.lat='28.141787', gh.long='-29.959855' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Leronti';
update gii_hierarchy as gh set gh.lat='28.181598', gh.long='-29.970199' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Tsenekeng';
update gii_hierarchy as gh set gh.lat='28.181165', gh.long='-30.006041' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Khosi';
update gii_hierarchy as gh set gh.lat='28.182599', gh.long='-29.98868' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Luka';
update gii_hierarchy as gh set gh.lat='28.211274', gh.long='-29.976625' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Nkonyana';
update gii_hierarchy as gh set gh.lat='28.200741', gh.long='-29.995199' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Notsi';
update gii_hierarchy as gh set gh.lat='28.15327', gh.long='-29.991322' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Malefetsane';
update gii_hierarchy as gh set gh.lat='28.161901', gh.long='-29.986931' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Meeling';

update gii_hierarchy as gh set gh.lat='28.156935', gh.long='-29.970544' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Lepekola';


update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.0687', gh.long='-30.005252' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Elia';
update gii_hierarchy as gh set gh.lat='28.082988', gh.long='-29.974398' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Likhutloaneng';
update gii_hierarchy as gh set gh.lat='28.052178', gh.long='-30.003383' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Maluke';

update gii_hierarchy as gh set gh.lat='28.063607', gh.long='-29.988784' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Sefateng';



update gii_hierarchy as gh set gh.lat='28.143796', gh.long='-30.013595' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Mathibane';
update gii_hierarchy as gh set gh.lat='28.153472', gh.long='-30.003772' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Liphamoleng';

update gii_hierarchy as gh set gh.lat='28.180258', gh.long='-30.013116' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Mokukutoana';
update gii_hierarchy as gh set gh.lat='28.173092', gh.long='-30.023247' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Mokopung';
update gii_hierarchy as gh set gh.lat='28.133145', gh.long='-30.031684' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Motsoane';

update gii_hierarchy as gh set gh.lat='28.114026', gh.long='-30.035431' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Senyeka';
update gii_hierarchy as gh set gh.lat='28.121441', gh.long='-30.059899' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='27.934447', gh.long='-30.034615' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Letsatseng';
update gii_hierarchy as gh set gh.lat='28.108392', gh.long='-30.023332' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Masaleng';


update gii_hierarchy as gh set gh.lat='28.030423', gh.long='-30.03076' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Ntaoana';
update gii_hierarchy as gh set gh.lat='28.030292', gh.long='-30.025282' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Ntja';
update gii_hierarchy as gh set gh.lat='28.04859', gh.long='-30.019399' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Selalome';

update gii_hierarchy as gh set gh.lat='28.086801', gh.long='-30.057482' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Khajoane';

update gii_hierarchy as gh set gh.lat='28.108435', gh.long='-30.049618' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Tota';
update gii_hierarchy as gh set gh.lat='27.51005', gh.long='-30.242533' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='28.04842', gh.long='-30.056994' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Isao';
update gii_hierarchy as gh set gh.lat='28.06751', gh.long='-30.05789' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Malefane';
update gii_hierarchy as gh set gh.lat='28.045431', gh.long='-30.075393' where district='MOHALES HOEK' and council='Likhutloaneng Council' and village='Ha Masilo';



update gii_hierarchy as gh set gh.lat='28.340258', gh.long='-29.896256' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Boroko';
update gii_hierarchy as gh set gh.lat='28.372469', gh.long='-29.879968' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Chalotsane';
update gii_hierarchy as gh set gh.lat='28.362554', gh.long='-29.873447' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Lechesa';
update gii_hierarchy as gh set gh.lat='28.350788', gh.long='-29.883175' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Moahloli';
update gii_hierarchy as gh set gh.lat='27.729555', gh.long='-30.21839' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Pholo';
update gii_hierarchy as gh set gh.lat='27.524983', gh.long='-30.331236' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Rabele';
update gii_hierarchy as gh set gh.lat='27.798557', gh.long='-30.180923' where district='MOHALES HOEK' and council='Nkau Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.385732', gh.long='-29.878893' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Lenyatsa';
update gii_hierarchy as gh set gh.lat='28.396013', gh.long='-29.875487' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Romane';
update gii_hierarchy as gh set gh.lat='27.512464', gh.long='-30.142951' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Tsolo';

update gii_hierarchy as gh set gh.lat='28.41304', gh.long='-29.89409' where district='MOHALES HOEK' and council='Nkau Council' and village='Sehaula';
update gii_hierarchy as gh set gh.lat='27.310154', gh.long='-30.06048' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mokhele';
update gii_hierarchy as gh set gh.lat='28.409818', gh.long='-29.921638' where district='MOHALES HOEK' and council='Nkau Council' and village='Matsabeng';
update gii_hierarchy as gh set gh.lat='28.394396', gh.long='-29.936545' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Makhetha';
update gii_hierarchy as gh set gh.lat='28.409834', gh.long='-29.92689' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Matsa';

update gii_hierarchy as gh set gh.lat='28.388001', gh.long='-29.94469' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Selone';


update gii_hierarchy as gh set gh.lat='28.277797', gh.long='-29.951121' where district='MOHALES HOEK' and council='Nkau Council' and village='Lithakong';
update gii_hierarchy as gh set gh.lat='28.353567', gh.long='-29.959422' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Emile';
update gii_hierarchy as gh set gh.lat='28.363978', gh.long='-29.953793' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Kajeng';

update gii_hierarchy as gh set gh.lat='28.362941', gh.long='-29.946795' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mpusi';


update gii_hierarchy as gh set gh.lat='28.367164', gh.long='-29.932955' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Ntoane';
update gii_hierarchy as gh set gh.lat='28.37058', gh.long='-29.897211' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Rankhoba';
update gii_hierarchy as gh set gh.lat='28.377155', gh.long='-29.930112' where district='MOHALES HOEK' and council='Nkau Council' and village='Makokong';
update gii_hierarchy as gh set gh.lat='28.315305', gh.long='-29.903411' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Liau';
update gii_hierarchy as gh set gh.lat='27.745231', gh.long='-30.115351' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mokone';

update gii_hierarchy as gh set gh.lat='28.337465', gh.long='-29.905767' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Seeqela';
update gii_hierarchy as gh set gh.lat='28.346312', gh.long='-29.900212' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Setone';
update gii_hierarchy as gh set gh.lat='28.332187', gh.long='-29.903013' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Thiba li eme';
update gii_hierarchy as gh set gh.lat='28.314605', gh.long='-29.929043' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Kahlolo';
update gii_hierarchy as gh set gh.lat='27.407308', gh.long='-30.317319' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mokotso';
update gii_hierarchy as gh set gh.lat='28.318457', gh.long='-29.93992' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Morema';

update gii_hierarchy as gh set gh.lat='27.49209', gh.long='-30.341572' where district='MOHALES HOEK' and council='Nkau Council' and village='Khohlong';

update gii_hierarchy as gh set gh.lat='28.296459', gh.long='-29.941147' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Masilo';
update gii_hierarchy as gh set gh.lat='28.295048', gh.long='-29.906033' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Moepholi';
update gii_hierarchy as gh set gh.lat='28.284191', gh.long='-29.921454' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Motsie';
update gii_hierarchy as gh set gh.lat='28.273182', gh.long='-29.948162' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Jopo';
update gii_hierarchy as gh set gh.lat='28.270609', gh.long='-29.959778' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Phafoli';
update gii_hierarchy as gh set gh.lat='28.334072', gh.long='-29.968541' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Madodene';
update gii_hierarchy as gh set gh.lat='28.277058', gh.long='-29.984565' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mohlokoane';

update gii_hierarchy as gh set gh.lat='28.307507', gh.long='-29.986253' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Muso';

update gii_hierarchy as gh set gh.lat='28.336074', gh.long='-29.995631' where district='MOHALES HOEK' and council='Nkau Council' and village='Khilibiting';


update gii_hierarchy as gh set gh.lat='27.713048', gh.long='-30.306528' where district='MOHALES HOEK' and council='Nkau Council' and village='Matlapeng';
update gii_hierarchy as gh set gh.lat='27.730865', gh.long='-30.181228' where district='MOHALES HOEK' and council='Nkau Council' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='28.35557', gh.long='-29.991695' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Setlhotlelo';
update gii_hierarchy as gh set gh.lat='28.202122', gh.long='-30.013737' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Kojoana';
update gii_hierarchy as gh set gh.lat='28.246556', gh.long='-30.010824' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Mphuthela';
update gii_hierarchy as gh set gh.lat='28.272661', gh.long='-30.01548' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Ntoahae';
update gii_hierarchy as gh set gh.lat='27.847441', gh.long='-30.243231' where district='MOHALES HOEK' and council='Nkau Council' and village='Hloahloeng';
update gii_hierarchy as gh set gh.lat='28.22309', gh.long='-30.0221' where district='MOHALES HOEK' and council='Nkau Council' and village='Pitsaneng';
update gii_hierarchy as gh set gh.lat='28.229698', gh.long='-30.00247' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Malatsi';
update gii_hierarchy as gh set gh.lat='28.236026', gh.long='-29.99136' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Molele';
update gii_hierarchy as gh set gh.lat='28.235394', gh.long='-29.997792' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Seqhoke';
update gii_hierarchy as gh set gh.lat='28.266092', gh.long='-29.979998' where district='MOHALES HOEK' and council='Nkau Council' and village='Ha Thuhloane';
update gii_hierarchy as gh set gh.lat='28.2508', gh.long='-29.979598' where district='MOHALES HOEK' and council='Nkau Council' and village='Lilibaneng';





update gii_hierarchy as gh set gh.lat='28.512277', gh.long='-29.901282' where district='MOHALES HOEK' and council='Qabane Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.526104', gh.long='-29.849942' where district='MOHALES HOEK' and council='Qabane Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.518184', gh.long='-29.892407' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Moisa';
update gii_hierarchy as gh set gh.lat='28.540668', gh.long='-29.875461' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Qoloane';
update gii_hierarchy as gh set gh.lat='28.539215', gh.long='-29.855532' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Ramatatiele';
update gii_hierarchy as gh set gh.lat='28.555306', gh.long='-29.869925' where district='MOHALES HOEK' and council='Qabane Council' and village='Litejaneng';
update gii_hierarchy as gh set gh.lat='28.549579', gh.long='-29.918468' where district='MOHALES HOEK' and council='Qabane Council' and village='Mokoallong';
update gii_hierarchy as gh set gh.lat='27.675007', gh.long='-30.294377' where district='MOHALES HOEK' and council='Qabane Council' and village='Phuthing';

update gii_hierarchy as gh set gh.lat='28.533852', gh.long='-29.909264' where district='MOHALES HOEK' and council='Qabane Council' and village='Tesi';

update gii_hierarchy as gh set gh.lat='28.482758', gh.long='-29.937323' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Moeti';
update gii_hierarchy as gh set gh.lat='28.512838', gh.long='-29.9348' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Phalo';
update gii_hierarchy as gh set gh.lat='28.487644', gh.long='-29.925384' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Tsosane';

update gii_hierarchy as gh set gh.lat='28.505181', gh.long='-29.917261' where district='MOHALES HOEK' and council='Qabane Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.457847', gh.long='-29.941173' where district='MOHALES HOEK' and council='Qabane Council' and village='Bareng';


update gii_hierarchy as gh set gh.lat='28.395292', gh.long='-30.007218' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Motsoanakaba';
update gii_hierarchy as gh set gh.lat='28.466493', gh.long='-29.977257' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Qalatsa';


update gii_hierarchy as gh set gh.lat='27.981801', gh.long='-29.8447' where district='MOHALES HOEK' and council='Qabane Council' and village='Litsoeneng';

update gii_hierarchy as gh set gh.lat='28.453011', gh.long='-29.931217' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Khate';
update gii_hierarchy as gh set gh.lat='28.453118', gh.long='-29.918424' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Pesi';
update gii_hierarchy as gh set gh.lat='28.455983', gh.long='-29.936084' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Tsemane';

update gii_hierarchy as gh set gh.lat='27.485574', gh.long='-30.345928' where district='MOHALES HOEK' and council='Qabane Council' and village='Sethaleng';
update gii_hierarchy as gh set gh.lat='28.433509', gh.long='-29.961159' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Mosebi';


update gii_hierarchy as gh set gh.lat='28.424596', gh.long='-29.962464' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Seilane';
update gii_hierarchy as gh set gh.lat='28.420617', gh.long='-29.984323' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Shauli';
update gii_hierarchy as gh set gh.lat='28.406655', gh.long='-29.973664' where district='MOHALES HOEK' and council='Qabane Council' and village='Polasi';
update gii_hierarchy as gh set gh.lat='28.430947', gh.long='-29.951998' where district='MOHALES HOEK' and council='Qabane Council' and village='Poriking';

update gii_hierarchy as gh set gh.lat='28.394209', gh.long='-29.970954' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Letumanyane';

update gii_hierarchy as gh set gh.lat='28.408637', gh.long='-29.955977' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Rathaha';

update gii_hierarchy as gh set gh.lat='28.361203', gh.long='-30.015698' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Masupha';
update gii_hierarchy as gh set gh.lat='28.370539', gh.long='-29.998127' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Mokoafo';

update gii_hierarchy as gh set gh.lat='27.791021', gh.long='-29.898993' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Setofolo';
update gii_hierarchy as gh set gh.lat='27.709377', gh.long='-30.321594' where district='MOHALES HOEK' and council='Qabane Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.400759', gh.long='-30.004622' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Montsi';
update gii_hierarchy as gh set gh.lat='28.396214', gh.long='-30.003443' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Mosobe';
update gii_hierarchy as gh set gh.lat='28.399163', gh.long='-30.001329' where district='MOHALES HOEK' and council='Qabane Council' and village='Ha Tsoane';
update gii_hierarchy as gh set gh.lat='28.40389', gh.long='-30.042299' where district='MOHALES HOEK' and council='Qabane Council' and village='Khomong';
update gii_hierarchy as gh set gh.lat='28.400017', gh.long='-30.047782' where district='MOHALES HOEK' and council='Qabane Council' and village='Matateng';
update gii_hierarchy as gh set gh.lat='28.38833', gh.long='-30.022842' where district='MOHALES HOEK' and council='Qabane Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='28.398018', gh.long='-30.019379' where district='MOHALES HOEK' and council='Qabane Council' and village='Sekameng';

update gii_hierarchy as gh set gh.lat='28.399981', gh.long='-30.032538' where district='MOHALES HOEK' and council='Qabane Council' and village='Thaba Tsoeu';
update gii_hierarchy as gh set gh.lat='28.734746', gh.long='-29.108848' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='28.741345', gh.long='-29.085639' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Manyakane';
update gii_hierarchy as gh set gh.lat='28.697621', gh.long='-29.131978' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Phepheng';



update gii_hierarchy as gh set gh.lat='28.668088', gh.long='-29.166831' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Meno';

update gii_hierarchy as gh set gh.lat='28.684095', gh.long='-29.161351' where district='MOKHOTLONG' and council='Matsoku Council' and village='Thaba Chitja';

update gii_hierarchy as gh set gh.lat='28.658427', gh.long='-29.177025' where district='MOKHOTLONG' and council='Matsoku Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.659223', gh.long='-29.184441' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Mafonyoko';

update gii_hierarchy as gh set gh.lat='28.632636', gh.long='-29.185626' where district='MOKHOTLONG' and council='Matsoku Council' and village='Mahonyeling';
update gii_hierarchy as gh set gh.lat='29.121039', gh.long='-29.269436' where district='MOKHOTLONG' and council='Matsoku Council' and village='Makhapung';

update gii_hierarchy as gh set gh.lat='28.596597', gh.long='-29.192761' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Nthele';

update gii_hierarchy as gh set gh.lat='28.60779', gh.long='-29.190445' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Ralithebe';
update gii_hierarchy as gh set gh.lat='28.625233', gh.long='-29.239256' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Hlolo';
update gii_hierarchy as gh set gh.lat='28.63927', gh.long='-29.231749' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Mokoto';
update gii_hierarchy as gh set gh.lat='28.590038', gh.long='-29.227873' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Khosi';

update gii_hierarchy as gh set gh.lat='28.589372', gh.long='-29.217206' where district='MOKHOTLONG' and council='Matsoku Council' and village='Mosifaneng';
update gii_hierarchy as gh set gh.lat='28.606689', gh.long='-29.220108' where district='MOKHOTLONG' and council='Matsoku Council' and village='Postola';
update gii_hierarchy as gh set gh.lat='28.746908', gh.long='-29.345128' where district='MOKHOTLONG' and council='Matsoku Council' and village='Sekhutlong';
update gii_hierarchy as gh set gh.lat='28.586731', gh.long='-29.202453' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Mosisi';


update gii_hierarchy as gh set gh.lat='28.612031', gh.long='-29.22334' where district='MOKHOTLONG' and council='Matsoku Council' and village='Likhutlong';
update gii_hierarchy as gh set gh.lat='28.56774', gh.long='-29.235164' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Leohla';
update gii_hierarchy as gh set gh.lat='28.573218', gh.long='-29.226815' where district='MOKHOTLONG' and council='Matsoku Council' and village='Ha Senkhane';


update gii_hierarchy as gh set gh.lat='29.024761', gh.long='-29.01568' where district='MOKHOTLONG' and council='Matsoku Council' and village='Matsatsaneng';


update gii_hierarchy as gh set gh.lat='28.586997', gh.long='-29.266484' where district='MOKHOTLONG' and council='Matsoku Council' and village='Pitseng';
update gii_hierarchy as gh set gh.lat='28.7892', gh.long='-29.225523' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Mphuthi';
update gii_hierarchy as gh set gh.lat='28.796633', gh.long='-29.226683' where district='MOKHOTLONG' and council='Khubelu Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.805755', gh.long='-29.228184' where district='MOKHOTLONG' and council='Khubelu Council' and village='Makorong';


update gii_hierarchy as gh set gh.lat='28.756264', gh.long='-29.248277' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Phera';
update gii_hierarchy as gh set gh.lat='28.787457', gh.long='-29.255443' where district='MOKHOTLONG' and council='Khubelu Council' and village='Linokong';
update gii_hierarchy as gh set gh.lat='28.788201', gh.long='-29.25061' where district='MOKHOTLONG' and council='Khubelu Council' and village='Mainyatso';
update gii_hierarchy as gh set gh.lat='28.796822', gh.long='-29.252567' where district='MOKHOTLONG' and council='Khubelu Council' and village='Tsitsa';
update gii_hierarchy as gh set gh.lat='28.807593', gh.long='-29.254342' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Hlohlo';
update gii_hierarchy as gh set gh.lat='28.82379', gh.long='-29.255161' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Nthuseng';
update gii_hierarchy as gh set gh.lat='28.802115', gh.long='-29.244332' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Ralitsepe';
update gii_hierarchy as gh set gh.lat='28.834291', gh.long='-29.24781' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Sotane';
update gii_hierarchy as gh set gh.lat='28.853014', gh.long='-29.254616' where district='MOKHOTLONG' and council='Khubelu Council' and village='Tloha re bue';
update gii_hierarchy as gh set gh.lat='28.863205', gh.long='-29.260834' where district='MOKHOTLONG' and council='Khubelu Council' and village='Malingoaneng';
update gii_hierarchy as gh set gh.lat='28.868649', gh.long='-29.272294' where district='MOKHOTLONG' and council='Khubelu Council' and village='Masokong';
update gii_hierarchy as gh set gh.lat='28.859705', gh.long='-29.259056' where district='MOKHOTLONG' and council='Khubelu Council' and village='Meeling';

update gii_hierarchy as gh set gh.lat='28.850708', gh.long='-29.284151' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Ramonakalali';
update gii_hierarchy as gh set gh.lat='28.831526', gh.long='-29.277847' where district='MOKHOTLONG' and council='Khubelu Council' and village='Makokoaneng';
update gii_hierarchy as gh set gh.lat='28.822472', gh.long='-29.271025' where district='MOKHOTLONG' and council='Khubelu Council' and village='Matikiring';
update gii_hierarchy as gh set gh.lat='28.811561', gh.long='-29.268509' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Letheha';
update gii_hierarchy as gh set gh.lat='28.807703', gh.long='-29.261323' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Maeu';

update gii_hierarchy as gh set gh.lat='28.813575', gh.long='-29.271791' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Matekase';
update gii_hierarchy as gh set gh.lat='29.137075', gh.long='-29.206342' where district='MOKHOTLONG' and council='Khubelu Council' and village='Foreisetata';

update gii_hierarchy as gh set gh.lat='28.775701', gh.long='-29.289103' where district='MOKHOTLONG' and council='Khubelu Council' and village='Maresele';

update gii_hierarchy as gh set gh.lat='28.706957', gh.long='-29.323283' where district='MOKHOTLONG' and council='Khubelu Council' and village='Mahesheleng';



update gii_hierarchy as gh set gh.lat='28.779037', gh.long='-29.316751' where district='MOKHOTLONG' and council='Khubelu Council' and village='Makhiseng';

update gii_hierarchy as gh set gh.lat='28.800101', gh.long='-29.301764' where district='MOKHOTLONG' and council='Khubelu Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.796797', gh.long='-29.296613' where district='MOKHOTLONG' and council='Khubelu Council' and village='Nqobelle';
update gii_hierarchy as gh set gh.lat='28.795814', gh.long='-29.310065' where district='MOKHOTLONG' and council='Khubelu Council' and village='Semapong';
update gii_hierarchy as gh set gh.lat='28.821847', gh.long='-29.288704' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Mei';
update gii_hierarchy as gh set gh.lat='28.812125', gh.long='-29.275706' where district='MOKHOTLONG' and council='Khubelu Council' and village='Thuhloane';
update gii_hierarchy as gh set gh.lat='28.818892', gh.long='-29.284765' where district='MOKHOTLONG' and council='Khubelu Council' and village='Tibising';
update gii_hierarchy as gh set gh.lat='28.821105', gh.long='-29.306717' where district='MOKHOTLONG' and council='Khubelu Council' and village='Khotsang';
update gii_hierarchy as gh set gh.lat='28.808002', gh.long='-29.330207' where district='MOKHOTLONG' and council='Khubelu Council' and village='Lipeleng';

update gii_hierarchy as gh set gh.lat='28.78238', gh.long='-29.337697' where district='MOKHOTLONG' and council='Khubelu Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.743162', gh.long='-29.321686' where district='MOKHOTLONG' and council='Khubelu Council' and village='Ha Mphatsoane';

update gii_hierarchy as gh set gh.lat='28.775814', gh.long='-29.325961' where district='MOKHOTLONG' and council='Khubelu Council' and village='Maqhaung';
update gii_hierarchy as gh set gh.lat='28.769827', gh.long='-29.328527' where district='MOKHOTLONG' and council='Khubelu Council' and village='Masakoaneng';





update gii_hierarchy as gh set gh.lat='28.696705', gh.long='-29.32594' where district='MOKHOTLONG' and council='Khubelu Council' and village='Liepeleng';


update gii_hierarchy as gh set gh.lat='28.955726', gh.long='-29.131494' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='28.92645', gh.long='-29.172096' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Komotere';
update gii_hierarchy as gh set gh.lat='28.940186', gh.long='-29.169413' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Maputsoe';


update gii_hierarchy as gh set gh.lat='28.906504', gh.long='-29.130892' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Mantsieng';
update gii_hierarchy as gh set gh.lat='28.895448', gh.long='-29.150835' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Tsomoli';
update gii_hierarchy as gh set gh.lat='29.274033', gh.long='-29.381208' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Letlapeng';

update gii_hierarchy as gh set gh.lat='28.891269', gh.long='-29.15259' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Phatlalla';
update gii_hierarchy as gh set gh.lat='28.847654', gh.long='-29.136741' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Lipululeng';
update gii_hierarchy as gh set gh.lat='28.865046', gh.long='-29.141074' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Makopanong';
update gii_hierarchy as gh set gh.lat='28.858977', gh.long='-29.11227' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Masoleng';
update gii_hierarchy as gh set gh.lat='28.867067', gh.long='-29.151748' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Lebakana';
update gii_hierarchy as gh set gh.lat='28.869606', gh.long='-29.156288' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Tsepong';

update gii_hierarchy as gh set gh.lat='28.841616', gh.long='-29.173426' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Matsoiring';

update gii_hierarchy as gh set gh.lat='28.813024', gh.long='-29.17221' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='28.813862', gh.long='-29.200707' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Khukhune';
update gii_hierarchy as gh set gh.lat='28.838377', gh.long='-29.203418' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Mankeng';
update gii_hierarchy as gh set gh.lat='28.832186', gh.long='-29.198583' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Tsieng';
update gii_hierarchy as gh set gh.lat='28.861411', gh.long='-29.179877' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Bochabela';
update gii_hierarchy as gh set gh.lat='28.871081', gh.long='-29.170548' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.871357', gh.long='-29.178666' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Mokhoabong';

update gii_hierarchy as gh set gh.lat='28.873418', gh.long='-29.191628' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Lithoteng';

update gii_hierarchy as gh set gh.lat='28.881164', gh.long='-29.189787' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Matebeng';

update gii_hierarchy as gh set gh.lat='28.920792', gh.long='-29.189561' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Rammeleke';
update gii_hierarchy as gh set gh.lat='28.913885', gh.long='-29.188816' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Terapaneng';
update gii_hierarchy as gh set gh.lat='28.8963', gh.long='-29.194245' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Mahemeng';




update gii_hierarchy as gh set gh.lat='28.958667', gh.long='-29.094741' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Majakaneng';

update gii_hierarchy as gh set gh.lat='28.852749', gh.long='-29.21207' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Makalieng';
update gii_hierarchy as gh set gh.lat='28.841185', gh.long='-29.205789' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Malothoaneng';
update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.848106', gh.long='-29.218396' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Letsaneng';
update gii_hierarchy as gh set gh.lat='28.829303', gh.long='-29.213011' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Likoting';
update gii_hierarchy as gh set gh.lat='28.843219', gh.long='-29.215541' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Nkutloise';

update gii_hierarchy as gh set gh.lat='28.883053', gh.long='-29.229406' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Ha Ntsesanyane';
update gii_hierarchy as gh set gh.lat='28.860476', gh.long='-29.232124' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Bolahla';
update gii_hierarchy as gh set gh.lat='28.858491', gh.long='-29.23977' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Checheng';
update gii_hierarchy as gh set gh.lat='28.849814', gh.long='-29.238792' where district='MOKHOTLONG' and council='Mapholaneng Council' and village='Sebera';
update gii_hierarchy as gh set gh.lat='28.906534', gh.long='-28.981756' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Lichecheng';
update gii_hierarchy as gh set gh.lat='28.834381', gh.long='-29.442823' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Moeaneng';

update gii_hierarchy as gh set gh.lat='28.84315', gh.long='-29.014153' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Letseng la Terae';
update gii_hierarchy as gh set gh.lat='28.941018', gh.long='-29.007504' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Maloraneng';
update gii_hierarchy as gh set gh.lat='28.945832', gh.long='-29.019244' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Pae la itlhatsoa';
update gii_hierarchy as gh set gh.lat='28.968878', gh.long='-29.062441' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Ha Masasane';

update gii_hierarchy as gh set gh.lat='29.066446', gh.long='-29.244463' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='28.96298', gh.long='-29.074663' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Likhutlong';
update gii_hierarchy as gh set gh.lat='28.958667', gh.long='-29.094741' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Majakaneng';

update gii_hierarchy as gh set gh.lat='29.219917', gh.long='-29.295082' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.959806', gh.long='-29.101342' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Mafarung';



update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Pae la Itlhatsoa Council' and village='Matebeleng';


update gii_hierarchy as gh set gh.lat='28.896441', gh.long='-29.220736' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Tipi';
update gii_hierarchy as gh set gh.lat='28.909128', gh.long='-29.231128' where district='MOKHOTLONG' and council='Popa Council' and village='Kheseng';
update gii_hierarchy as gh set gh.lat='28.91006', gh.long='-29.225778' where district='MOKHOTLONG' and council='Popa Council' and village='Makhalong';

update gii_hierarchy as gh set gh.lat='28.920392', gh.long='-29.233287' where district='MOKHOTLONG' and council='Popa Council' and village='Litsoeneng';


update gii_hierarchy as gh set gh.lat='28.918807', gh.long='-29.228703' where district='MOKHOTLONG' and council='Popa Council' and village='Paballong';

update gii_hierarchy as gh set gh.lat='28.914329', gh.long='-29.227088' where district='MOKHOTLONG' and council='Popa Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.911789', gh.long='-29.205187' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Nyoko';

update gii_hierarchy as gh set gh.lat='28.834381', gh.long='-29.442823' where district='MOKHOTLONG' and council='Popa Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.992732', gh.long='-29.208069' where district='MOKHOTLONG' and council='Popa Council' and village='Lisaleng';

update gii_hierarchy as gh set gh.lat='28.999761', gh.long='-29.23289' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Tsese';
update gii_hierarchy as gh set gh.lat='29.014235', gh.long='-29.259284' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Letjama';
update gii_hierarchy as gh set gh.lat='29.000193', gh.long='-29.242654' where district='MOKHOTLONG' and council='Popa Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='28.991567', gh.long='-29.267356' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Mathibeli';
update gii_hierarchy as gh set gh.lat='28.99715', gh.long='-29.276185' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Ramohale';

update gii_hierarchy as gh set gh.lat='28.948405', gh.long='-29.25673' where district='MOKHOTLONG' and council='Popa Council' and village='Matlobong';
update gii_hierarchy as gh set gh.lat='28.962248', gh.long='-29.254214' where district='MOKHOTLONG' and council='Popa Council' and village='Tsila Ntso';
update gii_hierarchy as gh set gh.lat='28.92398', gh.long='-29.266892' where district='MOKHOTLONG' and council='Popa Council' and village='Kanana';

update gii_hierarchy as gh set gh.lat='28.891968', gh.long='-29.255366' where district='MOKHOTLONG' and council='Popa Council' and village='Mabeleteng';

update gii_hierarchy as gh set gh.lat='28.903347', gh.long='-29.248627' where district='MOKHOTLONG' and council='Popa Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='28.906221', gh.long='-29.283397' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Konki';
update gii_hierarchy as gh set gh.lat='28.911904', gh.long='-29.268861' where district='MOKHOTLONG' and council='Popa Council' and village='Lilimala';
update gii_hierarchy as gh set gh.lat='28.906744', gh.long='-29.265644' where district='MOKHOTLONG' and council='Popa Council' and village='Makalong';
update gii_hierarchy as gh set gh.lat='28.896111', gh.long='-29.285315' where district='MOKHOTLONG' and council='Popa Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.927017', gh.long='-29.274396' where district='MOKHOTLONG' and council='Popa Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='28.94121', gh.long='-29.275593' where district='MOKHOTLONG' and council='Popa Council' and village='Makaoteng';
update gii_hierarchy as gh set gh.lat='28.942301', gh.long='-29.280505' where district='MOKHOTLONG' and council='Popa Council' and village='Makhomalong';
update gii_hierarchy as gh set gh.lat='28.971828', gh.long='-29.283726' where district='MOKHOTLONG' and council='Popa Council' and village='Mabothong';
update gii_hierarchy as gh set gh.lat='28.987728', gh.long='-29.284267' where district='MOKHOTLONG' and council='Popa Council' and village='Sekokong';
update gii_hierarchy as gh set gh.lat='28.962208', gh.long='-29.289376' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Koatake';
update gii_hierarchy as gh set gh.lat='28.934217', gh.long='-29.313663' where district='MOKHOTLONG' and council='Popa Council' and village='Ha Phohla';
update gii_hierarchy as gh set gh.lat='28.928049', gh.long='-29.296642' where district='MOKHOTLONG' and council='Popa Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='28.934321', gh.long='-28.981598' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Matlakeng';
update gii_hierarchy as gh set gh.lat='28.957462', gh.long='-29.027357' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Ha Moroke';
update gii_hierarchy as gh set gh.lat='28.947534', gh.long='-29.010563' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Ha Seema';
update gii_hierarchy as gh set gh.lat='29.032656', gh.long='-29.021527' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Lithakong';
update gii_hierarchy as gh set gh.lat='29.024761', gh.long='-29.01568' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='29.033134', gh.long='-29.025793' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Phatlalla';

update gii_hierarchy as gh set gh.lat='29.030206', gh.long='-29.003207' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Thabana li Mele';


update gii_hierarchy as gh set gh.lat='28.992148', gh.long='-29.050144' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Khonofaneng';
update gii_hierarchy as gh set gh.lat='29.050564', gh.long='-29.06313' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='29.058816', gh.long='-29.082056' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Lepatsong';
update gii_hierarchy as gh set gh.lat='29.036368', gh.long='-29.096295' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Phuthing';

update gii_hierarchy as gh set gh.lat='29.050197', gh.long='-29.10195' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Thoteng';


update gii_hierarchy as gh set gh.lat='29.030087', gh.long='-29.12323' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Lehlakaneng';

update gii_hierarchy as gh set gh.lat='28.982403', gh.long='-29.129341' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Marumong';

update gii_hierarchy as gh set gh.lat='28.975034', gh.long='-29.108399' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Rapeising';

update gii_hierarchy as gh set gh.lat='29.001006', gh.long='-29.170184' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Linareng';
update gii_hierarchy as gh set gh.lat='29.014914', gh.long='-29.15745' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Masheaneng';

update gii_hierarchy as gh set gh.lat='28.978888', gh.long='-29.153994' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Ntsoana tsatsi';
update gii_hierarchy as gh set gh.lat='28.957814', gh.long='-29.168255' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Liotloaneng';
update gii_hierarchy as gh set gh.lat='28.96399', gh.long='-29.156384' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Mabuleng';
update gii_hierarchy as gh set gh.lat='29.001842', gh.long='-29.194292' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.997615', gh.long='-29.18705' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Pitsaneng';
update gii_hierarchy as gh set gh.lat='28.952931', gh.long='-29.172529' where district='MOKHOTLONG' and council='Molika Liko Council' and village='Ha Molopo';



update gii_hierarchy as gh set gh.lat='29.035423', gh.long='-29.009709' where district='MOKHOTLONG' and council='Khalahali Council' and village='Tsoana Makhulo';
update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Khalahali Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='29.048012', gh.long='-29.0379' where district='MOKHOTLONG' and council='Khalahali Council' and village='Patising';
update gii_hierarchy as gh set gh.lat='29.073915', gh.long='-29.078402' where district='MOKHOTLONG' and council='Khalahali Council' and village='Ha Khethisa (Thoteng)';
update gii_hierarchy as gh set gh.lat='29.097464', gh.long='-29.073692' where district='MOKHOTLONG' and council='Khalahali Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='29.08247', gh.long='-29.067583' where district='MOKHOTLONG' and council='Khalahali Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='29.072352', gh.long='-29.098449' where district='MOKHOTLONG' and council='Khalahali Council' and village='Bothakhisa ntja';
update gii_hierarchy as gh set gh.lat='29.089941', gh.long='-29.089021' where district='MOKHOTLONG' and council='Khalahali Council' and village='Ha Mothebesoane';
update gii_hierarchy as gh set gh.lat='29.099386', gh.long='-29.083965' where district='MOKHOTLONG' and council='Khalahali Council' and village='Maphalleng';
update gii_hierarchy as gh set gh.lat='29.130083', gh.long='-29.052818' where district='MOKHOTLONG' and council='Khalahali Council' and village='Makeneng';
update gii_hierarchy as gh set gh.lat='29.127037', gh.long='-29.074184' where district='MOKHOTLONG' and council='Khalahali Council' and village='Sakeng';
update gii_hierarchy as gh set gh.lat='29.199198', gh.long='-29.116783' where district='MOKHOTLONG' and council='Khalahali Council' and village='Ha Malinyane';
update gii_hierarchy as gh set gh.lat='29.168101', gh.long='-29.129663' where district='MOKHOTLONG' and council='Khalahali Council' and village='Linareng';
update gii_hierarchy as gh set gh.lat='29.114205', gh.long='-29.138027' where district='MOKHOTLONG' and council='Khalahali Council' and village='Boritsa';
update gii_hierarchy as gh set gh.lat='29.11813', gh.long='-29.154888' where district='MOKHOTLONG' and council='Khalahali Council' and village='Ha Makulane';
update gii_hierarchy as gh set gh.lat='29.113704', gh.long='-29.14874' where district='MOKHOTLONG' and council='Khalahali Council' and village='Limapong';
update gii_hierarchy as gh set gh.lat='29.149263', gh.long='-29.137741' where district='MOKHOTLONG' and council='Khalahali Council' and village='Masenkeng';
update gii_hierarchy as gh set gh.lat='29.132464', gh.long='-29.144052' where district='MOKHOTLONG' and council='Khalahali Council' and village='Motalaneng';
update gii_hierarchy as gh set gh.lat='29.084018', gh.long='-29.126763' where district='MOKHOTLONG' and council='Khalahali Council' and village='Hlokoa le mafi';
update gii_hierarchy as gh set gh.lat='29.064094', gh.long='-29.110864' where district='MOKHOTLONG' and council='Khalahali Council' and village='Likoekoeng';

update gii_hierarchy as gh set gh.lat='29.049797', gh.long='-29.144506' where district='MOKHOTLONG' and council='Khalahali Council' and village='Likhang';
update gii_hierarchy as gh set gh.lat='29.031378', gh.long='-29.172283' where district='MOKHOTLONG' and council='Khalahali Council' and village='Matsoapong';

update gii_hierarchy as gh set gh.lat='29.045788', gh.long='-29.153723' where district='MOKHOTLONG' and council='Khalahali Council' and village='Tsopholing';
update gii_hierarchy as gh set gh.lat='29.107895', gh.long='-29.170251' where district='MOKHOTLONG' and council='Khalahali Council' and village='Mahaneng';
update gii_hierarchy as gh set gh.lat='29.101402', gh.long='-29.17691' where district='MOKHOTLONG' and council='Khalahali Council' and village='Sepatleng';


update gii_hierarchy as gh set gh.lat='29.031188', gh.long='-29.189907' where district='MOKHOTLONG' and council='Khalahali Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='29.033319', gh.long='-29.204523' where district='MOKHOTLONG' and council='Khalahali Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='28.809191', gh.long='-29.264468' where district='MOKHOTLONG' and council='Khalahali Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='29.05939', gh.long='-29.214443' where district='MOKHOTLONG' and council='Khalahali Council' and village='Mapateng';
update gii_hierarchy as gh set gh.lat='29.052843', gh.long='-29.222594' where district='MOKHOTLONG' and council='Khalahali Council' and village='Mphosisa';
update gii_hierarchy as gh set gh.lat='29.057075', gh.long='-29.241285' where district='MOKHOTLONG' and council='Khalahali Council' and village='Motsitseng';
update gii_hierarchy as gh set gh.lat='29.030608', gh.long='-29.232372' where district='MOKHOTLONG' and council='Khalahali Council' and village='Sekoka';
update gii_hierarchy as gh set gh.lat='29.176453', gh.long='-29.156795' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Botaisa';
update gii_hierarchy as gh set gh.lat='29.181963', gh.long='-29.142125' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Leapola';
update gii_hierarchy as gh set gh.lat='29.274033', gh.long='-29.381208' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Letlapeng';

update gii_hierarchy as gh set gh.lat='29.151825', gh.long='-29.161041' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Thaba Ntso';
update gii_hierarchy as gh set gh.lat='29.132114', gh.long='-29.187907' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Molao';
update gii_hierarchy as gh set gh.lat='29.135245', gh.long='-29.169595' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Matsatsaneng';
update gii_hierarchy as gh set gh.lat='29.127234', gh.long='-29.185321' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='29.108765', gh.long='-29.201901' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Makoatleng';
update gii_hierarchy as gh set gh.lat='29.122744', gh.long='-29.198434' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Paneng';
update gii_hierarchy as gh set gh.lat='28.771312', gh.long='-29.311684' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Foreistata';
update gii_hierarchy as gh set gh.lat='29.13191', gh.long='-29.214577' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Chopho (Bafali)';
update gii_hierarchy as gh set gh.lat='29.137714', gh.long='-29.211881' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Tlokoeng (Bafali)';



update gii_hierarchy as gh set gh.lat='29.087555', gh.long='-29.207176' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Thoteng (Ha Senkoase)';

update gii_hierarchy as gh set gh.lat='29.086796', gh.long='-29.233939' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Mahooeng';
update gii_hierarchy as gh set gh.lat='29.082738', gh.long='-29.237048' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Masuoaneng';
update gii_hierarchy as gh set gh.lat='29.069001', gh.long='-29.252036' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Lebopo';

update gii_hierarchy as gh set gh.lat='29.127789', gh.long='-29.2306' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Tsekelo';
update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Matebeleng';

update gii_hierarchy as gh set gh.lat='29.143193', gh.long='-29.238077' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Lisene';
update gii_hierarchy as gh set gh.lat='29.148255', gh.long='-29.24105' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Motanyane';
update gii_hierarchy as gh set gh.lat='29.164923', gh.long='-29.24238' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Tolotsana';
update gii_hierarchy as gh set gh.lat='29.121039', gh.long='-29.269436' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Makhapung';


update gii_hierarchy as gh set gh.lat='29.109679', gh.long='-29.276729' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Nkotoane';
update gii_hierarchy as gh set gh.lat='29.150289', gh.long='-29.284919' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Mangopeng';
update gii_hierarchy as gh set gh.lat='29.149359', gh.long='-29.281384' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ntsirele';
update gii_hierarchy as gh set gh.lat='29.145718', gh.long='-29.286304' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='29.141392', gh.long='-29.295016' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Makoae';
update gii_hierarchy as gh set gh.lat='29.142217', gh.long='-29.289326' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Moshemong';
update gii_hierarchy as gh set gh.lat='29.149327', gh.long='-29.300725' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Hlakane';
update gii_hierarchy as gh set gh.lat='29.128522', gh.long='-29.31498' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Boiketlo';
update gii_hierarchy as gh set gh.lat='29.122974', gh.long='-29.314667' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Thaba Khubelu';
update gii_hierarchy as gh set gh.lat='29.102631', gh.long='-29.306934' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ha Soai';
update gii_hierarchy as gh set gh.lat='29.081455', gh.long='-29.31001' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='29.099431', gh.long='-29.290558' where district='MOKHOTLONG' and council='Moremoholo Council' and village='Ntsiking';

update gii_hierarchy as gh set gh.lat='29.051113', gh.long='-29.334103' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Rankae';

update gii_hierarchy as gh set gh.lat='29.055003', gh.long='-29.331305' where district='MOKHOTLONG' and council='Sakeng Council' and village='Mapeleng';

update gii_hierarchy as gh set gh.lat='29.049339', gh.long='-29.349191' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Senepi';

update gii_hierarchy as gh set gh.lat='29.071672', gh.long='-29.343313' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Thamane';



update gii_hierarchy as gh set gh.lat='28.783588', gh.long='-29.225508' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Mokone';
update gii_hierarchy as gh set gh.lat='29.084415', gh.long='-29.376916' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Mpiti';
update gii_hierarchy as gh set gh.lat='29.06847', gh.long='-29.356286' where district='MOKHOTLONG' and council='Sakeng Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='29.09518', gh.long='-29.362584' where district='MOKHOTLONG' and council='Sakeng Council' and village='Khohloaneng';

update gii_hierarchy as gh set gh.lat='29.147482', gh.long='-29.385665' where district='MOKHOTLONG' and council='Sakeng Council' and village='Ha Liphate';
update gii_hierarchy as gh set gh.lat='29.121736', gh.long='-29.373756' where district='MOKHOTLONG' and council='Sakeng Council' and village='Manyofaneng';
update gii_hierarchy as gh set gh.lat='29.129617', gh.long='-29.338575' where district='MOKHOTLONG' and council='Mateanong Council' and village='Khutlo Peli';
update gii_hierarchy as gh set gh.lat='29.138699', gh.long='-29.340516' where district='MOKHOTLONG' and council='Mateanong Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='29.146367', gh.long='-29.330774' where district='MOKHOTLONG' and council='Mateanong Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='29.178036', gh.long='-29.305991' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Malapane';
update gii_hierarchy as gh set gh.lat='29.163293', gh.long='-29.296925' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Pela';
update gii_hierarchy as gh set gh.lat='29.165181', gh.long='-29.323588' where district='MOKHOTLONG' and council='Mateanong Council' and village='Kholokoe';
update gii_hierarchy as gh set gh.lat='29.159866', gh.long='-29.340506' where district='MOKHOTLONG' and council='Mateanong Council' and village='Makoabating';
update gii_hierarchy as gh set gh.lat='29.172239', gh.long='-29.351861' where district='MOKHOTLONG' and council='Mateanong Council' and village='Malefiloane';
update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Mateanong Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.927976', gh.long='-28.993039' where district='MOKHOTLONG' and council='Mateanong Council' and village='Patiseng';

update gii_hierarchy as gh set gh.lat='29.193645', gh.long='-29.319101' where district='MOKHOTLONG' and council='Mateanong Council' and village='Manganeng';


update gii_hierarchy as gh set gh.lat='29.201256', gh.long='-29.358697' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Jorose';
update gii_hierarchy as gh set gh.lat='29.218984', gh.long='-29.366738' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='29.189595', gh.long='-29.36945' where district='MOKHOTLONG' and council='Mateanong Council' and village='Lentsoeteng';

update gii_hierarchy as gh set gh.lat='29.231095', gh.long='-29.373405' where district='MOKHOTLONG' and council='Mateanong Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='29.243178', gh.long='-29.384436' where district='MOKHOTLONG' and council='Mateanong Council' and village='Qobellong';
update gii_hierarchy as gh set gh.lat='29.269295', gh.long='-29.392173' where district='MOKHOTLONG' and council='Mateanong Council' and village='Matlaong';
update gii_hierarchy as gh set gh.lat='29.25725', gh.long='-29.387632' where district='MOKHOTLONG' and council='Mateanong Council' and village='Tlhakoaneng';
update gii_hierarchy as gh set gh.lat='29.225291', gh.long='-29.343581' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Leutsoa';

update gii_hierarchy as gh set gh.lat='29.234149', gh.long='-29.357517' where district='MOKHOTLONG' and council='Mateanong Council' and village='Sephokong';

update gii_hierarchy as gh set gh.lat='28.859705', gh.long='-29.259056' where district='MOKHOTLONG' and council='Mateanong Council' and village='Meeling';

update gii_hierarchy as gh set gh.lat='29.285721', gh.long='-29.314018' where district='MOKHOTLONG' and council='Mateanong Council' and village='Koeneng';


update gii_hierarchy as gh set gh.lat='29.298349', gh.long='-29.314724' where district='MOKHOTLONG' and council='Mateanong Council' and village='Tsieng';
update gii_hierarchy as gh set gh.lat='29.307221', gh.long='-29.308661' where district='MOKHOTLONG' and council='Mateanong Council' and village='Mokoekoe';

update gii_hierarchy as gh set gh.lat='29.231514', gh.long='-29.294493' where district='MOKHOTLONG' and council='Mateanong Council' and village='Letseng';

update gii_hierarchy as gh set gh.lat='29.188837', gh.long='-29.297712' where district='MOKHOTLONG' and council='Mateanong Council' and village='Ha Maseru';

update gii_hierarchy as gh set gh.lat='29.041648', gh.long='-29.286546' where district='MOKHOTLONG' and council='Liphamola Council' and village='Ntlholohetsane';

update gii_hierarchy as gh set gh.lat='29.108448', gh.long='-29.366839' where district='MOKHOTLONG' and council='Liphamola Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='29.053188', gh.long='-29.285145' where district='MOKHOTLONG' and council='Liphamola Council' and village='Checha';
update gii_hierarchy as gh set gh.lat='29.059224', gh.long='-29.290459' where district='MOKHOTLONG' and council='Liphamola Council' and village='Salang';
update gii_hierarchy as gh set gh.lat='29.066958', gh.long='-29.2853' where district='MOKHOTLONG' and council='Liphamola Council' and village='Matamong';
update gii_hierarchy as gh set gh.lat='29.071237', gh.long='-29.278267' where district='MOKHOTLONG' and council='Liphamola Council' and village='Airport';
update gii_hierarchy as gh set gh.lat='29.073892', gh.long='-29.292216' where district='MOKHOTLONG' and council='Liphamola Council' and village='Sepetlele';
update gii_hierarchy as gh set gh.lat='29.066933', gh.long='-29.290063' where district='MOKHOTLONG' and council='Liphamola Council' and village='Mapoleseng';
update gii_hierarchy as gh set gh.lat='29.063335', gh.long='-29.290897' where district='MOKHOTLONG' and council='Liphamola Council' and village='Thaba Bosiu';

update gii_hierarchy as gh set gh.lat='29.047737', gh.long='-29.290041' where district='MOKHOTLONG' and council='Liphamola Council' and village='Mangaung';

update gii_hierarchy as gh set gh.lat='28.84681', gh.long='-29.211617' where district='MOKHOTLONG' and council='Liphamola Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='29.027977', gh.long='-29.301331' where district='MOKHOTLONG' and council='Liphamola Council' and village='Chaba se maketse';
update gii_hierarchy as gh set gh.lat='29.025552', gh.long='-29.30764' where district='MOKHOTLONG' and council='Liphamola Council' and village='Ha Kotsiea';
update gii_hierarchy as gh set gh.lat='29.033454', gh.long='-29.29879' where district='MOKHOTLONG' and council='Liphamola Council' and village='Ha Seeiso (Thabang)';
update gii_hierarchy as gh set gh.lat='29.035467', gh.long='-29.335435' where district='MOKHOTLONG' and council='Liphamola Council' and village='Ha Mojakisane';



update gii_hierarchy as gh set gh.lat='28.85675', gh.long='-29.365811' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Masokong';
update gii_hierarchy as gh set gh.lat='28.852709', gh.long='-29.357931' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Nqobelle';
update gii_hierarchy as gh set gh.lat='28.861959', gh.long='-29.344925' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Mochochononong';


update gii_hierarchy as gh set gh.lat='29.056006', gh.long='-29.130817' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Likhameng';

update gii_hierarchy as gh set gh.lat='28.888728', gh.long='-29.326676' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Phate';
update gii_hierarchy as gh set gh.lat='28.881245', gh.long='-29.328495' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.892249', gh.long='-29.341869' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Maluba lube';
update gii_hierarchy as gh set gh.lat='28.908495', gh.long='-29.316921' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Molalana';
update gii_hierarchy as gh set gh.lat='28.885389', gh.long='-29.255946' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Liphokong';


update gii_hierarchy as gh set gh.lat='28.913853', gh.long='-29.351379' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Mofali';
update gii_hierarchy as gh set gh.lat='28.916507', gh.long='-29.340665' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Hlomohang';

update gii_hierarchy as gh set gh.lat='28.912004', gh.long='-29.357541' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Ramaleshoane';
update gii_hierarchy as gh set gh.lat='28.918222', gh.long='-29.363516' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Ntsebele';
update gii_hierarchy as gh set gh.lat='28.93739', gh.long='-29.359153' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Phatoli';
update gii_hierarchy as gh set gh.lat='28.935093', gh.long='-29.374844' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.947682', gh.long='-29.360463' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Setsoto';
update gii_hierarchy as gh set gh.lat='29.219917', gh.long='-29.295082' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Lekhalong';


update gii_hierarchy as gh set gh.lat='28.953347', gh.long='-29.375495' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Tsepeng';


update gii_hierarchy as gh set gh.lat='28.971615', gh.long='-29.389863' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Janteu';

update gii_hierarchy as gh set gh.lat='28.975778', gh.long='-29.387586' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Sakaneng';
update gii_hierarchy as gh set gh.lat='28.971006', gh.long='-29.376695' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Motebang';



update gii_hierarchy as gh set gh.lat='28.999683', gh.long='-29.380098' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.997714', gh.long='-29.370033' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Maotleng';


update gii_hierarchy as gh set gh.lat='28.971197', gh.long='-29.342037' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Mamphaneng';
update gii_hierarchy as gh set gh.lat='28.841122', gh.long='-29.179645' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Matsekeng';

update gii_hierarchy as gh set gh.lat='28.98895', gh.long='-29.32503' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Molumong';
update gii_hierarchy as gh set gh.lat='28.958667', gh.long='-29.094741' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='29.003962', gh.long='-29.356219' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Lehlohonolo';
update gii_hierarchy as gh set gh.lat='29.005371', gh.long='-29.348462' where district='MOKHOTLONG' and council='Rafolatsane Council' and village='Ha Rafolatsane';
update gii_hierarchy as gh set gh.lat='28.85048', gh.long='-29.420899' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Ralitlhare';

update gii_hierarchy as gh set gh.lat='28.846719', gh.long='-29.413795' where district='MOKHOTLONG' and council='Marung Council' and village='Lilatoleng';





update gii_hierarchy as gh set gh.lat='28.896431', gh.long='-29.398532' where district='MOKHOTLONG' and council='Marung Council' and village='Lifofaneng';
update gii_hierarchy as gh set gh.lat='28.873968', gh.long='-29.402793' where district='MOKHOTLONG' and council='Marung Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.9068', gh.long='-29.40249' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Setoko';

update gii_hierarchy as gh set gh.lat='28.952622', gh.long='-29.386321' where district='MOKHOTLONG' and council='Marung Council' and village='Botha Bothe';
update gii_hierarchy as gh set gh.lat='28.93752', gh.long='-29.392083' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Roelane';

update gii_hierarchy as gh set gh.lat='28.859705', gh.long='-29.259056' where district='MOKHOTLONG' and council='Marung Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.962818', gh.long='-29.39053' where district='MOKHOTLONG' and council='Marung Council' and village='Lifatjaneng';


update gii_hierarchy as gh set gh.lat='28.879776', gh.long='-29.429024' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Liete';
update gii_hierarchy as gh set gh.lat='29.211686', gh.long='-29.334997' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Taelo';

update gii_hierarchy as gh set gh.lat='28.849892', gh.long='-29.430236' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Moeketsane';

update gii_hierarchy as gh set gh.lat='28.85824', gh.long='-29.435587' where district='MOKHOTLONG' and council='Marung Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.857027', gh.long='-29.439228' where district='MOKHOTLONG' and council='Marung Council' and village='Makorotong';

update gii_hierarchy as gh set gh.lat='28.808444', gh.long='-29.436547' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Mohai';
update gii_hierarchy as gh set gh.lat='28.827813', gh.long='-29.423757' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Moleko';
update gii_hierarchy as gh set gh.lat='28.834381', gh.long='-29.442823' where district='MOKHOTLONG' and council='Marung Council' and village='Moeaneng';


update gii_hierarchy as gh set gh.lat='28.85618', gh.long='-29.454763' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Mokotjo';
update gii_hierarchy as gh set gh.lat='28.84817', gh.long='-29.489328' where district='MOKHOTLONG' and council='Marung Council' and village='Ha Mathibela';
update gii_hierarchy as gh set gh.lat='28.796293', gh.long='-29.497328' where district='MOKHOTLONG' and council='Marung Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='28.891251', gh.long='-29.503971' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Likotjaneng';
update gii_hierarchy as gh set gh.lat='28.859705', gh.long='-29.259056' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.87148', gh.long='-29.483783' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Rosemane';
update gii_hierarchy as gh set gh.lat='28.880054', gh.long='-29.477513' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Manganeng';



update gii_hierarchy as gh set gh.lat='28.920536', gh.long='-29.499602' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Mothating';
update gii_hierarchy as gh set gh.lat='28.907946', gh.long='-29.497648' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='28.943925', gh.long='-29.45534' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Boiketlo';
update gii_hierarchy as gh set gh.lat='28.948079', gh.long='-29.441828' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Khorong';
update gii_hierarchy as gh set gh.lat='28.947018', gh.long='-29.452739' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.936529', gh.long='-29.456617' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Tsatsanyane';
update gii_hierarchy as gh set gh.lat='28.929596', gh.long='-29.500892' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Chesalaene';
update gii_hierarchy as gh set gh.lat='28.926337', gh.long='-29.488071' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Ha Moepanyane';

update gii_hierarchy as gh set gh.lat='28.934545', gh.long='-29.493372' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Mankeng';
update gii_hierarchy as gh set gh.lat='28.956813', gh.long='-29.491854' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Ha Polaki';
update gii_hierarchy as gh set gh.lat='28.952237', gh.long='-29.49554' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Motsitseng';

update gii_hierarchy as gh set gh.lat='28.987525', gh.long='-29.487444' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Ha Soai';




update gii_hierarchy as gh set gh.lat='29.015887', gh.long='-29.476248' where district='MOKHOTLONG' and council='Linakaneng Council' and village='Mokotleng';


update gii_hierarchy as gh set gh.lat='29.219917', gh.long='-29.295082' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Lekhalong';


update gii_hierarchy as gh set gh.lat='29.034129', gh.long='-29.368861' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Likoae';
update gii_hierarchy as gh set gh.lat='29.064047', gh.long='-29.371029' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Ha Setefane';
update gii_hierarchy as gh set gh.lat='29.045867', gh.long='-29.385358' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Linareng';
update gii_hierarchy as gh set gh.lat='29.025538', gh.long='-29.393352' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Masuoaneng';
update gii_hierarchy as gh set gh.lat='29.019783', gh.long='-29.412795' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Tseko';

update gii_hierarchy as gh set gh.lat='29.077384', gh.long='-29.390572' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Ha Poho';
update gii_hierarchy as gh set gh.lat='29.121039', gh.long='-29.269436' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Makhapung';
update gii_hierarchy as gh set gh.lat='29.075408', gh.long='-29.403814' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='29.083297', gh.long='-29.396887' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Mathakheng';
update gii_hierarchy as gh set gh.lat='29.085554', gh.long='-29.40125' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Ha Maile';


update gii_hierarchy as gh set gh.lat='29.083049', gh.long='-29.410871' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Tlapa le Putsoa';
update gii_hierarchy as gh set gh.lat='29.095998', gh.long='-29.409092' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Ha Matsoejane';


update gii_hierarchy as gh set gh.lat='29.087898', gh.long='-29.433203' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Matsoaing';
update gii_hierarchy as gh set gh.lat='29.116931', gh.long='-29.423547' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Boritsa';
update gii_hierarchy as gh set gh.lat='29.112265', gh.long='-29.417553' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Ha Koenane';
update gii_hierarchy as gh set gh.lat='29.12715', gh.long='-29.445722' where district='MOKHOTLONG' and council='Tekeseleng Council' and village='Thaba Phatsoa';
update gii_hierarchy as gh set gh.lat='28.30731', gh.long='-30.025791' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Matee';
update gii_hierarchy as gh set gh.lat='28.311971', gh.long='-30.012647' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Nkoko';
update gii_hierarchy as gh set gh.lat='28.312568', gh.long='-30.030972' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ramoholi';
update gii_hierarchy as gh set gh.lat='28.299983', gh.long='-30.027355' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Rantsolo';
update gii_hierarchy as gh set gh.lat='28.321373', gh.long='-30.035784' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ramapane';
update gii_hierarchy as gh set gh.lat='28.334324', gh.long='-30.05399' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Raporoto';
update gii_hierarchy as gh set gh.lat='28.331371', gh.long='-30.041817' where district='QACHAS NEK' and council='Patlong Council' and village='Matholeng';
update gii_hierarchy as gh set gh.lat='28.349792', gh.long='-30.033211' where district='QACHAS NEK' and council='Patlong Council' and village='Patlong';
update gii_hierarchy as gh set gh.lat='28.356348', gh.long='-30.036624' where district='QACHAS NEK' and council='Patlong Council' and village='Sekhutloaneng';


update gii_hierarchy as gh set gh.lat='28.364851', gh.long='-30.055385' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ntsoane';
update gii_hierarchy as gh set gh.lat='28.359555', gh.long='-30.050726' where district='QACHAS NEK' and council='Patlong Council' and village='Makhoaeleng';
update gii_hierarchy as gh set gh.lat='28.351302', gh.long='-30.045695' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Khoahla';


update gii_hierarchy as gh set gh.lat='28.366571', gh.long='-30.068256' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Manyatse';
update gii_hierarchy as gh set gh.lat='28.371245', gh.long='-30.070512' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ntei';
update gii_hierarchy as gh set gh.lat='28.368675', gh.long='-30.061362' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Sejanamane';

update gii_hierarchy as gh set gh.lat='28.398819', gh.long='-30.08248' where district='QACHAS NEK' and council='Patlong Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.370485', gh.long='-30.084055' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Hoki';
update gii_hierarchy as gh set gh.lat='28.35267', gh.long='-30.085345' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Moeti';
update gii_hierarchy as gh set gh.lat='28.379657', gh.long='-30.073916' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ralekoala';


update gii_hierarchy as gh set gh.lat='28.383991', gh.long='-30.074743' where district='QACHAS NEK' and council='Patlong Council' and village='Letlapaneng';
update gii_hierarchy as gh set gh.lat='28.378723', gh.long='-30.078874' where district='QACHAS NEK' and council='Patlong Council' and village='Lihlabaneng';
update gii_hierarchy as gh set gh.lat='28.340998', gh.long='-30.080577' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Kali';
update gii_hierarchy as gh set gh.lat='28.348719', gh.long='-30.062319' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Thosi';


update gii_hierarchy as gh set gh.lat='28.331614', gh.long='-30.07302' where district='QACHAS NEK' and council='Patlong Council' and village='Tsatsane';

update gii_hierarchy as gh set gh.lat='28.325147', gh.long='-30.075423' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Belebesi';
update gii_hierarchy as gh set gh.lat='28.320948', gh.long='-30.061229' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Tlhoro';

update gii_hierarchy as gh set gh.lat='28.320178', gh.long='-30.088807' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Joele';
update gii_hierarchy as gh set gh.lat='28.329054', gh.long='-30.093779' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Moeketsi';

update gii_hierarchy as gh set gh.lat='28.302311', gh.long='-30.083879' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Sekepe';


update gii_hierarchy as gh set gh.lat='28.308374', gh.long='-30.090856' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Moleleki';
update gii_hierarchy as gh set gh.lat='28.328791', gh.long='-30.103566' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ntoko';
update gii_hierarchy as gh set gh.lat='28.293993', gh.long='-30.089928' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Seqalaba';
update gii_hierarchy as gh set gh.lat='28.273748', gh.long='-30.093672' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Malefane';
update gii_hierarchy as gh set gh.lat='28.272867', gh.long='-30.0867' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Tekane';
update gii_hierarchy as gh set gh.lat='28.266045', gh.long='-30.072528' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Raene';
update gii_hierarchy as gh set gh.lat='28.256795', gh.long='-30.092545' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Shakhane';
update gii_hierarchy as gh set gh.lat='28.237458', gh.long='-30.090799' where district='QACHAS NEK' and council='Patlong Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.286606', gh.long='-30.110656' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Semethe';
update gii_hierarchy as gh set gh.lat='28.316017', gh.long='-30.11037' where district='QACHAS NEK' and council='Patlong Council' and village='Bongalla';

update gii_hierarchy as gh set gh.lat='28.312733', gh.long='-30.105387' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Ramotseoa';
update gii_hierarchy as gh set gh.lat='28.30691', gh.long='-30.116854' where district='QACHAS NEK' and council='Patlong Council' and village='Phatla Poho';
update gii_hierarchy as gh set gh.lat='28.453834', gh.long='-30.127335' where district='QACHAS NEK' and council='Patlong Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='28.261307', gh.long='-30.119568' where district='QACHAS NEK' and council='Patlong Council' and village='Matebeleng';



update gii_hierarchy as gh set gh.lat='28.241507', gh.long='-30.133572' where district='QACHAS NEK' and council='Patlong Council' and village='Ha Mokhothu';

update gii_hierarchy as gh set gh.lat='28.252485', gh.long='-30.138544' where district='QACHAS NEK' and council='Patlong Council' and village='Matikareng';



update gii_hierarchy as gh set gh.lat='28.449394', gh.long='-30.077086' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Kose';
update gii_hierarchy as gh set gh.lat='28.43795', gh.long='-30.080495' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Motlomelo';
update gii_hierarchy as gh set gh.lat='28.435825', gh.long='-30.072937' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Rankhala';

update gii_hierarchy as gh set gh.lat='28.449485', gh.long='-30.084624' where district='QACHAS NEK' and council='White Hill Council' and village='Mankoaneng';

update gii_hierarchy as gh set gh.lat='28.456485', gh.long='-30.120558' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Jobo';




update gii_hierarchy as gh set gh.lat='28.507868', gh.long='-30.098855' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Molalanyane';
update gii_hierarchy as gh set gh.lat='28.50409', gh.long='-30.077166' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Molikoa';
update gii_hierarchy as gh set gh.lat='28.493776', gh.long='-30.091709' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Rateronko';
update gii_hierarchy as gh set gh.lat='28.50189', gh.long='-30.084041' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Tontsi';
update gii_hierarchy as gh set gh.lat='28.505388', gh.long='-30.083176' where district='QACHAS NEK' and council='White Hill Council' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='28.476797', gh.long='-30.083809' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Mosesi';
update gii_hierarchy as gh set gh.lat='28.48107', gh.long='-30.117062' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Motselo';
update gii_hierarchy as gh set gh.lat='28.261307', gh.long='-30.119568' where district='QACHAS NEK' and council='White Hill Council' and village='Matebeleng';




update gii_hierarchy as gh set gh.lat='28.513792', gh.long='-30.064726' where district='QACHAS NEK' and council='White Hill Council' and village='Ha Mantilane';
update gii_hierarchy as gh set gh.lat='28.536767', gh.long='-30.065506' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Noosi';
update gii_hierarchy as gh set gh.lat='28.558649', gh.long='-30.071047' where district='QACHAS NEK' and council='Letloepe Council' and village='Malimong';
update gii_hierarchy as gh set gh.lat='28.580332', gh.long='-30.078834' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Mphahama';
update gii_hierarchy as gh set gh.lat='28.60159', gh.long='-30.06575' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Nqhoaki';
update gii_hierarchy as gh set gh.lat='28.589175', gh.long='-30.07356' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='28.620534', gh.long='-30.072588' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Mpiti';
update gii_hierarchy as gh set gh.lat='28.609616', gh.long='-30.077837' where district='QACHAS NEK' and council='Letloepe Council' and village='Liqhooeng';
update gii_hierarchy as gh set gh.lat='28.611418', gh.long='-30.086118' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Bolokoe';
update gii_hierarchy as gh set gh.lat='28.616248', gh.long='-30.082306' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Mosola';
update gii_hierarchy as gh set gh.lat='28.608755', gh.long='-30.0894' where district='QACHAS NEK' and council='Letloepe Council' and village='Topa';
update gii_hierarchy as gh set gh.lat='28.645204', gh.long='-30.097813' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Manteko';
update gii_hierarchy as gh set gh.lat='28.642012', gh.long='-30.090217' where district='QACHAS NEK' and council='Letloepe Council' and village='White City';
update gii_hierarchy as gh set gh.lat='28.642083', gh.long='-30.107688' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Nkhahle';


update gii_hierarchy as gh set gh.lat='28.648919', gh.long='-30.10451' where district='QACHAS NEK' and council='Letloepe Council' and village='Thaba Tsoeu';


update gii_hierarchy as gh set gh.lat='28.653747', gh.long='-30.119699' where district='QACHAS NEK' and council='Letloepe Council' and village='Tereseng';
update gii_hierarchy as gh set gh.lat='28.666788', gh.long='-30.122055' where district='QACHAS NEK' and council='Letloepe Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.680001', gh.long='-30.116149' where district='QACHAS NEK' and council='Letloepe Council' and village='Leropong';
update gii_hierarchy as gh set gh.lat='28.683431', gh.long='-30.128955' where district='QACHAS NEK' and council='Letloepe Council' and village='Keiting';




update gii_hierarchy as gh set gh.lat='28.677794', gh.long='-30.103011' where district='QACHAS NEK' and council='Letloepe Council' and village='Thifa';

update gii_hierarchy as gh set gh.lat='28.666958', gh.long='-30.107703' where district='QACHAS NEK' and council='Letloepe Council' and village='Lifofaneng';

update gii_hierarchy as gh set gh.lat='28.669751', gh.long='-30.102431' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Mamosa';
update gii_hierarchy as gh set gh.lat='28.699815', gh.long='-30.110434' where district='QACHAS NEK' and council='Letloepe Council' and village='Hill Side';
update gii_hierarchy as gh set gh.lat='28.696524', gh.long='-30.101792' where district='QACHAS NEK' and council='Letloepe Council' and village='Mapheleng';

update gii_hierarchy as gh set gh.lat='28.690858', gh.long='-30.100345' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Ramoeletsi';
update gii_hierarchy as gh set gh.lat='28.684312', gh.long='-30.099405' where district='QACHAS NEK' and council='Letloepe Council' and village='Liqoqoeng';
update gii_hierarchy as gh set gh.lat='28.421084', gh.long='-30.051063' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Mahabe';
update gii_hierarchy as gh set gh.lat='28.44185', gh.long='-30.06337' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Phatela';
update gii_hierarchy as gh set gh.lat='28.436956', gh.long='-30.05165' where district='QACHAS NEK' and council='Maseepho Council' and village='Mesitsaneng';
update gii_hierarchy as gh set gh.lat='28.463456', gh.long='-30.058561' where district='QACHAS NEK' and council='Maseepho Council' and village='Liphakoeng';


update gii_hierarchy as gh set gh.lat='28.480501', gh.long='-30.03406' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Mapote';
update gii_hierarchy as gh set gh.lat='28.521174', gh.long='-30.041466' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Mokhele';
update gii_hierarchy as gh set gh.lat='28.525287', gh.long='-30.039951' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Ranqhongoana';

update gii_hierarchy as gh set gh.lat='28.520223', gh.long='-29.99593' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Sebata';
update gii_hierarchy as gh set gh.lat='28.516335', gh.long='-29.979897' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Pheello';





update gii_hierarchy as gh set gh.lat='28.540684', gh.long='-30.032385' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Rapase';
update gii_hierarchy as gh set gh.lat='28.530758', gh.long='-30.018679' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Ratsiu';
update gii_hierarchy as gh set gh.lat='28.532742', gh.long='-30.029981' where district='QACHAS NEK' and council='Maseepho Council' and village='Ha Lesala';



update gii_hierarchy as gh set gh.lat='28.91493', gh.long='-29.848223' where district='QACHAS NEK' and council='Matebeng Council' and village='Ha Mofolo';
update gii_hierarchy as gh set gh.lat='28.870858', gh.long='-29.821146' where district='QACHAS NEK' and council='Matebeng Council' and village='Ha Nkofo';




update gii_hierarchy as gh set gh.lat='28.855553', gh.long='-29.843804' where district='QACHAS NEK' and council='Matebeng Council' and village='Ha Wana';

update gii_hierarchy as gh set gh.lat='28.675809', gh.long='-29.914676' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Mosenekeng';
update gii_hierarchy as gh set gh.lat='28.723451', gh.long='-29.916029' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Ramokakatlela';
update gii_hierarchy as gh set gh.lat='28.724178', gh.long='-29.882856' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Tsolo';
update gii_hierarchy as gh set gh.lat='28.763869', gh.long='-29.86787' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Qenehelong';
update gii_hierarchy as gh set gh.lat='28.78722', gh.long='-29.90147' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Bantomo';

update gii_hierarchy as gh set gh.lat='28.788526', gh.long='-29.909969' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Qei';
update gii_hierarchy as gh set gh.lat='28.774882', gh.long='-29.924028' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Seketane';
update gii_hierarchy as gh set gh.lat='28.82739', gh.long='-29.910819' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Takatso';
update gii_hierarchy as gh set gh.lat='28.67612', gh.long='-29.946294' where district='QACHAS NEK' and council='Mosenekeng Council' and village='Ha Ralengoele';

update gii_hierarchy as gh set gh.lat='28.676776', gh.long='-29.802646' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Nkoeng';



update gii_hierarchy as gh set gh.lat='28.642621', gh.long='-29.871621' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Rothifa';
update gii_hierarchy as gh set gh.lat='28.61423', gh.long='-29.869995' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Beselateng';
update gii_hierarchy as gh set gh.lat='28.622478', gh.long='-29.858849' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='28.643331', gh.long='-29.886791' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Ha Molomo';
update gii_hierarchy as gh set gh.lat='28.648631', gh.long='-29.916616' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Ha Letete';



update gii_hierarchy as gh set gh.lat='28.668693', gh.long='-29.998997' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Ha Mofutho';
update gii_hierarchy as gh set gh.lat='28.662434', gh.long='-29.977477' where district='QACHAS NEK' and council='Thaba Khubelu Council' and village='Ha Motloang';
update gii_hierarchy as gh set gh.lat='28.716501', gh.long='-30.094752' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Maluma';
update gii_hierarchy as gh set gh.lat='28.70093', gh.long='-30.089282' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Ramoroke';
update gii_hierarchy as gh set gh.lat='28.754104', gh.long='-30.094025' where district='QACHAS NEK' and council='Letloepe Council' and village='Ha Thaha';


update gii_hierarchy as gh set gh.lat='28.75479', gh.long='-30.100483' where district='QACHAS NEK' and council='Letloepe Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.725749', gh.long='-30.097516' where district='QACHAS NEK' and council='Letloepe Council' and village='Tobotsa';
update gii_hierarchy as gh set gh.lat='28.662822', gh.long='-30.089649' where district='QACHAS NEK' and council='Letloepe Council' and village='Liqalabeng';
update gii_hierarchy as gh set gh.lat='29.083425', gh.long='-29.840104' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Thamathu';



update gii_hierarchy as gh set gh.lat='28.848393', gh.long='-30.050129' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='29.038684', gh.long='-29.873946' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Edward';
update gii_hierarchy as gh set gh.lat='29.019669', gh.long='-29.852939' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Sephelane';

update gii_hierarchy as gh set gh.lat='29.067278', gh.long='-29.882535' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Sehlabathebe';
update gii_hierarchy as gh set gh.lat='29.051751', gh.long='-29.899447' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Mavuka';


update gii_hierarchy as gh set gh.lat='29.054441', gh.long='-29.926778' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Mpharane';
update gii_hierarchy as gh set gh.lat='29.025343', gh.long='-29.936992' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Moshebi';
update gii_hierarchy as gh set gh.lat='29.028473', gh.long='-29.95315' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Libateng';
update gii_hierarchy as gh set gh.lat='29.052392', gh.long='-29.950551' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Mafika Lisiu';

update gii_hierarchy as gh set gh.lat='28.999572', gh.long='-29.983202' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Setefane';
update gii_hierarchy as gh set gh.lat='28.973476', gh.long='-29.939426' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Mosiuoa';
update gii_hierarchy as gh set gh.lat='28.947342', gh.long='-29.965468' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Chaka';
update gii_hierarchy as gh set gh.lat='28.972058', gh.long='-29.971063' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Khabana';
update gii_hierarchy as gh set gh.lat='28.931087', gh.long='-29.973156' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Chabana';
update gii_hierarchy as gh set gh.lat='28.927662', gh.long='-29.957601' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Makorotong';
update gii_hierarchy as gh set gh.lat='28.887836', gh.long='-29.964044' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Ha Matapole';
update gii_hierarchy as gh set gh.lat='28.909334', gh.long='-29.973124' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Likhameng';

update gii_hierarchy as gh set gh.lat='28.92111', gh.long='-30.002662' where district='QACHAS NEK' and council='Khomo Phatsoa Council' and village='Likoebeleng';
update gii_hierarchy as gh set gh.lat='28.657614', gh.long='-30.046049' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Mosuoe';


update gii_hierarchy as gh set gh.lat='28.681194', gh.long='-30.03416' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Ratsoleli';
update gii_hierarchy as gh set gh.lat='28.841706', gh.long='-30.037819' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.697456', gh.long='-30.023056' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Thaba';
update gii_hierarchy as gh set gh.lat='28.721502', gh.long='-30.028611' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Matlali';

update gii_hierarchy as gh set gh.lat='28.72136', gh.long='-30.043551' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Mafikeng';

update gii_hierarchy as gh set gh.lat='28.737083', gh.long='-30.059462' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Kanana';
update gii_hierarchy as gh set gh.lat='28.739154', gh.long='-30.048519' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Matebeng';
update gii_hierarchy as gh set gh.lat='28.726291', gh.long='-30.049935' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Likhohloaneng';
update gii_hierarchy as gh set gh.lat='28.719609', gh.long='-30.047981' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Pitseng';
update gii_hierarchy as gh set gh.lat='28.449485', gh.long='-30.084624' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Mankoaneng';
update gii_hierarchy as gh set gh.lat='28.671654', gh.long='-30.056984' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Sethebeng';
update gii_hierarchy as gh set gh.lat='28.638719', gh.long='-30.059991' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Waterfall';
update gii_hierarchy as gh set gh.lat='28.638927', gh.long='-30.067122' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Foreisetata';
update gii_hierarchy as gh set gh.lat='28.633435', gh.long='-30.068641' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Moloko';
update gii_hierarchy as gh set gh.lat='28.642283', gh.long='-30.071953' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Rooijane';
update gii_hierarchy as gh set gh.lat='28.652687', gh.long='-30.078134' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Linokong';
update gii_hierarchy as gh set gh.lat='28.666993', gh.long='-30.074681' where district='QACHAS NEK' and council='Ratsoleli Council' and village='Ha Tsepiso';
update gii_hierarchy as gh set gh.lat='28.790354', gh.long='-30.044353' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Lioling';
update gii_hierarchy as gh set gh.lat='28.775821', gh.long='-30.049432' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Paneng';
update gii_hierarchy as gh set gh.lat='28.750762', gh.long='-30.062895' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Mojaki';
update gii_hierarchy as gh set gh.lat='28.786059', gh.long='-30.057796' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Rankakala';


update gii_hierarchy as gh set gh.lat='28.772191', gh.long='-30.080557' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Likotopong';
update gii_hierarchy as gh set gh.lat='28.793789', gh.long='-30.088592' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Liqaleng';

update gii_hierarchy as gh set gh.lat='28.81325', gh.long='-30.056182' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Makeoane';

update gii_hierarchy as gh set gh.lat='28.836605', gh.long='-30.075029' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Makoae';
update gii_hierarchy as gh set gh.lat='28.826415', gh.long='-30.049705' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Mapakising';
update gii_hierarchy as gh set gh.lat='28.865166', gh.long='-30.047876' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Ramahlaela';
update gii_hierarchy as gh set gh.lat='28.858038', gh.long='-30.039056' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Semethe';
update gii_hierarchy as gh set gh.lat='28.886746', gh.long='-30.047157' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Popi';
update gii_hierarchy as gh set gh.lat='28.892645', gh.long='-30.043981' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Makong';

update gii_hierarchy as gh set gh.lat='28.884417', gh.long='-30.03127' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Makhoareng';



update gii_hierarchy as gh set gh.lat='28.928012', gh.long='-30.048101' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Ramatseliso';
update gii_hierarchy as gh set gh.lat='28.94405', gh.long='-30.016861' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Monyane';
update gii_hierarchy as gh set gh.lat='28.975794', gh.long='-29.996051' where district='QACHAS NEK' and council='Ramatseliso Council' and village='Ha Jakopo';
update gii_hierarchy as gh set gh.lat='28.723694', gh.long='-29.965469' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Khanya';
update gii_hierarchy as gh set gh.lat='28.723361', gh.long='-29.982127' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Khoathi';
update gii_hierarchy as gh set gh.lat='28.752309', gh.long='-29.950387' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Mahooeng';
update gii_hierarchy as gh set gh.lat='28.739808', gh.long='-29.956515' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Thueleng';
update gii_hierarchy as gh set gh.lat='28.723689', gh.long='-30.016226' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Nyatso';
update gii_hierarchy as gh set gh.lat='28.718218', gh.long='-29.994164' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Likileng';
update gii_hierarchy as gh set gh.lat='28.748128', gh.long='-29.976769' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Chale';

update gii_hierarchy as gh set gh.lat='28.74471', gh.long='-30.015618' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Hohobeng';

update gii_hierarchy as gh set gh.lat='28.772912', gh.long='-30.014294' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Mapeleng';
update gii_hierarchy as gh set gh.lat='28.79594', gh.long='-29.976199' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Rasekoele';
update gii_hierarchy as gh set gh.lat='28.79174', gh.long='-29.964239' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.786467', gh.long='-29.980928' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Lepapaneng';
update gii_hierarchy as gh set gh.lat='28.78311', gh.long='-30.027099' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Moalosi';
update gii_hierarchy as gh set gh.lat='28.792304', gh.long='-30.004546' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Thube';




update gii_hierarchy as gh set gh.lat='28.839611', gh.long='-30.019125' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Mapa';


update gii_hierarchy as gh set gh.lat='28.904707', gh.long='-30.004484' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Isaka';
update gii_hierarchy as gh set gh.lat='28.879588', gh.long='-30.017994' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Tsita';
update gii_hierarchy as gh set gh.lat='28.870986', gh.long='-30.004593' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Thena';
update gii_hierarchy as gh set gh.lat='28.869638', gh.long='-29.975063' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Sepechele';
update gii_hierarchy as gh set gh.lat='28.829208', gh.long='-29.916553' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Lehata';
update gii_hierarchy as gh set gh.lat='28.863815', gh.long='-29.907989' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Mosebi';
update gii_hierarchy as gh set gh.lat='28.856637', gh.long='-29.902001' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Ntlama';
update gii_hierarchy as gh set gh.lat='28.796189', gh.long='-29.939087' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Ramotheba';
update gii_hierarchy as gh set gh.lat='28.798354', gh.long='-29.959516' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Thokoa';
update gii_hierarchy as gh set gh.lat='28.840836', gh.long='-29.872695' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Ha Tsoene';
update gii_hierarchy as gh set gh.lat='28.847142', gh.long='-29.921371' where district='QACHAS NEK' and council='Thaba Litsoene Council' and village='Kholokoe';



update gii_hierarchy as gh set gh.lat='29.006902', gh.long='-29.951448' where district='QACHAS NEK' and council='Matebeng Council' and village='Ha Sefaha';


update gii_hierarchy as gh set gh.lat='28.859719', gh.long='-29.787637' where district='QACHAS NEK' and council='Matebeng Council' and village='Ha Libete';


update gii_hierarchy as gh set gh.lat='27.6654', gh.long='-30.515682' where district='QUTHING' and council='Likhohlong Council' and village='Sethepung';


update gii_hierarchy as gh set gh.lat='27.682668', gh.long='-30.532948' where district='QUTHING' and council='Likhohlong Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='27.691897', gh.long='-30.528868' where district='QUTHING' and council='Likhohlong Council' and village='Mankoaneng';
update gii_hierarchy as gh set gh.lat='27.690138', gh.long='-30.54003' where district='QUTHING' and council='Likhohlong Council' and village='Marakabei';
update gii_hierarchy as gh set gh.lat='27.704346', gh.long='-30.559613' where district='QUTHING' and council='Likhohlong Council' and village='Ha Mpeka';
update gii_hierarchy as gh set gh.lat='27.699031', gh.long='-30.55195' where district='QUTHING' and council='Likhohlong Council' and village='Mokapeleng';
update gii_hierarchy as gh set gh.lat='28.131836', gh.long='-30.19503' where district='QUTHING' and council='Likhohlong Council' and village='Phuthing';
update gii_hierarchy as gh set gh.lat='27.693498', gh.long='-30.542369' where district='QUTHING' and council='Likhohlong Council' and village='Thabong';
update gii_hierarchy as gh set gh.lat='27.678556', gh.long='-30.434805' where district='QUTHING' and council='Likhohlong Council' and village='Tlhakoaneng';

update gii_hierarchy as gh set gh.lat='27.736099', gh.long='-30.525079' where district='QUTHING' and council='Likhohlong Council' and village='Ha Sekhobe';
update gii_hierarchy as gh set gh.lat='27.771284', gh.long='-30.543207' where district='QUTHING' and council='Likhohlong Council' and village='Ha Selebalo';
update gii_hierarchy as gh set gh.lat='27.780624', gh.long='-30.543098' where district='QUTHING' and council='Likhohlong Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='27.959665', gh.long='-30.148699' where district='QUTHING' and council='Likhohlong Council' and village='Lichecheng';
update gii_hierarchy as gh set gh.lat='27.76255', gh.long='-30.535487' where district='QUTHING' and council='Likhohlong Council' and village='Motsekuoa';
update gii_hierarchy as gh set gh.lat='27.762973', gh.long='-30.562858' where district='QUTHING' and council='Likhohlong Council' and village='Ha Motsapi';


update gii_hierarchy as gh set gh.lat='27.720168', gh.long='-30.565096' where district='QUTHING' and council='Likhohlong Council' and village='Ha Makhalanyane';


update gii_hierarchy as gh set gh.lat='27.630892', gh.long='-30.490616' where district='QUTHING' and council='Likhohlong Council' and village='Motse Mocha';

update gii_hierarchy as gh set gh.lat='27.7165', gh.long='-30.579454' where district='QUTHING' and council='Likhohlong Council' and village='Motheaneng';
update gii_hierarchy as gh set gh.lat='27.718332', gh.long='-30.569307' where district='QUTHING' and council='Likhohlong Council' and village='Patisi';
update gii_hierarchy as gh set gh.lat='27.743216', gh.long='-30.578429' where district='QUTHING' and council='Likhohlong Council' and village='Ha Nkoto';



update gii_hierarchy as gh set gh.lat='27.816961', gh.long='-30.561395' where district='QUTHING' and council='Likhohlong Council' and village='Ha Machakela';
update gii_hierarchy as gh set gh.lat='27.780135', gh.long='-30.569779' where district='QUTHING' and council='Likhohlong Council' and village='Ha Shemane';



update gii_hierarchy as gh set gh.lat='27.840889', gh.long='-30.56246' where district='QUTHING' and council='Likhohlong Council' and village='Ha Mphojoa';
update gii_hierarchy as gh set gh.lat='27.849758', gh.long='-30.570138' where district='QUTHING' and council='Likhohlong Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.078679', gh.long='-30.304705' where district='QUTHING' and council='Likhohlong Council' and village='Meriting';
update gii_hierarchy as gh set gh.lat='27.87042', gh.long='-30.554307' where district='QUTHING' and council='Likhohlong Council' and village='Nkoeng';


update gii_hierarchy as gh set gh.lat='27.645718', gh.long='-30.375976' where district='QUTHING' and council='Matsatseng Council' and village='Ha Makoloane';
update gii_hierarchy as gh set gh.lat='27.646967', gh.long='-30.362265' where district='QUTHING' and council='Matsatseng Council' and village='Takisa';
update gii_hierarchy as gh set gh.lat='27.613034', gh.long='-30.362759' where district='QUTHING' and council='Matsatseng Council' and village='Ha Mosuoe';





update gii_hierarchy as gh set gh.lat='27.594948', gh.long='-30.373756' where district='QUTHING' and council='Matsatseng Council' and village='Ha Lira';
update gii_hierarchy as gh set gh.lat='27.588701', gh.long='-30.381675' where district='QUTHING' and council='Matsatseng Council' and village='Lihekaneng';
update gii_hierarchy as gh set gh.lat='27.575214', gh.long='-30.385128' where district='QUTHING' and council='Matsatseng Council' and village='Seaka';
update gii_hierarchy as gh set gh.lat='27.597564', gh.long='-30.373095' where district='QUTHING' and council='Matsatseng Council' and village='Ha Hlalele';

update gii_hierarchy as gh set gh.lat='27.608605', gh.long='-30.379217' where district='QUTHING' and council='Matsatseng Council' and village='Ha Mathabathe';
update gii_hierarchy as gh set gh.lat='27.602278', gh.long='-30.376413' where district='QUTHING' and council='Matsatseng Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.632839', gh.long='-30.379009' where district='QUTHING' and council='Matsatseng Council' and village='Masakaneng';
update gii_hierarchy as gh set gh.lat='27.62618', gh.long='-30.38809' where district='QUTHING' and council='Matsatseng Council' and village='Thoteng';
update gii_hierarchy as gh set gh.lat='27.633798', gh.long='-30.375131' where district='QUTHING' and council='Matsatseng Council' and village='Tipane';
update gii_hierarchy as gh set gh.lat='27.647516', gh.long='-30.381603' where district='QUTHING' and council='Matsatseng Council' and village='Ha Zakia';
update gii_hierarchy as gh set gh.lat='27.659578', gh.long='-30.394297' where district='QUTHING' and council='Matsatseng Council' and village='Khutsong';
update gii_hierarchy as gh set gh.lat='27.65457', gh.long='-30.385958' where district='QUTHING' and council='Matsatseng Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='27.678803', gh.long='-30.523414' where district='QUTHING' and council='Matsatseng Council' and village='Tsekong';

update gii_hierarchy as gh set gh.lat='27.624337', gh.long='-30.396028' where district='QUTHING' and council='Matsatseng Council' and village='Alwynskop';
update gii_hierarchy as gh set gh.lat='27.959164', gh.long='-30.13852' where district='QUTHING' and council='Matsatseng Council' and village='Phuleng';

update gii_hierarchy as gh set gh.lat='27.615153', gh.long='-30.463273' where district='QUTHING' and council='Matsatseng Council' and village='Marakong';
update gii_hierarchy as gh set gh.lat='27.610231', gh.long='-30.394569' where district='QUTHING' and council='Matsatseng Council' and village='Tsethe';

update gii_hierarchy as gh set gh.lat='27.600208', gh.long='-30.403393' where district='QUTHING' and council='Matsatseng Council' and village='Waterfall';



update gii_hierarchy as gh set gh.lat='27.634165', gh.long='-30.412045' where district='QUTHING' and council='Matsatseng Council' and village='Majakaneng';

update gii_hierarchy as gh set gh.lat='27.629837', gh.long='-30.402851' where district='QUTHING' and council='Matsatseng Council' and village='Tsoeneng';

update gii_hierarchy as gh set gh.lat='28.004329', gh.long='-30.497692' where district='QUTHING' and council='Matsatseng Council' and village='Marabeng';

update gii_hierarchy as gh set gh.lat='27.654241', gh.long='-30.415343' where district='QUTHING' and council='Matsatseng Council' and village='Ha Lekete';
update gii_hierarchy as gh set gh.lat='27.645637', gh.long='-30.426142' where district='QUTHING' and council='Matsatseng Council' and village='Matsatseng';


update gii_hierarchy as gh set gh.lat='27.604462', gh.long='-30.418287' where district='QUTHING' and council='Matsatseng Council' and village='Ha Caswell';
update gii_hierarchy as gh set gh.lat='27.593845', gh.long='-30.423406' where district='QUTHING' and council='Matsatseng Council' and village='Ha Lekhoba';

update gii_hierarchy as gh set gh.lat='27.591369', gh.long='-30.413374' where district='QUTHING' and council='Matsatseng Council' and village='Ha Tapole';

update gii_hierarchy as gh set gh.lat='27.577758', gh.long='-30.429973' where district='QUTHING' and council='Matsatseng Council' and village='Ha Khakhau';
update gii_hierarchy as gh set gh.lat='27.605136', gh.long='-30.442666' where district='QUTHING' and council='Matsatseng Council' and village='Bolepeletsa';
update gii_hierarchy as gh set gh.lat='27.591807', gh.long='-30.431222' where district='QUTHING' and council='Matsatseng Council' and village='Mabitseng';


update gii_hierarchy as gh set gh.lat='27.637694', gh.long='-30.441855' where district='QUTHING' and council='Matsatseng Council' and village='Kobolong';

update gii_hierarchy as gh set gh.lat='27.630294', gh.long='-30.45388' where district='QUTHING' and council='Matsatseng Council' and village='Setakeng';





update gii_hierarchy as gh set gh.lat='27.666005', gh.long='-30.449739' where district='QUTHING' and council='Matsatseng Council' and village='Sizindene';



update gii_hierarchy as gh set gh.lat='27.680142', gh.long='-30.461714' where district='QUTHING' and council='Matsatseng Council' and village='Fola';



update gii_hierarchy as gh set gh.lat='27.722819', gh.long='-30.488542' where district='QUTHING' and council='Matsatseng Council' and village='Nontokwene';




update gii_hierarchy as gh set gh.lat='27.691553', gh.long='-30.371577' where district='QUTHING' and council='Matsatseng Council' and village='Maaoeng';



update gii_hierarchy as gh set gh.lat='28.131836', gh.long='-30.19503' where district='QUTHING' and council='Matsatseng Council' and village='Phuthing';

update gii_hierarchy as gh set gh.lat='27.660343', gh.long='-30.365336' where district='QUTHING' and council='Matsatseng Council' and village='Ha Taoa';
update gii_hierarchy as gh set gh.lat='27.650685', gh.long='-30.34708' where district='QUTHING' and council='Matsatseng Council' and village='Ha Tlhohothelo';
update gii_hierarchy as gh set gh.lat='27.663152', gh.long='-30.380592' where district='QUTHING' and council='Matsatseng Council' and village='Mahaheng';

update gii_hierarchy as gh set gh.lat='27.618947', gh.long='-30.485244' where district='QUTHING' and council='Matsatseng Council' and village='Thajaneng';
update gii_hierarchy as gh set gh.lat='27.738747', gh.long='-30.439044' where district='QUTHING' and council='Matsatseng Council' and village='Ha George';
update gii_hierarchy as gh set gh.lat='27.731845', gh.long='-30.442163' where district='QUTHING' and council='Matsatseng Council' and village='Ha Mochaso';
update gii_hierarchy as gh set gh.lat='27.734865', gh.long='-30.448923' where district='QUTHING' and council='Matsatseng Council' and village='Peling';
update gii_hierarchy as gh set gh.lat='27.70275', gh.long='-30.448247' where district='QUTHING' and council='Matsatseng Council' and village='Ben Hoek';
update gii_hierarchy as gh set gh.lat='27.710311', gh.long='-30.448406' where district='QUTHING' and council='Matsatseng Council' and village='Ha Moshati';
update gii_hierarchy as gh set gh.lat='27.696178', gh.long='-30.448845' where district='QUTHING' and council='Matsatseng Council' and village='Ha Liqa';
update gii_hierarchy as gh set gh.lat='27.691188', gh.long='-30.441117' where district='QUTHING' and council='Matsatseng Council' and village='Setanteng';
update gii_hierarchy as gh set gh.lat='27.678556', gh.long='-30.434805' where district='QUTHING' and council='Matsatseng Council' and village='Tlhakoaneng';






update gii_hierarchy as gh set gh.lat='27.779794', gh.long='-30.407066' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Setoko';
update gii_hierarchy as gh set gh.lat='27.819604', gh.long='-30.41418' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Litau';

update gii_hierarchy as gh set gh.lat='27.787871', gh.long='-30.435635' where district='QUTHING' and council='Qomoqomong Council' and village='Basieng';







update gii_hierarchy as gh set gh.lat='27.783334', gh.long='-30.44296' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Elia';
update gii_hierarchy as gh set gh.lat='27.805363', gh.long='-30.47724' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Kompi';


update gii_hierarchy as gh set gh.lat='27.65278', gh.long='-30.36108' where district='QUTHING' and council='Qomoqomong Council' and village='Matebeleng';

update gii_hierarchy as gh set gh.lat='28.131836', gh.long='-30.19503' where district='QUTHING' and council='Qomoqomong Council' and village='Phuthing';




update gii_hierarchy as gh set gh.lat='27.783576', gh.long='-30.474928' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Molebaliso';
update gii_hierarchy as gh set gh.lat='27.830395', gh.long='-30.456925' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Moorosi';
update gii_hierarchy as gh set gh.lat='27.816142', gh.long='-30.474919' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Tsikane';
update gii_hierarchy as gh set gh.lat='27.806695', gh.long='-30.438258' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Liphophi';
update gii_hierarchy as gh set gh.lat='27.827111', gh.long='-30.453792' where district='QUTHING' and council='Qomoqomong Council' and village='Ha Tameisi';
update gii_hierarchy as gh set gh.lat='27.858498', gh.long='-30.466846' where district='QUTHING' and council='Qomoqomong Council' and village='Mabuleng';

update gii_hierarchy as gh set gh.lat='27.860788', gh.long='-30.479705' where district='QUTHING' and council='Qomoqomong Council' and village='Makhetheng';
update gii_hierarchy as gh set gh.lat='27.855166', gh.long='-30.475098' where district='QUTHING' and council='Qomoqomong Council' and village='Maphepheng';


update gii_hierarchy as gh set gh.lat='27.691342', gh.long='-30.380634' where district='QUTHING' and council='Liphakoe Council' and village='Ha Mofetoli';
update gii_hierarchy as gh set gh.lat='27.689697', gh.long='-30.396795' where district='QUTHING' and council='Liphakoe Council' and village='Ha Mokola';
update gii_hierarchy as gh set gh.lat='27.69453', gh.long='-30.384756' where district='QUTHING' and council='Liphakoe Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='27.693498', gh.long='-30.542369' where district='QUTHING' and council='Liphakoe Council' and village='Thabong';

update gii_hierarchy as gh set gh.lat='27.707018', gh.long='-30.372767' where district='QUTHING' and council='Liphakoe Council' and village='Ha Ntho';
update gii_hierarchy as gh set gh.lat='27.703837', gh.long='-30.389365' where district='QUTHING' and council='Liphakoe Council' and village='Maboelleng';

update gii_hierarchy as gh set gh.lat='27.695001', gh.long='-30.395584' where district='QUTHING' and council='Liphakoe Council' and village='Thabaneng';


update gii_hierarchy as gh set gh.lat='27.741701', gh.long='-30.416759' where district='QUTHING' and council='Liphakoe Council' and village='Ha Mathabela';
update gii_hierarchy as gh set gh.lat='27.731208', gh.long='-30.40771' where district='QUTHING' and council='Liphakoe Council' and village='Ha Rashoalane';

update gii_hierarchy as gh set gh.lat='27.72521', gh.long='-30.408022' where district='QUTHING' and council='Liphakoe Council' and village='Ha Ratema';
update gii_hierarchy as gh set gh.lat='27.732672', gh.long='-30.417814' where district='QUTHING' and council='Liphakoe Council' and village='Mohloling';

update gii_hierarchy as gh set gh.lat='27.677958', gh.long='-30.361029' where district='QUTHING' and council='Liphakoe Council' and village='Koung';
update gii_hierarchy as gh set gh.lat='27.720894', gh.long='-30.426005' where district='QUTHING' and council='Liphakoe Council' and village='Ha Lekhotso';
update gii_hierarchy as gh set gh.lat='27.719444', gh.long='-30.40221' where district='QUTHING' and council='Liphakoe Council' and village='Ha Sephamo';

update gii_hierarchy as gh set gh.lat='27.708936', gh.long='-30.398043' where district='QUTHING' and council='Liphakoe Council' and village='Motse mocha (Ha Sikara)';
update gii_hierarchy as gh set gh.lat='27.630892', gh.long='-30.490616' where district='QUTHING' and council='Liphakoe Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='27.698531', gh.long='-30.398391' where district='QUTHING' and council='Liphakoe Council' and village='Ha Lehlabela';

update gii_hierarchy as gh set gh.lat='27.816556', gh.long='-30.295938' where district='QUTHING' and council='Liphakoe Council' and village='Borokhong';
update gii_hierarchy as gh set gh.lat='27.691004', gh.long='-30.399464' where district='QUTHING' and council='Liphakoe Council' and village='Lipeleng';
update gii_hierarchy as gh set gh.lat='27.70909', gh.long='-30.402238' where district='QUTHING' and council='Liphakoe Council' and village='Lower Moyeni';

update gii_hierarchy as gh set gh.lat='27.701218', gh.long='-30.403758' where district='QUTHING' and council='Liphakoe Council' and village='Mampoboleng';

update gii_hierarchy as gh set gh.lat='27.704061', gh.long='-30.406073' where district='QUTHING' and council='Liphakoe Council' and village='Upper Moyeni';
update gii_hierarchy as gh set gh.lat='27.702741', gh.long='-30.398267' where district='QUTHING' and council='Liphakoe Council' and village='Ha Sikara';
update gii_hierarchy as gh set gh.lat='27.67175', gh.long='-30.418123' where district='QUTHING' and council='Liphakoe Council' and village='Ha Ramohanoe';
update gii_hierarchy as gh set gh.lat='27.679811', gh.long='-30.405565' where district='QUTHING' and council='Liphakoe Council' and village='Leloaleng';
update gii_hierarchy as gh set gh.lat='27.667173', gh.long='-30.397397' where district='QUTHING' and council='Liphakoe Council' and village='Mokanametsong';
update gii_hierarchy as gh set gh.lat='27.750956', gh.long='-30.389799' where district='QUTHING' and council='Liphakoe Council' and village='Ha Letsika';
update gii_hierarchy as gh set gh.lat='27.729081', gh.long='-30.388805' where district='QUTHING' and council='Liphakoe Council' and village='Ha Makepile';

update gii_hierarchy as gh set gh.lat='27.730376', gh.long='-30.38471' where district='QUTHING' and council='Liphakoe Council' and village='Ha Rakhoboli';
update gii_hierarchy as gh set gh.lat='27.71798', gh.long='-30.38126' where district='QUTHING' and council='Liphakoe Council' and village='Hekeng';
update gii_hierarchy as gh set gh.lat='27.746504', gh.long='-30.385807' where district='QUTHING' and council='Liphakoe Council' and village='Makanese';
update gii_hierarchy as gh set gh.lat='27.69851', gh.long='-30.371609' where district='QUTHING' and council='Liphakoe Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='27.732121', gh.long='-30.278202' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Potomane';
update gii_hierarchy as gh set gh.lat='27.758656', gh.long='-30.290303' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Lebona';
update gii_hierarchy as gh set gh.lat='27.807175', gh.long='-30.28527' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Robi';




update gii_hierarchy as gh set gh.lat='27.79821', gh.long='-30.322131' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Boloumane';
update gii_hierarchy as gh set gh.lat='27.769089', gh.long='-30.314422' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Kotane';
update gii_hierarchy as gh set gh.lat='27.781128', gh.long='-30.325828' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Selebalo';
update gii_hierarchy as gh set gh.lat='27.791791', gh.long='-30.322096' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Soetsane';
update gii_hierarchy as gh set gh.lat='27.739896', gh.long='-30.309166' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Boke';



update gii_hierarchy as gh set gh.lat='27.7535', gh.long='-30.343457' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Masunyane';
update gii_hierarchy as gh set gh.lat='27.744911', gh.long='-30.343275' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Tamanyane';
update gii_hierarchy as gh set gh.lat='27.96021', gh.long='-30.400369' where district='QUTHING' and council='Ha Nkoebe Council' and village='Teraeng';
update gii_hierarchy as gh set gh.lat='27.748399', gh.long='-30.37578' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Hlalele';

update gii_hierarchy as gh set gh.lat='27.738004', gh.long='-30.364855' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Nyolo';
update gii_hierarchy as gh set gh.lat='27.737685', gh.long='-30.377007' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Qhotsi';
update gii_hierarchy as gh set gh.lat='27.729229', gh.long='-30.354265' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Rakhomo';

update gii_hierarchy as gh set gh.lat='27.65278', gh.long='-30.36108' where district='QUTHING' and council='Ha Nkoebe Council' and village='Matebeleng';



update gii_hierarchy as gh set gh.lat='27.760256', gh.long='-30.322146' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Sehloho (Lithabaneng)';


update gii_hierarchy as gh set gh.lat='27.811404', gh.long='-30.308827' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Sempe';
update gii_hierarchy as gh set gh.lat='27.808324', gh.long='-30.32566' where district='QUTHING' and council='Ha Nkoebe Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='27.831417', gh.long='-30.325719' where district='QUTHING' and council='Ha Nkoebe Council' and village='Maphapheng';
update gii_hierarchy as gh set gh.lat='27.852404', gh.long='-30.333279' where district='QUTHING' and council='Ha Nkoebe Council' and village='Maokeng';


update gii_hierarchy as gh set gh.lat='27.840215', gh.long='-30.360782' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Malephane';



update gii_hierarchy as gh set gh.lat='27.762973', gh.long='-30.562858' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Motsapi';

update gii_hierarchy as gh set gh.lat='27.834265', gh.long='-30.384254' where district='QUTHING' and council='Ha Nkoebe Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='27.871578', gh.long='-30.372893' where district='QUTHING' and council='Ha Nkoebe Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='27.88903', gh.long='-30.389217' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Mosifa';
update gii_hierarchy as gh set gh.lat='27.858981', gh.long='-30.39965' where district='QUTHING' and council='Ha Nkoebe Council' and village='Mokhoabong';
update gii_hierarchy as gh set gh.lat='27.871508', gh.long='-30.396647' where district='QUTHING' and council='Ha Nkoebe Council' and village='Photha photha';












update gii_hierarchy as gh set gh.lat='27.79116', gh.long='-30.36402' where district='QUTHING' and council='Ha Nkoebe Council' and village='Ha Mphasane';

update gii_hierarchy as gh set gh.lat='27.895589', gh.long='-30.314577' where district='QUTHING' and council='Tsatsane Council' and village='Ha Thaha';
update gii_hierarchy as gh set gh.lat='27.835766', gh.long='-30.44974' where district='QUTHING' and council='Tsatsane Council' and village='Litsoeneng';


update gii_hierarchy as gh set gh.lat='27.949927', gh.long='-30.342334' where district='QUTHING' and council='Tsatsane Council' and village='Ha Ramanasi';










update gii_hierarchy as gh set gh.lat='27.946334', gh.long='-30.43038' where district='QUTHING' and council='Tsatsane Council' and village='Ha Falatsa';

update gii_hierarchy as gh set gh.lat='27.994434', gh.long='-30.343911' where district='QUTHING' and council='Tsatsane Council' and village='Koti se phola';

update gii_hierarchy as gh set gh.lat='27.65278', gh.long='-30.36108' where district='QUTHING' and council='Tsatsane Council' and village='Matebeleng';



update gii_hierarchy as gh set gh.lat='27.946885', gh.long='-30.385672' where district='QUTHING' and council='Tsatsane Council' and village='Ha Mpapa';


update gii_hierarchy as gh set gh.lat='27.858981', gh.long='-30.39965' where district='QUTHING' and council='Tsatsane Council' and village='Mokhoabong';
update gii_hierarchy as gh set gh.lat='27.998678', gh.long='-30.386298' where district='QUTHING' and council='Tsatsane Council' and village='Ha Hlaela';

update gii_hierarchy as gh set gh.lat='28.030967', gh.long='-30.386133' where district='QUTHING' and council='Tsatsane Council' and village='Ha Mathe';
update gii_hierarchy as gh set gh.lat='27.979421', gh.long='-30.389342' where district='QUTHING' and council='Tsatsane Council' and village='Ha Mofokeng';

update gii_hierarchy as gh set gh.lat='27.736099', gh.long='-30.525079' where district='QUTHING' and council='Tsatsane Council' and village='Ha Sekhobe';


update gii_hierarchy as gh set gh.lat='28.031994', gh.long='-30.183783' where district='QUTHING' and council='Tsatsane Council' and village='Tlokoeng';

update gii_hierarchy as gh set gh.lat='27.972641', gh.long='-30.418778' where district='QUTHING' and council='Tsatsane Council' and village='Ha Maleka';
update gii_hierarchy as gh set gh.lat='27.995704', gh.long='-30.430651' where district='QUTHING' and council='Tsatsane Council' and village='Ha Montsi';


update gii_hierarchy as gh set gh.lat='28.002288', gh.long='-30.460562' where district='QUTHING' and council='Tsatsane Council' and village='Ha Liphapang';






update gii_hierarchy as gh set gh.lat='28.036208', gh.long='-30.458215' where district='QUTHING' and council='Tsatsane Council' and village='Ha Thibella';
update gii_hierarchy as gh set gh.lat='28.063323', gh.long='-30.495262' where district='QUTHING' and council='Tsatsane Council' and village='Ha Lephahamela';

update gii_hierarchy as gh set gh.lat='28.03491', gh.long='-30.484667' where district='QUTHING' and council='Tsatsane Council' and village='Ha Sekonyela';




update gii_hierarchy as gh set gh.lat='28.021461', gh.long='-30.550992' where district='QUTHING' and council='Tsatsane Council' and village='Ha France';
update gii_hierarchy as gh set gh.lat='28.034109', gh.long='-30.530567' where district='QUTHING' and council='Tsatsane Council' and village='Ha Raemile';
update gii_hierarchy as gh set gh.lat='28.036282', gh.long='-30.538306' where district='QUTHING' and council='Tsatsane Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.024032', gh.long='-30.577379' where district='QUTHING' and council='Tsatsane Council' and village='Ha Mosele';

update gii_hierarchy as gh set gh.lat='27.987955', gh.long='-30.346956' where district='QUTHING' and council='Tsatsane Council' and village='Sekoaing';
update gii_hierarchy as gh set gh.lat='27.924587', gh.long='-30.148774' where district='QUTHING' and council='Mkhono Council' and village='Ha Machakela';
update gii_hierarchy as gh set gh.lat='27.900474', gh.long='-30.142048' where district='QUTHING' and council='Mkhono Council' and village='Ha Mofomme';
update gii_hierarchy as gh set gh.lat='27.935975', gh.long='-30.134476' where district='QUTHING' and council='Mkhono Council' and village='Ha Sekoati';
update gii_hierarchy as gh set gh.lat='27.912093', gh.long='-30.150185' where district='QUTHING' and council='Mkhono Council' and village='Mapolaneng';
update gii_hierarchy as gh set gh.lat='27.916391', gh.long='-30.12531' where district='QUTHING' and council='Mkhono Council' and village='Ha Mothamane';
update gii_hierarchy as gh set gh.lat='27.926279', gh.long='-30.127235' where district='QUTHING' and council='Mkhono Council' and village='Ha Tanyele';
update gii_hierarchy as gh set gh.lat='27.835766', gh.long='-30.44974' where district='QUTHING' and council='Mkhono Council' and village='Litsoeneng';


update gii_hierarchy as gh set gh.lat='27.943981', gh.long='-30.111525' where district='QUTHING' and council='Mkhono Council' and village='Ha Mashapha';
update gii_hierarchy as gh set gh.lat='27.677958', gh.long='-30.361029' where district='QUTHING' and council='Mkhono Council' and village='Koung';

update gii_hierarchy as gh set gh.lat='27.964195', gh.long='-30.145786' where district='QUTHING' and council='Mkhono Council' and village='Lekhalaneng';
update gii_hierarchy as gh set gh.lat='27.959665', gh.long='-30.148699' where district='QUTHING' and council='Mkhono Council' and village='Lichecheng';

update gii_hierarchy as gh set gh.lat='27.959164', gh.long='-30.13852' where district='QUTHING' and council='Mkhono Council' and village='Phuleng';
update gii_hierarchy as gh set gh.lat='27.96188', gh.long='-30.135696' where district='QUTHING' and council='Mkhono Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='27.987692', gh.long='-30.130037' where district='QUTHING' and council='Mkhono Council' and village='Ha Boroko';
update gii_hierarchy as gh set gh.lat='27.995867', gh.long='-30.117225' where district='QUTHING' and council='Mkhono Council' and village='Ha Majara';
update gii_hierarchy as gh set gh.lat='27.982265', gh.long='-30.133223' where district='QUTHING' and council='Mkhono Council' and village='Ha Tsoinyane';
update gii_hierarchy as gh set gh.lat='27.849758', gh.long='-30.570138' where district='QUTHING' and council='Mkhono Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='27.65278', gh.long='-30.36108' where district='QUTHING' and council='Mkhono Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='27.997113', gh.long='-30.086224' where district='QUTHING' and council='Mkhono Council' and village='Ha Mapena';
update gii_hierarchy as gh set gh.lat='28.028058', gh.long='-30.10079' where district='QUTHING' and council='Mkhono Council' and village='Ha Selatile';
update gii_hierarchy as gh set gh.lat='27.785958', gh.long='-30.379936' where district='QUTHING' and council='Mkhono Council' and village='Makatseng';

update gii_hierarchy as gh set gh.lat='28.038083', gh.long='-30.104528' where district='QUTHING' and council='Mkhono Council' and village='Ha Matlali';
update gii_hierarchy as gh set gh.lat='28.05219', gh.long='-30.108914' where district='QUTHING' and council='Mkhono Council' and village='Macheseng';
update gii_hierarchy as gh set gh.lat='28.055468', gh.long='-30.138565' where district='QUTHING' and council='Mkhono Council' and village='Ha Morai';
update gii_hierarchy as gh set gh.lat='28.069198', gh.long='-30.111516' where district='QUTHING' and council='Mkhono Council' and village='Ha Raseeng';

update gii_hierarchy as gh set gh.lat='28.078456', gh.long='-30.115644' where district='QUTHING' and council='Mkhono Council' and village='Makaoteng';
update gii_hierarchy as gh set gh.lat='28.033951', gh.long='-30.140964' where district='QUTHING' and council='Mkhono Council' and village='Ha Lekhoele';
update gii_hierarchy as gh set gh.lat='28.020896', gh.long='-30.143499' where district='QUTHING' and council='Mkhono Council' and village='Ha Monoana';
update gii_hierarchy as gh set gh.lat='28.007078', gh.long='-30.147621' where district='QUTHING' and council='Mkhono Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='27.986782', gh.long='-30.149001' where district='QUTHING' and council='Mkhono Council' and village='Maebaneng';

update gii_hierarchy as gh set gh.lat='27.993184', gh.long='-30.158324' where district='QUTHING' and council='Mkhono Council' and village='Mosafeleng';
update gii_hierarchy as gh set gh.lat='28.015962', gh.long='-30.163744' where district='QUTHING' and council='Mkhono Council' and village='Ha Sekhaola';
update gii_hierarchy as gh set gh.lat='28.022004', gh.long='-30.152129' where district='QUTHING' and council='Mkhono Council' and village='Likonyeleng';
update gii_hierarchy as gh set gh.lat='28.021131', gh.long='-30.171176' where district='QUTHING' and council='Mkhono Council' and village='Maphakatlaling';
update gii_hierarchy as gh set gh.lat='28.036072', gh.long='-30.171396' where district='QUTHING' and council='Mkhono Council' and village='Mokekeng';
update gii_hierarchy as gh set gh.lat='28.004356', gh.long='-30.16376' where district='QUTHING' and council='Mkhono Council' and village='Qheeba';
update gii_hierarchy as gh set gh.lat='28.018157', gh.long='-30.176785' where district='QUTHING' and council='Mkhono Council' and village='Ha Lebelonyane';

update gii_hierarchy as gh set gh.lat='27.72521', gh.long='-30.408022' where district='QUTHING' and council='Mkhono Council' and village='Ha Ratema';


update gii_hierarchy as gh set gh.lat='27.990544', gh.long='-30.170589' where district='QUTHING' and council='Mkhono Council' and village='Ha Tobia';
update gii_hierarchy as gh set gh.lat='27.678803', gh.long='-30.523414' where district='QUTHING' and council='Mkhono Council' and village='Tsekong';

update gii_hierarchy as gh set gh.lat='27.871578', gh.long='-30.372893' where district='QUTHING' and council='Mkhono Council' and village='Letlapeng';



update gii_hierarchy as gh set gh.lat='27.946999', gh.long='-30.155881' where district='QUTHING' and council='Mkhono Council' and village='Ha Mphori';
update gii_hierarchy as gh set gh.lat='27.944596', gh.long='-30.172039' where district='QUTHING' and council='Mkhono Council' and village='Lilepeng';

update gii_hierarchy as gh set gh.lat='27.933676', gh.long='-30.187994' where district='QUTHING' and council='Mkhono Council' and village='Chache';


update gii_hierarchy as gh set gh.lat='27.92084', gh.long='-30.215795' where district='QUTHING' and council='Mkhono Council' and village='Likhokhotsing';

update gii_hierarchy as gh set gh.lat='28.00666', gh.long='-30.280898' where district='QUTHING' and council='Mkhono Council' and village='Lithakong';
update gii_hierarchy as gh set gh.lat='28.157123', gh.long='-30.146302' where district='QUTHING' and council='Mkhono Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.131836', gh.long='-30.19503' where district='QUTHING' and council='Mkhono Council' and village='Phuthing';
update gii_hierarchy as gh set gh.lat='27.950158', gh.long='-30.211464' where district='QUTHING' and council='Mkhono Council' and village='Bolula';
update gii_hierarchy as gh set gh.lat='27.940783', gh.long='-30.21729' where district='QUTHING' and council='Mkhono Council' and village='Ha Mohlakoana';
update gii_hierarchy as gh set gh.lat='27.935656', gh.long='-30.235425' where district='QUTHING' and council='Mkhono Council' and village='Tolong';
update gii_hierarchy as gh set gh.lat='27.973383', gh.long='-30.205602' where district='QUTHING' and council='Mkhono Council' and village='Ha Makhoali';
update gii_hierarchy as gh set gh.lat='27.958759', gh.long='-30.204938' where district='QUTHING' and council='Mkhono Council' and village='Ha Nonyana';
update gii_hierarchy as gh set gh.lat='28.274832', gh.long='-30.168606' where district='QUTHING' and council='Mkhono Council' and village='Polateng';
update gii_hierarchy as gh set gh.lat='27.988561', gh.long='-30.448635' where district='QUTHING' and council='Mkhono Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='27.80433', gh.long='-30.402365' where district='QUTHING' and council='Mkhono Council' and village='Khohlong';


update gii_hierarchy as gh set gh.lat='27.69851', gh.long='-30.371609' where district='QUTHING' and council='Mkhono Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='27.882349', gh.long='-30.356728' where district='QUTHING' and council='Mkhono Council' and village='Thepung';

update gii_hierarchy as gh set gh.lat='27.985389', gh.long='-30.212915' where district='QUTHING' and council='Mkhono Council' and village='Ha Lebesele';
update gii_hierarchy as gh set gh.lat='27.996583', gh.long='-30.219076' where district='QUTHING' and council='Mkhono Council' and village='Ha Rasofia';

update gii_hierarchy as gh set gh.lat='28.023333', gh.long='-30.225508' where district='QUTHING' and council='Mkhono Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.074504', gh.long='-30.20946' where district='QUTHING' and council='Mkhono Council' and village='Ha Kholoa';
update gii_hierarchy as gh set gh.lat='28.045604', gh.long='-30.221233' where district='QUTHING' and council='Mkhono Council' and village='Ha Mabina';


update gii_hierarchy as gh set gh.lat='27.853768', gh.long='-30.321061' where district='QUTHING' and council='Mokotjomela Council' and village='Matsitsing';
update gii_hierarchy as gh set gh.lat='27.845414', gh.long='-30.323116' where district='QUTHING' and council='Mokotjomela Council' and village='Sephokong';





update gii_hierarchy as gh set gh.lat='27.876497', gh.long='-30.298623' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mphethi';
update gii_hierarchy as gh set gh.lat='27.856629', gh.long='-30.293408' where district='QUTHING' and council='Mokotjomela Council' and village='Khohlong (Ha Koali)';

update gii_hierarchy as gh set gh.lat='27.860234', gh.long='-30.280892' where district='QUTHING' and council='Mokotjomela Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='27.853688', gh.long='-30.283091' where district='QUTHING' and council='Mokotjomela Council' and village='Tsoelike';
update gii_hierarchy as gh set gh.lat='27.826747', gh.long='-30.289093' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mathatjane';

update gii_hierarchy as gh set gh.lat='27.848375', gh.long='-30.280059' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Koali';

update gii_hierarchy as gh set gh.lat='27.808687', gh.long='-30.562882' where district='QUTHING' and council='Mokotjomela Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='27.866731', gh.long='-30.283852' where district='QUTHING' and council='Mokotjomela Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='27.885009', gh.long='-30.275207' where district='QUTHING' and council='Mokotjomela Council' and village='Lipeleng';

update gii_hierarchy as gh set gh.lat='27.879515', gh.long='-30.257763' where district='QUTHING' and council='Mokotjomela Council' and village='Polasing';

update gii_hierarchy as gh set gh.lat='27.881641', gh.long='-30.266379' where district='QUTHING' and council='Mokotjomela Council' and village='Maputsoe';
update gii_hierarchy as gh set gh.lat='27.890111', gh.long='-30.249049' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Chere';
update gii_hierarchy as gh set gh.lat='27.883959', gh.long='-30.242552' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Moqalo';
update gii_hierarchy as gh set gh.lat='27.885195', gh.long='-30.232718' where district='QUTHING' and council='Mokotjomela Council' and village='Mehlehleng';
update gii_hierarchy as gh set gh.lat='27.875248', gh.long='-30.246093' where district='QUTHING' and council='Mokotjomela Council' and village='Nqanqasing';
update gii_hierarchy as gh set gh.lat='27.91096', gh.long='-30.256661' where district='QUTHING' and council='Mokotjomela Council' and village='Mantsoepa';
update gii_hierarchy as gh set gh.lat='27.902787', gh.long='-30.275578' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Lerotholi';
update gii_hierarchy as gh set gh.lat='27.930608', gh.long='-30.266826' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Lethinya';



update gii_hierarchy as gh set gh.lat='28.031994', gh.long='-30.183783' where district='QUTHING' and council='Mokotjomela Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='27.934965', gh.long='-30.248659' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mofula';
update gii_hierarchy as gh set gh.lat='27.93008', gh.long='-30.24519' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Moone';
update gii_hierarchy as gh set gh.lat='27.930858', gh.long='-30.259511' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Ponto';


update gii_hierarchy as gh set gh.lat='27.945422', gh.long='-30.282244' where district='QUTHING' and council='Mokotjomela Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='27.94896', gh.long='-30.302795' where district='QUTHING' and council='Mokotjomela Council' and village='Mapekeng';



update gii_hierarchy as gh set gh.lat='27.970495', gh.long='-30.295267' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Sekhele';


update gii_hierarchy as gh set gh.lat='27.989018', gh.long='-30.305317' where district='QUTHING' and council='Mokotjomela Council' and village='Marakong';
update gii_hierarchy as gh set gh.lat='27.985093', gh.long='-30.310668' where district='QUTHING' and council='Mokotjomela Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='27.997775', gh.long='-30.342492' where district='QUTHING' and council='Mokotjomela Council' and village='Sekolong';
update gii_hierarchy as gh set gh.lat='27.678803', gh.long='-30.523414' where district='QUTHING' and council='Mokotjomela Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='27.947272', gh.long='-30.250193' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Malibe';
update gii_hierarchy as gh set gh.lat='28.015662', gh.long='-30.30821' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mokae';

update gii_hierarchy as gh set gh.lat='28.131836', gh.long='-30.19503' where district='QUTHING' and council='Mokotjomela Council' and village='Phuthing';
update gii_hierarchy as gh set gh.lat='27.974134', gh.long='-30.238513' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mpheelle';
update gii_hierarchy as gh set gh.lat='27.994917', gh.long='-30.249511' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Moleleki';
update gii_hierarchy as gh set gh.lat='28.008467', gh.long='-30.242211' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Ntemere';
update gii_hierarchy as gh set gh.lat='28.003347', gh.long='-30.255986' where district='QUTHING' and council='Mokotjomela Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='28.0286', gh.long='-30.315086' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Muso';
update gii_hierarchy as gh set gh.lat='28.017813', gh.long='-30.295889' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Tebesi';
update gii_hierarchy as gh set gh.lat='28.01108', gh.long='-30.303454' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mokokoane';
update gii_hierarchy as gh set gh.lat='27.617044', gh.long='-30.368754' where district='QUTHING' and council='Mokotjomela Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='27.992671', gh.long='-30.324526' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mohlori';
update gii_hierarchy as gh set gh.lat='28.274832', gh.long='-30.168606' where district='QUTHING' and council='Mokotjomela Council' and village='Polateng';
update gii_hierarchy as gh set gh.lat='27.678556', gh.long='-30.434805' where district='QUTHING' and council='Mokotjomela Council' and village='Tlhakoaneng';

update gii_hierarchy as gh set gh.lat='28.060416', gh.long='-30.318088' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Leroma';
update gii_hierarchy as gh set gh.lat='28.052404', gh.long='-30.304876' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mabala';
update gii_hierarchy as gh set gh.lat='28.039824', gh.long='-30.302618' where district='QUTHING' and council='Mokotjomela Council' and village='Ha Mohlakaso';
update gii_hierarchy as gh set gh.lat='27.882349', gh.long='-30.356728' where district='QUTHING' and council='Mokotjomela Council' and village='Thepung';
update gii_hierarchy as gh set gh.lat='28.049549', gh.long='-30.270602' where district='QUTHING' and council='Mphaki Council' and village='Ha Pokisi';


update gii_hierarchy as gh set gh.lat='28.055654', gh.long='-30.278028' where district='QUTHING' and council='Mphaki Council' and village='Ha Makoae';
update gii_hierarchy as gh set gh.lat='28.05159', gh.long='-30.280404' where district='QUTHING' and council='Mphaki Council' and village='Ha Noko';






update gii_hierarchy as gh set gh.lat='28.14959', gh.long='-30.251577' where district='QUTHING' and council='Mphaki Council' and village='Ha Mokhosi';
update gii_hierarchy as gh set gh.lat='28.142668', gh.long='-30.272615' where district='QUTHING' and council='Mphaki Council' and village='Ha Peete';


update gii_hierarchy as gh set gh.lat='28.172116', gh.long='-30.282602' where district='QUTHING' and council='Mphaki Council' and village='Ha Sera';



update gii_hierarchy as gh set gh.lat='28.109197', gh.long='-30.274146' where district='QUTHING' and council='Mphaki Council' and village='Ha Mafa';
update gii_hierarchy as gh set gh.lat='27.780624', gh.long='-30.543098' where district='QUTHING' and council='Mphaki Council' and village='Lekhalong';

update gii_hierarchy as gh set gh.lat='28.120341', gh.long='-30.294651' where district='QUTHING' and council='Mphaki Council' and village='Pholeng';
update gii_hierarchy as gh set gh.lat='28.096317', gh.long='-30.29373' where district='QUTHING' and council='Mphaki Council' and village='Tlapaneng';
update gii_hierarchy as gh set gh.lat='28.088265', gh.long='-30.300972' where district='QUTHING' and council='Mphaki Council' and village='Ha Motjoli';
update gii_hierarchy as gh set gh.lat='28.078679', gh.long='-30.304705' where district='QUTHING' and council='Mphaki Council' and village='Meriting';
update gii_hierarchy as gh set gh.lat='28.071737', gh.long='-30.303321' where district='QUTHING' and council='Mphaki Council' and village='Ha Machesetsa';


update gii_hierarchy as gh set gh.lat='27.860788', gh.long='-30.479705' where district='QUTHING' and council='Mphaki Council' and village='Makhetheng';



update gii_hierarchy as gh set gh.lat='28.127873', gh.long='-30.321038' where district='QUTHING' and council='Mphaki Council' and village='Ha Lefelisa';
update gii_hierarchy as gh set gh.lat='28.115811', gh.long='-30.327918' where district='QUTHING' and council='Mphaki Council' and village='Ha Lethena';
update gii_hierarchy as gh set gh.lat='28.095099', gh.long='-30.318331' where district='QUTHING' and council='Mphaki Council' and village='Ha Malimabe';

update gii_hierarchy as gh set gh.lat='28.114984', gh.long='-30.317534' where district='QUTHING' and council='Mphaki Council' and village='Ha Tsepane';


update gii_hierarchy as gh set gh.lat='28.062847', gh.long='-30.167642' where district='QUTHING' and council='Mphaki Council' and village='Ha Maeke';
update gii_hierarchy as gh set gh.lat='28.04456', gh.long='-30.186213' where district='QUTHING' and council='Mphaki Council' and village='Ha Mokhethi';



update gii_hierarchy as gh set gh.lat='28.076347', gh.long='-30.193478' where district='QUTHING' and council='Mphaki Council' and village='Ha Lebeko';

update gii_hierarchy as gh set gh.lat='28.066592', gh.long='-30.191451' where district='QUTHING' and council='Mphaki Council' and village='Sekhutloaneng';
update gii_hierarchy as gh set gh.lat='28.093055', gh.long='-30.176728' where district='QUTHING' and council='Mphaki Council' and village='Ha Mohloli';
update gii_hierarchy as gh set gh.lat='27.69851', gh.long='-30.371609' where district='QUTHING' and council='Mphaki Council' and village='Thaba Chitja';

update gii_hierarchy as gh set gh.lat='28.080407', gh.long='-30.201451' where district='QUTHING' and council='Mphaki Council' and village='Kopanong';

update gii_hierarchy as gh set gh.lat='28.082826', gh.long='-30.194448' where district='QUTHING' and council='Mphaki Council' and village='Thabang';



update gii_hierarchy as gh set gh.lat='28.119261', gh.long='-30.174087' where district='QUTHING' and council='Mphaki Council' and village='Ha Tlali';





update gii_hierarchy as gh set gh.lat='28.101253', gh.long='-30.206405' where district='QUTHING' and council='Mphaki Council' and village='Likhohloaneng';

update gii_hierarchy as gh set gh.lat='28.124633', gh.long='-30.202426' where district='QUTHING' and council='Mphaki Council' and village='Ha Feke';

update gii_hierarchy as gh set gh.lat='28.131106', gh.long='-30.15122' where district='QUTHING' and council='Mphaki Council' and village='Ha Mokoena';


update gii_hierarchy as gh set gh.lat='28.161025', gh.long='-30.149894' where district='QUTHING' and council='Mphaki Council' and village='Ha Moifo';
update gii_hierarchy as gh set gh.lat='28.159007', gh.long='-30.157097' where district='QUTHING' and council='Mphaki Council' and village='Ha Motau';
update gii_hierarchy as gh set gh.lat='28.169075', gh.long='-30.14134' where district='QUTHING' and council='Mphaki Council' and village='Ha Pitso';
update gii_hierarchy as gh set gh.lat='28.192472', gh.long='-30.174325' where district='QUTHING' and council='Mphaki Council' and village='Ha Setsena';
update gii_hierarchy as gh set gh.lat='28.205755', gh.long='-30.166899' where district='QUTHING' and council='Mphaki Council' and village='Matsoareng';
update gii_hierarchy as gh set gh.lat='28.220413', gh.long='-30.150483' where district='QUTHING' and council='Mphaki Council' and village='Ha Nthunya';

update gii_hierarchy as gh set gh.lat='28.211009', gh.long='-30.144817' where district='QUTHING' and council='Mphaki Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='28.249417', gh.long='-30.171726' where district='QUTHING' and council='Mphaki Council' and village='Ha Thaha';
update gii_hierarchy as gh set gh.lat='28.217561', gh.long='-30.177125' where district='QUTHING' and council='Mphaki Council' and village='Ha Tsoene';


update gii_hierarchy as gh set gh.lat='28.235406', gh.long='-30.145133' where district='QUTHING' and council='Mphaki Council' and village='Ha Moreba';





update gii_hierarchy as gh set gh.lat='28.287018', gh.long='-30.200593' where district='QUTHING' and council='Mphaki Council' and village='Mahlachaneng';
update gii_hierarchy as gh set gh.lat='27.759784', gh.long='-30.434521' where district='QUTHING' and council='Mphaki Council' and village='Ha Mohapi';


update gii_hierarchy as gh set gh.lat='28.288973', gh.long='-30.209281' where district='QUTHING' and council='Mphaki Council' and village='Selomong';
update gii_hierarchy as gh set gh.lat='28.203628', gh.long='-30.19805' where district='QUTHING' and council='Mphaki Council' and village='Ha Rasepelemane';



update gii_hierarchy as gh set gh.lat='28.163789', gh.long='-30.196179' where district='QUTHING' and council='Mphaki Council' and village='Ha Mahlomola';
update gii_hierarchy as gh set gh.lat='28.171322', gh.long='-30.187093' where district='QUTHING' and council='Mphaki Council' and village='Ha Masenkane';
update gii_hierarchy as gh set gh.lat='28.17316', gh.long='-30.162159' where district='QUTHING' and council='Mphaki Council' and village='Ha Pali';
update gii_hierarchy as gh set gh.lat='28.171229', gh.long='-30.177275' where district='QUTHING' and council='Mphaki Council' and village='Ha Ramosetsanyane';


update gii_hierarchy as gh set gh.lat='28.197849', gh.long='-30.215576' where district='QUTHING' and council='Mphaki Council' and village='Ha Kelebone';
update gii_hierarchy as gh set gh.lat='28.187394', gh.long='-30.226658' where district='QUTHING' and council='Mphaki Council' and village='Ha Pheello';

update gii_hierarchy as gh set gh.lat='28.22137', gh.long='-30.240767' where district='QUTHING' and council='Mphaki Council' and village='Ha Moloki';
update gii_hierarchy as gh set gh.lat='28.209104', gh.long='-30.234057' where district='QUTHING' and council='Mphaki Council' and village='Ha Peterose';
update gii_hierarchy as gh set gh.lat='28.21716', gh.long='-30.223079' where district='QUTHING' and council='Mphaki Council' and village='Rothe';
update gii_hierarchy as gh set gh.lat='28.023333', gh.long='-30.225508' where district='QUTHING' and council='Mphaki Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='27.988561', gh.long='-30.448635' where district='QUTHING' and council='Mphaki Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='27.616794', gh.long='-30.372965' where district='QUTHING' and council='Mphaki Council' and village='Ha Maruping';
update gii_hierarchy as gh set gh.lat='28.169343', gh.long='-30.210404' where district='QUTHING' and council='Mphaki Council' and village='Ha Tokelo';
update gii_hierarchy as gh set gh.lat='28.132772', gh.long='-30.212416' where district='QUTHING' and council='Mphaki Council' and village='Borokoana';
update gii_hierarchy as gh set gh.lat='28.141236', gh.long='-30.234211' where district='QUTHING' and council='Mphaki Council' and village='Ha Khethisa';
update gii_hierarchy as gh set gh.lat='28.13222', gh.long='-30.227355' where district='QUTHING' and council='Mphaki Council' and village='Ha Mantsoinyana';
update gii_hierarchy as gh set gh.lat='28.095083', gh.long='-30.220099' where district='QUTHING' and council='Mphaki Council' and village='Ha Makatikele';


update gii_hierarchy as gh set gh.lat='28.081648', gh.long='-30.245505' where district='QUTHING' and council='Mphaki Council' and village='Ha Kooko';
update gii_hierarchy as gh set gh.lat='28.074463', gh.long='-30.239043' where district='QUTHING' and council='Mphaki Council' and village='Ha Tsenki';

update gii_hierarchy as gh set gh.lat='28.037379', gh.long='-30.242727' where district='QUTHING' and council='Mphaki Council' and village='Ha Binare';
update gii_hierarchy as gh set gh.lat='28.050073', gh.long='-30.239454' where district='QUTHING' and council='Mphaki Council' and village='Ha Motsiri';
update gii_hierarchy as gh set gh.lat='28.05791', gh.long='-30.249049' where district='QUTHING' and council='Mphaki Council' and village='Ha Rafabia';
update gii_hierarchy as gh set gh.lat='28.143875', gh.long='-30.244448' where district='QUTHING' and council='Mphaki Council' and village='Ha Sebota';
update gii_hierarchy as gh set gh.lat='28.105262', gh.long='-30.262779' where district='QUTHING' and council='Mphaki Council' and village='Khakeng';


update gii_hierarchy as gh set gh.lat='28.143135', gh.long='-30.19654' where district='QUTHING' and council='Mphaki Council' and village='Makhalong';

update gii_hierarchy as gh set gh.lat='27.811374', gh.long='-30.349839' where district='QUTHING' and council='Mphaki Council' and village='Tsieng';
update gii_hierarchy as gh set gh.lat='28.297707', gh.long='-30.055045' where district='QUTHING' and council='Seforong Council' and village='Ha Ramoroba';
update gii_hierarchy as gh set gh.lat='27.630892', gh.long='-30.490616' where district='QUTHING' and council='Seforong Council' and village='Motse Mocha';
update gii_hierarchy as gh set gh.lat='28.281191', gh.long='-30.050684' where district='QUTHING' and council='Seforong Council' and village='Ha Mosi';
update gii_hierarchy as gh set gh.lat='28.266332', gh.long='-30.04514' where district='QUTHING' and council='Seforong Council' and village='Lichecheng';
update gii_hierarchy as gh set gh.lat='27.617044', gh.long='-30.368754' where district='QUTHING' and council='Seforong Council' and village='Aupolasi';



update gii_hierarchy as gh set gh.lat='28.227547', gh.long='-30.048764' where district='QUTHING' and council='Seforong Council' and village='Ha Nkati';
update gii_hierarchy as gh set gh.lat='28.241774', gh.long='-30.049906' where district='QUTHING' and council='Seforong Council' and village='Ha Sekoati';

update gii_hierarchy as gh set gh.lat='28.198914', gh.long='-30.062919' where district='QUTHING' and council='Seforong Council' and village='Ha Motiki';
update gii_hierarchy as gh set gh.lat='28.213403', gh.long='-30.053538' where district='QUTHING' and council='Seforong Council' and village='Phocha';
update gii_hierarchy as gh set gh.lat='28.164593', gh.long='-30.041651' where district='QUTHING' and council='Seforong Council' and village='Ha Monoto';
update gii_hierarchy as gh set gh.lat='28.182199', gh.long='-30.066826' where district='QUTHING' and council='Seforong Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='28.177155', gh.long='-30.056437' where district='QUTHING' and council='Seforong Council' and village='Makhetheng';
update gii_hierarchy as gh set gh.lat='28.164499', gh.long='-30.070648' where district='QUTHING' and council='Seforong Council' and village='Sehlabaneng';
update gii_hierarchy as gh set gh.lat='28.143479', gh.long='-30.063656' where district='QUTHING' and council='Seforong Council' and village='Ha Mankata';


update gii_hierarchy as gh set gh.lat='28.169717', gh.long='-30.09051' where district='QUTHING' and council='Seforong Council' and village='Thaba Chitja';
update gii_hierarchy as gh set gh.lat='28.220903', gh.long='-30.074369' where district='QUTHING' and council='Seforong Council' and village='Ha Teleka';
update gii_hierarchy as gh set gh.lat='28.211943', gh.long='-30.088979' where district='QUTHING' and council='Seforong Council' and village='Mabeleteng';



update gii_hierarchy as gh set gh.lat='28.219119', gh.long='-30.100707' where district='QUTHING' and council='Seforong Council' and village='Ha Masupha';

update gii_hierarchy as gh set gh.lat='28.190632', gh.long='-30.105013' where district='QUTHING' and council='Seforong Council' and village='Ha Sello';
update gii_hierarchy as gh set gh.lat='27.864942', gh.long='-30.378212' where district='QUTHING' and council='Seforong Council' and village='Sekoaing';
update gii_hierarchy as gh set gh.lat='28.189383', gh.long='-30.123991' where district='QUTHING' and council='Seforong Council' and village='Ha Maime';

update gii_hierarchy as gh set gh.lat='28.177166', gh.long='-30.119582' where district='QUTHING' and council='Seforong Council' and village='Ha Monese';






update gii_hierarchy as gh set gh.lat='28.149586', gh.long='-30.127955' where district='QUTHING' and council='Seforong Council' and village='Ha Filane';

update gii_hierarchy as gh set gh.lat='28.162309', gh.long='-30.135674' where district='QUTHING' and council='Seforong Council' and village='Ha Polaki';

update gii_hierarchy as gh set gh.lat='28.149018', gh.long='-30.139088' where district='QUTHING' and council='Seforong Council' and village='Ha Tibisi';

update gii_hierarchy as gh set gh.lat='28.158232', gh.long='-30.096142' where district='QUTHING' and council='Seforong Council' and village='Ha Seqotomela';
update gii_hierarchy as gh set gh.lat='28.144308', gh.long='-30.105142' where district='QUTHING' and council='Seforong Council' and village='Malosong';
update gii_hierarchy as gh set gh.lat='28.105751', gh.long='-30.091886' where district='QUTHING' and council='Seforong Council' and village='Ha Mabusetsa';
update gii_hierarchy as gh set gh.lat='28.121388', gh.long='-30.104625' where district='QUTHING' and council='Seforong Council' and village='Ha Sekilane';
update gii_hierarchy as gh set gh.lat='28.12253', gh.long='-30.093492' where district='QUTHING' and council='Seforong Council' and village='Kamora Thaba';
update gii_hierarchy as gh set gh.lat='27.808324', gh.long='-30.32566' where district='QUTHING' and council='Seforong Council' and village='Pontseng';


update gii_hierarchy as gh set gh.lat='28.090091', gh.long='-30.106103' where district='QUTHING' and council='Seforong Council' and village='Ha Ratsitso';
update gii_hierarchy as gh set gh.lat='28.08823', gh.long='-30.081096' where district='QUTHING' and council='Seforong Council' and village='Ha Shao';
update gii_hierarchy as gh set gh.lat='28.080641', gh.long='-30.096836' where district='QUTHING' and council='Seforong Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.115499', gh.long='-30.13101' where district='QUTHING' and council='Seforong Council' and village='Ha Motebang';
update gii_hierarchy as gh set gh.lat='28.099606', gh.long='-30.11986' where district='QUTHING' and council='Seforong Council' and village='Ha Motsoane';
update gii_hierarchy as gh set gh.lat='28.166844', gh.long='-30.112109' where district='QUTHING' and council='Seforong Council' and village='Ha Potso';
update gii_hierarchy as gh set gh.lat='28.130471', gh.long='-30.125916' where district='QUTHING' and council='Seforong Council' and village='Ha Tsita';

update gii_hierarchy as gh set gh.lat='28.115281', gh.long='-30.156436' where district='QUTHING' and council='Seforong Council' and village='Ha Lesholu';
update gii_hierarchy as gh set gh.lat='28.089218', gh.long='-30.158916' where district='QUTHING' and council='Seforong Council' and village='Sekokoaneng';

update gii_hierarchy as gh set gh.lat='28.073162', gh.long='-30.138262' where district='QUTHING' and council='Seforong Council' and village='Ha Kokoropo';
update gii_hierarchy as gh set gh.lat='28.081461', gh.long='-30.152882' where district='QUTHING' and council='Seforong Council' and village='Ha Ngoae';
update gii_hierarchy as gh set gh.lat='27.871578', gh.long='-30.372893' where district='QUTHING' and council='Seforong Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.066496', gh.long='-30.140603' where district='QUTHING' and council='Seforong Council' and village='Letsoapong';
update gii_hierarchy as gh set gh.lat='28.241682', gh.long='-29.807582' where district='THABA TSEKA' and council='Malehloana Council' and village='Lihlephehlepheng';
update gii_hierarchy as gh set gh.lat='28.172033', gh.long='-29.494285' where district='THABA TSEKA' and council='Malehloana Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='28.213011', gh.long='-29.757008' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Motsoanakaba';
update gii_hierarchy as gh set gh.lat='28.249488', gh.long='-29.763409' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Thaane';
update gii_hierarchy as gh set gh.lat='28.238009', gh.long='-29.763557' where district='THABA TSEKA' and council='Malehloana Council' and village='Matamong';
update gii_hierarchy as gh set gh.lat='28.236779', gh.long='-29.776204' where district='THABA TSEKA' and council='Malehloana Council' and village='Thabang';
update gii_hierarchy as gh set gh.lat='28.235463', gh.long='-29.734825' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Lephaila';
update gii_hierarchy as gh set gh.lat='28.22886', gh.long='-29.746723' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Ralebetlana';
update gii_hierarchy as gh set gh.lat='28.249241', gh.long='-29.739784' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Sekoeta';
update gii_hierarchy as gh set gh.lat='28.201746', gh.long='-29.735582' where district='THABA TSEKA' and council='Malehloana Council' and village='Koma Koma';
update gii_hierarchy as gh set gh.lat='28.232546', gh.long='-29.738386' where district='THABA TSEKA' and council='Malehloana Council' and village='Letlapeng';

update gii_hierarchy as gh set gh.lat='28.279475', gh.long='-29.641779' where district='THABA TSEKA' and council='Malehloana Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.236822', gh.long='-29.717867' where district='THABA TSEKA' and council='Malehloana Council' and village='Nthabeleng';
update gii_hierarchy as gh set gh.lat='28.23592', gh.long='-29.723385' where district='THABA TSEKA' and council='Malehloana Council' and village='Tlhakoaneng';

update gii_hierarchy as gh set gh.lat='28.224671', gh.long='-29.701363' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Ntintana';
update gii_hierarchy as gh set gh.lat='28.209548', gh.long='-29.683956' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Oropeng';
update gii_hierarchy as gh set gh.lat='28.253397', gh.long='-29.708985' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Ramosebo';
update gii_hierarchy as gh set gh.lat='28.227375', gh.long='-29.697099' where district='THABA TSEKA' and council='Malehloana Council' and village='Likoung';
update gii_hierarchy as gh set gh.lat='28.675332', gh.long='-29.358611' where district='THABA TSEKA' and council='Malehloana Council' and village='Manganeng';




update gii_hierarchy as gh set gh.lat='28.214668', gh.long='-29.678687' where district='THABA TSEKA' and council='Malehloana Council' and village='Malothoaneng';
update gii_hierarchy as gh set gh.lat='28.217876', gh.long='-29.696761' where district='THABA TSEKA' and council='Malehloana Council' and village='Mangaung';

update gii_hierarchy as gh set gh.lat='28.205144', gh.long='-29.631723' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Fantisi';
update gii_hierarchy as gh set gh.lat='28.190954', gh.long='-29.618137' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Felete';
update gii_hierarchy as gh set gh.lat='28.201853', gh.long='-29.6523' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Khohlopo';

update gii_hierarchy as gh set gh.lat='28.1946', gh.long='-29.649449' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Thejane';
update gii_hierarchy as gh set gh.lat='28.19066', gh.long='-29.640133' where district='THABA TSEKA' and council='Malehloana Council' and village='Sebothoane';
update gii_hierarchy as gh set gh.lat='28.180809', gh.long='-29.637518' where district='THABA TSEKA' and council='Malehloana Council' and village='Teletsana';
update gii_hierarchy as gh set gh.lat='28.240018', gh.long='-29.622831' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Ntaote';
update gii_hierarchy as gh set gh.lat='28.244786', gh.long='-29.649164' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Qhala';

update gii_hierarchy as gh set gh.lat='28.220639', gh.long='-29.62204' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Sootho';
update gii_hierarchy as gh set gh.lat='28.222052', gh.long='-29.611011' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Takane';
update gii_hierarchy as gh set gh.lat='28.223981', gh.long='-29.650793' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Tlali';
update gii_hierarchy as gh set gh.lat='28.209166', gh.long='-29.595182' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Janrase';
update gii_hierarchy as gh set gh.lat='28.213093', gh.long='-29.58515' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Seqhoe';
update gii_hierarchy as gh set gh.lat='28.364978', gh.long='-29.791557' where district='THABA TSEKA' and council='Malehloana Council' and village='Makhalong';
update gii_hierarchy as gh set gh.lat='28.19576', gh.long='-29.59667' where district='THABA TSEKA' and council='Malehloana Council' and village='Matomaneng';
update gii_hierarchy as gh set gh.lat='28.221532', gh.long='-29.544652' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Cheche';
update gii_hierarchy as gh set gh.lat='28.202254', gh.long='-29.555382' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Labane';

update gii_hierarchy as gh set gh.lat='28.213815', gh.long='-29.555208' where district='THABA TSEKA' and council='Malehloana Council' and village='Meeling';
update gii_hierarchy as gh set gh.lat='28.187425', gh.long='-29.55187' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Mpate';
update gii_hierarchy as gh set gh.lat='28.166893', gh.long='-29.558517' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Noha';
update gii_hierarchy as gh set gh.lat='28.153645', gh.long='-29.552405' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Tsitso';
update gii_hierarchy as gh set gh.lat='28.182887', gh.long='-29.526877' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Makopoi';
update gii_hierarchy as gh set gh.lat='28.161435', gh.long='-29.521427' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Sepokane';
update gii_hierarchy as gh set gh.lat='28.188171', gh.long='-29.539921' where district='THABA TSEKA' and council='Malehloana Council' and village='Kholokoe';
update gii_hierarchy as gh set gh.lat='28.215435', gh.long='-29.525601' where district='THABA TSEKA' and council='Malehloana Council' and village='Lefikaneng';
update gii_hierarchy as gh set gh.lat='28.191988', gh.long='-29.531281' where district='THABA TSEKA' and council='Malehloana Council' and village='Tholang';




update gii_hierarchy as gh set gh.lat='28.183622', gh.long='-29.503514' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Matlotlo';
update gii_hierarchy as gh set gh.lat='28.167855', gh.long='-29.51032' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Setena';
update gii_hierarchy as gh set gh.lat='28.224554', gh.long='-29.504898' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Apili';
update gii_hierarchy as gh set gh.lat='28.196308', gh.long='-29.507787' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Moriana';


update gii_hierarchy as gh set gh.lat='28.145481', gh.long='-29.501644' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Mariti';
update gii_hierarchy as gh set gh.lat='28.19658', gh.long='-29.476521' where district='THABA TSEKA' and council='Malehloana Council' and village='Pitseng';
update gii_hierarchy as gh set gh.lat='28.153938', gh.long='-29.474849' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Matlabathe';
update gii_hierarchy as gh set gh.lat='28.166525', gh.long='-29.482541' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Mohale';
update gii_hierarchy as gh set gh.lat='28.133325', gh.long='-29.471265' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Mokeke';
update gii_hierarchy as gh set gh.lat='28.140015', gh.long='-29.481937' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Mpuoe';
update gii_hierarchy as gh set gh.lat='28.362871', gh.long='-29.673414' where district='THABA TSEKA' and council='Malehloana Council' and village='Sefateng';

update gii_hierarchy as gh set gh.lat='28.312409', gh.long='-29.793174' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Tsiu';

update gii_hierarchy as gh set gh.lat='28.127771', gh.long='-29.465906' where district='THABA TSEKA' and council='Malehloana Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.127773', gh.long='-29.427249' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Koporale';
update gii_hierarchy as gh set gh.lat='28.233948', gh.long='-29.327115' where district='THABA TSEKA' and council='Malehloana Council' and village='Letsatseng';
update gii_hierarchy as gh set gh.lat='28.129658', gh.long='-29.421093' where district='THABA TSEKA' and council='Malehloana Council' and village='Ha Rantsatsi';
update gii_hierarchy as gh set gh.lat='28.405039', gh.long='-29.717511' where district='THABA TSEKA' and council='Malehloana Council' and village='Khamolane';
update gii_hierarchy as gh set gh.lat='28.149492', gh.long='-29.402728' where district='THABA TSEKA' and council='Malehloana Council' and village='Masaleng';

update gii_hierarchy as gh set gh.lat='28.197589', gh.long='-29.368003' where district='THABA TSEKA' and council='Malehloana Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.267558', gh.long='-29.289175' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Jimi';
update gii_hierarchy as gh set gh.lat='28.298187', gh.long='-29.260874' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Makeleme';
update gii_hierarchy as gh set gh.lat='28.293258', gh.long='-29.251473' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Motsoari';

update gii_hierarchy as gh set gh.lat='28.256342', gh.long='-29.300586' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Ratsosane';


update gii_hierarchy as gh set gh.lat='28.205713', gh.long='-29.337681' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Koenyama';

update gii_hierarchy as gh set gh.lat='28.216876', gh.long='-29.351332' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Ntake';
update gii_hierarchy as gh set gh.lat='28.260639', gh.long='-29.367113' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Sekola';
update gii_hierarchy as gh set gh.lat='28.228699', gh.long='-29.353644' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Thabure';
update gii_hierarchy as gh set gh.lat='28.689873', gh.long='-29.362925' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.69495', gh.long='-29.439451' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='28.279475', gh.long='-29.641779' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.201628', gh.long='-29.357139' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Matlakeng';
update gii_hierarchy as gh set gh.lat='28.225949', gh.long='-29.345084' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Moeaneng';
update gii_hierarchy as gh set gh.lat='28.223252', gh.long='-29.326623' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Phuleng';

update gii_hierarchy as gh set gh.lat='28.266314', gh.long='-29.552092' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Tiping';

update gii_hierarchy as gh set gh.lat='28.185251', gh.long='-29.370008' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Kokolia';

update gii_hierarchy as gh set gh.lat='28.658997', gh.long='-29.241956' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Sekolopata';
update gii_hierarchy as gh set gh.lat='28.215137', gh.long='-29.381225' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='28.261598', gh.long='-29.474969' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Malebese';




update gii_hierarchy as gh set gh.lat='28.296868', gh.long='-29.500392' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Mokotane';
update gii_hierarchy as gh set gh.lat='28.303674', gh.long='-29.487829' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Sehaula';
update gii_hierarchy as gh set gh.lat='28.299962', gh.long='-29.482147' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Seipalle';
update gii_hierarchy as gh set gh.lat='28.326593', gh.long='-29.515656' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Letuka';
update gii_hierarchy as gh set gh.lat='28.320462', gh.long='-29.505946' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Rothe';
update gii_hierarchy as gh set gh.lat='28.293084', gh.long='-29.53465' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Ntsokoane';
update gii_hierarchy as gh set gh.lat='28.313466', gh.long='-29.515476' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='28.293544', gh.long='-29.514766' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Leronti';


update gii_hierarchy as gh set gh.lat='28.232546', gh.long='-29.738386' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.260367', gh.long='-29.494257' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Liphokoaneng';
update gii_hierarchy as gh set gh.lat='28.238641', gh.long='-29.492112' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Liponchong';
update gii_hierarchy as gh set gh.lat='28.256504', gh.long='-29.4951' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Mocheng';


update gii_hierarchy as gh set gh.lat='28.245788', gh.long='-29.527294' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Lihloaeleng';
update gii_hierarchy as gh set gh.lat='28.256883', gh.long='-29.525812' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Muso';
update gii_hierarchy as gh set gh.lat='28.271743', gh.long='-29.527021' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Toka';

update gii_hierarchy as gh set gh.lat='28.172033', gh.long='-29.494285' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Aupolasi';

update gii_hierarchy as gh set gh.lat='28.284345', gh.long='-29.550971' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Chooko';
update gii_hierarchy as gh set gh.lat='28.283868', gh.long='-29.537133' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Tlapa Letsotso';
update gii_hierarchy as gh set gh.lat='28.268856', gh.long='-29.550062' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ntsirele';
update gii_hierarchy as gh set gh.lat='28.2487', gh.long='-29.53827' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Rankomo';
update gii_hierarchy as gh set gh.lat='28.24825', gh.long='-29.555327' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Mahlong';
update gii_hierarchy as gh set gh.lat='28.269761', gh.long='-29.556865' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Lilomong';
update gii_hierarchy as gh set gh.lat='28.258456', gh.long='-29.576807' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Sepiriti';
update gii_hierarchy as gh set gh.lat='28.244166', gh.long='-29.571269' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Linareng';
update gii_hierarchy as gh set gh.lat='28.239451', gh.long='-29.579255' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Nyane';
update gii_hierarchy as gh set gh.lat='28.227833', gh.long='-29.57993' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Taole';
update gii_hierarchy as gh set gh.lat='28.228187', gh.long='-29.591366' where district='THABA TSEKA' and council='Mphe Lebeko Council' and village='Ha Thabo';

update gii_hierarchy as gh set gh.lat='28.353026', gh.long='-29.206326' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Mahooana';
update gii_hierarchy as gh set gh.lat='28.376786', gh.long='-29.271317' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Makhangoa';


update gii_hierarchy as gh set gh.lat='28.363568', gh.long='-29.25403' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Mokati';





update gii_hierarchy as gh set gh.lat='28.385768', gh.long='-29.326536' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Mantsi';
update gii_hierarchy as gh set gh.lat='28.376043', gh.long='-29.332245' where district='THABA TSEKA' and council='Bokong Council' and village='Letsatseng';

update gii_hierarchy as gh set gh.lat='28.397613', gh.long='-29.31837' where district='THABA TSEKA' and council='Bokong Council' and village='Thabaneng';
update gii_hierarchy as gh set gh.lat='28.394737', gh.long='-29.366275' where district='THABA TSEKA' and council='Bokong Council' and village='Fukhumela';

update gii_hierarchy as gh set gh.lat='28.398634', gh.long='-29.348319' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Mafosa';
update gii_hierarchy as gh set gh.lat='28.406937', gh.long='-29.359084' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Makhona';
update gii_hierarchy as gh set gh.lat='28.397309', gh.long='-29.35209' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Nkhunyane';
update gii_hierarchy as gh set gh.lat='28.400755', gh.long='-29.376062' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Ramarebotse';
update gii_hierarchy as gh set gh.lat='28.403037', gh.long='-29.32954' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Rampai';

update gii_hierarchy as gh set gh.lat='28.45059', gh.long='-29.331752' where district='THABA TSEKA' and council='Bokong Council' and village='Sephareng';
update gii_hierarchy as gh set gh.lat='28.45404', gh.long='-29.346873' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Khunong';
update gii_hierarchy as gh set gh.lat='28.450267', gh.long='-29.354738' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Maphike';
update gii_hierarchy as gh set gh.lat='28.462922', gh.long='-29.340671' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Khenene';
update gii_hierarchy as gh set gh.lat='28.470623', gh.long='-29.358269' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Ramokoatsi';
update gii_hierarchy as gh set gh.lat='28.486785', gh.long='-29.345951' where district='THABA TSEKA' and council='Bokong Council' and village='Khokhoba';
update gii_hierarchy as gh set gh.lat='28.480925', gh.long='-29.332633' where district='THABA TSEKA' and council='Bokong Council' and village='Katse Village';

update gii_hierarchy as gh set gh.lat='28.502597', gh.long='-29.35372' where district='THABA TSEKA' and council='Bokong Council' and village='Makhoabeng';
update gii_hierarchy as gh set gh.lat='28.475404', gh.long='-29.37338' where district='THABA TSEKA' and council='Bokong Council' and village='Chaena';
update gii_hierarchy as gh set gh.lat='28.484726', gh.long='-29.388909' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Mothepu';
update gii_hierarchy as gh set gh.lat='28.258456', gh.long='-29.576807' where district='THABA TSEKA' and council='Bokong Council' and village='Ha Sepiriti';

update gii_hierarchy as gh set gh.lat='28.480961', gh.long='-29.381768' where district='THABA TSEKA' and council='Bokong Council' and village='Linkoaneng';

update gii_hierarchy as gh set gh.lat='28.27198', gh.long='-29.595573' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mateu';
update gii_hierarchy as gh set gh.lat='28.274924', gh.long='-29.590016' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Molupe';
update gii_hierarchy as gh set gh.lat='28.279475', gh.long='-29.641779' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Matebeleng';
update gii_hierarchy as gh set gh.lat='28.197589', gh.long='-29.368003' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Khubetsoana';
update gii_hierarchy as gh set gh.lat='28.263371', gh.long='-29.623993' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mafa';
update gii_hierarchy as gh set gh.lat='28.269584', gh.long='-29.616666' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Moketane';
update gii_hierarchy as gh set gh.lat='28.314462', gh.long='-29.480772' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Khohlong';
update gii_hierarchy as gh set gh.lat='28.264432', gh.long='-29.647112' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Nthoana';


update gii_hierarchy as gh set gh.lat='28.271283', gh.long='-29.661923' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Khutlang';
update gii_hierarchy as gh set gh.lat='28.252163', gh.long='-29.640856' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='28.254167', gh.long='-29.647072' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Makoetjaneng';


update gii_hierarchy as gh set gh.lat='28.294176', gh.long='-29.701663' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Sekharume';
update gii_hierarchy as gh set gh.lat='28.285477', gh.long='-29.694056' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Tsoarelo';

update gii_hierarchy as gh set gh.lat='28.273511', gh.long='-29.704423' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Macheseng';

update gii_hierarchy as gh set gh.lat='28.313123', gh.long='-29.696489' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Shoella';
update gii_hierarchy as gh set gh.lat='28.319814', gh.long='-29.685242' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Bothoba Pelo';
update gii_hierarchy as gh set gh.lat='28.350697', gh.long='-29.688909' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Fisane';
update gii_hierarchy as gh set gh.lat='28.349437', gh.long='-29.707262' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Khomari';
update gii_hierarchy as gh set gh.lat='28.349933', gh.long='-29.696885' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Sehlahla';
update gii_hierarchy as gh set gh.lat='28.675332', gh.long='-29.358611' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.362871', gh.long='-29.673414' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Sefateng';
update gii_hierarchy as gh set gh.lat='28.296279', gh.long='-29.524399' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.372845', gh.long='-29.707892' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Lali';
update gii_hierarchy as gh set gh.lat='28.390665', gh.long='-29.714059' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mosa';
update gii_hierarchy as gh set gh.lat='28.254602', gh.long='-29.82704' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Motsiba';

update gii_hierarchy as gh set gh.lat='28.366177', gh.long='-29.719501' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Nyolo';
update gii_hierarchy as gh set gh.lat='28.405039', gh.long='-29.717511' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Khamolane';
update gii_hierarchy as gh set gh.lat='28.362495', gh.long='-29.700399' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Makhausing';
update gii_hierarchy as gh set gh.lat='28.363366', gh.long='-29.704427' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Mapetleng';
update gii_hierarchy as gh set gh.lat='28.326795', gh.long='-29.735428' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mosiroe';
update gii_hierarchy as gh set gh.lat='28.321822', gh.long='-29.742372' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Ngope';
update gii_hierarchy as gh set gh.lat='28.343016', gh.long='-29.722291' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Phefo';
update gii_hierarchy as gh set gh.lat='28.275801', gh.long='-29.671236' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Poho';
update gii_hierarchy as gh set gh.lat='28.232546', gh.long='-29.738386' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Letlapeng';
update gii_hierarchy as gh set gh.lat='28.344689', gh.long='-29.735601' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Phororong';

update gii_hierarchy as gh set gh.lat='28.300183', gh.long='-29.711658' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mokebisa';
update gii_hierarchy as gh set gh.lat='28.280436', gh.long='-29.736497' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Tjako';

update gii_hierarchy as gh set gh.lat='28.262294', gh.long='-29.779152' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Lethibella';
update gii_hierarchy as gh set gh.lat='28.291679', gh.long='-29.762898' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Matsosa';
update gii_hierarchy as gh set gh.lat='28.259792', gh.long='-29.72661' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mokhoro';

update gii_hierarchy as gh set gh.lat='28.267553', gh.long='-29.730574' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Sehlabeng sa hae';
update gii_hierarchy as gh set gh.lat='28.425694', gh.long='-29.665101' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Thoteng';

update gii_hierarchy as gh set gh.lat='28.346442', gh.long='-29.795957' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Makara';
update gii_hierarchy as gh set gh.lat='28.307853', gh.long='-29.77422' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mokhafi';
update gii_hierarchy as gh set gh.lat='28.297317', gh.long='-29.783566' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Mokone';

update gii_hierarchy as gh set gh.lat='28.325418', gh.long='-29.764629' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Rahlabi';
update gii_hierarchy as gh set gh.lat='28.352047', gh.long='-29.801325' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Ha Thebane';

update gii_hierarchy as gh set gh.lat='28.187126', gh.long='-29.686004' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Khatleng';
update gii_hierarchy as gh set gh.lat='28.337593', gh.long='-29.796189' where district='THABA TSEKA' and council='Thaba Kholo Council' and village='Rolong';




update gii_hierarchy as gh set gh.lat='28.507678', gh.long='-29.681477' where district='THABA TSEKA' and council='Lesobeng Council' and village='Boinyatso';

update gii_hierarchy as gh set gh.lat='28.494112', gh.long='-29.674754' where district='THABA TSEKA' and council='Lesobeng Council' and village='Khorosaneng';


update gii_hierarchy as gh set gh.lat='28.518932', gh.long='-29.70001' where district='THABA TSEKA' and council='Lesobeng Council' and village='Makanyaneng';
update gii_hierarchy as gh set gh.lat='28.47932', gh.long='-29.700936' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Maseru';
update gii_hierarchy as gh set gh.lat='28.496849', gh.long='-29.693675' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Phalole';
update gii_hierarchy as gh set gh.lat='28.499908', gh.long='-29.704045' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Tebeli';

update gii_hierarchy as gh set gh.lat='28.495508', gh.long='-29.716876' where district='THABA TSEKA' and council='Lesobeng Council' and village='Tsekong';

update gii_hierarchy as gh set gh.lat='28.465599', gh.long='-29.702821' where district='THABA TSEKA' and council='Lesobeng Council' and village='Bareng';

update gii_hierarchy as gh set gh.lat='28.474904', gh.long='-29.694061' where district='THABA TSEKA' and council='Lesobeng Council' and village='Malimong';

update gii_hierarchy as gh set gh.lat='28.402773', gh.long='-29.672393' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Nokoane';


update gii_hierarchy as gh set gh.lat='28.391351', gh.long='-29.692527' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Letsika';
update gii_hierarchy as gh set gh.lat='28.401339', gh.long='-29.693393' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Mabilikoe';

update gii_hierarchy as gh set gh.lat='28.422884', gh.long='-29.714742' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Lephoi';


update gii_hierarchy as gh set gh.lat='28.440627', gh.long='-29.702659' where district='THABA TSEKA' and council='Lesobeng Council' and village='Khauoaneng';
update gii_hierarchy as gh set gh.lat='28.45991', gh.long='-29.695032' where district='THABA TSEKA' and council='Lesobeng Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='28.127771', gh.long='-29.465906' where district='THABA TSEKA' and council='Lesobeng Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.189058', gh.long='-29.623656' where district='THABA TSEKA' and council='Lesobeng Council' and village='Thepung';
update gii_hierarchy as gh set gh.lat='28.23592', gh.long='-29.723385' where district='THABA TSEKA' and council='Lesobeng Council' and village='Tlhakoaneng';


update gii_hierarchy as gh set gh.lat='28.197589', gh.long='-29.368003' where district='THABA TSEKA' and council='Lesobeng Council' and village='Khubetsoana';

update gii_hierarchy as gh set gh.lat='28.682553', gh.long='-29.353177' where district='THABA TSEKA' and council='Lesobeng Council' and village='Pontseng';

update gii_hierarchy as gh set gh.lat='28.268856', gh.long='-29.550062' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ntsirele';




update gii_hierarchy as gh set gh.lat='28.4144', gh.long='-29.719417' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Marumo';




update gii_hierarchy as gh set gh.lat='28.439879', gh.long='-29.773282' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Sephooko';

update gii_hierarchy as gh set gh.lat='28.401386', gh.long='-29.734072' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Khopiso';
update gii_hierarchy as gh set gh.lat='28.406233', gh.long='-29.757979' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Ralisale';
update gii_hierarchy as gh set gh.lat='28.233948', gh.long='-29.327115' where district='THABA TSEKA' and council='Lesobeng Council' and village='Letsatseng';

update gii_hierarchy as gh set gh.lat='28.373574', gh.long='-29.760691' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Motseki';
update gii_hierarchy as gh set gh.lat='28.379726', gh.long='-29.762977' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Ramajalle';
update gii_hierarchy as gh set gh.lat='28.394832', gh.long='-29.758414' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Tsanyane';
update gii_hierarchy as gh set gh.lat='28.296279', gh.long='-29.524399' where district='THABA TSEKA' and council='Lesobeng Council' and village='Taung';

update gii_hierarchy as gh set gh.lat='28.359098', gh.long='-29.757345' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Kokoana';

update gii_hierarchy as gh set gh.lat='28.364978', gh.long='-29.791557' where district='THABA TSEKA' and council='Lesobeng Council' and village='Makhalong';


update gii_hierarchy as gh set gh.lat='28.188171', gh.long='-29.539921' where district='THABA TSEKA' and council='Lesobeng Council' and village='Kholokoe';
update gii_hierarchy as gh set gh.lat='28.394286', gh.long='-29.780473' where district='THABA TSEKA' and council='Lesobeng Council' and village='Mantsaneng';




update gii_hierarchy as gh set gh.lat='28.363033', gh.long='-29.833133' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Janefeke';
update gii_hierarchy as gh set gh.lat='28.373519', gh.long='-29.829927' where district='THABA TSEKA' and council='Lesobeng Council' and village='Leribe';
update gii_hierarchy as gh set gh.lat='28.360094', gh.long='-29.865386' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Tokota';
update gii_hierarchy as gh set gh.lat='28.352215', gh.long='-29.854063' where district='THABA TSEKA' and council='Lesobeng Council' and village='Makoaeleng';
update gii_hierarchy as gh set gh.lat='28.335976', gh.long='-29.860594' where district='THABA TSEKA' and council='Lesobeng Council' and village='Topa';
update gii_hierarchy as gh set gh.lat='28.301692', gh.long='-29.869081' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Mojela';
update gii_hierarchy as gh set gh.lat='28.263643', gh.long='-29.860361' where district='THABA TSEKA' and council='Lesobeng Council' and village='Ha Molofotsane';

update gii_hierarchy as gh set gh.lat='28.567114', gh.long='-29.459745' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Patisi';
update gii_hierarchy as gh set gh.lat='28.605906', gh.long='-29.466785' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Rasebate';

update gii_hierarchy as gh set gh.lat='28.619747', gh.long='-29.50126' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.575185', gh.long='-29.485552' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Laka';
update gii_hierarchy as gh set gh.lat='28.583999', gh.long='-29.511748' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Motsepa';


update gii_hierarchy as gh set gh.lat='28.609078', gh.long='-29.510406' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Thabong II';
update gii_hierarchy as gh set gh.lat='28.60892', gh.long='-29.520592' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Projecteng';

update gii_hierarchy as gh set gh.lat='28.598428', gh.long='-29.516226' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Hillside';
update gii_hierarchy as gh set gh.lat='28.580713', gh.long='-29.5247' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Moeko';
update gii_hierarchy as gh set gh.lat='28.565658', gh.long='-29.525248' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Phaila';
update gii_hierarchy as gh set gh.lat='28.586907', gh.long='-29.520696' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Sekiring';
update gii_hierarchy as gh set gh.lat='28.563799', gh.long='-29.543577' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Majara';

update gii_hierarchy as gh set gh.lat='28.554446', gh.long='-29.524147' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Sephooko';
update gii_hierarchy as gh set gh.lat='28.522639', gh.long='-29.560212' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Maqethong';
update gii_hierarchy as gh set gh.lat='28.307223', gh.long='-29.68732' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Topa';
update gii_hierarchy as gh set gh.lat='28.585414', gh.long='-29.529839' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Thabana Mahlanya';
update gii_hierarchy as gh set gh.lat='28.590225', gh.long='-29.53466' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Majakaneng';
update gii_hierarchy as gh set gh.lat='28.599268', gh.long='-29.530182' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Phomolong';
update gii_hierarchy as gh set gh.lat='28.612115', gh.long='-29.535361' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Liphokoaneng';
update gii_hierarchy as gh set gh.lat='28.621551', gh.long='-29.562032' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Ramalapi';

update gii_hierarchy as gh set gh.lat='28.61601', gh.long='-29.545918' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Mohlakeng';
update gii_hierarchy as gh set gh.lat='28.590427', gh.long='-29.547179' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Ha Moqekela';

update gii_hierarchy as gh set gh.lat='28.599755', gh.long='-29.556774' where district='THABA TSEKA' and council='Thabana Mahlanya Council' and village='Khomo ea Leburu';
update gii_hierarchy as gh set gh.lat='28.64708', gh.long='-29.57315' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Nakeli';
update gii_hierarchy as gh set gh.lat='28.620674', gh.long='-29.585264' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Rantsimane';

update gii_hierarchy as gh set gh.lat='28.312409', gh.long='-29.793174' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Tsiu';
update gii_hierarchy as gh set gh.lat='28.653597', gh.long='-29.604356' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Motorong';
update gii_hierarchy as gh set gh.lat='28.66717', gh.long='-29.594813' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='28.252163', gh.long='-29.640856' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Liphakoeng';
update gii_hierarchy as gh set gh.lat='28.667504', gh.long='-29.61197' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Machaping';
update gii_hierarchy as gh set gh.lat='28.675074', gh.long='-29.625226' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Linokong';

update gii_hierarchy as gh set gh.lat='28.201746', gh.long='-29.735582' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Koma Koma';
update gii_hierarchy as gh set gh.lat='28.58256', gh.long='-29.488458' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Maboloka';
update gii_hierarchy as gh set gh.lat='28.746199', gh.long='-29.659203' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Ramoliehi';
update gii_hierarchy as gh set gh.lat='28.735955', gh.long='-29.66546' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.69672', gh.long='-29.648986' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Lekholoane';


update gii_hierarchy as gh set gh.lat='28.303674', gh.long='-29.487829' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Sehaula';
update gii_hierarchy as gh set gh.lat='28.714859', gh.long='-29.680889' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Bocheletsane';
update gii_hierarchy as gh set gh.lat='28.66212', gh.long='-29.272729' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Mokoto';
update gii_hierarchy as gh set gh.lat='28.717184', gh.long='-29.722903' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Setanteng';
update gii_hierarchy as gh set gh.lat='28.690977', gh.long='-29.74038' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Liqonong';
update gii_hierarchy as gh set gh.lat='28.733649', gh.long='-29.769442' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Makoabating';
update gii_hierarchy as gh set gh.lat='28.749933', gh.long='-29.777604' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Ha Ramatseliso';
update gii_hierarchy as gh set gh.lat='28.728923', gh.long='-29.792746' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Lihlabaneng';
update gii_hierarchy as gh set gh.lat='28.756624', gh.long='-29.839733' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.774613', gh.long='-29.824436' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Matsaile';
update gii_hierarchy as gh set gh.lat='28.72415', gh.long='-29.824994' where district='THABA TSEKA' and council='Mohlanapeng Council' and village='Tlaling';
update gii_hierarchy as gh set gh.lat='28.490304', gh.long='-29.389099' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Baruting';



update gii_hierarchy as gh set gh.lat='28.682553', gh.long='-29.353177' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Pontseng';


update gii_hierarchy as gh set gh.lat='28.520965', gh.long='-29.388606' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Lefa';
update gii_hierarchy as gh set gh.lat='28.52805', gh.long='-29.380107' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Ntseke';
update gii_hierarchy as gh set gh.lat='28.534616', gh.long='-29.380461' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Motsosi';
update gii_hierarchy as gh set gh.lat='28.5294', gh.long='-29.391698' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Sebetoane';
update gii_hierarchy as gh set gh.lat='28.554034', gh.long='-29.397439' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Mothibe';
update gii_hierarchy as gh set gh.lat='28.551309', gh.long='-29.389461' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Sekhohola';
update gii_hierarchy as gh set gh.lat='28.548394', gh.long='-29.396805' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Libareng';


update gii_hierarchy as gh set gh.lat='28.57242', gh.long='-29.393072' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Tsekong';
update gii_hierarchy as gh set gh.lat='28.604241', gh.long='-29.370386' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Soai';
update gii_hierarchy as gh set gh.lat='28.594727', gh.long='-29.410721' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Beresi';
update gii_hierarchy as gh set gh.lat='28.590329', gh.long='-29.401821' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Tlolo Tlolo';
update gii_hierarchy as gh set gh.lat='28.617998', gh.long='-29.424024' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Motsekuoa';


update gii_hierarchy as gh set gh.lat='28.606821', gh.long='-29.449049' where district='THABA TSEKA' and council='Khohlo Ntso Council' and village='Ha Khoanyane';
update gii_hierarchy as gh set gh.lat='28.771001', gh.long='-29.366881' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Ramokobo';
update gii_hierarchy as gh set gh.lat='28.79209', gh.long='-29.355042' where district='THABA TSEKA' and council='Bobete Council' and village='Khamolane';

update gii_hierarchy as gh set gh.lat='28.376838', gh.long='-29.701438' where district='THABA TSEKA' and council='Bobete Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='28.763955', gh.long='-29.375085' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Ntsasa';
update gii_hierarchy as gh set gh.lat='28.781469', gh.long='-29.38968' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Kolahali';
update gii_hierarchy as gh set gh.lat='28.74016', gh.long='-29.390558' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Theleli';
update gii_hierarchy as gh set gh.lat='28.314462', gh.long='-29.480772' where district='THABA TSEKA' and council='Bobete Council' and village='Khohlong';

update gii_hierarchy as gh set gh.lat='28.776673', gh.long='-29.394219' where district='THABA TSEKA' and council='Bobete Council' and village='Liphokoaneng';
update gii_hierarchy as gh set gh.lat='28.749556', gh.long='-29.395101' where district='THABA TSEKA' and council='Bobete Council' and village='Malalaneng';
update gii_hierarchy as gh set gh.lat='28.769999', gh.long='-29.395677' where district='THABA TSEKA' and council='Bobete Council' and village='Matseleng';


update gii_hierarchy as gh set gh.lat='28.702737', gh.long='-29.403199' where district='THABA TSEKA' and council='Bobete Council' and village='Lithotaneng';
update gii_hierarchy as gh set gh.lat='28.690393', gh.long='-29.387821' where district='THABA TSEKA' and council='Bobete Council' and village='Makhuleng';

update gii_hierarchy as gh set gh.lat='28.651087', gh.long='-29.401612' where district='THABA TSEKA' and council='Bobete Council' and village='Lilomong';

update gii_hierarchy as gh set gh.lat='28.684856', gh.long='-29.408032' where district='THABA TSEKA' and council='Bobete Council' and village='Mahahleng';
update gii_hierarchy as gh set gh.lat='28.669182', gh.long='-29.402424' where district='THABA TSEKA' and council='Bobete Council' and village='Moraong';
update gii_hierarchy as gh set gh.lat='28.706767', gh.long='-29.408676' where district='THABA TSEKA' and council='Bobete Council' and village='Masaleng';
update gii_hierarchy as gh set gh.lat='28.71711', gh.long='-29.425382' where district='THABA TSEKA' and council='Bobete Council' and village='Setoetoe';
update gii_hierarchy as gh set gh.lat='28.760896', gh.long='-29.419056' where district='THABA TSEKA' and council='Bobete Council' and village='Khotleng';
update gii_hierarchy as gh set gh.lat='28.783032', gh.long='-29.416737' where district='THABA TSEKA' and council='Bobete Council' and village='Likomeng';
update gii_hierarchy as gh set gh.lat='28.746413', gh.long='-29.422886' where district='THABA TSEKA' and council='Bobete Council' and village='Machakaneng';
update gii_hierarchy as gh set gh.lat='28.771754', gh.long='-29.413459' where district='THABA TSEKA' and council='Bobete Council' and village='Mafikeng';
update gii_hierarchy as gh set gh.lat='28.77012', gh.long='-29.432654' where district='THABA TSEKA' and council='Bobete Council' and village='Letsatseng';

update gii_hierarchy as gh set gh.lat='28.752771', gh.long='-29.42573' where district='THABA TSEKA' and council='Bobete Council' and village='Makhoatsing';
update gii_hierarchy as gh set gh.lat='28.751926', gh.long='-29.429079' where district='THABA TSEKA' and council='Bobete Council' and village='Mapoteng';
update gii_hierarchy as gh set gh.lat='29.012131', gh.long='-29.55057' where district='THABA TSEKA' and council='Bobete Council' and village='Mohlanapeng';
update gii_hierarchy as gh set gh.lat='28.762257', gh.long='-29.440785' where district='THABA TSEKA' and council='Bobete Council' and village='Noha lia loana';
update gii_hierarchy as gh set gh.lat='28.737676', gh.long='-29.448989' where district='THABA TSEKA' and council='Bobete Council' and village='Khutlo se nonne';

update gii_hierarchy as gh set gh.lat='28.723081', gh.long='-29.451316' where district='THABA TSEKA' and council='Bobete Council' and village='Manokong';

update gii_hierarchy as gh set gh.lat='28.696993', gh.long='-29.424514' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Maanela';
update gii_hierarchy as gh set gh.lat='28.69495', gh.long='-29.439451' where district='THABA TSEKA' and council='Bobete Council' and village='Majakaneng';

update gii_hierarchy as gh set gh.lat='28.691744', gh.long='-29.427043' where district='THABA TSEKA' and council='Bobete Council' and village='Nqobelle';
update gii_hierarchy as gh set gh.lat='28.687124', gh.long='-29.433326' where district='THABA TSEKA' and council='Bobete Council' and village='Sekoting';
update gii_hierarchy as gh set gh.lat='28.665363', gh.long='-29.418138' where district='THABA TSEKA' and council='Bobete Council' and village='Bobete';
update gii_hierarchy as gh set gh.lat='28.670707', gh.long='-29.442212' where district='THABA TSEKA' and council='Bobete Council' and village='Boema';
update gii_hierarchy as gh set gh.lat='28.684853', gh.long='-29.447413' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Lebala';
update gii_hierarchy as gh set gh.lat='28.689873', gh.long='-29.362925' where district='THABA TSEKA' and council='Bobete Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.679444', gh.long='-29.449069' where district='THABA TSEKA' and council='Bobete Council' and village='Mojese';

update gii_hierarchy as gh set gh.lat='28.718086', gh.long='-29.467894' where district='THABA TSEKA' and council='Bobete Council' and village='Khotolieng';
update gii_hierarchy as gh set gh.lat='28.696979', gh.long='-29.475693' where district='THABA TSEKA' and council='Bobete Council' and village='Mahuleng';

update gii_hierarchy as gh set gh.lat='28.734579', gh.long='-29.475766' where district='THABA TSEKA' and council='Bobete Council' and village='Maqalikeng';

update gii_hierarchy as gh set gh.lat='28.776141', gh.long='-29.458439' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Heshepe';
update gii_hierarchy as gh set gh.lat='28.747748', gh.long='-29.472058' where district='THABA TSEKA' and council='Bobete Council' and village='Mokhangoaneng';

update gii_hierarchy as gh set gh.lat='28.716021', gh.long='-29.513799' where district='THABA TSEKA' and council='Bobete Council' and village='Ha Lephakha';


update gii_hierarchy as gh set gh.lat='28.733039', gh.long='-29.495217' where district='THABA TSEKA' and council='Bobete Council' and village='Lichecheng';

update gii_hierarchy as gh set gh.lat='28.719655', gh.long='-29.508082' where district='THABA TSEKA' and council='Bobete Council' and village='Phaleng';


update gii_hierarchy as gh set gh.lat='28.691744', gh.long='-29.524001' where district='THABA TSEKA' and council='Bobete Council' and village='Makhapung';
update gii_hierarchy as gh set gh.lat='28.673815', gh.long='-29.502058' where district='THABA TSEKA' and council='Bobete Council' and village='Ntsirele';
update gii_hierarchy as gh set gh.lat='28.670538', gh.long='-29.230425' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Mokhantsi';
update gii_hierarchy as gh set gh.lat='28.657939', gh.long='-29.236841' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Ratau';
update gii_hierarchy as gh set gh.lat='28.673784', gh.long='-29.247178' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Thene';

update gii_hierarchy as gh set gh.lat='28.172824', gh.long='-29.384465' where district='THABA TSEKA' and council='Senotong Council' and village='Sekolopata';
update gii_hierarchy as gh set gh.lat='28.652251', gh.long='-29.241314' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Sekila';

update gii_hierarchy as gh set gh.lat='28.622297', gh.long='-29.268232' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Tlelase';
update gii_hierarchy as gh set gh.lat='28.66212', gh.long='-29.272729' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Mokoto';
update gii_hierarchy as gh set gh.lat='28.644096', gh.long='-29.283897' where district='THABA TSEKA' and council='Senotong Council' and village='Mononong';


update gii_hierarchy as gh set gh.lat='28.67169', gh.long='-29.320227' where district='THABA TSEKA' and council='Senotong Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='28.45991', gh.long='-29.695032' where district='THABA TSEKA' and council='Senotong Council' and village='Litsoeneng';
update gii_hierarchy as gh set gh.lat='28.667633', gh.long='-29.289752' where district='THABA TSEKA' and council='Senotong Council' and village='Sephokong';
update gii_hierarchy as gh set gh.lat='28.49724', gh.long='-29.744144' where district='THABA TSEKA' and council='Senotong Council' and village='Thaba Bosiu';
update gii_hierarchy as gh set gh.lat='28.606356', gh.long='-29.281424' where district='THABA TSEKA' and council='Senotong Council' and village='Bahaoleng';
update gii_hierarchy as gh set gh.lat='28.600364', gh.long='-29.267368' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Lekiba';
update gii_hierarchy as gh set gh.lat='28.601536', gh.long='-29.274241' where district='THABA TSEKA' and council='Senotong Council' and village='Liseleng';
update gii_hierarchy as gh set gh.lat='28.572407', gh.long='-29.290383' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Pene';
update gii_hierarchy as gh set gh.lat='28.577061', gh.long='-29.272246' where district='THABA TSEKA' and council='Senotong Council' and village='Phakoeng';
update gii_hierarchy as gh set gh.lat='28.578454', gh.long='-29.299726' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Kalakatana';
update gii_hierarchy as gh set gh.lat='28.364978', gh.long='-29.791557' where district='THABA TSEKA' and council='Senotong Council' and village='Makhalong';


update gii_hierarchy as gh set gh.lat='28.621662', gh.long='-29.321238' where district='THABA TSEKA' and council='Senotong Council' and village='Maiseng';
update gii_hierarchy as gh set gh.lat='28.609893', gh.long='-29.321953' where district='THABA TSEKA' and council='Senotong Council' and village='Maqhoane';
update gii_hierarchy as gh set gh.lat='28.617994', gh.long='-29.332918' where district='THABA TSEKA' and council='Senotong Council' and village='Lioling';
update gii_hierarchy as gh set gh.lat='28.313466', gh.long='-29.515476' where district='THABA TSEKA' and council='Senotong Council' and village='Matsoapong';
update gii_hierarchy as gh set gh.lat='28.636572', gh.long='-29.315811' where district='THABA TSEKA' and council='Senotong Council' and village='Peteletsa';
update gii_hierarchy as gh set gh.lat='28.689873', gh.long='-29.362925' where district='THABA TSEKA' and council='Senotong Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.650798', gh.long='-29.333491' where district='THABA TSEKA' and council='Senotong Council' and village='Maforeisetateng';

update gii_hierarchy as gh set gh.lat='28.641058', gh.long='-29.347479' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Maramane';

update gii_hierarchy as gh set gh.lat='28.637415', gh.long='-29.39398' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Tiela';
update gii_hierarchy as gh set gh.lat='28.645824', gh.long='-29.383546' where district='THABA TSEKA' and council='Senotong Council' and village='Matikeng';
update gii_hierarchy as gh set gh.lat='28.682915', gh.long='-29.311324' where district='THABA TSEKA' and council='Senotong Council' and village='Kholoang';

update gii_hierarchy as gh set gh.lat='28.376838', gh.long='-29.701438' where district='THABA TSEKA' and council='Senotong Council' and village='Sekhutlong';

update gii_hierarchy as gh set gh.lat='28.665913', gh.long='-29.361546' where district='THABA TSEKA' and council='Senotong Council' and village='Foreisetata';
update gii_hierarchy as gh set gh.lat='28.675332', gh.long='-29.358611' where district='THABA TSEKA' and council='Senotong Council' and village='Manganeng';
update gii_hierarchy as gh set gh.lat='28.680188', gh.long='-29.357866' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Matona';
update gii_hierarchy as gh set gh.lat='28.682553', gh.long='-29.353177' where district='THABA TSEKA' and council='Senotong Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.296279', gh.long='-29.524399' where district='THABA TSEKA' and council='Senotong Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.703068', gh.long='-29.34095' where district='THABA TSEKA' and council='Senotong Council' and village='Ha Toeba';

update gii_hierarchy as gh set gh.lat='29.282925', gh.long='-29.582511' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Sani Top';




update gii_hierarchy as gh set gh.lat='28.74019', gh.long='-29.565221' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Makunyapane';
update gii_hierarchy as gh set gh.lat='28.296279', gh.long='-29.524399' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Taung';
update gii_hierarchy as gh set gh.lat='28.754451', gh.long='-29.582112' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Lelibohong';

update gii_hierarchy as gh set gh.lat='28.798224', gh.long='-29.57988' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Khoali';
update gii_hierarchy as gh set gh.lat='28.81783', gh.long='-29.574305' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Maputsoe';

update gii_hierarchy as gh set gh.lat='28.799518', gh.long='-29.54851' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Matlatseng';

update gii_hierarchy as gh set gh.lat='28.82299', gh.long='-29.509785' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Kutoane';
update gii_hierarchy as gh set gh.lat='28.689873', gh.long='-29.362925' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Lekhalong';
update gii_hierarchy as gh set gh.lat='28.837765', gh.long='-29.506156' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Makoko';
update gii_hierarchy as gh set gh.lat='28.254602', gh.long='-29.82704' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Motsiba';
update gii_hierarchy as gh set gh.lat='28.851856', gh.long='-29.513063' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Nkune';
update gii_hierarchy as gh set gh.lat='28.843298', gh.long='-29.559736' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Pitsaneng';
update gii_hierarchy as gh set gh.lat='28.19658', gh.long='-29.476521' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Pitseng';
update gii_hierarchy as gh set gh.lat='28.865612', gh.long='-29.5473' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Tjope';
update gii_hierarchy as gh set gh.lat='28.872021', gh.long='-29.550002' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Mahooeng';
update gii_hierarchy as gh set gh.lat='28.857943', gh.long='-29.51053' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Mongali';
update gii_hierarchy as gh set gh.lat='28.86454', gh.long='-29.505928' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Makanyaneng';

update gii_hierarchy as gh set gh.lat='28.896175', gh.long='-29.553285' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Bokhoase';
update gii_hierarchy as gh set gh.lat='28.939185', gh.long='-29.585579' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Salemone';
update gii_hierarchy as gh set gh.lat='28.49724', gh.long='-29.744144' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Thaba Bosiu';

update gii_hierarchy as gh set gh.lat='28.948069', gh.long='-29.53228' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Raletsoai';
update gii_hierarchy as gh set gh.lat='28.308606', gh.long='-29.86418' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Lithakong';
update gii_hierarchy as gh set gh.lat='28.905756', gh.long='-29.612143' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Lulang';
update gii_hierarchy as gh set gh.lat='28.962599', gh.long='-29.52902' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Maheising';

update gii_hierarchy as gh set gh.lat='28.985182', gh.long='-29.521902' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Phuleng';
update gii_hierarchy as gh set gh.lat='29.003863', gh.long='-29.552145' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='29.021186', gh.long='-29.557688' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Matseng';
update gii_hierarchy as gh set gh.lat='28.978733', gh.long='-29.547534' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Tiping';
update gii_hierarchy as gh set gh.lat='28.972365', gh.long='-29.570587' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Chakatsa';
update gii_hierarchy as gh set gh.lat='29.008561', gh.long='-29.580011' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Mosehle';
update gii_hierarchy as gh set gh.lat='28.997145', gh.long='-29.584061' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Motse mocha';
update gii_hierarchy as gh set gh.lat='29.023558', gh.long='-29.594574' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Jakopo';

update gii_hierarchy as gh set gh.lat='29.020194', gh.long='-29.540479' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Qena';

update gii_hierarchy as gh set gh.lat='29.027137', gh.long='-29.546231' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Malothoaneng';
update gii_hierarchy as gh set gh.lat='29.04331', gh.long='-29.547205' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ntsupe';
update gii_hierarchy as gh set gh.lat='29.028036', gh.long='-29.524075' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Nqochane';
update gii_hierarchy as gh set gh.lat='29.06512', gh.long='-29.538439' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Ha Machokoloane';
update gii_hierarchy as gh set gh.lat='29.076931', gh.long='-29.616485' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Majoe matso';
update gii_hierarchy as gh set gh.lat='29.07661', gh.long='-29.5908' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Masokoaneng';
update gii_hierarchy as gh set gh.lat='28.873834', gh.long='-29.516791' where district='THABA TSEKA' and council='Rapoleboea Council' and village='Mpharane';



update gii_hierarchy as gh set gh.lat='28.800682', gh.long='-29.606282' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Mokone';
update gii_hierarchy as gh set gh.lat='28.791061', gh.long='-29.610203' where district='THABA TSEKA' and council='Monyetleng Council' and village='Pontseng';
update gii_hierarchy as gh set gh.lat='28.854069', gh.long='-29.633062' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Motake';
update gii_hierarchy as gh set gh.lat='28.833341', gh.long='-29.621455' where district='THABA TSEKA' and council='Monyetleng Council' and village='Khotsong';
update gii_hierarchy as gh set gh.lat='28.854141', gh.long='-29.624659' where district='THABA TSEKA' and council='Monyetleng Council' and village='Phahameng';
update gii_hierarchy as gh set gh.lat='28.900348', gh.long='-29.616856' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Mankereu';
update gii_hierarchy as gh set gh.lat='28.889938', gh.long='-29.621146' where district='THABA TSEKA' and council='Monyetleng Council' and village='Matsiring';
update gii_hierarchy as gh set gh.lat='28.934991', gh.long='-29.606923' where district='THABA TSEKA' and council='Monyetleng Council' and village='Botsola';
update gii_hierarchy as gh set gh.lat='28.923445', gh.long='-29.610121' where district='THABA TSEKA' and council='Monyetleng Council' and village='Kholola';

update gii_hierarchy as gh set gh.lat='28.905967', gh.long='-29.622717' where district='THABA TSEKA' and council='Monyetleng Council' and village='Taung';


update gii_hierarchy as gh set gh.lat='28.985102', gh.long='-29.605298' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Seelane';
update gii_hierarchy as gh set gh.lat='28.779201', gh.long='-29.428607' where district='THABA TSEKA' and council='Monyetleng Council' and village='Mokhoabong';

update gii_hierarchy as gh set gh.lat='28.91874', gh.long='-29.64903' where district='THABA TSEKA' and council='Monyetleng Council' and village='Khatoloto';
update gii_hierarchy as gh set gh.lat='28.947685', gh.long='-29.661053' where district='THABA TSEKA' and council='Monyetleng Council' and village='Khochaneng';
update gii_hierarchy as gh set gh.lat='28.926357', gh.long='-29.633167' where district='THABA TSEKA' and council='Monyetleng Council' and village='Linotsing';
update gii_hierarchy as gh set gh.lat='28.87693', gh.long='-29.648129' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Khenene';
update gii_hierarchy as gh set gh.lat='28.877231', gh.long='-29.640721' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Seeiso';
update gii_hierarchy as gh set gh.lat='28.860815', gh.long='-29.655823' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Komanyane';
update gii_hierarchy as gh set gh.lat='28.845558', gh.long='-29.6462' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Rampeoane';

update gii_hierarchy as gh set gh.lat='28.822621', gh.long='-29.669182' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Boomo';
update gii_hierarchy as gh set gh.lat='28.812255', gh.long='-29.678662' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Setala';

update gii_hierarchy as gh set gh.lat='28.763287', gh.long='-29.644874' where district='THABA TSEKA' and council='Monyetleng Council' and village='Ha Teke (Hloahloeng)';
update gii_hierarchy as gh set gh.lat='28.745955', gh.long='-29.696382' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Fusi';
update gii_hierarchy as gh set gh.lat='28.675332', gh.long='-29.358611' where district='THABA TSEKA' and council='Sehonghong Council' and village='Manganeng';


update gii_hierarchy as gh set gh.lat='28.771179', gh.long='-29.695803' where district='THABA TSEKA' and council='Sehonghong Council' and village='Tlokoeng';
update gii_hierarchy as gh set gh.lat='28.769139', gh.long='-29.726732' where district='THABA TSEKA' and council='Sehonghong Council' and village='Sehong hong';
update gii_hierarchy as gh set gh.lat='28.773164', gh.long='-29.729427' where district='THABA TSEKA' and council='Sehonghong Council' and village='Lebung';
update gii_hierarchy as gh set gh.lat='28.172033', gh.long='-29.494285' where district='THABA TSEKA' and council='Sehonghong Council' and village='Aupolasi';
update gii_hierarchy as gh set gh.lat='28.797085', gh.long='-29.708551' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Mahlatsi';

update gii_hierarchy as gh set gh.lat='28.825254', gh.long='-29.69612' where district='THABA TSEKA' and council='Sehonghong Council' and village='Sekoainyane';
update gii_hierarchy as gh set gh.lat='28.864032', gh.long='-29.701027' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Makhabane';
update gii_hierarchy as gh set gh.lat='28.884264', gh.long='-29.70445' where district='THABA TSEKA' and council='Sehonghong Council' and village='Liqaleng';
update gii_hierarchy as gh set gh.lat='28.872802', gh.long='-29.763188' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Mpiko';
update gii_hierarchy as gh set gh.lat='28.864931', gh.long='-29.771188' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Setontolo';

update gii_hierarchy as gh set gh.lat='28.217876', gh.long='-29.696761' where district='THABA TSEKA' and council='Sehonghong Council' and village='Mangaung';
update gii_hierarchy as gh set gh.lat='28.840545', gh.long='-29.725823' where district='THABA TSEKA' and council='Sehonghong Council' and village='Matsolong';
update gii_hierarchy as gh set gh.lat='28.812737', gh.long='-29.736299' where district='THABA TSEKA' and council='Sehonghong Council' and village='Masakoane';
update gii_hierarchy as gh set gh.lat='28.824243', gh.long='-29.747704' where district='THABA TSEKA' and council='Sehonghong Council' and village='Matsikeng';
update gii_hierarchy as gh set gh.lat='28.790371', gh.long='-29.737361' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Setene';
update gii_hierarchy as gh set gh.lat='28.783306', gh.long='-29.738259' where district='THABA TSEKA' and council='Sehonghong Council' and village='Kheseng';
update gii_hierarchy as gh set gh.lat='28.608132', gh.long='-29.565345' where district='THABA TSEKA' and council='Sehonghong Council' and village='Moreneng';

update gii_hierarchy as gh set gh.lat='28.127771', gh.long='-29.465906' where district='THABA TSEKA' and council='Sehonghong Council' and village='Sekokoaneng';
update gii_hierarchy as gh set gh.lat='28.795869', gh.long='-29.778518' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Molaoa';
update gii_hierarchy as gh set gh.lat='28.787999', gh.long='-29.763732' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Poko';
update gii_hierarchy as gh set gh.lat='28.804164', gh.long='-29.791538' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Sekhaupane';
update gii_hierarchy as gh set gh.lat='28.809628', gh.long='-29.797943' where district='THABA TSEKA' and council='Sehonghong Council' and village='Ha Tebalo';

COMMIT;


-- update the address_hierarchy_entry table with this gps data
update address_hierarchy_entry
left join gii_hierarchy as gh on address_hierarchy_entry_id=gh.id
set latitude=gh.lat, longitude=gh.long
where gh.id is not null;

END$$

DELIMITER ;

