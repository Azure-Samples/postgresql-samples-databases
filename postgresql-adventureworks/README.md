# AdventureWorks database for Azure Database for PostgreSQL Flexible Server
This project restores the SQL Server AdventureWorks 2016 database backup converted to PostgreSQL schema to an Azure Database for PostgreSQL Flexible Server instance.  
## 1.  Provision an Azure Database for PostgreSQL Flexible Server instance
1.  Open the script CreatePostgreSQLFlexibleServer.ps1 in Visual Studio Code or PowerShell ISE.  
2.  Alter the parameters for the function to match what you want the servername, resource group, region and server parameters to be.  
![Server Parameters.](media/1a-RunFunction.JPG 'Server Parameters')  
3.  The script call will output a Server object which we can use to get the Fully Qualified Name of the server.  We will use this server name to connect to the PostgreSQL database via psql.  
The output will look similar to this:  
![Fully Qualified Server Name.](media/1b-ServerName.JPG 'Server Name')

## 2.  Create the AdventureWorks database on the Azure Database for PostgreSQL Flexible Server
1.  Download and install PGAdmin:  https://www.pgadmin.org/download/
2.  Navigate to where PGAdmin is installed (the location of D:\Program Files\pgAdmin 4\v5\runtime on this test machine) and open a Command Prompt.
3.  Execute the following command to connect to the PostgreSQL Flexible Server.  Be sure to use the Fully Qualified Name of your server and to enter your Password when prompted.  
```
   psql.exe "host=timchapflexpgtest6.postgres.database.azure.com port=5432 dbname=postgres user=timchapman"
   ```
The output will look similar to the following:  
![Server Login.](media/2a-PSQLLogin.JPG 'PSQL Login')
4.  Create the AdventureWorks database by using the following SQL statement:  
```
CREATE DATABASE adventureworks;
```
Which will have output similar to the following:
![Create Database.](media/2b-CreateDatabase.JPG 'Create Database')

## 3.  Restore the AdventureWorks database on the Azure Database for PostgreSQL Flexible Server
1.  Execute the pg_restore below.  Be sure to use the Fully Qualified Name of your server and the location of where you've cloned this repo.
```
pg_restore -h timchapflexpgtest6.postgres.database.azure.com -U timchapman  -d adventureworks D:/GitHub/postgresql-adventureworks/AdventureWorksPG.gz 
```
The output should look similar to the following.  **Note:  This script returns 2 Azure extension related errors.  These can be safely ignored.**
![Restore Database.](media/3a-RestoreDatabase.JPG 'Restore Database')

## 4.  Log into the AdventureWorks database via pgAdmin
1.  Open pgAdmin.  You may need to set up a password if this is your first time using it.
2.  Under Browser, right click and choose Create-->Server Group. Give the Server Group a name and then Choose Save. Mine is named Flexible.
3.  Enter the name of the Azure Database for PostgreSQL Flexible Server along with the username you chose when you created the Server.  The output will look similar to the following:  
![Register Server](media/4a-RegisterServer.JPG 'Register Server')  
4.  Expand the database in the Browser to view the AdventureWorks tables.   
![Expand AW](media/4b-AWExpanded.JPG  'Expand AW')