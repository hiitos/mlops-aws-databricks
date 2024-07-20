variable "project_name" {
  description = "The name of this project."
  type        = string
}

variable "account_id" {
  description = "The AWS account ID."
  type        = string
}

variable "region" {
  description = "The AWS region."
  type        = string
}

variable "databricks_host" {
  description = "The Databricks host URL."
  type        = string
}

variable "databricks_token" {
  description = "The Databricks API token."
  type        = string
}

variable "catalog_name" {
  description = "The name of the Unity Catalog."
  type        = string
}

variable "schema_name" {
  description = "The name of the schema."
  type        = string
}

variable "table_name" {
  description = "The name of the table."
  type        = string
}
