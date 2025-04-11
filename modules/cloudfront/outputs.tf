output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
  description = "DNS name of the cloudfront distribution"
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.this.arn
  description = "ARN of the cloudfront distribution"
}