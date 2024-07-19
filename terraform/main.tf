terraform {
  // terraformのバージョンを指定
  required_version = ">= 1.5.1"

  // awsプロバイダーのバージョンを指定
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    databricks = {
      source = "databricks/databricks"
      version = "1.48.3"
    }
  }
}

provider "aws" {
  region = "asia-northeast-1" # 適切なAWSリージョンに変更
}

provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

module "codepipeline_s3" {
  source      = "./modules/aws_s3"
  bucket_name = "codepipeline-test-bucket"
}

module "output_s3" {
  source      = "./modules/aws_s3"
  bucket_name = "output-test-bucket"
}

module "codecommit" {
  source          = "./modules/aws_codecommit"
  repository_name = "mlops-test"
}

module "codebuild_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "codebuild-role"
  service    = "codebuild.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}

# module "codedeploy_role" {
#   source     = "./modules/aws_iam_role"
#   role_name  = "codedeploy-role"
#   service    = "codedeploy.amazonaws.com"
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
# }

module "codepipeline_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "codepipeline-role"
  service    = "codepipeline.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

module "codebuild" {
  source       = "./modules/aws_codebuild"
  project_name = "terraform-build"
  service_role = module.codebuild_role.role_arn
}

# module "codedeploy" {
#   source                = "./modules/aws_codedeploy"
#   app_name              = "CodeDeployApp"
#   deployment_group_name = "deployment-group"
#   service_role          = module.codedeploy_role.role_arn
# }

module "codepipeline" {
  source            = "./modules/aws_codepipeline"
  pipeline_name     = "mlops-test-pipeline"
  codepipeline_role = module.codepipeline_role.role_arn
  artifact_store    = module.codepipeline_s3.bucket_name
  codecommit_repo   = module.codecommit.repository_name
  codebuild_project = module.codebuild.project_name
}

module "databricks" {
  source           = "./modules/databricks"
  workspace_name   = "mlops-test-workspace"
  cluster_name     = "mlops-test-cluster"
  job_name         = "example-job"
  notebook_path    = "/Users/example@example.com/TestNotebook"
  databricks_host  = var.databricks_host
  databricks_token = var.databricks_token
}

module "databricks_catalog" {
  source       = "./modules/databricks_catalog_schema_table"
  catalog_name = var.catalog_name
}

module "databricks_schema" {
  source       = "./modules/databricks_catalog_schema_table"
  schema_name  = var.schema_name
  catalog_name = module.databricks_catalog.catalog_name
}

module "databricks_table" {
  source       = "./modules/databricks_catalog_schema_table"
  table_name   = var.table_name
  catalog_name = module.databricks_catalog.catalog_name
  schema_name  = module.databricks_schema.schema_name
}
