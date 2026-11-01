# SQS Queue Module

Creates an Amazon SQS queue, optionally FIFO, with an optional dead-letter queue and KMS encryption. Use it for asynchronous messaging between services.

## Usage

```hcl
module "example_sqs_queue" {
  source = "../../modules/sqs-queue"

  fifo                       = false
  visibility_timeout_seconds = 60
  dead_letter_queue          = true
  kms_encryption             = true

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
| `fifo` | boolean | `false` | Create a FIFO queue. |
| `visibility_timeout_seconds` | number | `30` | Visibility timeout in seconds. |
| `dead_letter_queue` | boolean | `true` | Create and attach a dead-letter queue. |
| `kms_encryption` | boolean | `true` | Encrypt messages with KMS. |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `queue_id` | The URL of the SQS queue. |
| `queue_arn` | The ARN of the SQS queue. |
| `queue_name` | The name of the SQS queue. |
| `dlq_id` | The URL of the dead-letter queue (if enabled). |
| `dlq_arn` | The ARN of the dead-letter queue (if enabled). |

## Guardrails

- In production, `dead_letter_queue` must be `true`.
- Confidential data requires `kms_encryption` = `true`.

## Notes

- FIFO queues automatically enable content-based deduplication.
- Messages in the main queue are retained for 4 days; DLQ messages for 14 days.
- Max receive count for DLQ redrive is set to 3.
- KMS key ID is intentionally empty in this workshop repo; in production, specify a proper KMS key.
