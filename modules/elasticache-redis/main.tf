resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.tags["service"]}-${var.tags["environment"]}"
  subnet_ids = [] # To be provided via VPC configuration in real deployment

  tags = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.tags["service"]}-redis-${var.tags["environment"]}"
  description = "Security group for ${var.tags["service"]} Redis cluster"
  vpc_id      = "" # To be provided via VPC configuration in real deployment

  tags = var.tags
}

resource "aws_elasticache_parameter_group" "this" {
  name   = "${var.tags["service"]}-redis7-${var.tags["environment"]}"
  family = "redis7"

  tags = var.tags
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = "${var.tags["service"]}-${var.tags["environment"]}"
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = aws_elasticache_parameter_group.this.name

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = [aws_security_group.this.id]

  transit_encryption_enabled = var.transit_encryption
  port                       = 6379

  snapshot_retention_limit = var.num_cache_nodes > 1 ? 5 : 0
  snapshot_window          = "03:00-05:00"
  maintenance_window       = "sun:05:00-sun:07:00"

  tags = var.tags
}
