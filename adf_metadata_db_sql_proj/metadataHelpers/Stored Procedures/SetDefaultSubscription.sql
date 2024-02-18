CREATE PROCEDURE [metadataHelpers].[SetDefaultSubscription]
AS
BEGIN
	DECLARE @Subscriptions TABLE
		(
		[SubscriptionId] UNIQUEIDENTIFIER NOT NULL,
		[Name] NVARCHAR(200) NOT NULL,
		[Description] NVARCHAR(MAX) NULL,
		[TenantId] UNIQUEIDENTIFIER NOT NULL
		)

	INSERT INTO @Subscriptions
		(
		[SubscriptionId],
		[Name],
		[Description],
		[TenantId]
		)
	VALUES
		('930d2a20-dc22-431d-bdde-4a2916d0096b', 'platform', 'Example value for development environment.', '57b4e176-eb21-4c5c-be50-56baf5076018');

	MERGE INTO [metadata].[Subscriptions] AS tgt
	USING 
		@Subscriptions AS src
			ON tgt.[SubscriptionId] = src.[SubscriptionId]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[Name] = src.[Name],
			tgt.[Description] = src.[Description],
			tgt.[TenantId] = src.[TenantId]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[SubscriptionId],
			[Name],
			[Description],
			[TenantId]
			)
		VALUES
			(
			src.[SubscriptionId],
			src.[Name],
			src.[Description],
			src.[TenantId]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END;