variable "terraform_project_name" {
  description = "The name of this project."
  type        = string
}

variable "terraform_account_id" {
  description = "The AWS account ID."
  type        = string
}

variable "terraform_region" {
  description = "The AWS region."
  type        = string
}

variable "terraform_databricks_host" {
  description = "The Databricks host URL."
  type        = string
}

variable "terraform_databricks_token" {
  description = "The Databricks API token."
  type        = string
}

variable "terraform_catalog_name" {
  description = "The name of the Unity Catalog."
  type        = string
}

variable "terraform_schema_name" {
  description = "The name of the schema."
  type        = string
}

variable "terraform_table_name" {
  description = "The name of the table."
  type        = string
}
