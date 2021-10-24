Source repo: https://github.com/sintaro/CDK_ECSFargate_FastAPI

This repo uses `make` and `cdk` to execute the deployment. The later command can be installed by:

`npm install -g aws-cdk`

Basic use:
- Populate the variables in the `.env` file. A mock file is provided with the name `.env_example`. The assumption is you have created an IAM role that has the appropiate permissions to run the following commands.
- Run the `make deploy-infra` command to deploy the model to a Fargate instance (can take around 10 minutes). This command does the following:
    - Create an ECR repository (`make create-ecr`)
    - Push the dockerized model (`make push-container`)
    - Deploy model to AWS Fargate (`make create-ecs`)
- Once the deployment is complete, you will see a `CDKFargateServiceServiceURL` in CLI which you can use to access a public facing model.

A sample request can be sent to the created endpoint using the following command:
`curl -d @sample_request.json -H "Content-Type: application/json" <CDKFargateServiceServiceURL>/predict`
    - The response should be `{"prediction":4.1316}`

All resources can be removed using `make remove-infra`

The env variables store the following information
- ACCOUNT: Your account ID 
- AWS_REGION: The region you want to deploy to
- AWS_ACCESS_KEY_ID: Your AWS role's access key
- AWS_SECRET_ACCESS_KEY: Your AWS role's secret key
- REPOSITORY_NAME: The name of the ECR repository you want to use 
- ROLE_NAME: The name of the role used for Fargate Task