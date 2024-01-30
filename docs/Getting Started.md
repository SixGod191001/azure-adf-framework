# Project Name
ADF Universal Framework

## Project Description
This project is a universal Azure Data Factory framework designed to simplify and standardize the development and maintenance of ETL tasks. It provides a set of common data processing pipelines and templates that can be applied to various data integration and transformation scenarios.

## Quick Start
1. Prerequisites
   Make sure you have the following tools installed and configured:
   Prerequisites:
   - Git
   - Pycharm or Visual Studio Code
   - Azure Account
   - Azure DevOps Account (Repos in Azure DevOps is not used in this case)
   - GitHub Account (Config handshake between GitHub and Azure DevOps when create a new pipline in Azure DevOps )
   - Install and config Self Hosted Agent - Azure DevOps (For cost saving purpose)  
     [Reference 1-5](#1)  
     ![How to setup Self-hosted Windows agents.png](..%2Fimages%2FHow%20to%20setup%20Self-hosted%20Windows%20agents.png)
     Once config ready you should see the result as below:  
     ![Agent running status in local PC.png](..%2Fimages%2FAgent%20running%20status%20in%20local%20PC.png)  
     ![Agent running status in Azure DevOps account.png](..%2Fimages%2FAgent%20running%20status%20in%20Azure%20DevOps%20account.png)  

     Finally, you should see result as below  
     ![Agent running result.png](..%2Fimages%2FAgent%20running%20result.png)  
      
     ![Local Agent Log.png](..%2Fimages%2FLocal%20Agent%20Log.png)
     **Note:**  
       If you are using VPN locally please remove/set git proxy correctly.
     ```
     git config --global --unset http.proxy
     git config --global --unset https.proxy
  
     git config --global http.proxy http://your.new.proxy:port
     git config --global https.proxy http://your.new.proxy:port
  
     git config --get http.proxy
     git config --get https.proxy
     ```
   - Install and config ADF Self-Hosted IR locally for cost saving purpose
     1. Go to Integration Runtime
     2. Create New Self-Hosted IR
     3. config by express or manually
        - Download agent installation file or using [IR_ADF_ams.exe](..%2Fagent%2FIR_ams_930d2a20-dc22-431d-bdde-4a2916d0096b_e4b13772-1125-46cd-9501-83fe2c90380a_gX%2Bjgv0K09301%2B2VR1yYXVNNbpEy2OIzdhOixxkgFDo%3D_anBlLmZyb250ZW5kLmNsb3VkZGF0YWh1Yi5uZXQ%3D.exe)
        - Express installation as below
          ![config ADF IR.png](..%2Fimages%2Fconfig%20ADF%20IR.png)
2. Why use ADF Universal Framework
     1. xxx
     2. xxx
     3. xxx
     4. xxx
     5. xxx
     6. xxx
3. What are features of ADF Universal Framework
     1. xxx
     2. xxx
     3. xxx
     4. xxx
     5. xxx
     6. xxx
4. How to use ADF Universal Framework
   - How to Use ADF Universal Orchestrator Framework
     1. xxx
     2. xxx
     3. xxx
     4. xxx
     5. xxx
     6. xxx
   - How to Use ADF Universal Task Framework
     1. xxx
     2. xxx
     3. xxx
     4. xxx
     5. xxx
     6. xxx
5. How to use DataOps For The Modern Data Warehouse in ADF Universal Framework
     1. xxx
     2. xxx
     3. xxx
     4. xxx
     5. xxx
     6. xxx



