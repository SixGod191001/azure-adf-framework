CREATE PROCEDURE [metadataHelpers].[SetDefaultAlertOutcomes]
AS
BEGIN
	TRUNCATE TABLE [metadata].[AlertOutcomes];

	INSERT INTO [metadata].[AlertOutcomes]
		(
		[PipelineOutcomeStatus]
		)
	VALUES 
		('All'),
		('Success'),
		('Failed'),
		('Unknown'),
		('Cancelled');
END;