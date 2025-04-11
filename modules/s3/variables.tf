variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}

variable "name" {
  description = "S3 Bucket Name"
  type = string
}


variable "force_destroy" {
  default = true
  description = "If you want to be able to delete buckets with objects in."
}

variable "is_static_website_bucket" {
  default = false
  description = "Enable this if you want a static website bucket. Default is disabled"
}

variable "index_document" {
  type = string
  description = "Root web server document"
  default = "index.html"

}

variable "error_document" {
  type = string
  description = "Error web page"
  default = "error.html"
}


variable "is_policy_document" {
  default = false
  type = bool
  description = "If you want a bucket policy or not."
}


variable "lifecycle_rules" {
  description = "A map of lifecycle configuration rules. Each rule object must include an id, status, a filter prefix, and a list of transitions."
  type = map(object({
    id          = string
    status      = string
    prefix      = string
    transitions = list(object({
      days          = number
      storage_class = string
    }))
  }))
  default = {}  
}


variable "intelligent_tiering" {
  description = "A map of intelligent tiering configuration. Each key is an identifier, and its value is an object with access_tier and days."
  type = map(object({
    access_tier = string
    days        = number
  }))
  default = {} 
}

variable "principal_type" {
  description = "Principal type for the bucket policy (e.g., AWS, Service, Federated, Canonical ID)"
  type        = string
  default     = ""
  validation {
    condition     = !var.is_policy_document || (length(trim(var.principal_type, " ")) > 0)
    error_message = "When is_policy_document is true, principal_type must be provided."
  }
}


variable "identifiers" {
  description = "List of principal identifiers."
  type        = list(string)
  default     = []
  validation {
    condition = !var.is_policy_document || (length(var.identifiers) > 0)
    error_message = "When is_policy_document is true, at least one identifier must be provided."
  }
}

variable "actions" {
  description = "List of S3 API actions in PascalCase (e.g., GetObject, PutObject)."
  type        = list(string)
  default     = []
  validation {
    condition = !var.is_policy_document || (length(var.actions) > 0)
    error_message = "When is_policy_document is true, actions must be provided."
  }
}

variable "resources" {
  description = "List of resources for the bucket policy."
  type        = list(string)
  default     = []
  validation {
    condition     = !var.is_policy_document || (length(var.resources) > 0)
    error_message = "When is_policy_document is true, resources must be provided."
  }
}