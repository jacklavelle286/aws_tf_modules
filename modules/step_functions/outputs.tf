output "state_machine_arn" {
  value = aws_sfn_state_machine.this.arn
}

# output "log_group_arn" {
#   value = aws_cloudwatch_log_group.this.arn
# }