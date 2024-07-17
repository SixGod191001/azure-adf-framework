CREATE PROCEDURE [metadataHelpers].[SetDefaultBatches]
AS
BEGIN
	DECLARE @Batches TABLE
		(
		[BatchName] [VARCHAR](225) NOT NULL,
		[BatchDescription] [VARCHAR](4000) NULL,
		[SourceSystemName] [VARCHAR](255)  NULL,
	[TargetSystemName] [VARCHAR](255)  NULL,
	[InterfaceType] [VARCHAR](255)  NULL,
	[ConnectionType] [VARCHAR](255)  NULL,
		[Enabled] [BIT] NOT NULL
		)
	
	INSERT @Batches
		(
		[BatchName], 
		[BatchDescription], 
		[SourceSystemName],
		[TargetSystemName],
		[InterfaceType],
		[ConnectionType],
		[Enabled]
		) 
	VALUES 
		('Daily', N'Daily Worker Pipelines.', null,null,null,null,0),
		('Hourly', N'Hourly Worker Pipelines.',null,null,null,null, 0),
		('cpa', N'Process data comes from cpa', 'cpa',null,'inbound','file',1),
		('veeva', N'Process data comes from veeva','veeva',null,'inbound','file', 1),
		('edw', N'Process data to edw layer', null,null,'internal',null,1);	

	MERGE INTO [metadata].[Batches] AS tgt
	USING 
		@Batches AS src
			ON tgt.[BatchName] = src.[BatchName]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[BatchDescription] = src.[BatchDescription],
			tgt.[SourceSystemName] = src.[SourceSystemName],
			tgt.[TargetSystemName] = src.[TargetSystemName],
			tgt.[InterfaceType] = src.[InterfaceType],
			tgt.[ConnectionType] = src.[ConnectionType],
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[BatchName],
			[BatchDescription],
			[SourceSystemName],
			[TargetSystemName],
			[InterfaceType],
			[ConnectionType],
			[Enabled]
			)
		VALUES
			(
			src.[BatchName],
			src.[BatchDescription],
			src.[SourceSystemName],
			src.[TargetSystemName],
			src.[InterfaceType],
			src.[ConnectionType],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
END;