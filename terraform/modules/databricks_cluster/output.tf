output "cluster_name" {
  value = databricks_cluster.this.cluster_name
}

output "cluster_url" {
  value = databricks_cluster.this.url
}

output "cluster_id" {
  value = databricks_cluster.this.cluster_id
}
