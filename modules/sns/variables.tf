variable "tags" {
  type = map(string)
  description = "Tags applied to this resource."
  default = {}
}



variable "topic_name" {
  type = string
  description = "The name of your SNS Topic"
}

variable "subscribers" {
  description = "List of subscribers for the SNS topic. Each subscriber should specify a protocol and an endpoint."
  type = list(object({
    protocol = string
    endpoint = string
  }))
  default = []  
}


