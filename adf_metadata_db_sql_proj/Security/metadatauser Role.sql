/*
CREATE USER [##Data Factory Name (Managed Identity)##] 
FROM EXTERNAL PROVIDER;
*/

CREATE ROLE [metadatauser]
GO

GRANT 
	EXECUTE, 
	SELECT,
	CONTROL,
	ALTER
ON SCHEMA::[metadata] TO [metadatauser]
GO

/*
ALTER ROLE [metadatauser]
ADD MEMBER [##Data Factory Name (Managed Identity)##];
*/