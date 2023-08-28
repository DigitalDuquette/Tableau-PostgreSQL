/*
    last 6 months of historical data.
*/
SELECT COALESCE(su.friendly_name, husr.name) AS "User Name",
       CASE WHEN su.name LIKE '_%' THEN 'system accounts'
            WHEN su.email IS NULL AND su.name LIKE '_%' THEN 'kiosk accounts'
            ELSE 'user' END AS "user group", husr.system_user_id AS "Historical User ID",
       he.historical_event_type_id AS "Action - ID", het.name AS "Action - What did you do?",
       het.action_type AS "Action - Group",
       (he.created_at - INTERVAL '9 hour') AT TIME ZONE 'EST' AS "Action - DateTime", hv.name AS "Accessed View Name",
       REPLACE(v.repository_url, '/sheets', '') AS "Accessed View URL", hp.name AS "Accessed Project Name",
       p.id AS "Accessed Project URL", hw.name AS "Accessed Workbook Name", w.id AS "Accessed Workbook URL",
       hd.name AS "Accessed Datasource Name", d.id AS "Accessed Datasource URL", hw.revision,
       ((CAST(SPLIT_PART(hw.revision, '.', 1) AS INT) - 1) * 10 + CAST(SPLIT_PART(hw.revision, '.', 2) AS INT) +
        1) AS "Server Revision"
  FROM historical_events AS he
           LEFT OUTER JOIN hist_users AS husr
           ON (he.hist_actor_user_id = husr.id)
           LEFT OUTER JOIN users AS usr
           ON (husr.system_user_id = usr.id)
           INNER JOIN historical_event_types AS het
           ON (he.historical_event_type_id = het.type_id)
           LEFT OUTER JOIN hist_views AS hv
           ON (he.hist_view_id = hv.id)
           LEFT OUTER JOIN hist_projects AS hp
           ON (he.hist_project_id = hp.id)
           LEFT OUTER JOIN hist_workbooks AS hw
           ON (he.hist_workbook_id = hw.id)
           LEFT OUTER JOIN hist_datasources AS hd
           ON (he.hist_datasource_id = hd.id)
           LEFT OUTER JOIN system_users AS su
           ON (husr.system_user_id = su.id)
           LEFT OUTER JOIN views AS v
           ON (hv.repository_url = v.repository_url)
           LEFT OUTER JOIN workbooks AS w
           ON (hw.workbook_id = w.id)
           LEFT OUTER JOIN projects AS p
           ON (hp.project_id = p.id)
           LEFT OUTER JOIN datasources AS d
           ON (hd.datasource_id = d.id)
 WHERE he.is_failure = 'False' /* exclude failed historical events */