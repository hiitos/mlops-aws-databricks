terraform {
  // terraformのバージョンを指定
  required_version = "= 1.9.2"

  // awsプロバイダーのバージョンを指定
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "~> 5.0"
    }
    databricks = {
      source = "databricks/databricks"
      # version = "1.48.3"
    }
  }
}

provider "aws" {
  region = var.terraform_region
}

provider "databricks" {
  host  = var.terraform_databricks_host
  token = var.terraform_databricks_token
}
