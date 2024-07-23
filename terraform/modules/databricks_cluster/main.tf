# Create the cluster with the "smallest" amount
# of resources allowed.
# e.g. "Standard_DS3_v2"
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Use the latest Databricks Runtime
# Long Term Support (LTS) version.
# e.g. "7.3.x-scala2.12"
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = data.databricks_spark_version.latest_lts.id
  autotermination_minutes = var.cluster_autotermination_minutes
  num_workers             = var.cluster_num_workers
}
