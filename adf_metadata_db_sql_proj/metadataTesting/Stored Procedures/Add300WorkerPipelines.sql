CREATE PROCEDURE [metadataTesting].[Add300WorkerPipelines]
AS
BEGIN
	SET NOCOUNT ON;

	--clear default metadata
	DELETE FROM [metadata].[PipelineDependencies];
	DBCC CHECKIDENT ('[metadata].[PipelineDependencies]', RESEED, 0);

	DELETE FROM [metadata].[PipelineAlertLink];
	DBCC CHECKIDENT ('[metadata].[PipelineAlertLink]', RESEED, 0);

	DELETE FROM [metadata].[Recipients];
	DBCC CHECKIDENT ('[metadata].[Recipients]', RESEED, 0);

	DELETE FROM [metadata].[PipelineAuthLink];
	DBCC CHECKIDENT ('[metadata].[PipelineAuthLink]', RESEED, 0);

	DELETE FROM [dbo].[ServicePrincipals];
	DBCC CHECKIDENT ('[dbo].[ServicePrincipals]', RESEED, 0);

	DELETE FROM [metadata].[PipelineParameters];
	DBCC CHECKIDENT ('[metadata].[PipelineParameters]', RESEED, 0);

	DELETE FROM [metadata].[Pipelines];
	DBCC CHECKIDENT ('[metadata].[Pipelines]', RESEED, 0);

	--get Orchestrator id
	DECLARE @OrcId INT
	
	SELECT 
		@OrcId = [OrchestratorId] 
	FROM 
		[metadata].[Orchestrators]
	WHERE 
		[OrchestratorName] = 'WorkersFactory'
		AND [OrchestratorType] = 'ADF';

	--insert 300 pipelines
	;WITH cte AS
		(
		SELECT TOP 300
			ROW_NUMBER() OVER (ORDER BY s1.[object_id]) AS Number
		FROM 
			sys.all_columns AS s1
			CROSS JOIN sys.all_columns AS s2
		)
	INSERT INTO [metadata].[Pipelines]
		(
		[OrchestratorId],
		[StageId],
		[PipelineName],
		[LogicalPredecessorId],
		[Enabled]
		)
	SELECT
		@OrcId,
		CASE
			WHEN [Number] <= 100 THEN 1
			WHEN [Number] > 100 AND  [Number] <= 200 THEN 2
			WHEN [Number] > 200 AND  [Number] <= 300 THEN 3
		END,
		'Wait ' + CAST([Number] AS VARCHAR),
		NULL,
		1
	FROM
		cte;

	--disable other execution stages if exist
	UPDATE [metadata].[Stages] SET [Enabled] = 0 WHERE [StageId] > 3;

	--insert 300 pipeline parameters
	INSERT INTO [metadata].[PipelineParameters]
		(
		[PipelineId],
		[ParameterName],
		[ParameterValue]
		)
	SELECT
		[PipelineId],
		'WaitTime',
		LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY) AS INT)),2)
	FROM
		[metadata].[Pipelines];
END;