-- /*
-- Post-Deployment Script Template							
-- --------------------------------------------------------------------------------------
--  This file contains SQL statements that will be appended to the build script.		
--  Use SQLCMD syntax to include a file in the post-deployment script.			
--  Example:      :r .\myfile.sql								
--  Use SQLCMD syntax to reference a variable in the post-deployment script.		
--  Example:      :setvar TableName MyTable							
--                SELECT * FROM [$(TableName)]					
-- --------------------------------------------------------------------------------------
-- */
-- --load default metadata
EXEC [metadataHelpers].[SetDefaultProperties];
EXEC [metadataHelpers].[SetDefaultTenant];
EXEC [metadataHelpers].[SetDefaultSubscription];
EXEC [metadataHelpers].[SetDefaultOrchestrators];
EXEC [metadataHelpers].[SetDefaultBatches];
EXEC [metadataHelpers].[SetDefaultStages];
EXEC [metadataHelpers].[SetDefaultBatchStageLink];
EXEC [metadataHelpers].[SetDefaultPipelines];
EXEC [metadataHelpers].[SetDefaultPipelineParameters];
EXEC [metadataHelpers].[SetDefaultPipelineDependants];
-- :r .\Metadata\Recipients.sql
-- :r .\Metadata\AlertOutcomes.sql
-- :r .\Metadata\RecipientAlertsLink.sql

-- --restore log data
-- :r .\LogData\ExecutionLogRestore.sql
-- :r .\LogData\ErrorLogRestore.sql

-- --object transfers
-- :r .\Metadata\TransferHelperObjects.sql
-- :r .\Metadata\TransferReportingObjects.sql

-- --replace old objects
-- :r .\Metadata\ReplaceDataFactorys.sql
GO
