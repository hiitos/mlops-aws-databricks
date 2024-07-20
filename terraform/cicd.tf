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
module "codebuild_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "${var.terraform_project_name}-codebuild-role"
  service    = "codebuild.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}
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
module "codepipeline_role" {
  source     = "./modules/aws_iam_role"
  role_name  = "${var.terraform_project_name}-codepipeline-role"
  service    = "codepipeline.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

resource "aws_iam_role_policy" "codepipeline_codecommit_policy" {
  name   = "${var.terraform_project_name}_codepipeline_codecommit_policy"
  role   = module.codepipeline_role.role_name
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codecommit:GitPull",
        "codecommit:GetRepository",
        "codecommit:ListBranches",
        "codecommit:GetBranch",
        "codecommit:BatchGetRepositories",
        "codecommit:GetRepositoryTriggers"
      ],
      "Resource": "arn:aws:codecommit:${var.terraform_region}:${var.terraform_account_id}:${module.codecommit.repository_name}"
    }
  ]
}
POLICY
}
module "codepipeline" {
  source            = "./modules/aws_codepipeline"
  pipeline_name     = "${var.terraform_project_name}-pipeline"
  codepipeline_role = module.codepipeline_role.role_arn
  artifact_store    = module.codepipeline_s3.bucket_name
  codecommit_repo   = module.codecommit.repository_name
  codebuild_project = module.codebuild.codebuild_project_name
}
