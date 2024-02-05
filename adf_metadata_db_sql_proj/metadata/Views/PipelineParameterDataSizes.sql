CREATE VIEW [metadata].[PipelineParameterDataSizes]
AS

SELECT 
	[PipelineId],
	SUM(
		(CAST(
			DATALENGTH(
				STRING_ESCAPE([ParameterName] + [ParameterValue],'json')) AS DECIMAL)
			/1024) --KB
			/1024 --MB
		) AS Size
FROM 
	[metadata].[PipelineParameters]
GROUP BY
	[PipelineId];