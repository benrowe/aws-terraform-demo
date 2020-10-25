variable "name" {
  description = "The name of the repository"
}

variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "vpc" {
  description = "The vpc put this service into"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}
