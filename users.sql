/* 
    Server users. 
*/

select 
    LOWER(su.name) AS "user id", 
    (su.created_at - interval '9 hour') AT TIME ZONE 'EST' AS "user added to server on",
    (usr.login_at - interval '9 hour') AT TIME ZONE 'EST' AS "user last logged in on", 
    su.email AS "user email",
    su.friendly_name AS "user name", 
    CASE  
        WHEN usr.site_role_id = 0 THEN 'Site Administrator Explorer'
        WHEN usr.site_role_id = 2 THEN 'Explorer (can publish)' 
        WHEN usr.site_role_id = 3 THEN 'Explorer'  
        WHEN usr.site_role_id = 7 THEN 'Guest'
        WHEN usr.site_role_id = 8 THEN 'Unlicensed' 
        WHEN usr.site_role_id = 9 THEN 'Viewer' 
        WHEN usr.site_role_id = 10 AND su.admin_level = 0 THEN 'Creator'
        WHEN usr.site_role_id = 10 AND su.admin_level = 10 THEN 'Server Administrator'
        WHEN usr.site_role_id = 11 THEN 'Site Administrator Creator'
        ELSE 'Undefined (depricated) role'
    END AS "site role",
    s.name AS "site name", 
    CASE 
        WHEN su.name IN ( '_system', 'guest' ) THEN 'unused system accounts'
        WHEN su.name = '_tableau' THEN 'run as user' 
        WHEN su.email IS NULL AND su.name NOT IN ( '_system', 'guest', '_tableau' ) THEN 'kiosk accounts'
        ELSE 'user'
    END AS "user group"
from system_users AS su  
    left outer join users AS usr ON ( su.id = usr.id )
    inner join sites AS s ON ( usr.site_id = s.id )

    