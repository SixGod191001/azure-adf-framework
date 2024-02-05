-- This file contains SQL statements that will be executed before the build script.
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--data
:r .\LogData\ExecutionLogBackup.sql
:r .\LogData\ErrorLogBackup.sql

--delete all
:r .\Metadata\DropLegacyTables.sql
:r .\Metadata\DropLegacyObjects.sql
:r .\Metadata\DeleteAll.sql

--drop all if previous script not update to date, use below script to drop all without backup, take care
--:r .\Metadata\DropAll.sql