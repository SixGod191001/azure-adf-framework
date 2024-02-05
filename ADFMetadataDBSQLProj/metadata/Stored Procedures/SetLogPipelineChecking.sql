CREATE PROCEDURE [metadata].[SetLogPipelineChecking]
	(
	@ExecutionId UNIQUEIDENTIFIER,
	@StageId INT,
	@PipelineId INT
	)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE
		[metadata].[CurrentExecution]
	SET
		[PipelineStatus] = 'Checking'
	WHERE
		[LocalExecutionId] = @ExecutionId
		AND [StageId] = @StageId
		AND [PipelineId] = @PipelineId
END;
