import os
from aws_cdk import core
from cdk.ecs_stack import ECSStack
from cdk.ecr_stack import ECRStack

app = core.App()
ECRStack(app, "SKLearn-Registry-Stack")
ECSStack(app, "FastAPI-Stack")

app.synth()
