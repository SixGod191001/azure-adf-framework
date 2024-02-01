CREATE PROCEDURE [metadataHelpers].[SetDefaultRecipientPipelineAlerts]
AS
BEGIN
	EXEC [metadataHelpers].[AddRecipientPipelineAlerts]
		@RecipientName = N'Test User 1',
		@AlertForStatus = 'All';

	EXEC [metadataHelpers].[AddRecipientPipelineAlerts]
		@RecipientName = N'Test User 2',
		@PipelineName = 'Intentional Error',
		@AlertForStatus = 'Failed';

	EXEC [metadataHelpers].[AddRecipientPipelineAlerts]
		@RecipientName = N'Test User 3',
		@PipelineName = 'Wait 1',
		@AlertForStatus = 'Success, Failed, Cancelled';	
END;