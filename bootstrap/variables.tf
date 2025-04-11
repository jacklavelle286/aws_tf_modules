variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default = "eu-west-2"

}

variable "tags" {
  description = "Base tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "client_list_id" {
  description = "Client List id"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "thumbprint_list" {
  description = "List of thumbprints of the provider"
  type        = string
  default     = "6938fd4d98bab03faadb97b34396831e3780aea1"
}

variable "oidc_url" {
  description = "OIDC URL"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "trusted_repo" {
  description = "The repository that the IAM role is trusted to deploy to."
  type        = string
  default     = "repo:jacklavelle286/*"
}
