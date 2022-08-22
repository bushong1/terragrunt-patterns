locals {
  root = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals

  # Lookup the environment from environment.hcl; can't reference it in root.hcl
  # because this file doesn't exist within an env directory
  environment = read_terragrunt_config(find_in_parent_folders("environment.hcl")).locals.environment
  env_dir     = "${local.root.root_deployments_dir}/${local.environment}/"
}

dependency "vpc" {
  # Load the environment-specific module
  config_path = "${local.env_dir}/vpc"

  # Mocks are offloaded to a mocks.hcl within the base/<module>/mocks.hcl file
  mock_outputs = read_terragrunt_config("${local.root.base_dir}/vpc/mocks.hcl").locals.mock_outputs
}

# Wire up dependencies to inputs here
inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.subnet_ids
}
