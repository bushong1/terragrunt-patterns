resource "random_id" "vpc" {
  keepers = {
    vpc_id = var.environment
  }
  byte_length = 8
}

resource "random_id" "subnets" {
  count = var.subnet_count
  keepers = {
    subnet_number = count.index
    vpc_id        = "vpc-${random_id.vpc.hex}"
  }
  byte_length = 8
}
