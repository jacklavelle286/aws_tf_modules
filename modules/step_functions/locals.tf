locals {
  state_machine_definition = {
    Comment = "State Machine created by Terraform"
    StartAt = var.start_at
    States  = var.states
  }
}
