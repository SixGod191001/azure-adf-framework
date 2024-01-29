-- DROP SCHEMA metadata;

CREATE SCHEMA metadata;
-- frameworkmetadata.metadata.BatchEmailMapping definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.BatchEmailMapping;

CREATE TABLE frameworkmetadata.metadata.BatchEmailMapping (
	id int IDENTITY(1,1) NOT NULL,
	batchid nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	batchname nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	recipient nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enabled bit NULL,
	CONSTRAINT PK__BatchEma__3213E83F388BD5D1 PRIMARY KEY (id)
);


-- frameworkmetadata.metadata.BatchExecution definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.BatchExecution;

CREATE TABLE frameworkmetadata.metadata.BatchExecution (
	BatchId uniqueidentifier NOT NULL,
	ExecutionId uniqueidentifier NOT NULL,
	BatchName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BatchStatus nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	StartDateTime datetime NOT NULL,
	EndDateTime datetime NULL,
	CONSTRAINT PK_BatchExecution PRIMARY KEY (BatchId,ExecutionId)
);


-- frameworkmetadata.metadata.Batches definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Batches;

CREATE TABLE frameworkmetadata.metadata.Batches (
	BatchId uniqueidentifier DEFAULT newid() NOT NULL,
	BatchName varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	BatchDescription varchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Enabled bit DEFAULT 0 NOT NULL,
	CONSTRAINT PK_Batches PRIMARY KEY (BatchId)
);


-- frameworkmetadata.metadata.CurrentExecution definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.CurrentExecution;

CREATE TABLE frameworkmetadata.metadata.CurrentExecution (
	LocalExecutionId uniqueidentifier NOT NULL,
	StageId int NOT NULL,
	PipelineId int NOT NULL,
	CallingOrchestratorName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ResourceGroupName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OrchestratorType char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OrchestratorName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PipelineName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	StartDateTime datetime NULL,
	PipelineStatus nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	LastStatusCheckDateTime datetime NULL,
	EndDateTime datetime NULL,
	IsBlocked bit DEFAULT 0 NOT NULL,
	PipelineRunId uniqueidentifier NULL,
	PipelineParamsUsed nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_CurrentExecution PRIMARY KEY (LocalExecutionId,StageId,PipelineId)
);
 CREATE NONCLUSTERED INDEX IDX_GetPipelinesInStage ON metadata.CurrentExecution (  LocalExecutionId ASC  , StageId ASC  , PipelineStatus ASC  )
	 INCLUDE ( OrchestratorName , OrchestratorType , PipelineId , PipelineName , ResourceGroupName )
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- frameworkmetadata.metadata.CurrentExecution_test definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.CurrentExecution_test;

CREATE TABLE frameworkmetadata.metadata.CurrentExecution_test (
	localexecutionid uniqueidentifier NULL,
	Stageid int NULL,
	pipelineid int NULL,
	pipelinename nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	startdatetime datetime NULL,
	pipelinestatus nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enddatetime datetime NULL,
	isblocked bit NULL
);


-- frameworkmetadata.metadata.ErrorLog definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.ErrorLog;

CREATE TABLE frameworkmetadata.metadata.ErrorLog (
	LogId int IDENTITY(1,1) NOT NULL,
	LocalExecutionId uniqueidentifier NOT NULL,
	PipelineRunId uniqueidentifier NOT NULL,
	ActivityRunId uniqueidentifier NOT NULL,
	ActivityName varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ActivityType varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ErrorCode varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ErrorType varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ErrorMessage nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_ErrorLog PRIMARY KEY (LogId)
);


-- frameworkmetadata.metadata.ExecutionLog definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.ExecutionLog;

