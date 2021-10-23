SHELL := /bin/bash
.EXPORT_ALL_VARIABLES:
include .env

install:
	pip install aws_cdk.core aws_cdk.aws_ecr aws_cdk.aws_ecs aws_cdk.aws_ec2 aws_cdk.aws_iam aws_cdk.aws_ecs_patterns 

clean:
	rm -rf ./src

init: clean
	mkdir ./src

pull-repo: clean init
	cd ./src && git clone https://github.com/sarodz/sample_endpoint.git

ecr-login:
	aws ecr get-login-password --region ${AWS_REGION}

build: clean init pull-repo
	cd ./src/sample_endpoint && docker build -t sample-endpoint .
	