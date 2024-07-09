CREATE TABLE [metadata].[Pipelines] (
    [PipelineId]   INT            IDENTITY (1, 1) NOT NULL,
    [OrchestratorId] INT NOT NULL,
    [StageId]      INT            NOT NULL,
    [PipelineName] NVARCHAR (200) NOT NULL,
    [LogicalPredecessorId] INT NULL,
    [Enabled]      BIT CONSTRAINT [DF_Pipelines_Enabled] DEFAULT ((1)) NOT NULL,
    [BatchId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Pipelines] PRIMARY KEY CLUSTERED ([PipelineId] ASC),
    CONSTRAINT [FK_Pipelines_Stages] FOREIGN KEY ([StageId]) REFERENCES [metadata].[Stages] ([StageId]),
    CONSTRAINT [FK_Pipelines_Orchestrators] FOREIGN KEY([OrchestratorId]) REFERENCES [metadata].[Orchestrators] ([OrchestratorId]),
    CONSTRAINT [FK_Pipelines_Pipelines] FOREIGN KEY([LogicalPredecessorId]) REFERENCES [metadata].[Pipelines] ([PipelineId])
);

