/* 
===================================================================
Create Database and Schemas
===================================================================
script purpose:
  This script creates a new database named 'Datawarehouse' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database: bronze, silver, gold. 

Warning:
  Running this script will drop the entire 'Datawarehouse' database if it exists. 
  All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/

USE Master;
GO
--Drop and recreate the 'DataWarehouse' database--
IF EXISTS(SELECT 1 FROM sys.databases WHERE name= 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
--Create the 'DataWarehouse' Database--
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO
--Create Schemas--
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
