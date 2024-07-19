variable "pipeline_name" {
  description = "The name of the CodePipeline"
  type        = string
}

variable "codepipeline_role" {
  description = "The ARN of the CodePipeline service role"
  type        = string
}

variable "artifact_store" {
  description = "The S3 bucket for artifact storage"
  type        = string
}

variable "codecommit_repo" {
  description = "The name of the CodeCommit repository"
  type        = string
}

variable "codebuild_project" {
  description = "The name of the CodeBuild project"
  type        = string
}

# variable "codedeploy_app" {
#   description = "The name of the CodeDeploy application"
#   type        = string
# }

# variable "codedeploy_group" {
#   description = "The name of the CodeDeploy deployment group"
#   type        = string
# }
