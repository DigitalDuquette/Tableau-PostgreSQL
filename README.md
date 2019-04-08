# Tableau-PostgreSQL

Used in the custom SQL analysis for Tableau Server.  

Pumped to have [PostgreSQL in Azure Data Studio](https://digitalduquette.com/blog/2019/3/19/postgresql-in-azure-data-studio)! 

TODO: 

- [ ] 

**Query List**:

* datasource-workbook.sql
* workbooks.sql
* historical-events.sql
* subscriptions.sql
* past-actions.sql

## Data Sources

Used to look at data source use from published data sources to data sources that are included inside of a tableau workbook.

### datasource-workbook.sql

Shows connections in Tableau workbooks published to server.  This includes datasources that are published as extracts and live connections available in the datasource view as well as data sources that are included in the published Tableau workbooks.

### workbooks.sql

Workbook data.  

Primary focus is to show if analysts are missing About section information matching our data governance documentation needs.

### past-actions.sql

Each and every action taken by all Tableau Server users, from workbook access to view access, see the last 6 months of data on what actions were taken on server in detail.  

More information for recent term than the 'Who Has Seen This View' functionality built into server. 