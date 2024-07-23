variable "notebook_path_prefix" {
  description = "The prefix of the notebook's path."
  type        = string
  default     = "/Workspace/Shared"
}

variable "notebook_filename" {
  description = "The notebook's filename."
  type        = string
}

variable "notebook_language" {
  description = "The language of the notebook."
  type        = string
  default     = "PYTHON"
}

variable "local_notebook_path_prefix" {
  description = "The prefix of the notebook's path."
  type        = string
  default     = "../../notebook"
}
