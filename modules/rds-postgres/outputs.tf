output "db_instance_id" {
  description = "The RDS instance identifier."
  value       = aws_db_instance.this.id
}

output "db_instance_endpoint" {
  description = "The connection endpoint in address:port format."
  value       = aws_db_instance.this.endpoint
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance."
  value       = aws_db_instance.this.arn
}

output "db_name" {
  description = "The name of the database."
  value       = aws_db_instance.this.db_name
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.this.id
}
