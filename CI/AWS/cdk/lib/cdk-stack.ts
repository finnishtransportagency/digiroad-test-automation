import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import * as codebuild from 'aws-cdk-lib/aws-codebuild';
import { DockerImageAsset } from 'aws-cdk-lib/aws-ecr-assets';
import * as path from 'path';
import { env } from 'process';


export class TestAutomationCodeBuildStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const dockerAsset = new DockerImageAsset(this, 'AutomationDockerAsset', {
      directory: path.join(__dirname, '../docker/'),
      file: 'Dockerfile',
    });

    new cdk.CfnOutput(this, 'DockerImageURI', {
      value: dockerAsset.imageUri,
    });

    const project = new codebuild.Project(this, 'DigiroadTestAutomationBuild', {
      source: codebuild.Source.gitHub({
        owner: 'finnishtransportagency',
        repo: 'digiroad-test-automation',
        webhook: false,
      }),
      environment: {
        buildImage: codebuild.LinuxBuildImage.STANDARD_7_0,
        privileged: true,
      },
        //make an environment asset to avoid using dot symbol
        environmentVariables: {
        DOCKER_ASSET_IMAGE_URI: {
          value: dockerAsset.imageUri,
        },
      },
      cache: codebuild.Cache.local(codebuild.LocalCacheMode.DOCKER_LAYER),
      buildSpec: codebuild.BuildSpec.fromObject({
        version: 0.2,
        env: {
          shell: 'bash'
            },
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
          "sed -i '1i #!/bin/bash' /codebuild/output/tmp/script.sh", //changes to correct bash shell to prevent error 2
          'head -n 1 /codebuild/output/tmp/script.sh',
          'echo "Image URI: ${DOCKER_ASSET_IMAGE_URI}"',
          'docker build -t digiroadautomation:latest ./CI/AWS/cdk/docker/',
          'docker tag digiroadautomation:latest 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:$CODEBUILD_BUILD_NUMBER',
          'docker tag digiroadautomation:latest 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation:latest',
          'docker push --all-tags 475079312496.dkr.ecr.eu-west-1.amazonaws.com/digiroadautomation'
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
