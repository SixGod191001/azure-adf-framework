CREATE PROCEDURE [metadataHelpers].[SetDefaultDataProcessType]
AS
BEGIN
	DECLARE @DataProcessType TABLE
		(
  [DataProcessType] VARCHAR (100) NOT NULL DEFAULT ('dataflow'),
  [Enabled] [BIT]	DEFAULT(1) NOT NULL
		)
	
	INSERT @DataProcessType
		(
  [DataProcessType] ,
  [Enabled] 
		) 
	VALUES 
		('dataflow', 1),
		('storeprocedure', 1);
		
	MERGE INTO [metadata].[DataProcessType] AS tgt
	USING 
		@DataProcessType AS src
			ON tgt.[DataProcessType] = src.[DataProcessType]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[DataProcessType],
			[Enabled]
			)
		VALUES
			(
			src.[DataProcessType],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
END;