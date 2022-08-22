# Most module instantiations will only need to have this block
include "root" {
  path = find_in_parent_folders("root.hcl")
}
