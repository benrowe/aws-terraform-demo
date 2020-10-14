// Provider details
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  type = string
  default = "ap-southeast-2"
}

variable "stack_name" {}

// constants
variable "db_instance" {
  type = string
  default = "db.t2.micro"
}

variable "db_name" {
  description = "Database name"
  default = "example"
}

variable "db_username" {
  description = "Database username"
  default = "example"
}

variable "db_password" {
  description = "Database password"
}
