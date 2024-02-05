CREATE TABLE metadata.PipelineEmailMapping (
	id int IDENTITY(1,1) NOT NULL,
	stageid int NULL,
	pipelineid int NULL,
	pipelinename nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	recipient nvarchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	enabled bit NULL,
	CONSTRAINT PK__Pipeline__3213E83FB42E2407 PRIMARY KEY (id)
);