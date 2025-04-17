resource "aws_sfn_state_machine" "this" { 
  tags = var.tags
  name = var.sfn_name
  role_arn = aws_iam_role.this.arn
  definition = jsonencode(local.state_machine_definition)
  type = var.type
#   logging_configuration {
#     level = "ALL"
#     log_destination = aws_cloudwatch_log_group.this.arn
#   }
  tracing_configuration {
    enabled = true
  }
}


# resource "aws_cloudwatch_log_group" "this" {
#   tags = var.tags
#   retention_in_days = 30
#   name = "${var.sfn_name}-log_group"
# }

resource "aws_iam_role" "this" {
  tags = var.tags
  name = "${var.sfn_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_policy" "this" { 
  tags = var.tags
  policy = data.aws_iam_policy_document.this.json
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

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role = aws_iam_role.this.id
}
