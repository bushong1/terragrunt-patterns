# Most module instantiations will only need to have this block
include "root" {
  path = find_in_parent_folders("root.hcl")
}

# Modules which depend on other modules will load a base dependency file
include "dependencies" {
  path = find_in_parent_folders("base/cluster/dependencies.hcl")
}

inputs = {
  other = {
    override                   = "dev/cluster/terragrunt.hcl"
    override_dev_cluster_tghcl = "true"
  }
}
