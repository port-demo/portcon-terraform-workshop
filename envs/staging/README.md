# Staging Environment

This directory contains Terraform configurations for infrastructure requests in the **staging** environment.

## Structure

Each infrastructure request is represented by a single `.tf` file following the naming convention:

```
<service>-<module>-<request-id>.tf
```

For example:
- `myapp-s3-bucket-req123.tf`
- `api-rds-postgres-req456.tf`

## Request Files

Request files are **automatically generated** by the Port workflow integration and opened as pull requests by Cursor agents. Each file contains:

1. A single `module` block that references one of the modules in `../../modules/`
2. Input values approved during the request workflow
3. Required resource tags (service, team, environment, data_sensitivity, infra_request_id, managed_by)

**Do not manually create or modify request files.**

## Terraform Operations

This is a workshop repository. **No actual AWS resources are created.** The provider is configured with:
- `skip_credentials_validation = true`
- `skip_metadata_api_check = true`
- `skip_requesting_account_id = true`

This allows `terraform init -backend=false` and `terraform validate` to pass without AWS credentials.

## Available Modules

- `rds-postgres` - Amazon RDS for PostgreSQL
- `s3-bucket` - Amazon S3 bucket
- `elasticache-redis` - Amazon ElastiCache for Redis
- `sqs-queue` - Amazon SQS queue

See each module's README in `modules/` for details.
