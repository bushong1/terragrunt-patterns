output "alb" {
  value = "internal-${var.environment}-alb-${random_id.alb.dec}.us-east-1.elb.amazonaws.com"
}

output "instance_ids" {
  value = [for instance in random_id.instances : "i-${instance.hex}"]
}
output "other" {
  value = merge(var.other, { arbitrary_text = var.arbitrary_text })
}
