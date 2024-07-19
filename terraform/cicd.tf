############################################
################ S3 Buckets ################
############################################
module "codepipeline_s3" {
  source      = "./modules/aws_s3"
  bucket_name = "codepipeline-test-bucket"
}

############################################
################ CodeCommit ################
############################################
module "codecommit" {
  source          = "./modules/aws_codecommit"
  repository_name = "mlops-test"
}

############################################
################ CodeBuild #################
############################################
module "codebuild_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "codebuild-role"
  service    = "codebuild.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}
module "codebuild" {
  source       = "./modules/aws_codebuild"
  project_name = "terraform-build"
  service_role = module.codebuild_role.role_arn
}

############################################
################ CodeDeploy ################
############################################
# module "codedeploy_role" {
#   source     = "./modules/aws_iam_role"
#   role_name  = "codedeploy-role"
#   service    = "codedeploy.amazonaws.com"
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
# }

# module "codedeploy" {
#   source                = "./modules/aws_codedeploy"
#   app_name              = "CodeDeployApp"
#   deployment_group_name = "deployment-group"
#   service_role          = module.codedeploy_role.role_arn
# }

############################################
################ CodePipeline ###############
############################################
module "codepipeline_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "codepipeline-role"
  service    = "codepipeline.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}
module "codepipeline" {
  source            = "./modules/aws_codepipeline"
  pipeline_name     = "mlops-test-pipeline"
  codepipeline_role = module.codepipeline_role.role_arn
  artifact_store    = module.codepipeline_s3.bucket_name
  codecommit_repo   = module.codecommit.repository_name
  codebuild_project = module.codebuild.project_name
}