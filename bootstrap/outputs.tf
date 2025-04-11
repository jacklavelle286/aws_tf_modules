
output "oidc_role_arn" {
  description = "ARN of the OIDC IAM Role"
  value       = aws_iam_role.oidc_role.arn
}