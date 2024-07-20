variable "codedeploy_app_name" {
  description = "The name of the CodeDeploy application"
  type        = string
}

variable "deployment_group_name" {
  description = "The name of the CodeDeploy deployment group"
  type        = string
}

variable "service_role" {
  description = "The ARN of the service role for CodeDeploy"
  type        = string
}
