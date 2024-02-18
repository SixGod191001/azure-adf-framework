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