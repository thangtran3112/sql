# SQL various samples

## [Installation of SQL and using extensionson VSCode](https://www.youtube.com/watch?v=7mz73uXD9DA&t=906s)

- Using SQL Tools with variable driver extensions to PostGreSQL, MySQL, SQLite, etc. We can use a single IDE to connect to multiple databases.
- [SQLTools Extension](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools)
- [SQLTools Postgres Driver Extension](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools-driver-pg)
- Prettier SQL Formatter or SQL Tools formatter (which is built-in with SQL Tools).

## Connecting to PostgreSQL or any SQL database

![Create connection to local PostgreSQL](./images/SqlToolConnecting.png)
![Saving your query results into CSV or JSON](./images/SqlToolSavingResult.png)

## Local PostgreSQL import of CSV files

- Password: `Password@123`
- [Download csv_files](https://drive.google.com/drive/folders/1moeWYoUtUklJO6NJdWo9OV8zWjRn0rjN) into VsCode workspace and Open pgAdmin
- In Object Explorer (left-hand pane), navigate to `sql_course` database
- Right-click `sql_course` and select `PSQL Tool`
  - This opens a terminal window to write the following code
- Get the absolute file path of your csv files
  1.  Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
- Paste the following into `PSQL Tool`, (with the CORRECT file path)

```
\copy company_dim FROM '/Users/thangtran/sql/csv_files/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '/Users/thangtran/sql/csv_files/skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM '/Users/thangtran/sql/csv_files/job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM '/Users/thangtran/sql/csv_files/skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
```
