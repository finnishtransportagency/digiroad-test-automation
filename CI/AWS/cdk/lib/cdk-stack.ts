import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as codebuild from 'aws-cdk-lib/aws-codebuild';

export class TestAutomationCodeBuildStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const project = new codebuild.Project(this, 'DigiroadTestAutomationBuild', {
      environment: {
        buildImage: codebuild.LinuxBuildImage.STANDARD_7_0,
        privileged: true,
      },
      cache: codebuild.Cache.local(codebuild.LocalCacheMode.DOCKER_LAYER),
      buildSpec: codebuild.BuildSpec.fromObject({
        version: '0.2',
        phases: {
          install: {
            commands: [
            'apt-get update -y',
            'apt-get install -y awscli docker.io',
            'aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 475079312496.dkr.ecr.eu-west-1.amazonaws.com'
            ],
          },
          build: {
            commands: [
          'docker run --rm alpine:latest apk add curl bash',
          'docker build -f Dockerfile.robot -t 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:latest .',
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
