CREATE PROCEDURE [metadataHelpers].[SetDefaultTenant]
AS
BEGIN
	DECLARE @Tenants TABLE
		(
		[TenantId] UNIQUEIDENTIFIER NOT NULL,
		[Name] NVARCHAR(200) NOT NULL,
		[Description] NVARCHAR(MAX) NULL
		)

	INSERT INTO @Tenants
		(
		[TenantId],
		[Name],
		[Description]
		)
	VALUES
		('57b4e176-eb21-4c5c-be50-56baf5076018', 'Default', 'Example value for development environment.');

	MERGE INTO [metadata].[Tenants] AS tgt
	USING 
		@Tenants AS src
			ON tgt.[TenantId] = src.[TenantId]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[Name] = src.[Name],
			tgt.[Description] = src.[Description]		
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[TenantId],
			[Name],
			[Description]
			)
		VALUES
			(
			src.[TenantId],
			src.[Name],
			src.[Description]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;
END;