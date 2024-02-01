CREATE VIEW [metadata].[DataFactorys]
AS
SELECT
	[OrchestratorId] AS DataFactoryId,
	[OrchestratorName] AS DataFactoryName,
	[ResourceGroupName],
	[SubscriptionId],
	[Description]
FROM
	[metadata].[Orchestrators]
WHERE
	[OrchestratorType] = 'ADF';