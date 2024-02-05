CREATE FUNCTION [metadata].[GetPropertyValueInternal]
	(
	@PropertyName VARCHAR(128)
	)
RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @PropertyValue NVARCHAR(MAX)

	SELECT
		@PropertyValue = ISNULL([PropertyValue],'')
	FROM
		[metadata].[CurrentProperties]
	WHERE
		[PropertyName] = @PropertyName

    RETURN @PropertyValue
END;
