CREATE PROCEDURE [metadataHelpers].[SetDefaultPipelines]
AS
BEGIN
	DECLARE @Pipelines TABLE
		(
    [OrchestratorId] INT NOT NULL,
    [StageId]      INT            NOT NULL,
    [PipelineName] NVARCHAR (200) NOT NULL,
    [LogicalPredecessorId] INT NULL,
    [BatchId] UNIQUEIDENTIFIER NULL,
    [UniversalFlag]  BIT DEFAULT(0) NULL,
    [TaskName] VARCHAR(255)  NULL,
    [DataProcessTypeId] int null,
	[Enabled] [BIT] NOT NULL
		)
    DECLARE @cpa_batchid UNIQUEIDENTIFIER ;
	DECLARE @dataprocesstypeid int ;
	DECLARE @veeva_batchid UNIQUEIDENTIFIER ;

    SELECT @cpa_batchid = [BatchId] from [metadata].[Batches] where [BatchName]='cpa';
    SELECT @dataprocesstypeid = [DataProcessTypeId] from [metadata].[DataProcessType] where [DataProcessType]='dataflow';
    SELECT @veeva_batchid = [BatchId] from [metadata].[Batches] where [BatchName]='veeva';

	INSERT @Pipelines
		(
    [OrchestratorId],
    [StageId]      ,
    [PipelineName] ,
    [LogicalPredecessorId],
    [UniversalFlag]  ,
    [TaskName] ,
	[BatchId],
	[DataProcessTypeId],
	[Enabled]

		)
	VALUES
		(1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_hospital',@cpa_batchid,@dataprocesstypeid,0),
		(1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_medicine_sales',@cpa_batchid,@dataprocesstypeid,0),
        (1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_market_product',@cpa_batchid,@dataprocesstypeid,0),
 (1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_package_sku_mapping',@cpa_batchid,@dataprocesstypeid,0),
 (1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_franchise_marketing_mapping',@cpa_batchid,@dataprocesstypeid,1),
 (1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_franchise_province_region_mapping',@cpa_batchid,@dataprocesstypeid,1),
 (1, 1, 'pl_uni_blob_dl_excel', NULL, 1,'task_cpa_landing_cpa_patient_usage',@cpa_batchid,@dataprocesstypeid,0),
 (1, 1, 'pl_uni_blob_dl_csv', NULL, 1,'task_veeva_landing_brand_indication_mapping',@veeva_batchid ,@dataprocesstypeid,0),
 (1, 1, 'task_proj1_api_landing', NULL, 1,'task_proj1_api_landing',@cpa_batchid ,@dataprocesstypeid,0);


	MERGE INTO [metadata].[Pipelines] AS tgt
	USING 
		@Pipelines AS src
			ON  tgt.[PipelineName] = src.[PipelineName]
		AND isnull(tgt.[TaskName],'')=isnull(src.[TaskName],'')
	WHEN MATCHED THEN
		UPDATE
		SET
			tgt.[OrchestratorId] = src.[OrchestratorId],
			tgt.[StageId]=src.[StageId],
			tgt.[LogicalPredecessorId]=src.[LogicalPredecessorId],
			tgt.[UniversalFlag]=src.[UniversalFlag],
			tgt.[BatchId]=src.[BatchId],
	        tgt.[DataProcessTypeId]=src.[DataProcessTypeId],
			tgt.[Enabled]=src.[Enabled]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT
			(
			[OrchestratorId],
			[StageId],
			[PipelineName], 
			[LogicalPredecessorId],
			[UniversalFlag],
			[TaskName],
				[BatchId],
	[DataProcessTypeId],
			[Enabled]
			)
		VALUES
			(
			src.[OrchestratorId],
			src.[StageId],
			src.[PipelineName], 
			src.[LogicalPredecessorId],
			src.[UniversalFlag]  ,
            src.[TaskName] ,
			src.[BatchId],
	        src.[DataProcessTypeId],
			src.[Enabled]
			)
	WHEN NOT MATCHED BY SOURCE THEN
		DELETE;

		


END;
