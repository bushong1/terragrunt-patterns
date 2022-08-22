output "vpc_id" {
  value = "vpc-${random_id.vpc.hex}"
}

output "subnet_ids" {
  value = [for subnet in random_id.subnets : "subnet-${subnet.hex}"]
}
output "other" {
  value = merge(var.other, { arbitrary_text = var.arbitrary_text })
}
