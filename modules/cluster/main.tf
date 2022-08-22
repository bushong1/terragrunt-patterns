resource "random_id" "alb" {
  keepers = {
    vpc_id = var.vpc_id,
  }
  byte_length = 8
}

resource "random_id" "instances" {
  for_each = toset(var.subnet_ids)
  keepers = {
    vpc_id  = var.vpc_id,
    subnets = each.key,
  }
  byte_length = 8
}
