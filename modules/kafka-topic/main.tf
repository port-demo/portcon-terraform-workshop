terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.7"
    }
  }
}

locals {
  topic_name = coalesce(var.topic_name, "${var.tags["service"]}-invoice-events")
}

resource "kafka_topic" "this" {
  name               = local.topic_name
  replication_factor = var.replication_factor
  partitions         = var.partitions

  config = {
    "retention.ms"   = tostring(var.retention_ms)
    "cleanup.policy" = var.cleanup_policy
  }
}
