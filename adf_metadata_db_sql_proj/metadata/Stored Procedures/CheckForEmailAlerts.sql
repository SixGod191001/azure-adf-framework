CREATE PROCEDURE [metadata].[CheckForEmailAlerts]
	(
	@PipelineId INT
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SendAlerts BIT
	DECLARE @AlertingEnabled BIT

	--get property
	SELECT
		@AlertingEnabled = [metadata].[GetPropertyValueInternal]('UseFrameworkEmailAlerting');

	--based on global property
	IF (@AlertingEnabled = 1)
		BEGIN
			--based on piplines to recipients link
			IF EXISTS
				(
				SELECT pal.AlertId
				FROM metadata.CurrentExecution AS ce
				INNER JOIN metadata.AlertOutcomes AS ao
					ON ao.PipelineOutcomeStatus = ce.PipelineStatus
				INNER JOIN metadata.PipelineAlertLink AS pal
					ON pal.PipelineId = ce.PipelineId
				INNER JOIN metadata.Recipients AS r
					ON r.RecipientId = pal.RecipientId
				WHERE ce.PipelineId = @PipelineId
					   AND (
						ao.BitValue & pal.OutcomesBitValue <> 0
						OR pal.OutcomesBitValue & 1 <> 0 --all
						)
					  AND pal.[Enabled] = 1
					  AND r.[Enabled] = 1
				)
				BEGIN
					SET @SendAlerts = 1;
				END;
			ELSE
				BEGIN
					SET @SendAlerts = 0;
				END;
		END
	ELSE
		BEGIN
			SET @SendAlerts = 0;
		END;

	SELECT @SendAlerts AS SendAlerts
END;