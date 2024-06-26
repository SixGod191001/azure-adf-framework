﻿CREATE PROCEDURE [metadata].[GetStages]
	(
	@ExecutionId UNIQUEIDENTIFIER
	)
AS
BEGIN
	SET NOCOUNT ON;

	--defensive check
	IF NOT EXISTS 
		( 
		SELECT
			1
		FROM 
			[metadata].[CurrentExecution]
		WHERE
			[LocalExecutionId] = @ExecutionId
			AND ISNULL([PipelineStatus],'') <> 'Success'
		)
		BEGIN
			RAISERROR('Requested execution run does not contain any enabled stages/pipelines.',16,1);
			RETURN 0;
		END;

	SELECT DISTINCT 
		[StageId] 
	FROM 
		[metadata].[CurrentExecution]
	WHERE
		[LocalExecutionId] = @ExecutionId
		AND ISNULL([PipelineStatus],'') <> 'Success'
	ORDER BY 
		[StageId] ASC
END;