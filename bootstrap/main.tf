

# OIDC Provider
resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = [var.client_list_id]
  thumbprint_list = [var.thumbprint_list]
  url             = var.oidc_url
  tags = local.default_tags
}

# IAM Role for OIDC Authentication
resource "aws_iam_role" "oidc_role" {
  name = "OIDCRole"
  tags = local.default_tags
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "WebIdentity"
        Effect    = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = var.trusted_repo
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "oidc_role" {
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
    roles      = [aws_iam_role.oidc_role.name]
    name = "oidc_role"
}

# S3 Bucket for Terraform Backend State
resource "aws_s3_bucket" "backend" {
  bucket = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-backend-infra-tf-${var.project}"
  tags = local.default_tags

}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "lock" {
  name         = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}-backend-infra-tf-${var.project}-lock"
  billing_mode = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key     = "LockID"
  tags_all = var.tags
    
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.default_tags

}

