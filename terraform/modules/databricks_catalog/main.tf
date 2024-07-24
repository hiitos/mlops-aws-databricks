resource "databricks_catalog" "this" {
  name    = var.catalog_name
  comment = "This is an example Unity Catalog"
  properties = {
    purpose = "testing"
  }
}
