# my-terraform-project
 I used fargate to deploy this project with some shell script  (I already deleted the credentials inside project)

Dockerize the Flask Application:


1- Dockerize Flask application : First of all I created my folder structure using Visual Studio Code.


2- I created requirements.txt file for project dependencies.


pip3 freeze > requirements.txt


flask project dpeendencies written inside txt file.



3- I created Dockerfile inside the project


I have create deploy.sh file which is going to push docker image in ECR with tag.


4- I created shell file to automate this


We need to pass as argument ./deploy.sh dockerize



Note: I enabled the versioning for s3 bucket we will keep our state files


I used ecs service role and autoscale roles attached them to related services.


I created security groups just open necessary service port


For autoscaling scaling poicy , cloudwatch metric alarm(metric) created for up and down of related service


When I create network infrastructure I used Availability Zones for High Availability


There is two part in my project first is network-infra


Second part is infra-terraform


(I used workspace to run project on my local to keep to state files)


terraform init
terraform workspace new staging # Switched to workspace staging
terraform plan -var-file=staging/stage.tfvars -out staging.plan

------------------------------------------------------------------------------
Also I created two tfvars file prod and staging  there is two different tfvars for two different environment.
