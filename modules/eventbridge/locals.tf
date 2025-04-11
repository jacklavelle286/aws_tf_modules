locals {
  eventbridge_actions = [for action in var.actions : "events.${action}"]
}
