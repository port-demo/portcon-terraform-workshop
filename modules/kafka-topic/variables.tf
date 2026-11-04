variable "topic_name" {
  description = "Kafka topic name. Defaults to \"<service>-invoice-events\" when null."
  type        = string
  default     = null
}

variable "partitions" {
  description = "Number of topic partitions."
  type        = number
  default     = 6
}

variable "replication_factor" {
  description = "Topic replication factor across Kafka brokers."
  type        = number
  default     = 3
}

variable "retention_ms" {
  description = "How long messages are retained on the topic, in milliseconds."
  type        = number
  default     = 604800000 # 7 days
}

variable "cleanup_policy" {
  description = "Log cleanup policy (delete or compact)."
  type        = string
  default     = "delete"
}

variable "tags" {
  description = "Resource tags including service, team, environment, data_sensitivity, infra_request_id, and managed_by."
  type        = map(string)
}
