CREATE VIEW [metadataHelpers].[PipelineDependencyChains]
AS

SELECT 
	ps.[StageName] AS PredecessorStage,
	pp.[PipelineName] AS PredecessorPipeline,
	ds.[StageName] AS DependantStage,
	dp.[PipelineName] AS DependantPipeline
FROM 
	[metadata].[PipelineDependencies]					pd --pipeline dependencies
	INNER JOIN [metadata].[Pipelines]					pp --predecessor pipelines
		ON pd.[PipelineId] = pp.[PipelineId]
	INNER JOIN [metadata].[Pipelines]					dp --dependant pipelines
		ON pd.[DependantPipelineId] = dp.[PipelineId]
	INNER JOIN [metadata].[Stages]						ps --predecessor stage
		ON pp.[StageId] = ps.[StageId]
	INNER JOIN [metadata].[Stages]						ds --dependant stage
		ON dp.[StageId] = ds.[StageId];