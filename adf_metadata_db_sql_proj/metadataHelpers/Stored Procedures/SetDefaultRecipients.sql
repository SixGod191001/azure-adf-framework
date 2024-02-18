CREATE PROCEDURE [metadataHelpers].[SetDefaultRecipients]
AS
BEGIN
	DECLARE @Recipients TABLE
		(
		[Name] [VARCHAR](255) NULL,
		[EmailAddress] [NVARCHAR](500) NOT NULL,
		[MessagePreference] [CHAR](3) NOT NULL,
		[Enabled] [BIT] NOT NULL
		)

	INSERT INTO @Recipients
		(
		[Name],
		[EmailAddress],
		[MessagePreference],--TO/CC/BCC
		[Enabled]
		)
	VALUES
		('Jacky Yang','sixgod2019@outlook.com', 'TO', 1);

	MERGE INTO [metadata].[Recipients] AS tgt
	USING 
		@Recipients AS src
			ON tgt.[Name] = src.[Name]
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[EmailAddress] = src.[EmailAddress],
			tgt.[MessagePreference] = src.[MessagePreference],
			tgt.[Enabled] = src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[Name],
			[EmailAddress],
			[MessagePreference],
			[Enabled]
			)
		VALUES
			(
			src.[Name],
			src.[EmailAddress],
			src.[MessagePreference],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;	
END;