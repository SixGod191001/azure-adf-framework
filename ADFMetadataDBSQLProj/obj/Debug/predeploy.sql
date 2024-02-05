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
IF OBJECT_ID(N'[dbo].[ExecutionLogBackup]') IS NOT NULL DROP TABLE [dbo].[ExecutionLogBackup];

IF OBJECT_ID(N'[metadata].[ExecutionLog]') IS NOT NULL --check for new deployments
BEGIN
	SELECT 
		*
	INTO
		[dbo].[ExecutionLogBackup]
	FROM
		[metadata].[ExecutionLog];
END;
IF OBJECT_ID(N'[dbo].[ErrorLogBackup]') IS NOT NULL DROP TABLE [dbo].[ErrorLogBackup];

IF OBJECT_ID(N'[metadata].[ErrorLog]') IS NOT NULL --check for new deployments
BEGIN
	SELECT 
		*
	INTO
		[dbo].[ErrorLogBackup]
	FROM
		[metadata].[ErrorLog];
END;

--delete all
--PipelineProcesses
IF EXISTS 
	(
	SELECT
		* 
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'PipelineProcesses'
		AND s.[name] = 'metadata'
		AND o.[type] = 'U' --Check for tables as created synonyms to support backwards compatability
	)
	BEGIN
		--drop just to avoid constraints
		IF OBJECT_ID(N'[metadata].[PipelineParameters]') IS NOT NULL DROP TABLE [metadata].[PipelineParameters];
		IF OBJECT_ID(N'[metadata].[PipelineAuthLink]') IS NOT NULL DROP TABLE [metadata].[PipelineAuthLink];

		SELECT * INTO [dbo].[zz_PipelineProcesses] FROM [metadata].[PipelineProcesses];

		DROP TABLE [metadata].[PipelineProcesses];
	END

--ProcessingStageDetails
IF EXISTS 
	(
	SELECT
		* 
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'ProcessingStageDetails'
		AND s.[name] = 'metadata'
		AND o.[type] = 'U' --Check for tables as created synonyms to support backwards compatability
	)
	BEGIN
		SELECT * INTO [dbo].[zz_ProcessingStageDetails] FROM [metadata].[ProcessingStageDetails];
		
		DROP TABLE [metadata].[ProcessingStageDetails];
	END;

--DataFactoryDetails
IF EXISTS 
	(
	SELECT
		* 
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'DataFactoryDetails'
		AND s.[name] = 'metadata'
		AND o.[type] = 'U' --Check for tables as created synonyms to support backwards compatability
	)
	BEGIN
		SELECT * INTO [dbo].[zz_DataFactoryDetails] FROM [metadata].[DataFactoryDetails];
		
		DROP TABLE [metadata].[DataFactoryDetails];
	END;

--DataFactorys
IF EXISTS 
	(
	SELECT
		* 
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'DataFactorys'
		AND s.[name] = 'metadata'
		AND o.[type] = 'U' --Check for tables as created synonyms to support backwards compatability
	)
	BEGIN
		SELECT * INTO [dbo].[zz_DataFactorys] FROM [metadata].[DataFactorys];
	END;
IF OBJECT_ID(N'tempdb..#DropLegacyObjects') IS NOT NULL DROP PROCEDURE #DropLegacyObjects;
GO

CREATE PROCEDURE #DropLegacyObjects
	(
	@ObjectName NVARCHAR(128),
	@ObjectType CHAR(2)
	)
AS
BEGIN
	DECLARE @DDLType NVARCHAR(128)

	IF EXISTS
		(
		SELECT
			*
		FROM
			sys.objects o
			INNER JOIN sys.schemas s
				ON o.[schema_id] = s.[schema_id]
		WHERE
			o.[Name] = @ObjectName
			AND s.[name] = 'metadata'
			AND o.[type] = @ObjectType
		)
		BEGIN			
			SELECT
				@DDLType = CASE @ObjectType
								WHEN 'P' THEN 'PROCEDURE'
								WHEN 'V' THEN 'VIEW'
								WHEN 'FN' THEN 'FUNCTION'
							END;

			EXEC('DROP ' + @DDLType + ' [metadata].[' + @ObjectName + '];')
		END;
END;
GO

EXEC #DropLegacyObjects 'AddProperty', 'P';
EXEC #DropLegacyObjects 'GetExecutionDetails', 'P';
EXEC #DropLegacyObjects 'AddRecipientPipelineAlerts', 'P';
EXEC #DropLegacyObjects 'DeleteRecipientAlerts', 'P';
EXEC #DropLegacyObjects 'CheckStageAndPiplineIntegrity', 'P';
EXEC #DropLegacyObjects 'AddPipelineDependant', 'P';
EXEC #DropLegacyObjects 'AddServicePrincipalWrapper', 'P';
EXEC #DropLegacyObjects 'AddServicePrincipalUrls', 'P';
EXEC #DropLegacyObjects 'AddServicePrincipal', 'P';
EXEC #DropLegacyObjects 'DeleteServicePrincipal', 'P';
EXEC #DropLegacyObjects 'CheckForValidURL', 'FN';
EXEC #DropLegacyObjects 'PipelineDependencyChains', 'V';
EXEC #DropLegacyObjects 'AverageStageDuration', 'V';
EXEC #DropLegacyObjects 'CompleteExecutionErrorLog', 'V';
EXEC #DropLegacyObjects 'CompleteExecutionLog', 'V';
EXEC #DropLegacyObjects 'CurrentExecutionSummary', 'V';
EXEC #DropLegacyObjects 'LastExecution', 'V';
EXEC #DropLegacyObjects 'LastExecutionSummary', 'V';
EXEC #DropLegacyObjects 'WorkerParallelismOverTime', 'V';

