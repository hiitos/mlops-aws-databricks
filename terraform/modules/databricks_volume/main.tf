resource "databricks_volume" "this" {
  name         = var.volume_name
  catalog_name = var.catalog_name
  schema_name  = var.schema_name
  volume_type  = "MANAGED"
  // 外部ストレージ(S3など)の場合は、volume_type に "EXTERNAL" を指定
  # volume_type      = "EXTERNAL"
  # storage_location = databricks_external_location.some.url
  comment = "this volume is managed by terraform"
}
