SELECT 
    wkbk.description AS WorkbookDetails_about, 
    CAST(CASE 
        /* PURPOSE:
        Checks About section for more text than the template expected: 

            *Process Owner*: 
            *Functional Expert*: 
            *Technical Expert*: 
        */  
        WHEN 
        ( 
            length(wkbk.description) > 59 
            AND 
            (
                wkbk.description LIKE '%Process Owner%'
                AND wkbk.description LIKE '%Functional Expert%' 
                AND wkbk.description LIKE '%Technical Expert%' 
            )
        ) THEN 1 
        ELSE 0 
    END AS bit) AS ContainsAboutSection,  
    wkbk.id AS WorkbookID, 
    wkbk.name AS WorkbookName, 
    wkbk.repository_url AS WorkbookViewURL,
        /* PURPOSE 
            Use in servername.com/#/views/[WorkbookViewURL]
        */
    wkbk.created_at AT TIME ZONE 'EST' AS "Created (EST)",
    wkbk.updated_at AT TIME ZONE 'EST' AS "Updated (EST)", 
    wkbk.*
FROM workbooks AS wkbk 
-- WHERE 
--     length(wkbk.description) > 59
--     AND 
--     (
--         wkbk.description LIKE '%Process Owner%'
--         AND wkbk.description LIKE '%Functional Expert%' 
--         AND wkbk.description LIKE '%Technical Expert%' 
--     )
--     /* PURPOSE:
--         Checks About section for more text than the template expected: 

--             *Process Owner*: 
--             *Functional Expert*: 
--             *Technical Expert*: 
--     */


-- and wkbk.name = 'Information Technology Monthly Review'


-- LIMIT 10 
/* 
Monthly overview for Information Technology department metrics.  

*Process Owner*: Chad Brouwer
*Functional Expert*: Chad Brouwer
*Technical Expert*: Jared Duquette

*/