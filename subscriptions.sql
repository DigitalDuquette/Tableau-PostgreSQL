/* IN PROGRESS
    bring visibility to subscriptions on server. 
*/

select 
    subs.* 
FROM _subscriptions AS subs 
    LEFT OUTER JOIN _customized_views AS cv ON ( subs.customized_view_id = cv.id )
    LEFT OUTER JOIN _users AS usr ON ( subs.user_id = usr.id ) 
limit 10 

