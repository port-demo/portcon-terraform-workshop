output "topic_name" {
  description = "The name of the Kafka topic."
  value       = kafka_topic.this.name
}

output "partitions" {
  description = "The number of partitions on the topic."
  value       = kafka_topic.this.partitions
}

output "replication_factor" {
  description = "The replication factor of the topic."
  value       = kafka_topic.this.replication_factor
}
