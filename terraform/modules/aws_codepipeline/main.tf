resource "aws_codepipeline" "this" {
  name     = var.pipeline_name
  role_arn = var.codepipeline_role

  artifact_store {
    type     = "S3"
    location = var.artifact_store
  }

  stage {
    name = "Source"
    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      configuration = {
        RepositoryName = var.codecommit_repo
        BranchName     = "main"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      configuration = {
        ProjectName = var.codebuild_project
      }
    }
  }

  # stage {
  #   name = "Deploy"
  #   action {
  #     name            = "DeployAction"
  #     category        = "Deploy"
  #     owner           = "AWS"
  #     provider        = "CodeDeploy"
  #     version         = "1"
  #     input_artifacts = ["BuildArtifact"]
  #     configuration = {
  #       ApplicationName     = var.codedeploy_app
  #       DeploymentGroupName = var.codedeploy_group
  #     }
  #   }
  # }
}
