output "s3_bucket_arn" {
  value = aws_s3_bucket.this.arn
  description = "Bucket ARN."
}

output "static_website_endpoint" {
  value = aws_s3_bucket.this.bucket_domain_name
  description = "Website endpoint"
}


output "bucket_id" {
  value = aws_s3_bucket.this.id
  description = "Bucket ID"
}