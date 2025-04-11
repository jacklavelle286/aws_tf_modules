

resource "aws_s3_bucket" "this" {
  bucket = var.name
  force_destroy = var.force_destroy
  
}


resource "aws_s3_bucket_website_configuration" "this" {
  count = var.is_static_website_bucket ? 1 : 0
  bucket = aws_s3_bucket.this.id
  index_document {
    suffix = var.index_document
  }
  error_document {
    key = var.error_document
  }
}



resource "aws_s3_bucket_notification" "this" {
  eventbridge = true
  bucket = aws_s3_bucket.this.id
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(keys(var.lifecycle_rules)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      filter {
        prefix = rule.value.prefix
      }

      dynamic "transition" {
        for_each = rule.value.transitions
        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }
    }
  }
}





resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  count  = length(keys(var.intelligent_tiering)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.id
  name   = "s3_tiering_config"

  dynamic "tiering" {
    for_each = var.intelligent_tiering
    content {
      access_tier = tiering.value.access_tier
      days        = tiering.value.days
    }
  }
}


data "aws_iam_policy_document" "bucket_policy" {
  count = var.is_policy_document ? 1 : 0
  statement {
    principals {
      type        = var.principal_type
      identifiers = var.identifiers
    }

    actions   = var.actions
    resources = var.resources
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.is_policy_document ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.bucket_policy[0].json
}