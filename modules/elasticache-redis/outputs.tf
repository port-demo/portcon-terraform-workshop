output "cluster_id" {
  description = "The ElastiCache cluster identifier."
  value       = aws_elasticache_cluster.this.cluster_id
}

output "cache_nodes" {
  description = "List of cache node addresses."
  value       = aws_elasticache_cluster.this.cache_nodes
}

output "configuration_endpoint" {
  description = "The configuration endpoint (for cluster mode)."
  value       = aws_elasticache_cluster.this.configuration_endpoint
}

output "cluster_address" {
  description = "The DNS name of the cache cluster."
  value       = aws_elasticache_cluster.this.cluster_address
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.this.id
}
