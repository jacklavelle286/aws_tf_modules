variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}


variable "type" {
  default = "STANDARD"
  description = "Either standard or express."
}

variable "sfn_name" {
  description = "Name of the step functions state machine"
  type = string
}

variable "policy_statements" {
  description = "A list of policy statements to include in the IAM policy document."
  type = list(object({
    sid            = string
    effect         = string
    actions        = list(string)
    resources      = list(string)
  }))
}

variable "start_at" {
  description = "The name of the state to start with"
  type        = string
}

variable "states" {
  description = "A map of state definitions for the state machine. Each key is the state name and its value is an object that describes the state (e.g., type, resource, transitions, etc.)."
  type        = map(any)
  default     = {}  
}