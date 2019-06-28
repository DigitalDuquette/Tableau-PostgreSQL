
/*
    what groups is someone in
*/ 
select 
    * 
from group_users as gu 
    inner join users_view as uv on ( gu.user_id = uv.id )
    left outer join groups on ( gu.group_id = groups.id )
