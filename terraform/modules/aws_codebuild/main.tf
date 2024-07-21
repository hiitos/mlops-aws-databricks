resource "aws_codebuild_project" "this" {
  name         = var.codebuild_project_name
  service_role = var.service_role

  source {
    type      = "CODEPIPELINE"
    buildspec = "./terraform/init/buildspec.yml"
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
