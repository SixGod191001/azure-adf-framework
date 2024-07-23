CREATE PROCEDURE [metadataHelpers].[SetDefaultPipelineParameters]
AS
BEGIN
	DECLARE @PipelineParameters TABLE
		(
		[PipelineId] [INT] NOT NULL,
		[ParameterName] [VARCHAR](128) NOT NULL,
		[ParameterValue] [NVARCHAR](MAX) NULL
		)


	INSERT @PipelineParameters
		(
		[PipelineId], 
		[ParameterName], 
		[ParameterValue]
		) 
	VALUES 
		(137, 'source_container', 'cpa'),
		(137, 'source_filename', 'CPA_Franchise_Marketing_Mapping.xlsx'),
		(137, 'source_sheet', 'Sheet1'),
		(137, 'target_container', 'landing'),
		(137, 'target_path', 'cpa'),
		(137, 'target_filename', 'CPA_Franchise_Marketing_Mapping.csv'),
		(138, 'source_container', 'cpa'),
		(138, 'source_filename', 'CPA_Franchise_Province_Region_Mapping.xlsx'),
		(138, 'source_sheet', 'Sheet1'),
		(138, 'target_container', 'landing'),
		(138, 'target_path', 'cpa'),
		(138, 'target_filename', 'CPA_Franchise_Province_Region_Mapping.csv');


	MERGE INTO [metadata].[PipelineParameters]  AS tgt
	USING 
		@PipelineParameters AS src
			ON tgt.[PipelineId] = src.[PipelineId]
				AND tgt.[ParameterName] = src.[ParameterName]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[ParameterValue] = src.[ParameterValue]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[PipelineId], 
			[ParameterName], 
			[ParameterValue]
			) 
		VALUES
			(
			src.[PipelineId], 
			src.[ParameterName], 
			src.[ParameterValue]
			) 
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
		
END;