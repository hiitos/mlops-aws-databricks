variable "job_name" {
  description = "The name of the Databricks job"
  type        = string
}

variable "cluster_id" {
  description = "Cluster id for the job"
  type        = string
}

variable "tasks" {
  description = "List of tasks for the job"
  type = list(object({
    task_key      = string
    notebook_path = string
  }))
  default = []
}
# e.g.
# tasks = [
#   {
#     task_key      = "my_task_1"
#     notebook_path = "/Workspace/Notebooks/Task1"
#   },
#   {
#     task_key      = "my_task_2"
#     notebook_path = "/Workspace/Notebooks/Task2"
#   }
# ]
