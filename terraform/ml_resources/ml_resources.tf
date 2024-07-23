############################################
################ S3 Buckets ################
############################################
module "output_s3" {
  source      = "../modules/aws_s3"
  bucket_name = "${var.terraform_project_name}-databricks-output-test-bucket"
}

############################################
################ databricks ################
############################################
# module "databricks_test_ws" {
#   source           = "../modules/databricks_workspace"
#   workspace_name   = "${var.terraform_project_name}-workspace"
# }

module "databricks_test_cluster" {
  source                          = "../modules/databricks_cluster"
  cluster_name                    = "${var.terraform_project_name}-cluster"
  cluster_autotermination_minutes = 10
  cluster_num_workers             = 1
}

module "databricks_test_notebook" {
  source = "../modules/databricks_notebook"
  # notebook_path_prefix       = "/Workspace/Users/sample@gmail.com"
  notebook_path_prefix       = "/Workspace/Shared/Notebooks"
  notebook_filename          = "display_babynames_by_year.ipynb"
  notebook_language          = "PYTHON"
  local_notebook_path_prefix = "../../notebook"
}

module "databricks_test_notebook" {
  source = "../modules/databricks_notebook"
  # notebook_path_prefix       = "/Workspace/Users/sample@gmail.com"
  notebook_path_prefix       = "/Workspace/Shared/Notebooks"
  notebook_filename          = "download_and_save_csv_to_dbfs.ipynb"
  notebook_language          = "PYTHON"
  local_notebook_path_prefix = "../../notebook"
}

module "databricks_test_job" {
  source     = "../modules/databricks_job"
  job_name   = "test_job_from_terraform"
  cluster_id = module.databricks_test_cluster.cluster_id
  tasks = [
    {
      task_key      = "test_task_1"
      notebook_path = "/Workspace/Shared/Notebooks/display_babynames_by_year.ipynb"
    },
    {
      task_key      = "test_task_2"
      notebook_path = "/Workspace/Shared/Notebooks/download_and_save_csv_to_dbfs.ipynb"
    }
  ]
}

# module "databricks_catalog" {
#   source       = "../modules/databricks_catalog_schema_table"
#   catalog_name = var.terraform_catalog_name
# }

# module "databricks_schema" {
#   source       = "../modules/databricks_catalog_schema_table"
#   schema_name  = var.terraform_schema_name
#   catalog_name = module.databricks_catalog.catalog_name
# }

# module "databricks_table" {
#   source       = "../modules/databricks_catalog_schema_table"
#   table_name   = var.terraform_table_name
#   catalog_name = module.databricks_catalog.catalog_name
#   schema_name  = module.databricks_schema.schema_name
# }
