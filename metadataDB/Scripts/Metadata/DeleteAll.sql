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