resource "databricks_notebook" "this" {
  path     = "${var.notebook_path_prefix}/${var.notebook_filename}"
  language = var.notebook_language
  source   = "${local_notebook_path_prefix}/${var.notebook_filename}"
}
