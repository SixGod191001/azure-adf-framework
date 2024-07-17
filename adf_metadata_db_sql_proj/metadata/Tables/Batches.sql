CREATE TABLE [metadata].[Batches](
	[BatchId] UNIQUEIDENTIFIER DEFAULT(NEWID()) NOT NULL,
	[BatchName] [VARCHAR](255) NOT NULL,
	[BatchDescription] [VARCHAR](4000) NULL,
	[SourceSystemName] [VARCHAR](255)  NULL,
	[TargetSystemName] [VARCHAR](255)  NULL,
	[InterfaceType] [VARCHAR](255)  NULL,
	[ConnectionType] [VARCHAR](255)  NULL,
	[Enabled] [BIT]	DEFAULT(0) NOT NULL,
	 CONSTRAINT [PK_Batches] PRIMARY KEY CLUSTERED 
	(
		[BatchId] ASC
	)
)