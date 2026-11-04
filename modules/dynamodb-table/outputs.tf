output "table_id" {
  description = "The name of the DynamoDB table."
  value       = aws_dynamodb_table.this.id
}

output "table_arn" {
  description = "The ARN of the DynamoDB table."
  value       = aws_dynamodb_table.this.arn
}

output "table_name" {
  description = "The name of the DynamoDB table."
  value       = aws_dynamodb_table.this.name
}

output "hash_key" {
  description = "The partition key attribute name."
  value       = aws_dynamodb_table.this.hash_key
}
