variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role to attach the policy to"
  type        = string
}

variable "policy_json" {
  description = "The JSON policy document"
  type        = string
}
