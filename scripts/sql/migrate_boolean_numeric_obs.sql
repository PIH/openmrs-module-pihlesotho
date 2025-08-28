drop temporary table if exists temp_bool_obs;

            create temporary table temp_bool_obs
                select
                    o.obs_id, o.person_id, o.encounter_id,
                    o.concept_id, o.value_numeric,
                    o.obs_datetime, o.location_id, o.obs_group_id, o.creator, o.date_created,
                    o.status
                  from obs o, concept c
                 where c.concept_id = o.concept_id
                   and c.datatype_id = (select cd.concept_datatype_id from concept_datatype cd where cd.name like 'Boolean')
                   and o.value_numeric is not null
                   and o.voided = 0
                   ;

            -- insert obs with coded False
            insert into obs
                (person_id,
                 concept_id,
                 value_coded,
                 encounter_id,
                 obs_datetime,
                 location_id,
                 obs_group_id,
                 creator,
                 date_created,
                 voided,
                 uuid,
                 status,
                 previous_version
                )
            select
                t.person_id,
                t.concept_id,
                (select cn.concept_id from concept_name cn where cn.name like 'false' and cn.locale = 'en' and cn.locale_preferred = 1 and cn.voided = 0),
                t.encounter_id,
                t.obs_datetime,
                t.location_id,
                t.obs_group_id,
                t.creator,
                t.date_created,
                0,
                uuid(),
                t.status,
                t.obs_id
            from temp_bool_obs t
            where t.value_numeric = 0;

            -- insert obs with coded TRUE
            insert into obs
               (person_id,
                concept_id,
                value_coded,
                encounter_id,
                obs_datetime,
                location_id,
                obs_group_id,
                creator,
                date_created,
                voided,
                uuid,
                status,
                previous_version
               )
            select
                t.person_id,
                t.concept_id,
                (select cn.concept_id from concept_name cn where cn.name like 'true' and cn.locale = 'en' and cn.locale_preferred = 1 and cn.voided = 0),
                t.encounter_id,
                t.obs_datetime,
                t.location_id,
                t.obs_group_id,
                t.creator,
                t.date_created,
                0,
                uuid(),
                t.status,
                t.obs_id
            from temp_bool_obs t
            where t.value_numeric = 1;

            -- void numeric boolean obs
            update obs o
             inner join temp_bool_obs t on t.obs_id = o.obs_id
               set voided = 1,
                   voided_by = 1,
                   date_voided = now(),
                   void_reason = 'LSO-192 migrated to coded obs';

