# SQL Project Quick Start
![Labels.png](..%2Fimages%2FLabels.png)
![Logo.png](..%2Fimages%2FLogo.png)


## Check List
   - git installed
   - A GitHub account
   - Visual Studio Code installed 
   - An Azure SQL Database created


## Clone Git Repository
    - cd <folder>
    - Git clone <git url>

## Setting up Visual Studio Code
   1. Open VS Code and go to the extensions tab on the left
      ![open extension.png](../images/open%20extension.png)
   2. Using the Search Extensions in Marketplace bar, search for mssql. Once you find the SQL Server (mssql) extension, click the install blue button.
      ![search extension.png](../images/Search%20Extensions.png)
   3. This will install a few extensions, most importantly the SQL Database Projects extension. You can see the new extensions on the left of the Visual Studio Code window.
      ![project extension.png](../images/project%20extension.png)
   4. We are going to start with Database Projects. Just simply click the extension to bring up the Database Projects panel. Here, click the Open Existing.
      ![open existing sql project.png](../images/Open%20existing%20SQL%20project.png)

## Build
   1. Build project,for now excluded pre-deployment and post-deployment in build process
   2. If you want to re-create all the thing on the database please execute dropAll.sql

## Publish
   1. Edit the configuration in ADFMetadataDBSQLProj.publish.xml to your database
   2. Run deploy process