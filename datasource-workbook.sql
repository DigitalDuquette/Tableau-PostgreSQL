/*
	
	inside data_connections, not all listings are the data sources that are in a workbook, this also represents all of the records inside of published data sources.  
*/

SELECT
	 
	ds.is_certified AS "Certified Data Source", 
	ds.name AS "Tableau Data Source Name", 
	dc.dbname AS "Data Source Name", 
	dc.server AS "Data Source Server", 
	ds.db_class AS "Data Connection Type", 
	dc.username, 
	dc.owner_type,
	CASE 
		WHEN dc.owner_type = 'Datasource' THEN ds.name  
		ELSE wkb.name 
	END AS "Workbook or data source name"
	
    -- dc.*, 
    -- ds.* 
FROM data_connections AS dc 
    inner join datasources AS ds ON ( dc.datasource_id = ds.id )
    left outer join workbooks as wkb ON ( wkb.id = dc.owner_id )
 
ORDER BY 
	ds.name asc 

	

	
	
	
	
	
	