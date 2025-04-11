output "dynamodb_arn" {
  value = aws_dynamodb_table.this.arn
  description = "DynamoDB table ARN"
}

output "dynamodb_id" {
  value = aws_dynamodb_table.this.id
  description = "Dynamodb table ID"
}