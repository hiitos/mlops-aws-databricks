variable "workspace_name" {
  description = "The name of the Databricks workspace"
  type        = string
}

variable "cluster_name" {
  description = "The name of the Databricks cluster"
  type        = string
}

variable "job_name" {
  description = "The name of the Databricks job"
  type        = string
}

variable "notebook_path" {
  description = "The path to the Databricks notebook"
  type        = string
}

variable "databricks_host" {
  description = "The Databricks host URL"
  type        = string
}

variable "databricks_token" {
  description = "The Databricks API token"
  type        = string
}
