IF OBJECT_ID(N'[dbo].[ErrorLogBackup]') IS NOT NULL DROP TABLE [dbo].[ErrorLogBackup];

IF OBJECT_ID(N'[metadata].[ErrorLog]') IS NOT NULL --check for new deployments
BEGIN
	SELECT 
		*
	INTO
		[dbo].[ErrorLogBackup]
	FROM
		[metadata].[ErrorLog];
END;