resource "databricks_catalog" "this" {
  name    = var.catalog_name
  comment = "This is an example Unity Catalog"
}

resource "databricks_schema" "this" {
  name         = var.schema_name
  catalog_name = databricks_catalog.this.name
  comment      = "This is an example schema within Unity Catalog"
}

resource "databricks_table" "this" {
  name         = var.table_name
  catalog_name = databricks_catalog.this.name
  schema_name  = databricks_schema.this.name
  comment      = "This is an example table within the schema"
  table_type   = var.table_type
  data_source_format = var.data_source_format
  data_source {
    type = "MANAGED"
  }
  column {
    name = "id"
    type = "INT"
  }
  column {
    name = "value"
    type = "STRING"
  }
}

output "catalog_name" {
  value = databricks_catalog.this.name
}

output "schema_name" {
  value = databricks_schema.this.name
}

output "table_name" {
  value = databricks_table.this.name
}
