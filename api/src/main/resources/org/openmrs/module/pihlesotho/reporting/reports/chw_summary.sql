-- ## report_uuid = 7ec62ea3-a7b9-11e8-a948-0242ac110001
-- ## design_uuid = 7fb8c963-a7b9-11e8-a948-0242ac110001
-- ## report_name = CHW - Summary
-- ## report_description = CHW Summary Report.

select distinct p.identifier "Provider_id", p.person_id,  pr.name "Provider_role", CONCAT(pn.given_name, ' ',pn.family_name) "Provider_name", 
COALESCE(c.patients,0) "Patient_count", 
CONCAT(pn_sup.given_name, ' ',pn_sup.family_name) "Supervisor_Name" , p_sup.identifier "Supervisor_id", r_sup.relationship_id,
CONCAT(pn_co.given_name, ' ',pn_co.family_name) "Coordinator_Name" , p_co.identifier "Coordinator_id"
from provider p
INNER JOIN providermanagement_provider_role pr on p.provider_role_id = pr.provider_role_id and 
     pr.uuid in ('68624C4C-9E10-473B-A849-204820D16C45','11C1A56D-82F7-4269-95E8-2B67B9A3D837','E050AA6E-AFFB-4D31-B00F-CE118ECDEF18') -- CHW, CHW Supervisor, CHW Coordinator
LEFT OUTER JOIN (select person_a "CHW", count(*) "patients" from relationship
    where relationship =  (select relationship_type_id from relationship_type where uuid = '90d9ee7e-1b76-102d-b823-000c29891b1e') -- CHW relationship
    and end_date is null
    group by person_a) c on c.CHW = p.person_id
LEFT OUTER JOIN person_name pn on pn.person_name_id = 
             (select person_name_id from person_name pn2 where pn2.person_id = p.person_id and pn2.voided = 0 order by pn2.preferred desc, pn2.date_created desc limit 1)      
-- Supervisor
LEFT OUTER JOIN  relationship r_sup on r_sup.person_b = p.person_id and r_sup.voided = 0 and r_sup.end_date is null and r_sup.relationship = 
(select relationship_type_id from relationship_type where uuid = '435a1e53-f327-48da-b8be-c3b56bfeb019') -- CHW Supervisor
LEFT OUTER JOIN provider p_sup on p_sup.person_id = r_sup.person_a and p_sup.provider_role_id = 
  (select provider_role_id from providermanagement_provider_role where uuid = '11C1A56D-82F7-4269-95E8-2B67B9A3D837') -- CHW supervisor role
LEFT OUTER JOIN person_name pn_sup on pn_sup.person_name_id = 
             (select person_name_id from person_name pn_sup2 where pn_sup2.person_id = p_sup.person_id and pn_sup2.voided = 0 order by pn_sup2.preferred desc, pn_sup2.date_created desc limit 1)      
-- Coordinator
LEFT OUTER JOIN  relationship r_co on r_co.person_b = p.person_id and r_co.voided = 0 and r_co.end_date is null and r_co.relationship in 
(select relationship_type_id from relationship_type where uuid = '2a5f4ff4-a179-4b8a-aa4c-40f71956ebbc')  -- CHW Coordinator
LEFT OUTER JOIN provider p_co on p_co.person_id = r_co.person_a and p_co.provider_role_id = 
  (select provider_role_id from providermanagement_provider_role where uuid = 'E050AA6E-AFFB-4D31-B00F-CE118ECDEF18') -- Coordinator role
LEFT OUTER JOIN person_name pn_co on pn_co.person_name_id = 
             (select person_name_id from person_name pn_co2 where pn_co2.person_id = p_co.person_id and pn_co2.voided = 0 order by pn_co2.preferred desc, pn_co2.date_created desc limit 1)
;