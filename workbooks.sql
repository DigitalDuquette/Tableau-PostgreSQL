/*  

Author: Jared Duquette 
            @DigitalDuquette
            GitHub.com/DigitalDuquette
            DigitalDuquette.com 
Consuming Platform: Tableau
Created on: MM-DD-YY

Purpose:
    Workbook data from server. 

    Each record in workbooks is one workbook on server.

*****Change Log*****

Last Update        Name             Change Summary
MM-DD-YY           DUQ               summaryHere



*/ 


SELECT 
    wkbk.description AS WorkbookDetails_about, 
    (CASE 
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
        ) THEN 'true'
        ELSE 'false'
    END)::BOOLEAN AS "Contains About Section",  
    wkbk.id AS WorkbookID, 
    wkbk.name AS WorkbookName, 
    wkbk.repository_url AS WorkbookViewURL,
        /* PURPOSE 
            Use in servername.com/#/views/[WorkbookViewURL]
        */
    wkbk.created_at AT TIME ZONE 'EST' AS "Created (EST)",
    wkbk.first_published_at AT TIME ZONE 'EST' AS "First Published (EST)", 
    wkbk.updated_at AT TIME ZONE 'EST' AS "Updated (EST)", 
    wkbk.view_count AS WorkbookViewCount,
    
    wkbk.lock_version, 
    wkbk.revision, 
    wkbk.document_version, 
    -- TODO: add joins to lookup names
    wkbk.owner_id, 
    wkbk.project_id, 
    prj.name AS "Project Name"
    
    prj.* 
    -- wkbk.*
FROM workbooks AS wkbk 
    /* Each record == one workbook on server */
    INNER JOIN projects AS prj ON ( wkbk.project_id = prj.id )