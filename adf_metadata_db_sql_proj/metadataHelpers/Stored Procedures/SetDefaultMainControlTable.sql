CREATE PROCEDURE [metadata].[SetDefaultMainControlTable]
AS
  TRUNCATE TABLE metadata.metadata_cedc;
  INSERT INTO metadata.metadata_cedc 
  (SourceObjectSettings	,
SourceConnectionSettingsName	,
CopySourceSettings	,
SinkObjectSettings	,
SinkConnectionSettingsName	,
CopySinkSettings	,
CopyActivitySettings	,
TopLevelPipelineName	,
TriggerName	,
DataLoadingBehaviorSettings	,
TaskId	,
CopyEnabled	
)
  VALUES 
('{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "cases_deaths.csv",
            "folderPath": "ecdc",
            "container": "landing"
        }',null,'{
            "skipLineCount": 0,
            "recursive": true,
            "enablePartitionDiscovery": false
        }','{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "cases_deaths.csv",
            "folderPath": "ecdc",
            "fileSystem": "interim"
        }',null,'{
            "quoteAllText": true,
            "fileExtension": ".txt",
            "copyBehavior": "FlattenHierarchy"
        }','{
            "translator": {
                "type": "TabularTranslator",
                "typeConversion": true
            }
        }','CSV_COPY_BLOB_GEN2_m8j_TopLevel','[
            "Sandbox",
            "Manual"
        ]','{
            "dataLoadingBehavior": "FullLoad"
        }',2,1),
('{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "country_lookup.csv",
            "folderPath": "ecdc",
            "container": "landing"
        }',null,'{
            "skipLineCount": 0,
            "recursive": true,
            "enablePartitionDiscovery": false
        }','{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "country_lookup.csv",
            "folderPath": "ecdc",
            "fileSystem": "interim"
        }',null,'{
            "quoteAllText": true,
            "fileExtension": ".txt",
            "copyBehavior": "FlattenHierarchy"
        }','{
            "translator": {
                "type": "TabularTranslator",
                "typeConversion": true
            }
        }','CSV_COPY_BLOB_GEN2_m8j_TopLevel','[
            "Sandbox",
            "Manual"
        ]','{
            "dataLoadingBehavior": "FullLoad"
        }',2,1),        
('{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "country_response.csv",
            "folderPath": "ecdc",
            "container": "landing"
        }',null,'{
            "skipLineCount": 0,
            "recursive": true,
            "enablePartitionDiscovery": false
        }','{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "country_response.csv",
            "folderPath": "ecdc",
            "fileSystem": "interim"
        }',null,'{
            "quoteAllText": true,
            "fileExtension": ".txt",
            "copyBehavior": "FlattenHierarchy"
        }','{
            "translator": {
                "type": "TabularTranslator",
                "typeConversion": true
            }
        }','CSV_COPY_BLOB_GEN2_m8j_TopLevel','[
            "Sandbox",
            "Manual"
        ]','{
            "dataLoadingBehavior": "FullLoad"
        }',2,1),   
('{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "dim_date.csv",
            "folderPath": "ecdc",
            "container": "landing"
        }',null,'{
            "skipLineCount": 0,
            "recursive": true,
            "enablePartitionDiscovery": false
        }','{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "dim_date.csv",
            "folderPath": "ecdc",
            "fileSystem": "interim"
        }',null,'{
            "quoteAllText": true,
            "fileExtension": ".txt",
            "copyBehavior": "FlattenHierarchy"
        }','{
            "translator": {
                "type": "TabularTranslator",
                "typeConversion": true
            }
        }','CSV_COPY_BLOB_GEN2_m8j_TopLevel','[
            "Sandbox",
            "Manual"
        ]','{
            "dataLoadingBehavior": "FullLoad"
        }',1,1),   
('{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "hospital_admissions.csv",
            "folderPath": "ecdc",
            "container": "landing"
        }',null,'{
            "skipLineCount": 0,
            "recursive": true,
            "enablePartitionDiscovery": false
        }','{
            "columnDelimiter": ",",
            "escapeChar": "\\",
            "quoteChar": "\"",
            "firstRowAsHeader": true,
            "fileName": "hospital_admissions.csv",
            "folderPath": "ecdc",
            "fileSystem": "interim"
        }',null,'{
            "quoteAllText": true,
            "fileExtension": ".txt",
            "copyBehavior": "FlattenHierarchy"
        }','{
            "translator": {
                "type": "TabularTranslator",
                "typeConversion": true
            }
        }','CSV_COPY_BLOB_GEN2_m8j_TopLevel','[
            "Sandbox",
            "Manual"
        ]','{
            "dataLoadingBehavior": "FullLoad"
        }',1,1);