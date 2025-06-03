-- We no longer use the BIRT module, remove these global properties
delete from global_property where property like 'birt.%';

-- Due to liquibase major version updates, the MD5 calculation is different.  Clear this out to force recalculation
update liquibasechangelog set MD5SUM = null;

-- All users should be providers
insert into provider (person_id, identifier, creator, date_created, retired, retired_by, date_retired, retire_reason, uuid)
select u.person_id, u.system_id, 1, now(), u.retired, u.retired_by, u.date_retired, u.retire_reason, uuid()
from users u left join provider p on u.person_id = p.person_id
where p.provider_id is null;

-- All orders must be associated with an encounter
insert into encounter_type (encounter_type_id, uuid, name, description, creator, date_created)
values (22, uuid(), 'Order', 'Standalone encounter containing orders', 1, now());

-- Order Type table must be prepped
ALTER TABLE order_type ADD COLUMN java_class_name VARCHAR(255) DEFAULT NULL, ADD COLUMN parent INT(11) DEFAULT NULL;
UPDATE order_type SET java_class_name = 'org.openmrs.DrugOrder' WHERE name ='Drug Order';
UPDATE order_type SET java_class_name = 'org.openmrs.DrugOrder' WHERE name ='Drug';
UPDATE order_type SET java_class_name = 'org.openmrs.TestOrder' WHERE name ='Test';
UPDATE order_type SET java_class_name = 'org.openmrs.TestOrder' WHERE name ='Lab';

-- Units and frequency are converted from text to concepts.  Prepare for this
update drug_order set units = null where units = '';
update drug_order set frequency = null where frequency = '';

select concept_datatype_id into @numericDatatype from concept_datatype where name = 'Numeric';
select concept_datatype_id into @codedDatatype from concept_datatype where name = 'Coded';
select concept_datatype_id into @textDatatype from concept_datatype where name = 'Text';
select concept_datatype_id into @naDatatype from concept_datatype where name = 'N/A';
select concept_class_id into @miscClass from concept_class where name = 'Misc';
select concept_class_id into @convSetClass from concept_class where name = 'ConvSet';

-- Units
insert into concept (concept_id, uuid, class_id, datatype_id, is_set, creator, date_created)
values
    (7139, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7140, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7141, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7142, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7143, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7144, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7145, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7146, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7147, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7148, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7149, uuid(), @miscClass, @naDatatype, 0, 1, now()),
    (7150, uuid(), @convSetClass, @naDatatype, 1, 1, now())
;

INSERT INTO concept_name (uuid, concept_id, name, locale, locale_preferred, concept_name_type, creator, date_created)
values
    (uuid(), 7139, 'Milligram', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7140, 'Milliliter', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7141, 'Tablet', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7142, 'Once a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7143, 'Twice a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7144, 'Three times a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7145, 'Four times a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7146, 'Five times a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7147, 'Ten times a day', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7148, 'Once a day, 2 days per week', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7149, 'Daily', 'en', 1, 'FULLY_SPECIFIED', 1, now()),
    (uuid(), 7150, 'Dosing unit', 'en', 1, 'FULLY_SPECIFIED', 1, now())
;

INSERT INTO concept_set (uuid, concept_set, concept_id, sort_weight, creator, date_created)
values
    (uuid(), 7150, 7139, 1, 1, now()),
    (uuid(), 7150, 7140, 2, 1, now()),
    (uuid(), 7150, 7141, 3, 1, now())
;

update global_property set property_value = (select uuid from concept where concept_id = 7150) where property = 'order.drugDosingUnitsConceptUuid';

-- Set the order start date to the date midnight of the date_created, assumption that all orders are date-based in current system
UPDATE orders set start_date = date(date_created) where start_date is null;
update orders set orderer = creator where orderer is null;

-- All orders must be associated with an encounter.  Create encounters for all orders, grouping orders with the same start date and creator together
INSERT INTO encounter (uuid, encounter_type, patient_id, encounter_datetime, creator, date_created)
SELECT uuid(), 22, patient_id, start_date, creator, min(date_created)
from orders
where encounter_id is null
group by patient_id, creator, start_date
;

UPDATE orders o
    INNER JOIN encounter e on o.start_date = e.encounter_datetime and e.encounter_type = 22
set o.encounter_id = e.encounter_id
where o.encounter_id is null;

-- If all orders are voided in one of the created encounters, void the encounter
UPDATE encounter e
    LEFT JOIN (select encounter_id, count(*) AS non_voided_count from orders where voided = 0 group by encounter_id) c
    ON e.encounter_id = c.encounter_id
SET e.voided = 1, e.voided_by = 1, e.date_voided = now(), e.void_reason = 'All associated orders are voided'
WHERE e.encounter_type = 22 AND c.non_voided_count = 0
;

-- All created encounters should have an encounter provider

INSERT INTO encounter_provider (encounter_id, provider_id, encounter_role_id, creator, date_created, changed_by, date_changed, voided, date_voided, voided_by, void_reason, uuid)
SELECT e.encounter_id, pr.provider_id,1, e.creator, e.date_created, e.changed_by, e.date_changed, e.voided, e.date_voided, e.voided_by, e.void_reason,UUID()
FROM encounter e INNER JOIN users u ON e.creator = u.user_id
                 INNER JOIN (SELECT person_id, max(provider_id) as provider_id FROM provider GROUP BY person_id) pr ON u.person_id = pr.person_id
WHERE e.encounter_type = 22
;

-- All discontinued orders must have a discontinued date set
update orders set discontinued_date=start_date where discontinued=1 and discontinued_date is null;
update orders set discontinued_by=creator where discontinued=1 and discontinued_by is null;
