CREATE PROCEDURE [metadataHelpers].[SetDefaultPipelineDependants]
AS
BEGIN
select 1 where 1=2;
/*
	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'task_proj1_api_landing',
		@DependantPipelineName = 'task_proj1_api_malformed';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'task_proj1_api_malformed',
		@DependantPipelineName = 'task_proj1_api_interim';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'task_proj1_api_interim',
		@DependantPipelineName = 'task_proj1_api_edw';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'task_proj1_api_edw',
		@DependantPipelineName = 'task_proj1_api_dm';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'task_proj1_api_edw',
		@DependantPipelineName = 'task_proj1_api_dm2';
	*/
END;