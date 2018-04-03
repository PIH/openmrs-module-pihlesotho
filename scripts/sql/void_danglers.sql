-- --------------------------------------------------------------------------------
-- call void_danglers();
--   voids out associated person, encounter and obs data for voided patients
--   will create a log of voided patients in void_danglers_history
-- --------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `openmrs`.`void_danglers_history`(
  `patient_id` int(11) DEFAULT 0 PRIMARY KEY,
  `per` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL, -- added on 06 mar
  `enc` int(11) DEFAULT NULL,
  `obs` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$

DROP PROCEDURE IF EXISTS `openmrs`.`void_danglers`$$
CREATE PROCEDURE `openmrs`.`void_danglers`()
BEGIN

select NOW() into @void_date;

select 10552 into @void_user;

select 'voiding dangling data (patient was already voided)' into @void_reason;

SELECT 0 into @inc;

-- get the list of voided patients that this script never processed
DROP TABLE IF EXISTS `voided_patients`;
CREATE TEMPORARY TABLE `voided_patients`
as
select p.patient_id
, @inc:=@inc+1 AS `id`
from patient as p
left join void_danglers_history as vdp on p.patient_id=vdp.patient_id
where p.voided=1
and vdp.date is null;

select count(*) into @count from voided_patients;

WHILE @count > 0 DO

  select patient_id into @patient from voided_patients where id=@count;

  start transaction;

  -- person
  update person set voided=1, date_voided=@void_date, void_reason=@void_reason, voided_by=@void_user
  where person_id=@patient and voided=0;

  select ROW_COUNT() into @pers;

  -- patient identifiers
  update patient_identifier set voided=1, date_voided=@void_date, void_reason=@void_reason, voided_by=@void_user
  where patient_id=@patient and voided=0;

  select ROW_COUNT() into @pids;

  -- encounters
  update encounter set voided=1, date_voided=@void_date, void_reason=@void_reason, voided_by=@void_user
  where patient_id=@patient and voided=0;

  select ROW_COUNT() into @encs;

  -- observations
  update obs set voided=1, date_voided=@void_date, void_reason=@void_reason, voided_by=@void_user
  where person_id=@patient and voided=0;

  select ROW_COUNT() into @obss;

  -- insert into our table
  insert into `void_danglers_history` (patient_id, per, pid, enc, obs, `date`)
  values (@patient, @pers, @pids, @encs, @obss, @void_date);

  commit;

  -- decrement count
  select @count-1 into @count;

END WHILE;

select count(*) as patients INTO @total_voided from void_danglers_history
where `date`=@void_date;

IF @total_voided > 0 THEN

  SELECT 'The following changes were made in this session:' as Message;

  SELECT count(patient_id) as patients
  , sum(per) as persons
  , sum(pid) as identifiers
  , sum(enc) as encounters
  , sum(obs) as observations
  from void_danglers_history
  where `date`=@void_date;

ELSE

  SELECT 'No new patients were found to void data for in this session.' as Message;

END IF;

END$$

DELIMITER ;

-- corrections:
/*
-- fix the missing user
update person set voided_by=10552 where void_reason='voiding dangling data (patient was already voided)' and voided_by is null;
update encounter set voided_by=10552 where void_reason='voiding dangling data (patient was already voided)' and voided_by is null;
update obs set voided_by=10552 where void_reason='voiding dangling data (patient was already voided)' and voided_by is null;

-- add the new column
alter table void_danglers_history add column `pid` int(11) DEFAULT NULL;

-- update the patient identifier
select distinct(vdh.patient_id) from void_danglers_history as vdh
left join patient_identifier as pi on vdh.patient_id=pi.patient_id and pi.voided=0
where pi.identifier is not null;

update patient_identifier set voided=1, date_voided='2012-03-06 17:35:20', void_reason='voiding dangling data (patient was already voided)', voided_by=10552
where patient_id in (50, 122, 1371, 1469, 1971, 2015, 2020, 2067, 2073, 2102, 2103, 2105, 2107, 2109, 2110, 2111, 2112, 2113, 2115, 2116, 2117, 2118, 2119, 2120, 2210, 2217, 2246, 2247, 2248, 2279, 2281, 2282, 2283, 2297, 2298, 2299, 2300, 2301, 2302, 2303, 2315, 2422, 2892, 2910, 3009, 3110, 3248, 3281, 4060, 4211, 4299, 4892, 4922, 4925, 4930, 4938, 4981, 5061, 5159, 5160, 5161, 5162, 5163, 5164, 5165, 5166, 5167, 5169, 5170, 5171, 5172, 5173, 5174, 5175, 5176, 5177, 5178, 5179, 5180, 5181, 5182, 5183, 5184, 5185, 5186, 5187, 5188, 5189, 5190, 5191, 5192, 5193, 5194, 5195, 5196, 5197, 5198, 5200, 5212, 5213, 5214, 5215, 5216, 5217, 5218, 5219, 5220, 5221, 5222, 5223, 5224, 5225, 5226, 5227, 5228, 5229, 5230, 5231, 5232, 5233, 5234, 5235, 5236, 5237, 5238, 5239, 5240, 5241, 5242, 5243, 5244, 5245, 5246, 5247, 5248, 5257, 5362, 5364, 5365, 5548, 5770, 5781, 5783, 5802, 5839, 5908, 5984, 6043, 6111, 6173, 6303, 6314, 6344, 6489, 6527, 6529, 6530, 6533, 6534, 6535, 6536, 6537, 6545, 6553, 6589, 6593, 6598, 6605, 6611, 6614, 6626, 6629, 6736, 6877, 7058, 7082, 7127, 7170, 7218, 7253, 7268, 7281, 7321, 7323, 7343, 7375, 7390, 7403, 7409, 7491, 7492, 7515, 7522, 7529, 7540, 7623, 7736, 7857, 7942, 8070, 8181, 8201, 8219, 8322, 8469, 8490, 8801, 8884, 9101, 9116, 9196, 9250, 9509, 9526, 9551, 9552, 9612, 9993, 10239, 10240, 10297, 10298, 10299, 10300, 10301, 10302, 10303, 10304, 10305, 10306, 10307, 10308, 10309, 10310, 10311, 10312, 10313, 10314, 10315, 10316, 10317, 10318, 10319, 10320, 10321, 10322, 10577, 10578, 10579, 10594, 10614, 10692, 10693, 10773, 11197, 11245, 11634, 11738, 11855, 11920, 12027, 12266, 12268, 12452);

*/