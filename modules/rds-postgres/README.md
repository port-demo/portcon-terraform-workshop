# RDS PostgreSQL Module

Creates an Amazon RDS for PostgreSQL instance with a subnet group, a security group and a parameter group. Use it for relational, transactional data owned by a service.

## Usage

```hcl
module "example_rds_postgres" {
  source = "../../modules/rds-postgres"

  instance_class       = "db.t4g.small"
  allocated_storage_gb = 100
  engine_version       = "16"
  multi_az             = true
  storage_encrypted    = true

  tags = {
    service          = "example-service"
    team             = "data-platform"
    environment      = "production"
    data_sensitivity = "confidential"
    infra_request_id = "req_abc123"
    managed_by       = "port"
  }
}
```

## Inputs

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `instance_class` | string | `db.t4g.micro` | RDS instance class. |
| `allocated_storage_gb` | number | `20` | Allocated storage in GB. |
| `engine_version` | string | `16` | PostgreSQL major engine version. |
| `multi_az` | boolean | `false` | Deploy a standby in a second availability zone. |
| `storage_encrypted` | boolean | `true` | Encrypt storage at rest with KMS. |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `db_instance_id` | The RDS instance identifier. |
| `db_instance_endpoint` | The connection endpoint in address:port format. |
| `db_instance_arn` | The ARN of the RDS instance. |
| `db_name` | The name of the database. |
| `security_group_id` | The ID of the security group. |

## Guardrails

- `storage_encrypted` must be `true`.
- In production, `multi_az` must be `true`.
- Confidential data requires encryption and no public access (`publicly_accessible` = `false`).
- Outside production, `allocated_storage_gb` may be at most 500.

## Notes

- The module enforces `publicly_accessible = false` for security.
- In this workshop repo, VPC configuration (subnet IDs and VPC ID) is left empty since no actual resources will be created.
- Deletion protection is automatically enabled for production environments.
