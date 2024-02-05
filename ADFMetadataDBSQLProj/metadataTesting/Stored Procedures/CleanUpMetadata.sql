CREATE PROCEDURE [metadataTesting].[CleanUpMetadata]
AS
BEGIN
	EXEC [metadataHelpers].[DeleteMetadataWithIntegrity];
	EXEC [metadataHelpers].[DeleteMetadataWithoutIntegrity];
END;