resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role = aws_iam_role.this.arn
  tags = var.tags
  memory_size = var.memory_size
  timeout = var.timeout
  package_type = var.package_type
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish = var.is_versioning
  image_uri = var.image_uri
  tracing_config {
    mode = var.tracing_mode
  }
}

resource "aws_iam_policy" "this" {
  policy = data.aws_iam_policy_document.this.json
  name = "${var.lambda_role_name}-policy"
}


resource "aws_iam_role" "this" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name = var.lambda_role_name
  
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.policy_statements
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
    }
  }
}
