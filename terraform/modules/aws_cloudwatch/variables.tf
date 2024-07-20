variable "eventbridge_rule_name" {
  description = "The name of the EventBridge rule"
  type        = string
}

variable "codecommit_arn" {
  description = "The ARN of the CodeCommit repository"
  type        = string
}

variable "codepipeline_arn" {
  description = "The ARN of the CodePipeline"
  type        = string
}

variable "eventbridge_role" {
  description = "The ARN of the IAM role for EventBridge"
  type        = string
}
