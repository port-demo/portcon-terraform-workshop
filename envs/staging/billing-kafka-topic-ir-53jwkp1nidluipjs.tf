module "billing_kafka_topic" {
  source = "../../modules/kafka-topic"

  topic_name         = "billing-invoice-events"
  partitions         = 6
  replication_factor = 3
  retention_ms       = 604800000
  cleanup_policy     = "delete"

  tags = {
    service          = "billing"
    team             = "cloud-platform"
    environment      = "staging"
    data_sensitivity = "internal"
    infra_request_id = "ir-53jwkp1nidluipjs"
    managed_by       = "port"
  }
}