CREATE TABLE frameworkmetadata.metadata.ExecutionLog (
	LogId int IDENTITY(1,1) NOT NULL,
	LocalExecutionId uniqueidentifier NOT NULL,
	StageId int NOT NULL,
	PipelineId int NOT NULL,
	CallingOrchestratorName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'Unknown' NOT NULL,
	ResourceGroupName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'Unknown' NOT NULL,
	OrchestratorType char(3) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'N/A' NOT NULL,
	OrchestratorName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'Unknown' NOT NULL,
	PipelineName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	StartDateTime datetime NULL,
	PipelineStatus nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	EndDateTime datetime NULL,
	PipelineRunId uniqueidentifier NULL,
	PipelineParamsUsed nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS DEFAULT 'None' NULL,
	CONSTRAINT PK_ExecutionLog PRIMARY KEY (LogId)
);


-- frameworkmetadata.metadata.PipelineEmailMapping definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.PipelineEmailMapping;

CREATE TABLE frameworkmetadata.metadata.PipelineEmailMapping (
	id int IDENTITY(1,1) NOT NULL,
	stageid int NULL,
	pipelineid int NULL,
	pipelinename nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	recipient nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enabled bit NULL,
	CONSTRAINT PK__Pipeline__3213E83FB42E2407 PRIMARY KEY (id)
);


-- frameworkmetadata.metadata.Properties definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Properties;

CREATE TABLE frameworkmetadata.metadata.Properties (
	PropertyId int IDENTITY(1,1) NOT NULL,
	PropertyName varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	PropertyValue nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ValidFrom datetime DEFAULT getdate() NOT NULL,
	ValidTo datetime NULL,
	CONSTRAINT PK_Properties PRIMARY KEY (PropertyId,PropertyName)
);


-- frameworkmetadata.metadata.Stages definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Stages;

