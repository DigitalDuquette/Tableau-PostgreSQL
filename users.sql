/* 
    Server users. 
*/

select 
    husr.name AS "user id", 
    su.created_at AS "user added to server on",
    usr.login_at AS "user last logged in on", 
    su.email AS "user email",
    su.friendly_name AS "user name"
    
from hist_users AS husr 
    left outer join system_users AS su ON ( husr.system_user_id = su.id ) --husr.name = su.name )
    left outer join users AS usr ON ( husr.system_user_id = usr.id )
