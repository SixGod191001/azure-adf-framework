# CI/CD to Azure Data Factory
## Overview
- Solution Overview
- Agent prerequisite
- Build Pipeline
- Release Pipeline

## The new CI/CD flow
Each user makes changes in their private branches.  
Push to master isn't allowed. Users must create a pull request to make changes.  
The Azure DevOps pipeline build is triggered every time a new commit is made to master. It validates the resources and generates an ARM template as an artifact if validation succeeds.  
The DevOps Release pipeline is configured to create a new release and deploy the ARM template each time a new build is available.  
![image](https://github.com/SixGod191001/azure-adf-framework/assets/127569124/59500cc6-0df5-4d24-8dcd-8e239bcb7d17)

## Agent
Prerequisite  
Install Azure Powershell, follow the link below:  
<https://learn.microsoft.com/zh-cn/powershell/azure/install-azps-windows?view=azps-12.0.0&tabs=windowspowershell&pivots=windows-psgallery>

## Build Pipeline
Follow the guidance of the link below:  
<https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery-improvements>

## Release Pipeline
Follow the guidance of the link below:  
- Automate continuous integration using Azure Pipelines releases:
<https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery-automate-azure-pipelines>
- Sample pre- and post-deployment script:
<https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery-sample-script>
