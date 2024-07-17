CREATE TABLE [metadata].[DataProcessType]
(
  [DataProcessTypeId] INT            IDENTITY (1, 1) NOT NULL,
  [DataProcessType] VARCHAR (100) NOT NULL DEFAULT ('dataflow'),
  [Enabled] [BIT]	DEFAULT(1) NOT NULL,
   CONSTRAINT [PK_DataProcessType] PRIMARY KEY CLUSTERED 
	(
		[DataProcessTypeId] ASC
	)
)