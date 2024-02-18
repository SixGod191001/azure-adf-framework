CREATE PROCEDURE [metadataTesting].[Add300WorkerPipelineBatches]
AS
BEGIN
	SET NOCOUNT ON;

	--clear default metadata
	DELETE FROM [metadata].[BatchStageLink];
	DELETE FROM [metadata].[Batches];

	--add batch details
	;WITH sourceData AS
		(
		SELECT
			'0to300' AS BatchName, 
			'The first 300.' AS BatchDescription,
			1 AS [Enabled]
		UNION SELECT
			'301to600',
			'The second 300.',
			1	
		)
	MERGE INTO [metadata].[Batches] AS tgt
	USING 
		sourceData AS src
			ON tgt.[BatchName] = src.[BatchName]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[BatchDescription] = src.[BatchDescription],
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[BatchName],
			[BatchDescription],
			[Enabled]
			)
		VALUES
			(
			src.[BatchName],
			src.[BatchDescription],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
	
	--link batches to stages
	INSERT INTO [metadata].[BatchStageLink]
		(
		[BatchId],
		[StageId]
		)
	SELECT
		b.[BatchId],
		s.[StageId]
	FROM
		[metadata].[Batches] b
		INNER JOIN [metadata].[Stages] s
			ON s.[Enabled] = 1;
END;
