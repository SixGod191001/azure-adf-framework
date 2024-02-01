CREATE PROCEDURE [dbo].[DemoModePrecursor]
AS
BEGIN

	--quick win
	IF ([metadata].[GetPropertyValueInternal]('ExecutionPrecursorProc')) <> '[dbo].[DemoModePrecursor]'
	BEGIN
		EXEC [metadataHelpers].[AddProperty]
			@PropertyName = N'ExecutionPrecursorProc',
			@PropertyValue = N'[dbo].[DemoModePrecursor]';
	END;

	--reduce wait times
	;WITH cte AS
		(
		SELECT 
			[PipelineId],
			LEFT(ABS(CAST(CAST(NEWID() AS VARBINARY(192)) AS INT)),1) AS NewValue
		FROM 
			[metadata].[PipelineParameters]
		)
	UPDATE
		pp
	SET
		pp.[ParameterValue] = cte.[NewValue]
	FROM
		[metadata].[PipelineParameters] pp
		INNER JOIN cte
			ON pp.[PipelineId] = cte.[PipelineId]
		INNER JOIN [metadata].[Pipelines] p
			ON pp.[PipelineId] = p.[PipelineId]
	WHERE
		pp.[ParameterName] LIKE 'Wait%'
		AND p.[Enabled] = 1;


	--for intentional error
	IF NOT EXISTS
		(
		SELECT * FROM [metadata].[CurrentExecution]
		)
		BEGIN
			UPDATE
				pp
			SET
				pp.[ParameterValue] = 'true'
			FROM
				[metadata].[PipelineParameters] pp
				INNER JOIN [metadata].[Pipelines] p
					ON pp.[PipelineId] = p.[PipelineId]
			WHERE
				p.[PipelineName] = 'Intentional Error'
				AND pp.[ParameterName] = 'RaiseErrors';
		END;
		ELSE
		BEGIN
			UPDATE
				pp
			SET
				pp.[ParameterValue] = 'false'
			FROM
				[metadata].[PipelineParameters] pp
				INNER JOIN [metadata].[Pipelines] p
					ON pp.[PipelineId] = p.[PipelineId]
			WHERE
				p.[PipelineName] = 'Intentional Error'
				AND pp.[ParameterName] = 'RaiseErrors';
		END;

	--dependency chain failure handling
	IF ([metadata].[GetPropertyValueInternal]('FailureHandling')) <> 'DependencyChain'
	BEGIN
		EXEC [metadataHelpers].[AddProperty]
			@PropertyName = N'FailureHandling',
			@PropertyValue = N'DependencyChain';
	END;


	--short infant iterations
	IF ([metadata].[GetPropertyValueInternal]('PipelineStatusCheckDuration')) <> '5'
	BEGIN
		EXEC [metadataHelpers].[AddProperty]
			@PropertyName = N'PipelineStatusCheckDuration',
			@PropertyValue = N'5';
		END;
END;