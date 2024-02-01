CREATE PROCEDURE [metadataHelpers].[SetDefaultBatchStageLink]
AS
BEGIN
	TRUNCATE TABLE [metadata].[BatchStageLink]

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
			ON s.[StageName] <> 'Speed'
	WHERE
		b.[BatchName] = 'Daily'

	UNION ALL

	SELECT
		b.[BatchId],
		s.[StageId]
	FROM
		[metadata].[Batches] b
		INNER JOIN [metadata].[Stages] s
			ON s.[StageName] = 'Speed'
	WHERE
		b.[BatchName] = 'Hourly'
END;