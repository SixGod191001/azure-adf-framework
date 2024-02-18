CREATE PROCEDURE [metadataHelpers].[SetDefaultOrchestrators]
AS
BEGIN
	DECLARE @Orchestrators TABLE 
		(
		[OrchestratorName] NVARCHAR(200) NOT NULL,
		[OrchestratorType] CHAR(3) NOT NULL,
		[IsFrameworkOrchestrator] BIT NOT NULL,
		[ResourceGroupName] NVARCHAR(200) NOT NULL,
		[SubscriptionId] UNIQUEIDENTIFIER NOT NULL,
		[Description] NVARCHAR(MAX) NULL
		)
	
	INSERT INTO @Orchestrators
		(
		[OrchestratorName],
		[OrchestratorType],
		[IsFrameworkOrchestrator],
		[Description],
		[ResourceGroupName],
		[SubscriptionId]
		)
	VALUES
		('ADFUniversalOrchestratorFramework','ADF',1,'Example Data Factory used for development.','adf.framework','930d2a20-dc22-431d-bdde-4a2916d0096b')--,
		--('FrameworkFactoryDev','ADF',0,'Example Data Factory used for development deployments.','ADF.metadata','12345678-1234-1234-1234-012345678910'),
		--('FrameworkFactoryTest','ADF',0,'Example Data Factory used for testing.','ADF.metadata','12345678-1234-1234-1234-012345678910'),
		--('WorkersFactory','ADF',0,'Example Data Factory used to house worker pipelines.','ADF.metadata','12345678-1234-1234-1234-012345678910'),
		--('metadataforsynapse','SYN',0,'Example Synapse instance used to house all pipelines.','ADF.metadata','12345678-1234-1234-1234-012345678910')
		;

	MERGE INTO [metadata].[Orchestrators] AS tgt
	USING 
		@Orchestrators AS src
			ON tgt.[OrchestratorName] = src.[OrchestratorName]
				AND tgt.[OrchestratorType] = src.[OrchestratorType]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[IsFrameworkOrchestrator] = src.[IsFrameworkOrchestrator],
			tgt.[Description] = src.[Description],
			tgt.[ResourceGroupName] = src.[ResourceGroupName],
			tgt.[SubscriptionId] = src.[SubscriptionId]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[OrchestratorName],
			[OrchestratorType],
			[IsFrameworkOrchestrator],
			[Description],
			[ResourceGroupName],
			[SubscriptionId]
			)
		VALUES
			(
			src.[OrchestratorName],
			src.[OrchestratorType],
			src.[IsFrameworkOrchestrator],
			src.[Description],
			src.[ResourceGroupName],
			src.[SubscriptionId]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END;