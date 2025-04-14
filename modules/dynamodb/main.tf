resource "aws_dynamodb_table" "this" {
  name           = var.name
  billing_mode   = var.billing_mode

  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null

  hash_key  = var.hash_key
  range_key = var.range_key
  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.key
      type = attribute.value
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
      projection_type    = global_secondary_index.value.projection_type
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", [])
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_enabled && var.ttl_attribute_name != null ? [var.ttl_attribute_name] : []
    content {
      attribute_name = ttl.value
      enabled        = true
    }
  }

  tags = var.tags
}
