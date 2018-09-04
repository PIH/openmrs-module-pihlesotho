-- ## report_uuid = 64a8d5ca-a7a0-11e8-a948-0242ac110001
-- ## design_uuid = 56d9f6b5-a7a0-11e8-a948-0242ac110001
-- ## report_name = CHW - Patient
-- ## report_description = CHW Patient Report.

select 
p.identifier "provider_identifier",pr.name "Provider_role", CONCAT(pn.given_name, ' ',pn.family_name) "Provider_Name", 
CONCAT(pnc.given_name, ' ',pnc.family_name) "Patient_Name",pid.identifier "Patient_identifier",
cn_state.name "Current_HIV_State",
CASE 
  WHEN o.value_numeric = 1 THEN 'TRUE'
  WHEN o.value_numeric = 0 THEN 'FALSE'
  else cn_present.name
end   "CHW_present_last_pickup"
from provider p
INNER JOIN providermanagement_provider_role pr on p.provider_role_id = pr.provider_role_id and 
     pr.uuid in ('68624C4C-9E10-473B-A849-204820D16C45','11C1A56D-82F7-4269-95E8-2B67B9A3D837','E050AA6E-AFFB-4D31-B00F-CE118ECDEF18') -- CHW, CHW Supervisor, CHW Coordinator
LEFT OUTER JOIN person_name pn on pn.person_name_id = 
             (select person_name_id from person_name pn2 where pn2.person_id = p.person_id and pn2.voided = 0 order by pn2.preferred desc, pn2.date_created desc limit 1)      
INNER JOIN relationship r on r.person_a = p.person_id and r.voided = 0 and r. end_date is null and relationship = 
  (select relationship_type_id from relationship_type where uuid = '90d9ee7e-1b76-102d-b823-000c29891b1e') -- CHW relationship
INNER JOIN patient_program pp on pp.patient_id = r.person_b and pp.voided = 0 and  pp.program_id = 
  (select program_id from program where uuid = '90d6f0ca-1b76-102d-b823-000c29891b1e') -- HIV program
LEFT OUTER JOIN person_name pnc on pnc.person_name_id = 
             (select person_name_id from person_name pnc2 where pnc2.person_id = r.person_b and pnc2.voided = 0 order by pnc2.preferred desc, pnc2.date_created desc limit 1)      
-- patient id
LEFT OUTER JOIN patient_identifier pid ON pid.patient_identifier_id = (select pid2.patient_identifier_id from patient_identifier pid2 where pid2.patient_id =r.person_b and pid2.identifier_type = 
   (select patient_identifier_type_id from patient_identifier_type where uuid = '8dd553f8-1b76-102d-b823-000c29891b1e') -- paper file ID
                                                 order by pid2.preferred desc, pid2.date_created desc limit 1)
-- patient state 
LEFT OUTER JOIN patient_state ps on ps.patient_state_id = (select patient_state_id from patient_state 
     where patient_program_id = pp.patient_program_id and end_date is null order by patient_program_id limit 0,1)
LEFT OUTER JOIN program_workflow_state pws on pws.program_workflow_state_id = ps.state and pws.retired = 0
LEFT OUTER JOIN concept_name cn_state on cn_state.concept_id = pws.concept_id  and cn_state.locale = 'en' and cn_state.locale_preferred = '1'  and cn_state.voided = 0
LEFT OUTER JOIN program_workflow pw on pw.program_workflow_id = pws.program_workflow_id and pw.retired = 0
-- CHW Present
LEFT OUTER JOIN obs o on o.obs_id = (select obs_id from obs o2 where o2.person_id = pp.patient_id 
and o2.concept_id = (select concept_id from concept where uuid = '3ce13430-26fe-102b-80cb-0017a47871b2') -- COMMUNITY HEALTH WORKER PRESENT concept
order by o2.obs_datetime desc limit 1) 
LEFT OUTER JOIN concept_name cn_present on cn_present.concept_id = o.value_coded and cn_present.locale = 'en' and cn_present.locale_preferred = 1 and cn_present.voided = 0
;