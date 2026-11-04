# DynamoDB Table Module

Creates an Amazon DynamoDB table with optional sort key, point-in-time recovery, KMS encryption at rest, and optional TTL. Use it for application state such as delivery status, idempotency keys, and other key-value or document records.

## Usage

```hcl
module "example_dynamodb_table" {
  source = "../../modules/dynamodb-table"

  table_name             = "example-service-notification-delivery"
  hash_key_name          = "message_id"
  point_in_time_recovery = true
  kms_encryption         = true

  tags = {
    service          = "example-service"
    team             = "cloud-platform"
    environment      = "production"
    data_sensitivity = "internal"
    infra_request_id = "req_abc123"
    managed_by       = "port"
  }
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `table_name` | string | - | DynamoDB table name (required). Must be prefixed with the service name. |
| `hash_key_name` | string | `message_id` | Name of the partition key attribute. |
| `hash_key_type` | string | `S` | Type of the partition key attribute (S, N, or B). |
| `range_key_name` | string | `null` | Name of the sort key attribute (optional). |
| `range_key_type` | string | `S` | Type of the sort key attribute (S, N, or B). |
| `billing_mode` | string | `PAY_PER_REQUEST` | DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST). |
| `point_in_time_recovery` | boolean | `true` | Enable point-in-time recovery. |
| `kms_encryption` | boolean | `true` | Encrypt the table at rest with KMS. |
| `ttl_attribute_name` | string | `null` | Name of the TTL attribute; when set, TTL is enabled. |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `table_id` | The name of the DynamoDB table. |
| `table_arn` | The ARN of the DynamoDB table. |
| `table_name` | The name of the DynamoDB table. |
| `hash_key` | The partition key attribute name. |

## Guardrails

- `table_name` must be prefixed with the service name.
- In production, `point_in_time_recovery` must be `true`.
- Confidential data requires `kms_encryption` = `true`.

## Notes

- Non-key attributes (for example `status` and `timestamp`) are defined by application item writes; only key attributes are declared on the table.
- KMS key ARN is intentionally omitted in this workshop repo; in production, specify a customer-managed KMS key when required.
- On-demand (`PAY_PER_REQUEST`) billing is the default for workshop environments.
