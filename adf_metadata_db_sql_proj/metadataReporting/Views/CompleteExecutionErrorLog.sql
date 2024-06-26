﻿CREATE VIEW [metadataReporting].[CompleteExecutionErrorLog]
AS

SELECT
	exeLog.[LogId] AS ExecutionLogId,
	errLog.[LogId] AS ErrorLogId,
	exeLog.[LocalExecutionId],
	exeLog.[StartDateTime] AS ProcessingDateTime,
	exeLog.[CallingOrchestratorName],
	exeLog.[OrchestratorType] AS WorkerOrchestartorType,
	exeLog.[OrchestratorName] AS WorkerOrchestrator,
	exeLog.[PipelineName] AS WorkerPipelineName,
	exeLog.[PipelineStatus],
	errLog.[ActivityRunId],
	errLog.[ActivityName],
	errLog.[ActivityType],
	errLog.[ErrorCode],
	errLog.[ErrorType],
	errLog.[ErrorMessage]
FROM
	[metadata].[ExecutionLog] exeLog
	INNER JOIN [metadata].[ErrorLog] errLog
		ON exeLog.[LocalExecutionId] = errLog.[LocalExecutionId]
			AND exeLog.[PipelineRunId] = errLog.[PipelineRunId]
	INNER JOIN [metadata].[Stages] stgs
		ON exeLog.[StageId] = stgs.[StageId]
;