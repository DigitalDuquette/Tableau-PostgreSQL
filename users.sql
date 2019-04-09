/* 
    Server users. 
*/

select 
    su.name AS "user id", 
        /* something is weird with dates
            cast as EST and it's 9 hours off
            leave alone and it's 4 hours off.  
            casting as EST and then taking away the 9 hours. 
         */
    (su.created_at - interval '9 hour') AT TIME ZONE 'EST' AS "user added to server on",
    (usr.login_at - interval '9 hour') AT TIME ZONE 'EST' AS "user last logged in on", 
    su.email AS "user email",
    su.friendly_name AS "user name", 
    CASE  
        WHEN usr.site_role_id = 0 THEN CAST(usr.site_role_id AS varchar)
        WHEN usr.site_role_id = 1 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 2 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 3 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 4 THEN CAST(usr.site_role_id AS varchar)
        WHEN usr.site_role_id = 5 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 6 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 7 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 8 THEN CAST(usr.site_role_id AS varchar) 
        WHEN usr.site_role_id = 9 THEN CAST(usr.site_role_id AS varchar) 
        ELSE CAST(usr.site_role_id AS varchar)
    END AS "server role"
    
from system_users AS su  
    left outer join users AS usr ON ( su.id = usr.id )

where 
    su.name = 'jtduqu'

    