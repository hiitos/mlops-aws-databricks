resource "aws_codecommit_repository" "this" {
  repository_name = var.repository_name
}

output "repository_name" {
  value = aws_codecommit_repository.this.repository_name
}
