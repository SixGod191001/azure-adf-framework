CREATE PROCEDURE [metadata].[SetExecutionBlockDependants]
	(
	@ExecutionId UNIQUEIDENTIFIER = NULL,
	@PipelineId INT
	)
AS
BEGIN
	--update dependents status
	UPDATE
		ce
	SET
		ce.[PipelineStatus] = 'Blocked',
		ce.[IsBlocked] = 1
	FROM
		[metadata].[PipelineDependencies] pe
		INNER JOIN [metadata].[CurrentExecution] ce
			ON pe.[DependantPipelineId] = ce.[PipelineId]
	WHERE
		ce.[LocalExecutionId] = @ExecutionId
		AND pe.[PipelineId] = @PipelineId
END;