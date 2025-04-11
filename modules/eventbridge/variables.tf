variable "is_default_eventbus" {
  type        = bool
  default     = true
  description = <<EOF
When set to true, the module will use the AWS account's default EventBridge event bus, and no additional event bus configuration is required.

When set to false, the module will create a custom EventBridge event bus. In this case, you must provide the following additional configuration details:
  - **eventbus_name**: A unique name for the custom event bus.
  - **Policy Details** (if applicable): You must supply a valid policy configuration by specifying:
      - `sid`         : A unique identifier (statement ID) for the policy.
      - `effect`      : The policy effect (e.g., "Allow" or "Deny").
      - `actions`     : A list of API actions permitted on the event bus.
      - `principal_type`: The type of principal (e.g., AWS, Service, Federated, or Canonical ID).
      - `identifiers` : A list of principal identifiers.
      - `resources`   : A list of resource ARNs for which the policy applies.
EOF
}


variable "eventbus_name" {
  type = string
  default = "CustomEventBus"
}

variable "description" {
  type = string
  default = "Description of custom eventbus."
}

variable "sid" {
  type = string
  default = "Eventbus_policy"
  description = "Policy SID for the EventBridge Eventbus"
  validation {
    condition = var.is_default_eventbus || (length(var.sid) > 0)
    error_message = "When is_default_eventbus is true, a sid must be provided."
  }
}

variable "effect" {
  description = "Allow or Deny."
  type = string
  default = "Allow"
  validation {
    condition = var.is_default_eventbus || (length(var.effect) > 0)
    error_message = "When is_default_eventbus is true, an effect must be provided."
  }
}

variable "actions" {
  type        = list(string)
  description = "API calls allowed on the EventBridge EventBus."
  default     = []
  validation {
    condition     = var.is_default_eventbus || (length(var.actions) > 0)
    error_message = "When is_default_eventbus is false, actions must be provided."
  }
}

variable "resources" {
  type = list(string)
  description = "Resources which are allowed to make API calls to be made on the Amazon EventBridge EventBus."
  validation {
    condition = var.is_default_eventbus || (length(var.resources) > 0)
    error_message = "When is_default_eventbus is true, actions must be provided."
  }
  default = []

}


variable "principal_type" {
  description = "Principal type for the bucket policy (e.g., AWS, Service, Federated, Canonical ID)"
  type        = string
  default     = ""
  validation {
    condition     = var.is_default_eventbus || (length(trim(var.principal_type, " ")) > 0)
    error_message = "When is_default_eventbus is true, principal_type must be provided."
  }
}


variable "identifiers" {
  description = "List of principal identifiers."
  type        = list(string)
  default     = []
  validation {
    condition = var.is_default_eventbus || (length(var.identifiers) > 0)
    error_message = "When is_default_eventbus is true, at least one identifier must be provided."
  }
}
