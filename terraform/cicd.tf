############################################
################ S3 Buckets ################
############################################
module "codepipeline_s3" {
  source      = "./modules/aws_s3"
  bucket_name = "${var.terraform_project_name}-codepipeline-test-bucket"
}

############################################
################ CodeCommit ################
############################################
module "codecommit" {
  source          = "./modules/aws_codecommit"
  repository_name = var.terraform_project_name
}

############################################
################ CodeBuild #################
############################################
locals {
  codebuild_policy = templatefile("${path.module}/iam_policy_json/codebuild_policy.json.tpl", {})
}
module "codebuild_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "${var.terraform_project_name}-codebuild-role"
  service    = "codebuild.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}
# module "codebuild_policy" {
#   source      = "./modules/aws_iam_policy"
#   policy_name = "${var.terraform_project_name}_codebuild_policy"
#   role_name   = module.codebuild_role.role_name
#   # policy_json = data.template_file.codebuild_policy.rendered
#   policy_json = local.codebuild_policy
# }
module "codebuild" {
  source                 = "./modules/aws_codebuild"
  codebuild_project_name = "${var.terraform_project_name}-terraform-build"
  service_role           = module.codebuild_role.role_arn
}

############################################
################ CodeDeploy ################
############################################
# module "codedeploy_role" {
#   source     = "./modules/aws_iam_role"
#   role_name  = "${var.terraform_project_name}-codedeploy-role"
#   service    = "codedeploy.amazonaws.com"
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
# }

# module "codedeploy" {
#   source                = "./modules/aws_codedeploy"
#   app_name              = "${var.terraform_project_name}-codedeploy-app"
#   deployment_group_name = "${var.terraform_project_name}-deployment-group"
#   service_role          = module.codedeploy_role.role_arn
# }

############################################
################ CodePipeline ###############
############################################
locals {
  codepipeline_policy = templatefile("${path.module}/iam_policy_json/codepipeline_policy.json.tpl", {
    REGION          = var.terraform_region,
    ACCOUNT_ID      = var.terraform_account_id,
    REPOSITORY_NAME = module.codecommit.repository_name
  })
}
module "codepipeline_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "${var.terraform_project_name}-codepipeline-role"
  service    = "codepipeline.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

module "codepipeline_policy" {
  source      = "./modules/aws_iam_policy"
  policy_name = "${var.terraform_project_name}_codepipeline_policy"
  role_name   = module.codepipeline_role.role_name
  # policy_json = data.template_file.codepipeline_policy.rendered
  policy_json = local.codepipeline_policy
}
module "codepipeline" {
  source            = "./modules/aws_codepipeline"
  pipeline_name     = "${var.terraform_project_name}-pipeline"
  codepipeline_role = module.codepipeline_role.role_arn
  artifact_store    = module.codepipeline_s3.bucket_name
  codecommit_repo   = module.codecommit.repository_name
  codebuild_project = module.codebuild.codebuild_project_name
}
