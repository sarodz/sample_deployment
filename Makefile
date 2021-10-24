SHELL := /bin/bash
.EXPORT_ALL_VARIABLES:
include .env

install:
	pip install -r requirements.txt  

clean:
	rm -rf ./sample_endpoint

init: clean
	mkdir ./sample_endpoint

pull-repo: init
	git clone https://github.com/sarodz/sample_endpoint.git

ecr-login:
	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAME}

build: pull-repo
	cd ./sample_endpoint && docker build -t ${ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAME}:latest .

push-container: ecr-login build 
	docker push ${ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAME}:latest

create-ecr:
	cd ./stack && cdk synth && cdk deploy SKLearn-Registry-Stack --require-approval never

create-ecs:
	cd ./stack && cdk synth && cdk deploy FastAPI-Stack --require-approval never

deploy-infra: create-ecr push-container create-ecs

test:
	aws ecr list-images --repository-name ${REPOSITORY_NAME}

remove-infra:
	aws ecr batch-delete-image --repository-name ${REPOSITORY_NAME} --image-ids imageTag=latest
	cd ./stack && cdk destroy --all --require-approval never