locals {
  root_deployments_dir       = get_parent_terragrunt_dir()
  relative_deployment_path   = path_relative_to_include()
  deployment_path_components = compact(split("/", local.relative_deployment_path))
  base_dir                   = "${local.root_deployments_dir}/base"

  # Terragrunt paths, for informational purposes
  terragrunt = {
    path_relative_from_include  = path_relative_from_include()
    get_path_from_repo_root     = get_path_from_repo_root()
    get_path_to_repo_root       = get_path_to_repo_root()
    path_relative_to_include    = path_relative_to_include()
    get_terragrunt_dir          = get_terragrunt_dir()
    get_parent_terragrunt_dir   = get_parent_terragrunt_dir()
    get_original_terragrunt_dir = get_original_terragrunt_dir()
    source                      = "${local.root_deployments_dir}/../modules/${local.stack}"
  }

  # Only works when root.hcl is called within an environment/<env>/ directory
  environment = local.deployment_path_components[0]
  stack       = reverse(local.deployment_path_components)[0]

  # Get a list of every path between root_deployments_directory and the path of
  # the deployment
  possible_config_dirs = [
    for i in range(0, length(local.deployment_path_components) + 1) :
    join("/", concat(
      [local.root_deployments_dir],
      slice(local.deployment_path_components, 0, i)
    ))
  ]

  # Generate a list of possible config files at every possible_config_dir
  # (support both yaml and hcl)
  possible_config_paths = flatten([
    for dir in local.possible_config_dirs : [
      "${dir}/config.hcl",
      "${dir}/config.yaml",
      "${dir}/config.yml",
    ]
  ])

  # Load every config file that exists into an HCL map
  file_configs = [
    for path in local.possible_config_paths : (
      length(regexall("hcl$", path)) > 0 # Terraform has no "endswith" function
      ? read_terragrunt_config(path)     # Load HCL files
      : yamldecode(file(path))           # Otherwise load YAML files
    ) if fileexists(path)                # ... but only if the file actually exists
  ]

  root_inputs = {
    environment = local.environment
  }

  # Merge the maps together, with deeper configs overriding higher configs
  merged_config = merge(local.root_inputs, local.file_configs...)
}

# Set the merged config to be the base level inputs of the module
inputs = local.merged_config

# Set the terraform source to be a local directory matching the stack name; can be overridden by the terragrunt.hcl if needed
terraform {
  source = "${local.root_deployments_dir}/../modules/${local.stack}"
}
