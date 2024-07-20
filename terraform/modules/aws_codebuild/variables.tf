variable "codebuild_project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "service_role" {
  description = "The ARN of the service role for CodeBuild"
  type        = string
}
