CREATE VIEW [metadataReporting].[CurrentExecutionSummary]
AS

SELECT 
	ISNULL([PipelineStatus], 'Not Started') AS 'PipelineStatus',
	COUNT(0) AS 'RecordCount'
FROM 
	[metadata].[CurrentExecution]
GROUP BY
	[PipelineStatus]