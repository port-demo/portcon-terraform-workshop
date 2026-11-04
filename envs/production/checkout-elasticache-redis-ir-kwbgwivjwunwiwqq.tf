module "checkout_elasticache_redis" {
  source = "../../modules/elasticache-redis"

  node_type          = "cache.t4g.small"
  num_cache_nodes    = 2
  transit_encryption = true

  tags = {
    service          = "checkout"
    team             = "data-platform"
    environment      = "production"
    data_sensitivity = "internal"
    infra_request_id = "ir-kwbgwivjwunwiwqq"
    managed_by       = "port"
  }
}
