CREATE PROCEDURE [metadataHelpers].[SetDefaultPipelineDependants]
AS
BEGIN
	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'Intentional Error',
		@DependantPipelineName = 'Wait 5';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'Intentional Error',
		@DependantPipelineName = 'Wait 6';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'Wait 6',
		@DependantPipelineName = 'Wait 9';

	EXEC [metadataHelpers].[AddPipelineDependant]
		@PipelineName = 'Wait 9',
		@DependantPipelineName = 'Wait 10';
END;