-- Drop table

-- DROP TABLE frameworkmetadata.metadata.BatchEmailMapping;

CREATE TABLE frameworkmetadata.metadata.BatchEmailMapping (
	id int IDENTITY(1,1) NOT NULL,
	batchid nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	batchname nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	recipient nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enabled bit NULL,
	CONSTRAINT PK__BatchEma__3213E83F388BD5D1 PRIMARY KEY (id)
);
