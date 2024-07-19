############################################
################ S3 Buckets ################
############################################
module "output_s3" {
  source      = "./modules/aws_s3"
  bucket_name = "databricks-output-test-bucket"
}

############################################
################ databricks ################
############################################
# module "databricks" {
#   source           = "./modules/databricks"
#   workspace_name   = "mlops-test-workspace"
#   cluster_name     = "mlops-test-cluster"
#   job_name         = "example-job"
#   notebook_path    = "/Users/example@example.com/TestNotebook"
#   databricks_host  = var.databricks_host
#   databricks_token = var.databricks_token
# }

# module "databricks_catalog" {
#   source       = "./modules/databricks_catalog_schema_table"
#   catalog_name = var.catalog_name
# }

# module "databricks_schema" {
#   source       = "./modules/databricks_catalog_schema_table"
#   schema_name  = var.schema_name
#   catalog_name = module.databricks_catalog.catalog_name
# }

# module "databricks_table" {
#   source       = "./modules/databricks_catalog_schema_table"
#   table_name   = var.table_name
#   catalog_name = module.databricks_catalog.catalog_name
#   schema_name  = module.databricks_schema.schema_name
# }
