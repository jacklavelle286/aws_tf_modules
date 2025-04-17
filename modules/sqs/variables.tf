variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}


variable "sqs_queue_name" {
  type = string
  description = "Name of the SQS queue."
}

variable "is_fifo_queue" {
  type = bool
  default = false
}

