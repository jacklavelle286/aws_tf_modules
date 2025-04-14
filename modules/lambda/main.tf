resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role = aws_iam_role.this.id
  tags = var.tags
  runtime = var.runtime
  handler = var.handler
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


resource "aws_iam_role" "this" {
  assume_role_policy = jsondecode( )
}


data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.policy_statements
    content {
      sid     = statement.value.sid
      effect  = statement.value.effect
      actions = statement.value.actions
      resources = statement.value.resources

      principals {
        type        = statement.value.principal_type
        identifiers = statement.value.identifiers
      }
    }
  }
}
