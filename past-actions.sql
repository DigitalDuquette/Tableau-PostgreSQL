/*
    looks like this stores only the last 6 months of historical data. 
*/
select 
    COALESCE(su.friendly_name, husr.name) AS "User Name",
    husr.system_user_id AS "Historical User ID", 
    he.historical_event_type_id AS "Action - ID", 
    het.name AS "Action - What did you do?", 
    het.action_type AS "Action - Group", 
        /* something is weird with dates
            cast as EST and it's 9 hours off
            leave alone and it's 4 hours off.  
            casting as EST and then taking away the 9 hours. 
         */
    (he.created_at - interval '9 hour') AT TIME ZONE 'EST' AS "Action - DateTime", 
    -- he.hist_view_id AS "Access View ID",
    hv.name AS "Accessed View Name", 
    hv.repository_url AS "Accessed View URL",
    -- he.hist_project_id, 
    hp.name AS "Accessed Project Name", 
    -- he.hist_workbook_id, 
    -- hw.workbook_id, 
    hw.name AS "Accessed Workbook Name", 
    hw.repository_url AS "Accessed Workbook URL", 
    -- he.hist_datasource_id, 
    -- hd.datasource_id, 
    hd.name AS "Accessed Datasource Name", 
    hd.repository_url AS "Accessed Datasource URL"
from historical_events AS he 
    left outer join hist_users AS husr ON ( he.hist_actor_user_id = husr.id )
    left outer join users AS usr ON ( husr.system_user_id = usr.id )
    inner join historical_event_types AS het ON ( he.historical_event_type_id = het.type_id )
    left outer join hist_views as hv ON ( he.hist_view_id = hv.id )
    left outer join hist_projects AS hp ON ( he.hist_project_id = hp.id )
    left outer join hist_workbooks AS hw ON ( he.hist_workbook_id = hw.id )
    left outer join hist_datasources AS hd ON ( he.hist_datasource_id = hd.id )
    left outer join system_users AS su ON ( husr.system_user_id = su.id )
where 
    he.is_failure = 'False' /* exclude failed historical events */ 
    -- and hw.name = 'Headcount Over Time'
--     and husr.name = 'jjduqu'
--     and hw.name = 'Postgres Workbook Access Views'
-- order by 
--     he.created_at asc 



