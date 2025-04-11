output "eventbus_arn" {
  value = var.is_default_eventbus ? data.aws_cloudwatch_event_bus.default_eventbus[0].arn : aws_cloudwatch_event_bus.this[0].arn
  description = "ARN of the EventBridge EventBus."
}
