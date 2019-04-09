/* 
    Server users. 
*/

select 
    husr.name AS "user id", 
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
        WHEN usr.site_role_id = 0 THEN 'SiteAdministrator'
        WHEN usr.site_role_id = 1 THEN 'SupportUser' 
        WHEN usr.site_role_id = 2 THEN 'Publisher' 
        WHEN usr.site_role_id = 3 THEN 'Interactor' 
        WHEN usr.site_role_id = 4 THEN 'ViewerWithPublish' 
        WHEN usr.site_role_id = 5 THEN 'Viewer' 
        WHEN usr.site_role_id = 6 THEN 'UnlicensedWithPublish' 
        WHEN usr.site_role_id = 7 THEN 'Guest' 
        WHEN usr.site_role_id = 8 THEN 'Unlicensed' 
        WHEN usr.site_role_id = 9 THEN 'BasicUser' 
    END AS "server role"
    
from hist_users AS husr 
    left outer join system_users AS su ON ( husr.system_user_id = su.id ) --husr.name = su.name )
    left outer join users AS usr ON ( husr.system_user_id = usr.id )