CREATE TABLE frameworkmetadata.metadata.Stages (
	StageId int IDENTITY(1,1) NOT NULL,
	StageName varchar(225) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	StageDescription varchar(4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Enabled bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Stages PRIMARY KEY (StageId)
);


-- frameworkmetadata.metadata.Subscriptions definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Subscriptions;

CREATE TABLE frameworkmetadata.metadata.Subscriptions (
	SubscriptionId uniqueidentifier NOT NULL,
	Name nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Subscriptions PRIMARY KEY (SubscriptionId)
);


-- frameworkmetadata.metadata.BatchStageLink definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.BatchStageLink;

CREATE TABLE frameworkmetadata.metadata.BatchStageLink (
	BatchId uniqueidentifier NOT NULL,
	StageId int NOT NULL,
	CONSTRAINT PK_BatchStageLink PRIMARY KEY (BatchId,StageId),
	CONSTRAINT FK_BatchStageLink_Batches FOREIGN KEY (BatchId) REFERENCES frameworkmetadata.metadata.Batches(BatchId),
	CONSTRAINT FK_BatchStageLink_Stages FOREIGN KEY (StageId) REFERENCES frameworkmetadata.metadata.Stages(StageId)
);


-- frameworkmetadata.metadata.Orchestrators definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Orchestrators;

CREATE TABLE frameworkmetadata.metadata.Orchestrators (
	OrchestratorId int IDENTITY(1,1) NOT NULL,
	OrchestratorName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	OrchestratorType char(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	IsFrameworkOrchestrator bit DEFAULT 0 NOT NULL,
	ResourceGroupName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	SubscriptionId uniqueidentifier NOT NULL,
	Description nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_Orchestrators PRIMARY KEY (OrchestratorId),
	CONSTRAINT FK_Orchestrators_Subscriptions FOREIGN KEY (SubscriptionId) REFERENCES frameworkmetadata.metadata.Subscriptions(SubscriptionId)
);
ALTER TABLE frameworkmetadata.metadata.Orchestrators WITH NOCHECK ADD CONSTRAINT OrchestratorType CHECK ([OrchestratorType]='SYN' OR [OrchestratorType]='ADF');


-- frameworkmetadata.metadata.Pipelines definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.Pipelines;

CREATE TABLE frameworkmetadata.metadata.Pipelines (
	PipelineId int IDENTITY(1,1) NOT NULL,
	OrchestratorId int NOT NULL,
	StageId int NOT NULL,
	PipelineName nvarchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	Enabled bit DEFAULT 1 NOT NULL,
	CONSTRAINT PK_Pipelines PRIMARY KEY (PipelineId),
	CONSTRAINT FK_Pipelines_Orchestrators FOREIGN KEY (OrchestratorId) REFERENCES frameworkmetadata.metadata.Orchestrators(OrchestratorId),
	CONSTRAINT FK_Pipelines_Stages FOREIGN KEY (StageId) REFERENCES frameworkmetadata.metadata.Stages(StageId)
);


-- frameworkmetadata.metadata.PipelineDependencies definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.PipelineDependencies;

CREATE TABLE frameworkmetadata.metadata.PipelineDependencies (
	DependencyId int IDENTITY(1,1) NOT NULL,
	PipelineId int NOT NULL,
	DependantPipelineId int NOT NULL,
	CONSTRAINT PK_PipelineDependencies PRIMARY KEY (DependencyId),
	CONSTRAINT UK_PipelinesToDependantPipelines UNIQUE (PipelineId,DependantPipelineId),
	CONSTRAINT FK_PipelineDependencies_Pipelines FOREIGN KEY (PipelineId) REFERENCES frameworkmetadata.metadata.Pipelines(PipelineId),
	CONSTRAINT FK_PipelineDependencies_Pipelines1 FOREIGN KEY (DependantPipelineId) REFERENCES frameworkmetadata.metadata.Pipelines(PipelineId)
);
CREATE UNIQUE NONCLUSTERED INDEX UK_PipelinesToDependantPipelines ON frameworkmetadata.metadata.PipelineDependencies (PipelineId, DependantPipelineId);
ALTER TABLE frameworkmetadata.metadata.PipelineDependencies WITH NOCHECK ADD CONSTRAINT EQ_PipelineIdDependantPipelineId CHECK ([PipelineId]<>[DependantPipelineId]);


-- frameworkmetadata.metadata.PipelineParameters definition

-- Drop table

-- DROP TABLE frameworkmetadata.metadata.PipelineParameters;

CREATE TABLE frameworkmetadata.metadata.PipelineParameters (
	ParameterId int IDENTITY(1,1) NOT NULL,
	PipelineId int NOT NULL,
	ParameterName varchar(128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	ParameterValue nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	ParameterValueLastUsed nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CONSTRAINT PK_PipelineParameters PRIMARY KEY (ParameterId),
	CONSTRAINT FK_PipelineParameters_Pipelines FOREIGN KEY (PipelineId) REFERENCES frameworkmetadata.metadata.Pipelines(PipelineId)
);


-- metadata.CurrentProperties source

CREATE VIEW [metadata].[CurrentProperties]
AS

SELECT
	[PropertyName],
	[PropertyValue]
FROM
	[metadata].[Properties]
WHERE
	[ValidTo] IS NULL;



-- DROP SCHEMA metadataHelpers;

CREATE SCHEMA metadataHelpers;
-- metadataHelpers.PipelineDependencyChains source

CREATE VIEW [metadataHelpers].[PipelineDependencyChains]
AS

SELECT
	ps.[StageName] AS PredecessorStage,
	pp.[PipelineName] AS PredecessorPipeline,
	ds.[StageName] AS DependantStage,
	dp.[PipelineName] AS DependantPipeline
FROM
	[metadata].[PipelineDependencies]					pd --pipeline dependencies
	INNER JOIN [metadata].[Pipelines]					pp --predecessor pipelines
		ON pd.[PipelineId] = pp.[PipelineId]
	INNER JOIN [metadata].[Pipelines]					dp --dependant pipelines
		ON pd.[DependantPipelineId] = dp.[PipelineId]
	INNER JOIN [metadata].[Stages]						ps --predecessor stage
		ON pp.[StageId] = ps.[StageId]
	INNER JOIN [metadata].[Stages]						ds --dependant stage
		ON dp.[StageId] = ds.[StageId];



-- DROP SCHEMA metadataReporting;

CREATE SCHEMA metadataReporting;
-- metadataReporting.AverageStageDuration source

CREATE VIEW [metadataReporting].[AverageStageDuration]
AS

WITH stageStartEnd AS
	(
	SELECT
		[LocalExecutionId],
		[StageId],
		MIN([StartDateTime]) AS 'StageStart',
		MAX([EndDateTime]) AS 'StageEnd'
	FROM
		[metadata].[ExecutionLog]
	GROUP BY
		[LocalExecutionId],
		[StageId]
	)

SELECT
	s.[StageId],
	s.[StageName],
	s.[StageDescription],
	AVG(DATEDIFF(MINUTE, stageStartEnd.[StageStart], stageStartEnd.[StageEnd])) 'AvgStageRunDurationMinutes'
FROM
	stageStartEnd
	INNER JOIN [metadata].[Stages] s
		ON stageStartEnd.[StageId] = s.[StageId]
GROUP BY
	s.[StageId],
	s.[StageName],
	s.[StageDescription];


-- metadataReporting.AverageStageDuration_Daily source

CREATE VIEW [metadataReporting].[AverageStageDuration_Daily]
AS

WITH stageStartEnd AS
	(
	SELECT
		[LocalExecutionId],
		[StageId],
		MIN([StartDateTime]) AS 'StageStart',
		MAX([EndDateTime]) AS 'StageEnd'
	FROM
		[LatestExecutionLog]
	GROUP BY
		[LocalExecutionId],
		[StageId]
	)

SELECT
	s.[StageId],
	s.[StageName],
	s.[StageDescription],
	AVG(DATEDIFF(SECOND , stageStartEnd.[StageStart], stageStartEnd.[StageEnd])) 'AvgStageRunDurationSecond'
FROM
	stageStartEnd
	INNER JOIN [metadata].[Stages] s
		ON stageStartEnd.[StageId] = s.[StageId]
GROUP BY
	s.[StageId],
	s.[StageName],
	s.[StageDescription];


-- metadataReporting.CompleteExecutionErrorLog source

CREATE VIEW [metadataReporting].[CompleteExecutionErrorLog]
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


-- metadataReporting.CompleteExecutionLog source

CREATE VIEW [metadataReporting].[CompleteExecutionLog]
AS

SELECT
	[LogId],
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
	DATEDIFF(MINUTE, [StartDateTime], [EndDateTime]) 'RunDurationMinutes'
FROM
	[metadata].[ExecutionLog];


-- metadataReporting.CurrentExecutionSummary source

-- metadataReporting.CurrentExecutionSummary source

CREATE VIEW [metadataReporting].[CurrentExecutionSummary]
AS

SELECT LocalExecutionId,
	ISNULL([PipelineStatus], 'Not Started') AS 'PipelineStatus',
	COUNT(0) AS 'RecordCount'
FROM
	[metadata].[CurrentExecution]
GROUP BY
LocalExecutionId,
	[PipelineStatus];


-- metadataReporting.LastExecution source

CREATE VIEW [metadataReporting].[LastExecution]
AS

WITH maxLog AS
	(
	SELECT
		MAX([LogId]) AS 'MaxLogId'
	FROM
		[metadata].[ExecutionLog]
	),
	lastExecutionId AS
	(
	SELECT
		[LocalExecutionId]
	FROM
		[metadata].[ExecutionLog] el1
		INNER JOIN maxLog
			ON maxLog.[MaxLogId] = el1.[LogId]
	)
SELECT
	el2.[LogId],
	el2.[StageId],
	el2.[PipelineId],
	el2.[PipelineName],
	el2.[StartDateTime],
	el2.[PipelineStatus],
	el2.[EndDateTime],
	DATEDIFF(MINUTE, el2.[StartDateTime], el2.[EndDateTime]) AS RunDurationMinutes
FROM
	[metadata].[ExecutionLog] el2
	INNER JOIN lastExecutionId
		ON el2.[LocalExecutionId] = lastExecutionId.[LocalExecutionId]
WHERE
	el2.[EndDateTime] IS NOT NULL;


-- metadataReporting.LastExecutionSummary source

CREATE VIEW [metadataReporting].[LastExecutionSummary]
AS

WITH maxLog AS
	(
	SELECT
		MAX([LogId]) AS 'MaxLogId'
	FROM
		[metadata].[ExecutionLog]
	),
	lastExecutionId AS
	(
	SELECT
		[LocalExecutionId]
	FROM
		[metadata].[ExecutionLog] el1
		INNER JOIN maxLog
			ON maxLog.[MaxLogId] = el1.[LogId]
	)
SELECT
	el2.[LocalExecutionId],
	DATEDIFF(MINUTE, MIN(el2.[StartDateTime]), MAX(el2.[EndDateTime])) 'RunDurationMinutes'
FROM
	[metadata].[ExecutionLog] el2
	INNER JOIN lastExecutionId
		ON el2.[LocalExecutionId] = lastExecutionId.[LocalExecutionId]
GROUP BY
	el2.[LocalExecutionId];


-- metadataReporting.PipelineDependant source

CREATE VIEW metadataReporting.PipelineDependant AS
WITH DependantPipelines AS (
    SELECT
        PipelineId,
        DependantPipelineId,
        1 AS Level
    FROM
        frameworkmetadata.metadata.PipelineDependencies

    UNION ALL

    SELECT
        p.PipelineId,
        p.DependantPipelineId,
        dp.Level + 1
    FROM
        frameworkmetadata.metadata.PipelineDependencies p
    INNER JOIN
        DependantPipelines dp ON p.PipelineId = dp.DependantPipelineId
    WHERE
        dp.Level < 4)
SELECT
    dp.PipelineId,
    STRING_AGG(CAST(dp.DependantPipelineId AS VARCHAR(MAX)), ', ') WITHIN GROUP (ORDER BY dp.Level) AS AffectedPipelines,
    MAX(dp.Level) AS MaxLevel
FROM
    DependantPipelines dp
GROUP BY
    dp.PipelineId;


-- metadataReporting.WorkerParallelismOverTime source

CREATE VIEW [metadataReporting].[WorkerParallelismOverTime]
AS

WITH numbers AS
	(
	SELECT TOP 500
		ROW_NUMBER() OVER (ORDER BY s1.[object_id]) - 1 AS 'Number'
	FROM
		sys.all_columns AS s1
		CROSS JOIN sys.all_columns AS s2
	),
	executionBoundaries AS
	(
	SELECT
		[LocalExecutionId],
		CAST(CONVERT(VARCHAR(16), MIN([StartDateTime]), 120) AS DATETIME)  AS 'ExecutionStart',
		CAST(CONVERT(VARCHAR(16), MAX([EndDateTime]), 120) AS DATETIME) AS 'ExecutionEnd'
	FROM
		[metadata].[ExecutionLog]
	--WHERE
	--	[LocalExecutionId] = '2BB02783-2A2C-4970-9BEA-0543013BFD5E'
	GROUP BY
		[LocalExecutionId]
	),
	wallclockRunning AS
	(
	SELECT
		CAST(DATEADD(MINUTE, n.[Number], eB.[ExecutionStart]) AS DATE) AS 'WallclockDate',
		CAST(DATEADD(MINUTE, n.[Number], eB.[ExecutionStart]) AS TIME) AS 'WallclockTime',
		el.[LocalExecutionId],
		el.[PipelineId],
		el.[PipelineName],
		s.[StageName]
	FROM
		executionBoundaries eB
		CROSS JOIN numbers n
		INNER JOIN [metadata].[ExecutionLog] eL
			ON eB.[LocalExecutionId] = eL.[LocalExecutionId]
				AND DATEADD(MINUTE, n.[Number], eB.[ExecutionStart])
					BETWEEN eL.[StartDateTime] AND eL.[EndDateTime]
		INNER JOIN [metadata].[Stages] s
			ON eL.[StageId] = s.[StageId]
	)

SELECT
	[WallclockDate],
	[WallclockTime],
	[LocalExecutionId],
	[StageName],
	STRING_AGG(ISNULL([PipelineName],' '),', ') As 'PipelineName',
	COUNT([PipelineId]) AS 'WorkerCount'
FROM
	wallclockRunning
GROUP BY
	[WallclockDate],
	[WallclockTime],
	[LocalExecutionId],
	[StageName];




-- DROP SCHEMA metadataTesting;

CREATE SCHEMA metadataTesting;



