# ElastiCache Redis Module

Creates an Amazon ElastiCache for Redis cluster with a subnet group and a security group. Use it for caching and ephemeral data only.

## Usage

```hcl
module "example_elasticache_redis" {
  source = "../../modules/elasticache-redis"

  node_type          = "cache.t4g.small"
  num_cache_nodes    = 2
  transit_encryption = true

  tags = {
    service          = "example-service"
    team             = "data-platform"
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
| `node_type` | string | `cache.t4g.micro` | ElastiCache node type. |
| `num_cache_nodes` | number | `1` | Number of cache nodes. |
| `transit_encryption` | boolean | `true` | Enable in-transit (TLS) encryption. |
| `tags` | map(string) | - | Resource tags (required). |

## Outputs

| Name | Description |
|------|-------------|
| `cluster_id` | The ElastiCache cluster identifier. |
| `cache_nodes` | List of cache node addresses. |
| `configuration_endpoint` | The configuration endpoint (for cluster mode). |
| `cluster_address` | The DNS name of the cache cluster. |
| `security_group_id` | The ID of the security group. |

## Guardrails

- `transit_encryption` must be `true`.
- In production, `num_cache_nodes` must be at least 2.
- Not allowed for confidential data (cache only).

## Notes

- Uses Redis 7.1 engine.
- Snapshot retention is enabled (5 days) when multiple nodes are configured.
- In this workshop repo, VPC configuration (subnet IDs and VPC ID) is left empty since no actual resources will be created.
