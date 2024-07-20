resource "aws_codebuild_project" "this" {
  name         = var.codebuild_project_name
  service_role = var.service_role

  source {
    type      = "CODEPIPELINE"
    buildspec = <<EOF
version: 0.2

phases:
  install:
    runtime-versions:
      python: 3.8
  pre_build:
    commands:
      - pip install awscli
      - curl -LO https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_linux_amd64.zip
      - unzip terraform_1.9.2_linux_amd64.zip
      - mv terraform /usr/local/bin/
      - ./fetch_and_set_ssm_parameters.sh
  build:
    commands:
      - cd terraform
      - terraform init
      - terraform plan
      - terraform apply -auto-approve
EOF
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "DATETIME_VAR"
      value = "example_value"
    }
  }
}
