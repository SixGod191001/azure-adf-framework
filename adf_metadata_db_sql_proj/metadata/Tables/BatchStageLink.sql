﻿CREATE TABLE [metadata].[BatchStageLink]
	(
	[BatchId] [UNIQUEIDENTIFIER] NOT NULL,
	[StageId] [INT] NOT NULL,
	CONSTRAINT [PK_BatchStageLink] PRIMARY KEY CLUSTERED 
		(
		[BatchId] ASC,
		[StageId] ASC
		),
	CONSTRAINT [FK_BatchStageLink_Batches] FOREIGN KEY([BatchId]) REFERENCES [metadata].[Batches] ([BatchId]),
	CONSTRAINT [FK_BatchStageLink_Stages] FOREIGN KEY([StageId]) REFERENCES [metadata].[Stages] ([StageId])
)
