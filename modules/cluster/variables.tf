variable "environment" {
  type        = string
  description = "Name of the environment.  Ex: dev, test, prod, etc"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "subnet_ids" {
  type        = list(any)
  description = "list of subnet ids"
}

variable "other" {
  type    = any
  default = {}
}

variable "arbitrary_text" {
  type    = string
  default = ""
}
