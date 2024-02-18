/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
--load default metadata
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
EXEC [metadataHelpers].[SetDefaultRecipients];
EXEC [metadataHelpers].[SetDefaultAlertOutcomes];
EXEC [metadataHelpers].[SetDefaultRecipientPipelineAlerts]

--restore log data
DECLARE @Columns VARCHAR(MAX) = '';
DECLARE @Values VARCHAR(MAX) = '';
DECLARE @SQL VARCHAR(MAX) = '';

IF EXISTS
	(
	SELECT
		*
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'ExecutionLog'
		AND s.[name] = 'metadata'
	)
	AND EXISTS
	(
	SELECT
		*
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'ExecutionLogBackup'
		AND s.[name] = 'dbo'
	)
	BEGIN
		;WITH oldTableColumns AS
			(
			SELECT
				c.[name] AS ColName
			FROM
				sys.objects o
				INNER JOIN sys.schemas s
					ON o.[schema_id] = s.[schema_id]
				INNER JOIN sys.columns c
					ON o.[object_id] = c.[object_id]
			WHERE
				s.[name] = 'dbo'
				AND o.[name] = 'ExecutionLogBackup'
				AND c.[name] <> 'LogId'
			),
			newTableColumns AS
			(
			SELECT
				c.[column_id] AS ColId,
				c.[name] AS ColName
			FROM
				sys.objects o
				INNER JOIN sys.schemas s
					ON o.[schema_id] = s.[schema_id]
				INNER JOIN sys.columns c
					ON o.[object_id] = c.[object_id]
			WHERE
				s.[name] = 'metadata'
				AND o.[name] = 'ExecutionLog'
				AND c.[name] <> 'LogId'
			)
		SELECT  
			@Columns += QUOTENAME(newTableColumns.[ColName]) + ',' + CHAR(13),
			@Values += ISNULL(QUOTENAME(oldTableColumns.[ColName]),'NULL AS ''' + newTableColumns.[ColName] + '''' ) + ',' + CHAR(13)
		FROM
			newTableColumns 
			LEFT OUTER JOIN oldTableColumns
				ON newTableColumns.[ColName] = oldTableColumns.[ColName];

		SET @Columns = LEFT(@Columns,LEN(@Columns)-2);
		SET @Values = LEFT(@Values,LEN(@Values)-2);

		SET @SQL = 
		'
		INSERT INTO [metadata].[ExecutionLog]
		(
		' + @Columns + '
		)
		SELECT
		' + @Values + '
		FROM
			[dbo].[ExecutionLogBackup]
		';

		PRINT @SQL;
		EXEC(@SQL);

		DECLARE @Before INT = (SELECT COUNT(0) FROM [dbo].[ExecutionLogBackup]);
		DECLARE @After INT = (SELECT COUNT(0) FROM [metadata].[ExecutionLog]);

		IF (@Before = @After)
		BEGIN
			DROP TABLE [dbo].[ExecutionLogBackup]
		END;
	END;
DECLARE @ErrColumns VARCHAR(MAX) = '';
DECLARE @ErrValues VARCHAR(MAX) = '';
DECLARE @ErrSQL VARCHAR(MAX) = '';

IF EXISTS
	(
	SELECT
		*
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'ErrorLog'
		AND s.[name] = 'metadata'
	)
	AND EXISTS
	(
	SELECT
		*
	FROM
		sys.objects o
		INNER JOIN sys.schemas s
			ON o.[schema_id] = s.[schema_id]
	WHERE
		o.[name] = 'ErrorLogBackup'
		AND s.[name] = 'dbo'
	)
	BEGIN
		;WITH oldTableColumns AS
			(
			SELECT
				c.[name] AS 'ColName'
			FROM
				sys.objects o
				INNER JOIN sys.schemas s
					ON o.[schema_id] = s.[schema_id]
				INNER JOIN sys.columns c
					ON o.[object_id] = c.[object_id]
			WHERE
				s.[name] = 'dbo'
				AND o.[name] = 'ErrorLogBackup'
				AND c.[name] != 'LogId'
			),
			newTableColumns AS
			(
			SELECT
				c.[column_id] AS 'ColId',
				c.[name] AS 'ColName'
			FROM
				sys.objects o
				INNER JOIN sys.schemas s
					ON o.[schema_id] = s.[schema_id]
				INNER JOIN sys.columns c
					ON o.[object_id] = c.[object_id]
			WHERE
				s.[name] = 'metadata'
				AND o.[name] = 'ErrorLog'
				AND c.[name] != 'LogId'
			)
		SELECT  
			@ErrColumns += QUOTENAME(newTableColumns.[ColName]) + ',' + CHAR(13),
			@ErrValues += ISNULL(QUOTENAME(oldTableColumns.[ColName]),'NULL AS ''' + newTableColumns.[ColName] + '''' ) + ',' + CHAR(13)
		FROM
			newTableColumns 
			LEFT OUTER JOIN oldTableColumns
				ON newTableColumns.[ColName] = oldTableColumns.[ColName];

		SET @ErrColumns = LEFT(@ErrColumns,LEN(@ErrColumns)-2);
		SET @ErrValues = LEFT(@ErrValues,LEN(@ErrValues)-2);

		SET @ErrSQL = 
		'
		INSERT INTO [metadata].[ErrorLog]
		(
		' + @ErrColumns + '
		)
		SELECT
		' + @ErrValues + '
		FROM
			[dbo].[ErrorLogBackup]
		';

		PRINT @ErrSQL;
		EXEC(@ErrSQL);

		DECLARE @ErrBefore INT = (SELECT COUNT(0) FROM [dbo].[ErrorLogBackup]);
		DECLARE @ErrAfter INT = (SELECT COUNT(0) FROM [metadata].[ErrorLog]);

		IF (@ErrBefore = @ErrAfter)
		BEGIN
			DROP TABLE [dbo].[ErrorLogBackup]
		END;
	END

--object transfers
IF OBJECT_ID(N'tempdb..#TransferHelperObjects') IS NOT NULL DROP PROCEDURE #TransferHelperObjects;
GO

CREATE PROCEDURE #TransferHelperObjects
	(
	@ObjectName NVARCHAR(128),
	@ObjectType CHAR(2)
	)
AS
BEGIN
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
			PRINT 'Transferring: ' + @ObjectName;
			EXEC('ALTER SCHEMA [metadataHelpers] TRANSFER [metadata].[' + @ObjectName + '];')
		END;
END;
GO

EXEC #TransferHelperObjects 'AddProperty', 'P';
EXEC #TransferHelperObjects 'GetExecutionDetails', 'P';
EXEC #TransferHelperObjects 'AddRecipientPipelineAlerts', 'P';
EXEC #TransferHelperObjects 'DeleteRecipientAlerts', 'P';
EXEC #TransferHelperObjects 'CheckStageAndPiplineIntegrity', 'P';
EXEC #TransferHelperObjects 'AddPipelineDependant', 'P';
EXEC #TransferHelperObjects 'AddServicePrincipalWrapper', 'P';
EXEC #TransferHelperObjects 'AddServicePrincipalUrls', 'P';
EXEC #TransferHelperObjects 'AddServicePrincipal', 'P';
EXEC #TransferHelperObjects 'DeleteServicePrincipal', 'P';
EXEC #TransferHelperObjects 'CheckForValidURL', 'FN';
EXEC #TransferHelperObjects 'PipelineDependencyChains', 'V';
IF OBJECT_ID(N'tempdb..#TransferReportingObjects') IS NOT NULL DROP PROCEDURE #TransferReportingObjects;
GO

CREATE PROCEDURE #TransferReportingObjects
	(
	@ObjectName NVARCHAR(128),
	@ObjectType CHAR(2)
	)
AS
BEGIN
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
			PRINT 'Transferring: ' + @ObjectName;
			EXEC('ALTER SCHEMA [metadataHelpers] TRANSFER [metadata].[' + @ObjectName + '];')
		END;
END;
GO

EXEC #TransferReportingObjects 'PipelineDependencyChains', 'V';


--replace old objects
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
		DROP TABLE [metadata].[DataFactorys];

		EXEC('CREATE VIEW [metadata].[DataFactorys]
AS
SELECT
	[OrchestratorId] AS DataFactoryId,
	[OrchestratorName] AS DataFactoryName,
	[ResourceGroupName],
	[SubscriptionId],
	[Description]
FROM
	[metadata].[Orchestrators]
WHERE
	[OrchestratorType] = ''ADF'';')
	END;
GO
