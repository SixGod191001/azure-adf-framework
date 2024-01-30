# ADF Universal Framework

## Overview 
  The ADF Universal Framework is an open-source project designed to provide a comprehensive and flexible solution for building scalable and efficient data integration workflows using Azure Data Factory (ADF).  
  Whether you are dealing with data ingestion, transformation, or loading, this framework aims to streamline your ETL processes and empower data engineers and developers with a set of powerful capabilities.  
  And integrated various solutions, optimized and adjusted for the best outcome. Appreciate the contributions from open-source contributors.  

  This project primarily encompasses the following aspects:  
  1. ADF Universal Orchestrator Framework [Details](#5) 
  2. ADF Universal Task Framework [Details](#6) 
  3. CI/CD Solution For ADF Universal Framework [Details](#7) 
  4. DataOps For The Modern Data Warehouse [Details](#8) 

## Components:  

The solution uses these components:

| Component                      | Link                                                                                                                 |
|--------------------------------|----------------------------------------------------------------------------------------------------------------------|
| Azure Data Factory (ADF)       | [Azure Data Factory](https://azure.microsoft.com/services/data-factory)                                              |
| Azure Databricks               | [Azure Databricks](https://azure.microsoft.com/services/databricks)                                                  |
| Azure Data Lake Storage (ADLS) | [Azure Data Lake Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction)      |
| Azure Synapse Analytics        | [Azure Synapse Analytics](https://azure.microsoft.com/services/synapse-analytics)                                    |
| Azure Key Vault                | [Azure Key Vault](https://azure.microsoft.com/services/key-vault)                                                    |
| Azure DevOps                   | [Azure DevOps](https://azure.microsoft.com/services/devops)                                                          |
| Power BI                       | [Power BI](https://powerbi.microsoft.com/)                                                                           |
| Azure SQL Database             | [Azure SQL Database](https://azure.microsoft.com/en-us/products/azure-sql/database)                                  |
| Microsoft Purview              | [Microsoft Purview](https://azure.microsoft.com/en-us/products/purview)                                              |
| Azure Key Vault                | [Azure Key Vault](https://azure.microsoft.com/en-us/products/key-vault)                                              |
| Self-Hosted IR                 | [Self-Hosted IR](https://learn.microsoft.com/en-us/azure/data-factory/create-self-hosted-integration-runtime)        |
| Self-Hosted Agent              | [Self-Hosted Agent](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/windows-agent?view=azure-devops) |

## Getting Started  
  To get started with the ADF Universal Framework, please refer to the [documentation](docs%2FGetting%20Started.md) for detailed instructions, examples, and best practices.


<a id="4"></a>  
## High Level Architecture  



<a id="5"></a>  
## ADF Universal Orchestrator Framework
ADF master framework is the main portal to control the workflow and dependencies for all task pipeline  
  ![ADF master framework.png](images%2FADF%20master%20framework.png)  
### Orchestrator Framework Capabilities
  1. Metadata Management:  
     - Offer metadata storage and management to trace the sources, processing, and destinations of data.
     - Support data lineage and impact analysis to help understand and manage data workflows.
  2. Task Scheduling and Execution:  
     - Feature a robust task scheduling engine capable of executing data flow tasks according to a defined schedule.
     - Provide monitoring and logging capabilities to track task execution status and performance.
  3. Parameterization and Configuration:  
     - Allow parameterization of tasks and data flows to enhance reusability and flexibility.
     - Provide configuration options for dynamic adjustments based on environment and requirements.
  4. Error Handling and Fault Tolerance:  
     - Have a robust error-handling mechanism to capture and manage errors occurring in data flows.
     - Support fault tolerance mechanisms, allowing for task retries and recovery after failures.
  5. Security and Authentication:  
     - Integrate authentication and authorization mechanisms to ensure data security.
     - Support encryption, access control, and protection of sensitive information.
  6. Monitoring and Alerting:  
     - Provide real-time monitoring and alerting capabilities to track task performance and runtime status.
     - Integrate logging and auditing features to assist in issue troubleshooting and compliance requirements.
  7. Scalability and Customization:  
     - Demonstrate good scalability, integrating with third-party tools and services.
     - Provide custom activity and plugin mechanisms to adapt to diverse business requirements.
  8. Version Control and Collaboration:  
     - Support version control for managing and tracking changes in data workflows.
     - Provide collaboration and team development features to facilitate collaborative work among multiple team members.
  9. xxxx


<a id="6"></a>  
## ADF Universal Task Framework
  ADF task framework is aiming to build common pipeline which makes developer can use it easily by config metadata.  
  This pipeline should different kind of ingestion and data processing  
  ![ADF Task Framework.png](images%2FADF%20Task%20Framework.png)  

### Task Framework Capabilities
  1. Data Connection and Source/Destination Adapters:  
     - Ability to connect to various data stores and source systems, including relational databases, NoSQL databases, and cloud storage.
     - Provide a wide range of data source and destination adapters to support different data formats and protocols.
  2. Data Flow Processing:  
     - Support data transformation, cleansing, and processing to meet business requirements.
     - Offer a rich set of data processing activities such as data splitting, merging, aggregation, filtering, and more.
     - Support multiple interfaces, such as Azure Synapse and Azure Databricks
  3. Parameterization and Configuration:  
     - Allow parameterization of tasks and data flows to enhance reusability and flexibility.
     - Provide configuration options for dynamic adjustments based on environment and requirements.
  4. Metadata Management:  
     - Offer metadata storage and management to trace the sources, processing, and destinations of data.
     - Support data lineage and impact analysis to help understand and manage data workflows.
  5. Version Control and Collaboration:  
     - Support version control for managing and tracking changes in data workflows.
     - Provide collaboration and team development features to facilitate collaborative work among multiple team members.
  6. 


<a id="7"></a>  
## CI/CD For ADF Universal Framework Solution
### CI/CD lifecycle 
[Reference 7](#3) 
1. A development data factory is created and configured with Azure Repos Git. All developers should have permission to author Data Factory resources like pipelines and datasets.
2. A developer creates a feature branch to make a change. They debug their pipeline runs with their most recent changes.
3. After a developer is satisfied with their changes, they create a pull request from their feature branch to the main or collaboration branch to get their changes reviewed by peers.
4. After a pull request is approved and changes are merged in the main branch, the changes get published to the development factory.
5. When the team is ready to deploy the changes to a test or UAT (User Acceptance Testing) factory, the team goes to their Azure Pipelines release and deploys the desired version of the development factory to UAT.  
   This deployment takes place as part of an Azure Pipelines task and uses Resource Manager template parameters to apply the appropriate configuration.
6. After the changes have been verified in the test factory, deploy to the production factory by using the next task of the pipelines release.  
  ![CI CD lifecycle.png](images%2FCI%20CD%20lifecycle.png)  

**Note:** 
  Only the development factory is associated with a git repository.  
  The test and production factories shouldn't have a git repository associated with them and should only be updated via an Azure DevOps pipeline or via a Resource Management template.
### CI/CD flow 
[Reference 6](#2) 
  1. Each user makes changes in their private branches.
  2. Push to master isn't allowed. Users must create a pull request to make changes.
  3. The Azure DevOps pipeline build is triggered every time a new commit is made to master. It validates the resources and generates an ARM template as an artifact if validation succeeds.
  4. The DevOps Release pipeline is configured to create a new release and deploy the ARM template each time a new build is available.
  ![CI CD Flow.png](images%2FCI%20CD%20Flow.png)  
#### Walkthrough of CICD in Azure Data Factory
[Reference 9](#9)
  ![Walkthrough of CICD in Azure Data Factory.png](images%2FWalkthrough%20of%20CICD%20in%20Azure%20Data%20Factory.png)


<a id="8"></a> 
## DataOps For The Modern Data Warehouse  
### Architecture
![dataops overall architecture.png](images%2Fdataops%20overall%20architecture.png)  


### CI/CD for DataOps
![CICD for data ops solution.png](images%2FCICD%20for%20data%20ops%20solution.png)  


## Contribution
  Contributions to the project are welcome! If you have ideas for improvements, feature requests, or bug reports, feel free to open an issue or submit a pull request.  
  Let's collaborate to make data integration with Azure Data Factory more efficient and scalable!

## Version Life Cycle
ADF Universal Framework version life cycle:

| Version | Current Patch/Minor | State     | First Release | Limited Support   | EOL/Terminated |
|---------|---------------------|-----------|---------------|-------------------|----------------|
| 2       | 2.1.0               | Supported | Jun 30, 2024  | TBD               | TBD            |
| 1.4     | 1.4.3               | EOL       | May 31, 2024  | Dec 31, 2024      | Dec 31, 2024   |
| 1.3     | 1.3.0               | EOL       | Apr 30, 2024  | Dec 31, 2024      | Dec 31, 2024   |
| 1.2     | 1.2.5               | EOL       | Mar 31, 2024  | Dec 31, 2024      | Dec 31, 2024   |
| 1.1     | 1.1.1               | EOL       | Feb 28, 2024  | Dec 31, 2024      | Dec 31, 2024   |



## Reference Link:
<a id="1"></a>
1. [Continuous integration and delivery in Azure Data Factory](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery)
2. [How to setup Self-hosted Windows agents](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/windows-agent?view=azure-devops)
3. [Register an agent using a personal access token (PAT)](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/personal-access-token-agent-registration?view=azure-devops)
4. [Run the agent - interactively](https://learn.microsoft.com/zh-cn/azure/devops/pipelines/agents/windows-agent?view=azure-devops#run-interactively)
5. [Run the agent - service](https://learn.microsoft.com/zh-cn/azure/devops/pipelines/agents/windows-agent?view=azure-devops#run-as-a-service)
<a id="2"></a>
6. [Continuous deployment improvements](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery-improvements)
<a id="3"></a>
7. [Continuous integration and delivery in Azure Data Factory](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery)
8. [Walkthrough of CICD in Azure Data Factory (ADF)](https://medium.com/microsoftazure/walkthrough-of-cicd-in-azure-data-factory-adf-54a07ef90d1b)
<a id="9"></a>
9. [DataOps for the modern data warehouse](https://learn.microsoft.com/en-us/azure/architecture/databases/architecture/dataops-mdw)
10. [procfwk](https://github.com/mrpaulandrew/procfwk)