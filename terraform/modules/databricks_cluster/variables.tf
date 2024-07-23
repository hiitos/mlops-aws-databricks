variable "cluster_name" {
  description = "The name of the Databricks cluster"
  type        = string
}

variable "cluster_autotermination_minutes" {
  description = "How many minutes before automatically terminating due to inactivity."
  type        = number
  default     = 10
}

variable "cluster_num_workers" {
  description = "The number of workers."
  type        = number
  default     = 1
}
