/*
	data_connections has 756 rows  
	
	inside data_connections, not all listings are the data sources that are in a workbook, this also represents all of the records inside of published data sources.  
*/

SELECT
	 
	ds.is_certified AS CertifiedDataSource, 
	ds.name AS DataSourceName, 
	dc.server AS DataSourceServer, 
	ds.db_class AS DataConnectionType, 
	dc.username, 
	 
	
	dc.owner_type,
	CASE 
		WHEN dc.owner_type = 'Datasource' THEN ds.name  
		ELSE wkb.name 
	END AS "Workbook or data source name",
	''  
    -- dc.*, 
    -- ds.* 
FROM data_connections AS dc 
    inner join datasources AS ds ON ( dc.datasource_id = ds.id )
    left outer join workbooks as wkb ON ( wkb.id = dc.owner_id )
 
--WHERE 
--	ds.is_certified = TRUE 
--	wkb.name = 'Content Usage Review'

ORDER BY 
	ds.name asc 
	
	
	
	
	