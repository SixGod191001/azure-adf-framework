CREATE PROCEDURE [metadataTesting].[ResetMetadata]
AS
BEGIN	
	EXEC [metadataHelpers].[SetDefaultProperties];
	EXEC [metadataHelpers].[SetDefaultTenant];
	EXEC [metadataHelpers].[SetDefaultSubscription];
	EXEC [metadataHelpers].[SetDefaultOrchestrators];
	EXEC [metadataHelpers].[SetDefaultBatches];
	EXEC [metadataHelpers].[SetDefaultStages];
	EXEC [metadataHelpers].[SetDefaultBatchStageLink];
	EXEC [metadataHelpers].[SetDefaultPipelines];
	EXEC [metadataHelpers].[SetDefaultPipelineParameters];
	EXEC [metadataHelpers].[SetDefaultPipelineDependants];
	EXEC [metadataHelpers].[SetDefaultRecipients];
	EXEC [metadataHelpers].[SetDefaultAlertOutcomes];
	EXEC [metadataHelpers].[SetDefaultRecipientPipelineAlerts];
END;