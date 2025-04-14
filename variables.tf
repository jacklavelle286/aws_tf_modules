variable "tags" {
  description = "Base tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  type = string
  description = "Environment tag"
}

variable "project" {
  type = string
  description = "value"
}


variable "region" {
  type = string
  description = "Region which the infrastructure is deployed in."
  default = "eu-west-2"
}

variable "bucket_name" {
  type = string
  description = "S3 Bucket name"
}

variable "eventbus_name" {
  type = string
  description = "eventbus name"
  default = "Testing"
}