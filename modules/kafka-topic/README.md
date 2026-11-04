# Kafka Topic Module

Creates an Apache Kafka topic for pub/sub event streaming (for example, billing invoice updates consumed by multiple services). Topics are managed against an existing MSK cluster bootstrap endpoint configured in the environment provider.

## Usage

```hcl
module "example_kafka_topic" {
  source = "../../modules/kafka-topic"

  topic_name         = "billing-invoice-events"
  partitions         = 6
  replication_factor = 3
  retention_ms       = 604800000
  cleanup_policy     = "delete"

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
| `topic_name` | string | `null` | Kafka topic name. Defaults to `<service>-invoice-events`. |
| `partitions` | number | `6` | Number of topic partitions. |
| `replication_factor` | number | `3` | Replication factor across brokers. |
| `retention_ms` | number | `604800000` | Message retention in milliseconds (7 days). |
| `cleanup_policy` | string | `"delete"` | Log cleanup policy (`delete` or `compact`). |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `topic_name` | The name of the Kafka topic. |
| `partitions` | The number of partitions on the topic. |
| `replication_factor` | The replication factor of the topic. |

## Guardrails

- In production, `replication_factor` must be at least `3`.
- Confidential data requires cluster-level encryption (MSK) and restricted ACLs; topic retention should be reviewed with the data owner.
- Use `cleanup_policy = "compact"` only for keyed changelog topics, not general event streams.

## Notes

- Requires the `Mongey/kafka` provider configured with MSK bootstrap brokers (IAM or TLS as appropriate).
- Partition count cannot be decreased after creation; plan capacity for expected consumer parallelism.
- This workshop repo validates configuration only; topics are not applied without a live Kafka cluster.
