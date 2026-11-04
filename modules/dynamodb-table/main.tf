resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode

  hash_key  = var.hash_key_name
  range_key = var.range_key_name

  attribute {
    name = var.hash_key_name
    type = var.hash_key_type
  }

  dynamic "attribute" {
    for_each = var.range_key_name != null ? [1] : []
    content {
      name = var.range_key_name
      type = var.range_key_type
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery
  }

  server_side_encryption {
    enabled = var.kms_encryption
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute_name != null ? [1] : []
    content {
      attribute_name = var.ttl_attribute_name
      enabled        = true
    }
  }

  tags = var.tags
}
