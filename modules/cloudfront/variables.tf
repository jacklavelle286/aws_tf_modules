variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}

variable "allowed_methods" {
  type = list(string)
  default = ["GET", "HEAD"]
  validation {
    condition = alltrue([for method in var.allowed_methods : contains(["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"], method)])
    error_message = "Each method must be a valid HTTP method in all caps."
  }
}

variable "cached_methods" {
  type = list(string)
  default = ["GET", "HEAD"]
  validation {
    condition = alltrue([for method in var.cached_methods : contains(["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"], method)])
    error_message = "Each method must be a valid HTTP method in all caps."
  }
}

variable "target_origin_id" {
  type = string
  description = "ID of the origin for your CloudFront distribution."
}


variable "viewer_protocol_policy" {
  type = string
  description = "Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
}


variable "query_string" {
  type = string
  description = "Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default = "false"
}

variable "forward" {
  type = string
  description = "The forwarded values cookies that specifies how CloudFront handles cookies (maximum one)."
  default = "none"
}

variable "domain_name" {
  type = string
  description = "The domain name of your origin for your CloudFront distribution."
}


variable "origin_id" {
  type = string
  description = "The origin id of your origin for the cloudfront distribution."
}

variable "locations" {
  type = list(string)
  default = []
  validation {
    condition = alltrue([for location in var.locations : can(regex("^[A-Z]{2}$", location))])
    error_message = "Must be a valid ISO 3166-1-alpha-2 country code. e.g. US, GR etc"
  }
}

variable "restriction_type" {
  type = string
  description = "Resriction type for your CloudFront distribution, choose none, whitelist or blacklist - default is none."
  default = "none"
}


variable "is_default_certificate" {
  type    = bool
  default = true
}

variable "acm_certificate_arn" {
  type    = string
  default = null
}

variable "iam_certificate_id" {
  type    = string
  default = null
}

variable "enabled" {
  type = bool
  description = "If the cloudfront distribution is enabled or disabled, default is enabled."
  default = true
}


