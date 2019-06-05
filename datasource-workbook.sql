/*
	
	What data sources are used? 

	Shows published and non-published data sources from Excel workbooks to database connections. 
*/

SELECT
	ds.is_certified AS "Certified Datasource", 
	ds.name AS "Tableau Datasource Name", 
	dc.dbname AS "Datasource Name", 
	dc.server AS "Datasource Server", 
	ds.db_class AS "Data Connection Type", 
	dc.username AS "User Name", 
	dc.owner_type AS "Workbook or Datasource",
	CASE 
		WHEN dc.owner_type = 'Datasource' THEN ds.name  
		ELSE wkb.name 
	END AS "Workbook or Datasource name"
FROM data_connections AS dc 
    INNER JOIN datasources AS ds ON ( dc.datasource_id = ds.id )
    LEFT OUTER JOIN workbooks AS wkb ON ( wkb.id = dc.owner_id )
 
ORDER BY 
	ds.name ASC 

	

	
	
	
	
	
	