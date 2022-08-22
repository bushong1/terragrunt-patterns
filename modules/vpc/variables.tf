variable "environment" {
  type        = string
  description = "Name of the environment.  Ex: dev, test, prod, etc"
}

variable "subnet_count" {
  type        = number
  description = "Number of subnets"
}

variable "other" {
  type    = any
  default = {}
}
variable "arbitrary_text" {
  type    = string
  default = "vpc module default"
}
