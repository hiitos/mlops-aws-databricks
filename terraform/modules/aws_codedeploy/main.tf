resource "aws_codedeploy_app" "this" {
  name = var.app_name
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.service_role

  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  ec2_tag_filter {
    key   = "Name"
    value = "MyEC2Instance"
    type  = "KEY_AND_VALUE"
  }
}

output "app_name" {
  value = aws_codedeploy_app.this.name
}

output "deployment_group_name" {
  value = aws_codedeploy_deployment_group.this.deployment_group_name
}
