############################################
################ S3 Buckets ################
############################################
# module "output_s3" {
#   source      = "./modules/aws_s3"
#   bucket_name = "${var.terraform_project_name}-databricks-output-test-bucket"
# }

############################################
################ databricks ################
############################################
# module "databricks" {
#   source           = "./modules/databricks"
#   workspace_name   = "${var.terraform_project_name}-workspace"
#   cluster_name     = "${var.terraform_project_name}-cluster"
#   job_name         = "example-job"
#   notebook_path    = "/Users/example@example.com/TestNotebook"
#   databricks_host  = var.terraform_databricks_host
#   databricks_token = var.terraform_databricks_token
# }

# module "databricks_catalog" {
#   source       = "./modules/databricks_catalog_schema_table"
#   catalog_name = var.terraform_catalog_name
# }

# module "databricks_schema" {
#   source       = "./modules/databricks_catalog_schema_table"
#   schema_name  = var.terraform_schema_name
#   catalog_name = module.databricks_catalog.catalog_name
# }

# module "databricks_table" {
#   source       = "./modules/databricks_catalog_schema_table"
#   table_name   = var.terraform_table_name
#   catalog_name = module.databricks_catalog.catalog_name
#   schema_name  = module.databricks_schema.schema_name
# }
