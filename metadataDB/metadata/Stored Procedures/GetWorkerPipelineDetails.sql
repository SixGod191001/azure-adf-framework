CREATE PROCEDURE [metadata].[GetWorkerPipelineDetails]
	(
	@ExecutionId UNIQUEIDENTIFIER,
	@StageId INT,
	@PipelineId INT
	)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		[PipelineName],
		[OrchestratorName],
		[OrchestratorType],
		[ResourceGroupName]
	FROM 
		[metadata].[CurrentExecution]
	WHERE 
		[LocalExecutionId] = @ExecutionId
		AND [StageId] = @StageId
		AND [PipelineId] = @PipelineId;
END;