--replaced with new precursor concept in v1.8.5:
IF OBJECT_ID(N'[dbo].[SetRandomWaitValues]') IS NOT NULL DROP PROCEDURE [dbo].[SetRandomWaitValues];
	--BatchExecution
	IF OBJECT_ID(N'[metadata].[BatchExecution]') IS NOT NULL
		BEGIN
			TRUNCATE TABLE [metadata].[BatchExecution];
		END;

	--CurrentExecution
	IF OBJECT_ID(N'[metadata].[CurrentExecution]') IS NOT NULL
		BEGIN
			TRUNCATE TABLE [metadata].[CurrentExecution];
		END;

	--ExecutionLog
	IF OBJECT_ID(N'[metadata].[ExecutionLog]') IS NOT NULL
		BEGIN
			TRUNCATE TABLE [metadata].[ExecutionLog];
		END

	--ErrorLog
	IF OBJECT_ID(N'[metadata].[ExecutionLog]') IS NOT NULL
		BEGIN
			TRUNCATE TABLE [metadata].[ErrorLog];
		END

	--BatchStageLink
	IF OBJECT_ID(N'[metadata].[BatchStageLink]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[BatchStageLink];
		END;

	--Batches
	IF OBJECT_ID(N'[metadata].[Batches]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Batches];
		END;

	--PipelineDependencies
	IF OBJECT_ID(N'[metadata].[PipelineDependencies]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[PipelineDependencies];
			DBCC CHECKIDENT ('[metadata].[PipelineDependencies]', RESEED, 0);
		END;

	--PipelineAlertLink
	IF OBJECT_ID(N'[metadata].[PipelineAlertLink]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[PipelineAlertLink];
			DBCC CHECKIDENT ('[metadata].[PipelineAlertLink]', RESEED, 0);
		END;

	--Recipients
	IF OBJECT_ID(N'[metadata].[Recipients]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Recipients];
			DBCC CHECKIDENT ('[metadata].[Recipients]', RESEED, 0);
		END;

	--AlertOutcomes
	IF OBJECT_ID(N'[metadata].[AlertOutcomes]') IS NOT NULL
		BEGIN
			TRUNCATE TABLE [metadata].[AlertOutcomes];
		END;

	--PipelineAuthLink
	IF OBJECT_ID(N'[metadata].[PipelineAuthLink]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[PipelineAuthLink];
			DBCC CHECKIDENT ('[metadata].[PipelineAuthLink]', RESEED, 0);
		END;

	--ServicePrincipals
	IF OBJECT_ID(N'[dbo].[ServicePrincipals]') IS NOT NULL 
		BEGIN
			DELETE FROM [dbo].[ServicePrincipals];
			DBCC CHECKIDENT ('[dbo].[ServicePrincipals]', RESEED, 0);
		END;

	--Properties
	IF OBJECT_ID(N'[metadata].[Properties]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Properties];
			DBCC CHECKIDENT ('[metadata].[Properties]', RESEED, 0);
		END;

	--PipelineParameters
	IF OBJECT_ID(N'[metadata].[PipelineParameters]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[PipelineParameters];
			DBCC CHECKIDENT ('[metadata].[PipelineParameters]', RESEED, 0);
		END;

	--Pipelines
	IF OBJECT_ID(N'[metadata].[Pipelines]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Pipelines];
			DBCC CHECKIDENT ('[metadata].[Pipelines]', RESEED, 0);
		END;

	--Orchestrators
	IF EXISTS 
		(
		SELECT
			* 
		FROM
			sys.objects o
			INNER JOIN sys.schemas s
				ON o.[schema_id] = s.[schema_id]
		WHERE
			o.[name] = 'DataFactorys'
			AND s.[name] = 'metadata'
			AND o.[type] = 'U' --Check for tables as created synonyms to support backwards compatability
		)
		BEGIN
			DELETE FROM [metadata].[DataFactorys];
		END;

	IF OBJECT_ID(N'[metadata].[Orchestrators]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Orchestrators];
			DBCC CHECKIDENT ('[metadata].[Orchestrators]', RESEED, 0);
		END;

	--Stages
	IF OBJECT_ID(N'[metadata].[Stages]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Stages];
			DBCC CHECKIDENT ('[metadata].[Stages]', RESEED, 0);
		END;

	--Subscriptions
	IF OBJECT_ID(N'[metadata].[Subscriptions]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Subscriptions];
		END;
	
	--Tenants
	IF OBJECT_ID(N'[metadata].[Tenants]') IS NOT NULL
		BEGIN
			DELETE FROM [metadata].[Tenants];
		END;
GO
