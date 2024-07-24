resource "databricks_schema" "this" {
  catalog_name = var.catalog_id
  name         = var.schema_name
  comment      = "This is an example schema within Unity Catalog"
  properties = {
    kind = "various"
  }
}
