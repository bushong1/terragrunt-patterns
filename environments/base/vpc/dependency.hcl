locals {
  #root = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  root = include.root.locals
}
dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id     = "dummy"
    subnet_ids = ["dummy"]
  }
}
