CREATE PROCEDURE [metadata].[UpdateExecutionLog]
	(
	@PerformErrorCheck BIT = 1,
	@ExecutionId UNIQUEIDENTIFIER = NULL
	)
AS
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @AllCount INT
	DECLARE @SuccessCount INT

	IF([metadata].[GetPropertyValueInternal]('UseExecutionBatches')) = '0'
		BEGIN
			IF @PerformErrorCheck = 1
			BEGIN
				--Check current execution
				SELECT @AllCount = COUNT(0) FROM [metadata].[CurrentExecution]
				SELECT @SuccessCount = COUNT(0) FROM [metadata].[CurrentExecution] WHERE [PipelineStatus] = 'Success'

				IF @AllCount <> @SuccessCount
					BEGIN
						RAISERROR('Framework execution complete but not all Worker pipelines succeeded. See the [metadata].[CurrentExecution] table for details',16,1);
						RETURN 0;
					END;
			END;

			--Do this if no error raised and when called by the execution wrapper (OverideRestart = 1).
			INSERT INTO [metadata].[ExecutionLog]
				(
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[StartDateTime],
				[PipelineStatus],
				[EndDateTime],
				[PipelineRunId],
				[PipelineParamsUsed]
				)
			SELECT
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[StartDateTime],
				[PipelineStatus],
				[EndDateTime],
				[PipelineRunId],
				[PipelineParamsUsed]
			FROM
				[metadata].[CurrentExecution];

			TRUNCATE TABLE [metadata].[CurrentExecution];
		END
	ELSE IF ([metadata].[GetPropertyValueInternal]('UseExecutionBatches')) = '1'
		BEGIN
			IF @PerformErrorCheck = 1
			BEGIN
				--Check current execution
				SELECT 
					@AllCount = COUNT(0) 
				FROM 
					[metadata].[CurrentExecution]
				WHERE 
					[LocalExecutionId] = @ExecutionId;
				
				SELECT 
					@SuccessCount = COUNT(0) 
				FROM 
					[metadata].[CurrentExecution]
				WHERE 
					[LocalExecutionId] = @ExecutionId 
					AND [PipelineStatus] = 'Success';

				IF @AllCount <> @SuccessCount
					BEGIN
						UPDATE
							[metadata].[BatchExecution]
						SET
							[BatchStatus] = 'Stopped',
							[EndDateTime] = GETUTCDATE()
						WHERE
							[ExecutionId] = @ExecutionId;
						
						RAISERROR('Framework execution complete for batch but not all Worker pipelines succeeded. See the [metadata].[CurrentExecution] table for details',16,1);
						RETURN 0;
					END;
				ELSE
					BEGIN
						UPDATE
							[metadata].[BatchExecution]
						SET
							[BatchStatus] = 'Success',
							[EndDateTime] = GETUTCDATE()
						WHERE
							[ExecutionId] = @ExecutionId;
					END;
			END; --end check

			--Do this if no error raised and when called by the execution wrapper (OverideRestart = 1).
			INSERT INTO [metadata].[ExecutionLog]
				(
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[StartDateTime],
				[PipelineStatus],
				[EndDateTime],
				[PipelineRunId],
				[PipelineParamsUsed]
				)
			SELECT
				[LocalExecutionId],
				[StageId],
				[PipelineId],
				[CallingOrchestratorName],
				[ResourceGroupName],
				[OrchestratorType],
				[OrchestratorName],
				[PipelineName],
				[StartDateTime],
				[PipelineStatus],
				[EndDateTime],
				[PipelineRunId],
				[PipelineParamsUsed]
			FROM
				[metadata].[CurrentExecution]
			WHERE 
				[LocalExecutionId] = @ExecutionId;

			DELETE FROM
				[metadata].[CurrentExecution]
			WHERE
				[LocalExecutionId] = @ExecutionId;
		END;
END;