CREATE PROCEDURE [metadata].[SetLogPipelineValidating]
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
		[PipelineStatus] = 'Validating'
	WHERE
		[LocalExecutionId] = @ExecutionId
		AND [StageId] = @StageId
		AND [PipelineId] = @PipelineId
END;
