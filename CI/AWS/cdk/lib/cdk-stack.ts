import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as codebuild from 'aws-cdk-lib/aws-codebuild';

export class TestAutomationCodeBuildStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const project = new codebuild.Project(this, 'DigiroadTestAutomationBuild', {
      environment: {
        buildImage: codebuild.LinuxBuildImage.fromDockerRegistry('alpine:latest'),
        privileged: true,
      },
      buildSpec: codebuild.BuildSpec.fromObject({
        version: '0.2',
        phases: {
          install: {
            commands: [
              //'pip install --upgrade awscli',
              '$(aws ecr get-login --no-include-email --region eu-west-1)'
            ],
          },
          build: {
            commands: [
              'docker build -f CI/Docker-image/Dockerfile.robot -t 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:latest . --build-arg image=475079312496.dkr.ecr.eu-west-1.amazonaws.com/python-alpine:latest',
              'docker tag 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:latest 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:$CODEBUILD_BUILD_NUMBER',
              'docker push 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:latest',
              'docker push 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:$CODEBUILD_BUILD_NUMBER'
            ],
          },
        },
      }),
    });

    new cdk.CfnOutput(this, 'DRTestAutomationCfnOutputProject', {
      value: project.projectName,
    });
  }
}
