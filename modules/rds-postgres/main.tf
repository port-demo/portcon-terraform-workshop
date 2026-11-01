locals {
  db_name = replace(var.tags["service"], "-", "_")
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.tags["service"]}-${var.tags["environment"]}"
  subnet_ids = [] # To be provided via VPC configuration in real deployment

  tags = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.tags["service"]}-postgres-${var.tags["environment"]}"
  description = "Security group for ${var.tags["service"]} PostgreSQL database"
  vpc_id      = "" # To be provided via VPC configuration in real deployment

  tags = var.tags
}

resource "aws_db_parameter_group" "this" {
  name   = "${var.tags["service"]}-postgres${replace(var.engine_version, ".", "")}-${var.tags["environment"]}"
  family = "postgres${var.engine_version}"

  tags = var.tags
}

resource "aws_db_instance" "this" {
  identifier     = "${var.tags["service"]}-${var.tags["environment"]}"
  engine         = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage_gb
  storage_type      = "gp3"
  storage_encrypted = var.storage_encrypted

  db_name  = local.db_name
  username = "postgres"

  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  parameter_group_name   = aws_db_parameter_group.this.name

  publicly_accessible = false
  skip_final_snapshot = true

  backup_retention_period = var.multi_az ? 7 : 1
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  deletion_protection = var.tags["environment"] == "production" ? true : false

  tags = var.tags
}
