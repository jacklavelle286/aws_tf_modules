resource "aws_cloudwatch_event_bus" "this" {
  name = var.eventbus_name
  description = var.description
  count = var.is_default_eventbus ? 0 : 1
}


resource "aws_cloudwatch_event_bus_policy" "this" {
  count = var.is_default_eventbus ? 0 : 1
  policy = data.aws_iam_policy_document.this[0].id
}


data "aws_iam_policy_document" "this" {
  count = var.is_default_eventbus ? 0 : 1
  statement {
    sid    = var.sid
    effect = var.effect
    actions = var.actions
    resources = var.resources
    principals {
      type        = var.principal_type
      identifiers = var.identifiers
    }
  }
}


data "aws_cloudwatch_event_bus" "default_eventbus" {
  count = var.is_default_eventbus ? 1 : 0
  name = "default"
}
