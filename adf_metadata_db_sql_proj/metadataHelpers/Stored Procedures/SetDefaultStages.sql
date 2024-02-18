CREATE PROCEDURE [metadataHelpers].[SetDefaultStages]
AS
BEGIN
	DECLARE @Stages TABLE
		(
		[StageName] [VARCHAR](225) NOT NULL,
		[StageDescription] [VARCHAR](4000) NULL,
		[Enabled] [BIT] NOT NULL
		)
	
	INSERT @Stages
		(
		[StageName], 
		[StageDescription], 
		[Enabled]
		) 
	VALUES 
		('Landing', N'The Landing Zone is the initial storage area for raw and unprocessed data as it arrives from various sources. It serves as the first step in the data processing pipeline, often containing data in its original, sometimes unstructured, form.', 1),
		('Malformed', N'The Malformed Data Layer is a stage where data that doesn''t conform to expected formats or quality standards is temporarily stored. This layer is dedicated to identifying, handling, and potentially correcting data anomalies or errors before further processing.', 1),
		('Interim', N'The Interim Data Processing Layer is an intermediate stage where data from the landing and malformed layers undergoes necessary transformations and processing. It prepares the data for integration into the more structured layers of the data warehouse.', 1),
		('EDW', N'The Enterprise Data Warehouse (EDW) is the final repository for cleansed and integrated data. It provides a unified view of the data for analytical purposes, supporting business intelligence, reporting, and decision-making across the organization.', 1),
		('DM', N'Data Marts are subsets of the Enterprise Data Warehouse, focusing on specific business units or departments. They store and manage data tailored to the needs of individual teams, enabling more targeted and efficient analysis.', 1),
		('Speed', N'The "Speed Layer" typically refers to a layer within a data processing architecture that focuses on real-time or near-real-time data processing and analysis. The goal of this layer is to rapidly respond to data generated in real-time, enabling timely decision-making or providing real-time insights.', 1);

	MERGE INTO [metadata].[Stages] AS tgt
	USING 
		@Stages AS src
			ON tgt.[StageName] = src.[StageName]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[StageDescription] = src.[StageDescription],
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[StageName],
			[StageDescription],
			[Enabled]
			)
		VALUES
			(
			src.[StageName],
			src.[StageDescription],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
END;