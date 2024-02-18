CREATE PROCEDURE [metadataHelpers].[SetDefaultPipelines]
AS
BEGIN
	DECLARE @Pipelines TABLE
		(
		[OrchestratorId] [INT] NOT NULL,
		[StageId] [INT] NOT NULL,
		[PipelineName] [NVARCHAR](200) NOT NULL,
		[LogicalPredecessorId] [INT] NULL,
		[Enabled] [BIT] NOT NULL
		)

	INSERT @Pipelines
		(
		[OrchestratorId],
		[StageId],
		[PipelineName],
		[LogicalPredecessorId],
		[Enabled]
		)
	VALUES
		-- task_<project>_<datasource>_<layer/stage>
		(1, 1	, 'task_proj1_api_landing'    , NULL		, 1),
		(1, 2	, 'task_proj1_api_malformed'  , NULL		, 1),
		(1, 3	, 'task_proj1_api_interim'	  , NULL		, 1),
		(1, 4	, 'task_proj1_api_edw'		  , NULL		, 1),
		--synapse/azure sql database to serve dashboard
		(1, 5	, 'task_proj1_api_dm'		  , NULL		, 1),
		(1, 5	, 'task_proj1_api_dm2'		  , NULL		, 1),
		--speed
		(1, 6	, 'task_proj1_api_speed'	  , NULL		, 0);

	MERGE INTO [metadata].[Pipelines] AS tgt
	USING 
		@Pipelines AS src
			ON tgt.[OrchestratorId] = src.[OrchestratorId]
		AND tgt.[PipelineName] = src.[PipelineName]
		AND tgt.[StageId] = src.[StageId]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[LogicalPredecessorId] = src.[LogicalPredecessorId],
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[OrchestratorId],
			[StageId],
			[PipelineName], 
			[LogicalPredecessorId],
			[Enabled]
			)
		VALUES
			(
			src.[OrchestratorId],
			src.[StageId],
			src.[PipelineName], 
			src.[LogicalPredecessorId],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END;