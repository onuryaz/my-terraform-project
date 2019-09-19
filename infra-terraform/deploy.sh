#!/bin/sh


# set aws env. variables 
export AWS_ACCESS_KEY_ID="AKIAVNLQBRBEVNJMXXXZ"
export AWS_SECRET_ACCESS_KEY="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"
export AWS_DEFAULT_REGION="eu-west-1"
export AWS_ACCOUNT="372286523465"


# set ecr and project variables 
SERVICE_NAME="flask-hello-world"
SERVICE_TAG="latest"
ECR_REPO_URL="372286523465.dkr.ecr.eu-west-1.amazonaws.com/${SERVICE_NAME}"


# dockerize the project and and push into ECR repo
if [ "$1" = "dockerize" ];then

    $(aws ecr get-login --no-include-email --region eu-west-1)
    aws ecr create-repository --repository-name ${SERVICE_NAME:?} || true
    docker build -t ${SERVICE_NAME}:${SERVICE_TAG} . 
    docker tag ${SERVICE_NAME}:${SERVICE_TAG} ${ECR_REPO_URL}${SERVICE_NAME}:${SERVICE_TAG}
    docker push ${ECR_REPO_URL}:${SERVICE_TAG}

elif [ "$1" = "staging plan" ];then
    terraform init
    terraform workspace new staging  # Switched to workspace staging
    terraform plan -var-file=staging/stage.tfvars -out staging.plan
elif [ "$1" = "staging deploy" ];then
    terraform init
    terraform workspace new staging  # Switched to workspace staging
    terraform apply -var-file=staging/stage.tfvars -out staging.plan
    
elif [ "$1" = "destroy" ];then
    terraform destroy -var-file="staging/staging.tfvars" -var
fi
