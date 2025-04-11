locals {
  s3_actions = [for action in var.actions : "s3.${action}"]
}
