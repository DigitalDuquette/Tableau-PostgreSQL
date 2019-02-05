/*
	data_connections has 756 rows  
	
	inside data_connections, not all listings are the data sources that are in a workbook, this also represents all of the records inside of published data sources.  
*/

SELECT
	ds.is_certified AS CertifiedDataSource, 
	ds.name AS DataSourceName, 
	dc.owner_type,
	wkb."name",
	''  
    -- dc.*, 
    -- ds.* 
FROM data_connections AS dc 
    inner join datasources AS ds ON ( dc.datasource_id = ds.id )
    left outer join workbooks as wkb ON ( wkb.id = dc.owner_id )
 
--WHERE 
--	ds.is_certified = TRUE 
ORDER BY 
	ds.name asc 
	
	
	