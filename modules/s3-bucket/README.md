# S3 Bucket Module

Creates an Amazon S3 bucket with versioning, server-side encryption and a public access block. Use it for object storage such as files, exports and static assets.

## Usage

```hcl
module "example_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "example-service-data"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

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
| `bucket_name` | string | - | Bucket name (required). Must be prefixed with the service name. |
| `versioning` | boolean | `true` | Enable object versioning. |
| `block_public_access` | boolean | `true` | Block all public access to the bucket. |
| `encryption` | string | `aws:kms` | Server-side encryption algorithm (aws:kms or AES256). |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `bucket_id` | The name of the bucket. |
| `bucket_arn` | The ARN of the bucket. |
| `bucket_domain_name` | The bucket domain name. |
| `bucket_regional_domain_name` | The bucket region-specific domain name. |

## Guardrails

- `block_public_access` must be `true` unless `data_sensitivity` is `public`.
- Confidential data requires KMS encryption (`encryption` = `aws:kms`) and `versioning` = `true`.
- `bucket_name` must be prefixed with the service name.

## Notes

- A lifecycle rule automatically cleans up old versions after 90 days in non-production environments.
- KMS key ID is intentionally empty in this workshop repo; in production, specify a proper KMS key.
