# Tableau-PostgreSQL

Used in the custom SQL analysis for Tableau Server.  Primary functionality supported via `past-actions.sql`, a simple pgsql query against the PostgreSQL database Tableau uses.  Part of this release is a dashboard to bring visibility to server actions.

![dashboard](miscellany/img/dashboard.png)

**Query List**:

* datasource-workbook.sql
* workbooks.sql
* past-actions.sql
* subscriptions.sql
* past-actions.sql

## Dashboard

Primary data source, `past-actions.sql` powers a dashboard showing what actions users have taken over the last 6 months.  

![dashboard-gif](miscellany/img/using_dashboard.gif)

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
