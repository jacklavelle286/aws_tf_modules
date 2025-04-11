variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}

variable "name" {
  type        = string
  description = "The name of the DynamoDB table."
}

variable "billing_mode" {
  type        = string
  description = "Billing mode for the table, e.g. PROVISIONED or PAY_PER_REQUEST."
}

variable "read_capacity" {
  type        = number
  default     = null
  description = "Read capacity (only used for PROVISIONED billing mode)."
}

variable "write_capacity" {
  type        = number
  default     = null
  description = "Write capacity (only used for PROVISIONED billing mode)."
}

variable "hash_key" {
  type        = string
  description = "The partition key for the table."
}

variable "range_key" {
  type        = string
  default     = null
  description = "The sort key for the table (if any)."
}

variable "attributes" {
  type        = map(string)
  description = "A map where the key is the attribute name and the value is its DynamoDB type (e.g., \"S\" or \"N\")."
}

variable "global_secondary_indexes" {
  type = list(object({
    name              = string
    hash_key          = string
    range_key         = optional(string)
    read_capacity     = number
    write_capacity    = number
    projection_type   = string
    non_key_attributes = optional(list(string), [])
  }))
  default     = []
  description = "A list of global secondary indexes to create on the table."
}

variable "ttl_attribute_name" {
  type        = string
  default     = null
  description = "The attribute to use for TTL (if any)."
}

variable "ttl_enabled" {
  type        = bool
  default     = false
  description = "Whether TTL is enabled for the table."
}
