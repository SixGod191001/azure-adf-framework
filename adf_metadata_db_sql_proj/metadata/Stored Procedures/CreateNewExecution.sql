CREATE PROCEDURE [metadata].[CreateNewExecution]
	(
	@CallingOrchestratorName NVARCHAR(200),
	@LocalExecutionId UNIQUEIDENTIFIER = NULL
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @BatchId UNIQUEIDENTIFIER;

	IF([metadata].[GetPropertyValueInternal]('UseExecutionBatches')) = '0'
		BEGIN
			SET @LocalExecutionId = NEWID();

			TRUNCATE TABLE [metadata].[CurrentExecution];

			--defensive check
			IF NOT EXISTS
				(
				SELECT
					1
				FROM
					[metadata].[Pipelines] p
					INNER JOIN [metadata].[Stages] s
						ON p.[StageId] = s.[StageId]
					INNER JOIN [metadata].[Orchestrators] d
						ON p.[OrchestratorId] = d.[OrchestratorId]
				WHERE
					p.[Enabled] = 1
					AND s.[Enabled] = 1
				)
				BEGIN
					RAISERROR('Requested execution run does not contain any enabled stages/pipelines.',16,1);
					RETURN 0;
				END;

			INSERT INTO [metadata].[CurrentExecution]
				(
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[TaskName]
				)
			SELECT
				@LocalExecutionId,
				p.[StageId],
				p.[PipelineId],
				@CallingOrchestratorName,
				d.[ResourceGroupName],
				d.[OrchestratorType],
				d.[OrchestratorName],
				p.[PipelineName],
				p.[TaskName]
			FROM
				[metadata].[Pipelines] p
				INNER JOIN [metadata].[Stages] s
					ON p.[StageId] = s.[StageId]
				INNER JOIN [metadata].[Orchestrators] d
					ON p.[OrchestratorId] = d.[OrchestratorId]
			WHERE
				p.[Enabled] = 1
				AND s.[Enabled] = 1;

			SELECT
				@LocalExecutionId AS ExecutionId;
		END
	ELSE IF ([metadata].[GetPropertyValueInternal]('UseExecutionBatches')) = '1'
		BEGIN
			DELETE FROM 
				[metadata].[CurrentExecution]
			WHERE
				[LocalExecutionId] = @LocalExecutionId;

			SELECT
				@BatchId = [BatchId]
			FROM
				[metadata].[BatchExecution]
			WHERE
				[ExecutionId] = @LocalExecutionId;
			
			--defensive check
			IF NOT EXISTS
				(
				SELECT
					1
				FROM
					[metadata].[Pipelines] p
					INNER JOIN [metadata].[Stages] s
						ON p.[StageId] = s.[StageId]
					INNER JOIN [metadata].[Orchestrators] d
						ON p.[OrchestratorId] = d.[OrchestratorId]
					INNER JOIN [metadata].[BatchStageLink] b
						ON b.[StageId] = s.[StageId]
				WHERE
					b.[BatchId] = @BatchId
					AND p.[Enabled] = 1
					AND s.[Enabled] = 1
				)
				BEGIN
					RAISERROR('Requested execution run does not contain any enabled stages/pipelines.',16,1);
					RETURN 0;
				END;

			INSERT INTO [metadata].[CurrentExecution]
				(
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[TaskName]
				)
			SELECT
				@LocalExecutionId,
				p.[StageId],
				p.[PipelineId],
				@CallingOrchestratorName,
				d.[ResourceGroupName],
				d.[OrchestratorType],
				d.[OrchestratorName],
				p.[PipelineName],
				p.[TaskName]
			FROM
				[metadata].[Pipelines] p
				INNER JOIN [metadata].[Stages] s
					ON p.[StageId] = s.[StageId]
				INNER JOIN [metadata].[Orchestrators] d
					ON p.[OrchestratorId] = d.[OrchestratorId]
				INNER JOIN [metadata].[BatchStageLink] b
					ON b.[StageId] = s.[StageId]
			WHERE
				b.[BatchId] = @BatchId
				AND p.[Enabled] = 1
				AND s.[Enabled] = 1;
				
			SELECT
				@LocalExecutionId AS ExecutionId;
		END;

	ALTER INDEX [IDX_GetPipelinesInStage] ON [metadata].[CurrentExecution]
	REBUILD;
END;