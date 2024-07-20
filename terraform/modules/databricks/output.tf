output "workspace_name" {
  value = databricks_workspace.this.name
}

output "cluster_name" {
  value = databricks_cluster.this.cluster_name
}

output "job_name" {
  value = databricks_job.this.name
}
