CREATE TABLE [metadata].[metadata_cedc]
(
	Id int NOT NULL,
	SourceObjectSettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SourceConnectionSettingsName varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CopySourceSettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SinkObjectSettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SinkConnectionSettingsName varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CopySinkSettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	CopyActivitySettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TopLevelPipelineName varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TriggerName nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	DataLoadingBehaviorSettings nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	TaskId int NULL,
	CopyEnabled bit NULL,
	CONSTRAINT PK__metadata__3214EC074054ADA0 PRIMARY KEY (Id)
);