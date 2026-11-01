# PortCon SF 2026 Workshop: Plain Language → Governed Terraform PR

This repository demonstrates a hands-on workflow where natural language infrastructure requests are automatically transformed into compliant, reviewed Terraform pull requests.

## Workshop Flow

```
Developer Request → Port Workflow → AI Tech Plan → Guardrail Check → Dynamic Approval → Cursor Opens PR
```

1. **Developer submits a plain-language request** in Port (e.g., "I need an S3 bucket for user uploads in staging")
2. **Port workflow** creates an `infra_request` entity and triggers an AI agent
3. **AI generates a tech plan** by selecting a module and determining input values
4. **Guardrail check** validates the plan against security, compliance, and cost rules
5. **Dynamic approval** routes to auto-approve or requires human review based on rules
6. **Cursor agent opens a PR** in this repo with one new `.tf` file

## Repository Layout

```
├── modules/
│   ├── rds-postgres/        # Amazon RDS for PostgreSQL
│   ├── s3-bucket/           # Amazon S3 bucket
│   ├── elasticache-redis/   # Amazon ElastiCache for Redis
│   └── sqs-queue/           # Amazon SQS queue
├── envs/
│   ├── staging/             # Staging environment request files
│   └── production/          # Production environment request files
├── .github/
│   ├── CODEOWNERS           # Module ownership
│   ├── pull_request_template.md
│   └── workflows/
│       └── terraform-validate.yml
```

## Modules

Each module in `modules/` corresponds to a **terraform_module** entity in the Port catalog and includes:

- **variables.tf**: Module inputs matching catalog schema exactly
- **main.tf**: AWS resources with secure defaults
- **outputs.tf**: Resource identifiers and endpoints
- **README.md**: Usage examples and guardrails

### Available Modules

| Module | Purpose | Owner Team | Inputs |
|--------|---------|------------|--------|
| **rds-postgres** | Relational database | Data Platform | instance_class, allocated_storage_gb, engine_version, multi_az, storage_encrypted |
| **s3-bucket** | Object storage | Cloud Platform | bucket_name, versioning, block_public_access, encryption |
| **elasticache-redis** | Caching layer | Data Platform | node_type, num_cache_nodes, transit_encryption |
| **sqs-queue** | Message queue | Cloud Platform | fifo, visibility_timeout_seconds, dead_letter_queue, kms_encryption |

All modules accept a `tags` variable (map of strings) with required keys: `service`, `team`, `environment`, `data_sensitivity`, `infra_request_id`, `managed_by`.

## Request Files

Request files live in `envs/<environment>/` and follow this naming convention:

```
<service>-<module>-<request-id>.tf
```

Each file contains **one module block** that instantiates a module with approved inputs and required tags. For example:

```hcl
module "myapp_s3_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name         = "myapp-user-uploads"
  versioning          = true
  block_public_access = true
  encryption          = "aws:kms"

  tags = {
    service          = "myapp"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "req_abc123"
    managed_by       = "port"
  }
}
```

See `envs/staging/example-s3.tf.example` for a complete example.

## Guardrails

All tech plans are validated against platform rules before approval:

### Universal Rules
- Storage encryption must be enabled (RDS, S3, SQS)
- Transit encryption must be enabled (ElastiCache)
- Public access must be blocked unless data is explicitly public
- Module inputs must match the catalog schema

### Production-Specific Rules
- RDS: `multi_az = true` (high availability)
- ElastiCache: `num_cache_nodes >= 2` (redundancy)
- SQS: `dead_letter_queue = true` (message durability)

### Data Sensitivity Rules
- **Confidential data** requires KMS encryption and versioning
- **Internal data** requires encryption (KMS or SSE)
- **Public data** may skip access blocks

## CI/CD

The `.github/workflows/terraform-validate.yml` workflow runs on every PR:

- ✅ `terraform fmt -check -recursive` (formatting)
- ✅ `terraform init -backend=false` (initialize without backend)
- ✅ `terraform validate` (syntax and schema checks)

**No AWS credentials are required.** The provider uses:
```hcl
skip_credentials_validation = true
skip_metadata_api_check     = true
skip_requesting_account_id  = true
```

**No resources are ever applied.** This is a demonstration repository; there is no AWS account or apply CI.

## Pull Request Guidelines

PRs in this repository are **automatically opened by the workshop workflow**. Each PR:

- Adds exactly one file: `envs/<env>/<service>-<module>-<id>.tf`
- Never modifies, renames, or deletes existing files
- Never touches anything in `modules/`
- Follows the PR template with:
  - Summary and Port request link
  - Tech plan inputs table
  - Guardrail check result
  - Approval status

**Please do not merge PRs during the workshop.** They exist to demonstrate the governed IaC workflow.

## How Request Files Map to Catalog Modules

1. Developer describes need in natural language
2. AI matches request to a **terraform_module** entity in Port
3. AI proposes input values based on:
   - Module's `inputs` schema (types, defaults, descriptions)
   - Request context (service, environment, data sensitivity)
   - Guardrail rules
4. Guardrail check validates every rule explicitly
5. Approved inputs become the module block in `envs/<env>/<file>.tf`

## Local Development

To validate the repository locally:

```bash
# Format check
terraform fmt -check -recursive

# Validate staging
cd envs/staging
terraform init -backend=false
terraform validate

# Validate production
cd ../production
terraform init -backend=false
terraform validate

# Validate each module
cd ../../modules/rds-postgres && terraform init -backend=false && terraform validate
cd ../s3-bucket && terraform init -backend=false && terraform validate
cd ../elasticache-redis && terraform init -backend=false && terraform validate
cd ../sqs-queue && terraform init -backend=false && terraform validate
```

## Workshop Goals

By the end of this workshop, attendees will:

- ✅ See how natural language requests become structured tech plans
- ✅ Understand how AI-driven guardrail checks enforce compliance
- ✅ Experience dynamic approval routing (auto vs. human review)
- ✅ Observe Cursor agents opening production-ready PRs
- ✅ Review readable, small, green pull requests that match platform standards

---

🤖 **Powered by Port + Cursor**  
Questions? Reach out to the Platform Engineering team.
