/*
    last 6 months of historical data. 
*/
select 
    COALESCE(su.friendly_name, husr.name) AS "User Name",
    CASE 
        WHEN su.name IN ( '_system', 'guest' ) THEN 'unused system accounts'
        WHEN su.name = '_tableau' THEN 'run as user' 
        WHEN su.email IS NULL AND su.name NOT IN ( '_system', 'guest', '_tableau' ) THEN 'kiosk accounts'
        ELSE 'user'
    END AS "user group", 
    husr.system_user_id AS "Historical User ID", 
    he.historical_event_type_id AS "Action - ID", 
    het.name AS "Action - What did you do?", 
    het.action_type AS "Action - Group", 
    (he.created_at - interval '9 hour') AT TIME ZONE 'EST' AS "Action - DateTime", 
    hv.name AS "Accessed View Name", 
    REPLACE(v.repository_url, '/sheets', '') AS "Accessed View URL",
    hp.name AS "Accessed Project Name", 
    p.id AS "Accessed Project URL",
    hw.name AS "Accessed Workbook Name", 
    w.id AS "Accessed Workbook URL", 
    hd.name AS "Accessed Datasource Name", 
    d.id AS "Accessed Datasource URL"
    
from historical_events AS he 
    left outer join hist_users AS husr ON ( he.hist_actor_user_id = husr.id )
    left outer join users AS usr ON ( husr.system_user_id = usr.id )
    inner join historical_event_types AS het ON ( he.historical_event_type_id = het.type_id )
    left outer join hist_views as hv ON ( he.hist_view_id = hv.id )
    left outer join hist_projects AS hp ON ( he.hist_project_id = hp.id )
    left outer join hist_workbooks AS hw ON ( he.hist_workbook_id = hw.id )
    left outer join hist_datasources AS hd ON ( he.hist_datasource_id = hd.id )
    left outer join system_users AS su ON ( husr.system_user_id = su.id )
    left outer join views AS v ON ( hv.repository_url = v.repository_url )
    left outer join workbooks AS w ON ( hw.workbook_id = w.id )
    left outer join projects AS p ON ( hp.project_id = p.id ) 
    left outer join datasources AS d ON ( hd.datasource_id = d.id )
where 
    he.is_failure = 'False' /* exclude failed historical events */ 
