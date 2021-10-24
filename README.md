Source repo: https://github.com/sintaro/CDK_ECSFargate_FastAPI

This repo uses the CDK Toolkit. It can be installed using 
`npm install -g aws-cdk`

For additional details, check below
https://docs.aws.amazon.com/cdk/latest/guide/cli.html

To deploy the code in this repo you need to be able to use the `make` command.
Basic use:
    - Populate the variables in the `.env` file. A mock file is provided with the name `.env_example`. The assumption is you have created an IAM role that has the appropiate permissions to run the following commands.
    - Run the `make deploy-infra` command to (can take around 10 minutes):
        - Create ECR repository (`make create-ecr`)
        - Push dockerized model (`make push-container`)
        - Deploy model to AWS Fargate (`make create-ecs`)
    - Once the previous command is completed, you will see a `CDKFargateServiceServiceURL` which you can use to access a public facing model.

A sample request can be sent to the created endpoint using the following command after updating `<CDKFargateServiceServiceURL>`:
`curl -d @sample_request.json -H "Content-Type: application/json" <CDKFargateServiceServiceURL>/predict`
    - The response should be `{"prediction":4.1316}`

All resources can be removed using `make remove-infra`