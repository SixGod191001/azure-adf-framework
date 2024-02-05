CREATE VIEW [metadata].[CurrentProperties]
AS

SELECT
	[PropertyName],
	[PropertyValue]
FROM
	[metadata].[Properties]
WHERE
	[ValidTo] IS NULL;