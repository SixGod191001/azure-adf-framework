# Develop Standard
## Azure data factory pipeline naming standard:
- Worker pipeline: naming folder as <batch name>, create pipelines under corresponding folder, naming pipeline as task_<batch name>_<layer_name>_<task name>
- Data set name: naming folder as <batch name>, create data sets under corresponding folder, naming data set as ds_<batch name>_<file name>
- Universal pipeline: create pipeline under 'Utils' folder

## CI/CD Develop Standard
- Create your own branch with the name start as 'adf_feature/'
- Create pull request to merge your branch to develop branch
- Devops build pipeline will generate ARM template automatically once you commit to develop branch
- Devops release pipeline will deploy ARM template to azure data factory automatically once build pipeline is completed
- Create pull request to merge develop branch to main branch


   
